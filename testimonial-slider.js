// Testimonial Slider JavaScript
let currentTestimonialIndex = 0;
let testimonialInterval;

// Initialize the slider when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    const testimonials = document.querySelectorAll('.testimonial-item');
    const dots = document.querySelectorAll('.dot');
    
    if (testimonials.length === 0) return;
    
    // Start automatic rotation
    startTestimonialRotation();
    
    // Pause on hover
    const container = document.getElementById('testimonial-container');
    if (container) {
        container.addEventListener('mouseenter', stopTestimonialRotation);
        container.addEventListener('mouseleave', startTestimonialRotation);
    }
});

function showTestimonial(index) {
    const testimonials = document.querySelectorAll('.testimonial-item');
    const dots = document.querySelectorAll('.dot');
    
    // Hide all testimonials
    testimonials.forEach(testimonial => {
        testimonial.classList.remove('active');
    });
    
    // Remove active class from all dots
    dots.forEach(dot => {
        dot.classList.remove('active');
    });
    
    // Show current testimonial
    if (testimonials[index]) {
        testimonials[index].classList.add('active');
    }
    
    // Activate current dot
    if (dots[index]) {
        dots[index].classList.add('active');
    }
    
    currentTestimonialIndex = index;
}

function nextTestimonial() {
    const testimonials = document.querySelectorAll('.testimonial-item');
    currentTestimonialIndex = (currentTestimonialIndex + 1) % testimonials.length;
    showTestimonial(currentTestimonialIndex);
}

function currentTestimonial(index) {
    showTestimonial(index - 1); // Convert to 0-based index
    stopTestimonialRotation();
    startTestimonialRotation(); // Restart rotation
}

function startTestimonialRotation() {
    stopTestimonialRotation(); // Clear any existing interval
    testimonialInterval = setInterval(nextTestimonial, 4000); // Change every 4 seconds
}

function stopTestimonialRotation() {
    if (testimonialInterval) {
        clearInterval(testimonialInterval);
    }
}