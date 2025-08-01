class OnboardingInfo {
  final String title;
  final String description;
  final String image;

  const OnboardingInfo({
    required this.title,
    required this.description,
    required this.image,
  });
}

const List<OnboardingInfo> onboardingData = [
  OnboardingInfo(
    title: "Welcome to Cofe",
    description: "Discover the best coffee shops in your area.",
    image: "lib/assets/onboarding1.png",
  ),
  OnboardingInfo(
    title: "Find Your Favorite Coffee",
    description: "Explore a variety of coffee options tailored to your taste.",
    image: "lib/assets/onboarding2.png",
  ),
  OnboardingInfo(
    title: "Join the Community",
    description:
        "Connect with fellow coffee lovers and share your experiences.",
    image: "lib/assets/onboarding3.png",
  ),
];
