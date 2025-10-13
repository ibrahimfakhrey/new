// Testimonial Slider JavaScript
let currentTestimonialIndex = 0;
const testimonials = document.querySelectorAll('.testimonial-item');
const dots = document.querySelectorAll('.dot');
let testimonialInterval;

// Function to show a specific testimonial
function showTestimonial(index) {
    // Hide all testimonials
    testimonials.forEach((testimonial, i) => {
        testimonial.classList.remove('active');
        dots[i].classList.remove('active');
    });
    
    // Show the selected testimonial
    if (testimonials[index]) {
        testimonials[index].classList.add('active');
        dots[index].classList.add('active');
    }
    
    currentTestimonialIndex = index;
}

// Function to go to next testimonial
function nextTestimonial() {
    const nextIndex = (currentTestimonialIndex + 1) % testimonials.length;
    showTestimonial(nextIndex);
}

// Function to go to previous testimonial
function prevTestimonial() {
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
    testimonialInterval = setInterval(nextTestimonial, 5000); // Change every 5 seconds
}

// Function to reset the interval
function resetInterval() {
    clearInterval(testimonialInterval);
    startAutoRotation();
}

// Initialize the slider when the page loads
document.addEventListener('DOMContentLoaded', function() {
    if (testimonials.length > 0) {
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
});

// Make currentTestimonial function globally available for onclick handlers
window.currentTestimonial = currentTestimonial;