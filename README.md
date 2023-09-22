# MBS-Pricing

"This repository contains an in-depth case study on Mortgage-Backed Securities (MBS) pricing.The analysis is conducted as of January 31, 2023, for the reference portfolio of the SPV Cayman VI, with a total notional of €2 billion. The portfolio is assumed to be homogeneous, where mortgage payments occur at the end of a 4-year interest period, and defaults are independent of interest rates. Key objectives include:

a. **Pricing Mezzanine Tranche with Double t-Student Model (𝜈=4)**
   - Value the price of a mezzanine Tranche with specific subordinations (detachment points) Kd and Ku using a double t-Student model with 𝜈=4 degrees of freedom.
   - Validate the hypothesis of a Large Homogeneous Portfolio (LHP).

b. **Comparison with Vasicek Model**
   - Verify that, for a large number of degrees of freedom (e.g., ν=200), the results from the double t-Student model are indistinguishable from those obtained with a Vasicek model.
   - Continue to consider the validity of the LHP hypothesis.

c. **Impact of LHP Hypothesis on Double t-Student Model**
   - Estimate the impact of the LHP hypothesis on the double t-student model for the same Tranche.
   - Demonstrate that the Tranche's price in relative terms (as a percentage of the face value) is well-described by the Kullback-Leibler (KL) approximation within the range I=(10, 2x10^4), where the LHP approximation holds.
   - Plot the price variation with respect to I (in log scale on the abscissa) and include:
     - The exact solution (up to the computationally feasible I).
     - The approximate solution.
     - The LHP solution.

This repository serves as a comprehensive resource for individuals interested in MBS pricing, risk assessment, and financial modeling, offering practical exercises and insights into complex financial instruments."
