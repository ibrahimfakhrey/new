// Testimonial Slider JavaScript
(function() {
    let currentTestimonialIndex = 0;
    let testimonialInterval;
    let testimonials = [];

    // Function to initialize testimonials
    function initTestimonials() {
        testimonials = Array.from(document.querySelectorAll('.testimonial-item'));
        return testimonials.length > 0;
    }

    // Function to show a specific testimonial
    function showTestimonial(index) {
        if (testimonials.length === 0) return;
        
        // Hide all testimonials
        testimonials.forEach((testimonial) => {
            if (testimonial) {
                testimonial.classList.remove('active');
            }
        });
        
        // Show the selected testimonial
        if (testimonials[index]) {
            testimonials[index].classList.add('active');
        }
        
        currentTestimonialIndex = index;
    }

    // Function to go to next testimonial
    function nextTestimonial() {
        if (testimonials.length === 0) return;
        
        const nextIndex = (currentTestimonialIndex + 1) % testimonials.length;
        showTestimonial(nextIndex);
    }

    // Function to go to previous testimonial
    function prevTestimonial() {
        if (testimonials.length === 0) return;
        
        const prevIndex = (currentTestimonialIndex - 1 + testimonials.length) % testimonials.length;
        showTestimonial(prevIndex);
    }

    // Function for manual navigation (called by dot clicks)
    function currentTestimonial(index) {
        showTestimonial(index - 1); // Convert to 0-based index
        resetInterval(); // Reset the auto-rotation timer
    }

    // Function to start auto-rotation
    function startAutoRotation() {
        clearInterval(testimonialInterval);
        if (testimonials.length > 1) {
            testimonialInterval = setInterval(nextTestimonial, 4000); // Change every 4 seconds
        }
    }

    // Function to reset the interval
    function resetInterval() {
        clearInterval(testimonialInterval);
        startAutoRotation();
    }

    // Initialize the slider when the page loads
    function initSlider() {
        if (initTestimonials()) {
            showTestimonial(0); // Show first testimonial
            startAutoRotation(); // Start auto-rotation
            
            // Pause auto-rotation when user hovers over testimonials
            const testimonialContainer = document.getElementById('testimonial-container');
            if (testimonialContainer) {
                testimonialContainer.addEventListener('mouseenter', () => {
                    clearInterval(testimonialInterval);
                });
                
                testimonialContainer.addEventListener('mouseleave', () => {
                    startAutoRotation();
                });
            }
        }
    }

    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initSlider);
    } else {
        // DOM is already ready
        setTimeout(initSlider, 100);
    }

    // Make currentTestimonial function globally available for onclick handlers
    window.currentTestimonial = currentTestimonial;
})();