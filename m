Return-Path: <stable+bounces-125784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C95A6C187
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B5D3B9825
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B81DE3A7;
	Fri, 21 Mar 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tINNq1qg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B813C914
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578235; cv=none; b=ukwtyFsGeeibcWdJAB0pYO+ik93gEmsFT/me66lrDK50woSaEkzRS0V477qD1tBHYEiW3DgrzUy/qd3AwI9wT0EJYQp4lBAkmRI6k6YNT0R4aR/9I4ePzkQ0rd4GsD59Trl/6onCy4diJYfhVNMB3Q1u1d0neO4OjRU6rVC9tJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578235; c=relaxed/simple;
	bh=QyI4TuHo16s89VYiFtdUIygXUwz0NMfAj3Jf5lVwNXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kj6H3OfuU1va7C7g3LA5nlk44wiaUlVHXUZmUMoMf1gZewkPwY8ybBhYPbNEs9DbsfMj2naDTpYatzNyNnzc9zMfzaDQrJgryySc9yAJ1oFe4NSEa/H2OetqcGcug3dJi+xWjfs/eo8yCW/z3oQx/dBrJrys6V9n2KRugM7R58Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tINNq1qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF5AC4CEE3;
	Fri, 21 Mar 2025 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578235;
	bh=QyI4TuHo16s89VYiFtdUIygXUwz0NMfAj3Jf5lVwNXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tINNq1qgsgy8abwDm9+2VEaE+8ysBO873OEh1kW+tJRfKw4cio47LuOXykxUtYdfc
	 lT9f4enVJAewYjupR75d9JwPomlFwU6JPoxUiFpGiUbnyHFnL8Z0DF8ETVbk5r2kiK
	 2bsDa4fTAqOJejb34UjV8+3iaRf2cChUI2UzeU0UTuctClRBvqVIQK36Re5mexiUZJ
	 GlnSTznKvHuAHcomM2I7zS0cCCRpfzZQ9g3OMIAmMCbfnZ0iISHMW7u2vCuipqX/0l
	 Q1Rlc+Yk4WYEwO0ufLNuCJ+u+14DeXHxXaXdeqlvzHMF5U+ZKMA4c1upKtZ9cwxZiq
	 8BKojRbB0gEbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 v2 3/8] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Date: Fri, 21 Mar 2025 13:30:23 -0400
Message-Id: <20250321125130-4bb62e76b2846200@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-13-v2-3-3150e3370c40@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 8eca7f6d5100b6997df4f532090bc3f7e0203bef

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Note: The patch differs from the upstream commit:
---
1:  8eca7f6d5100b ! 1:  9bf55741b1ec4 KVM: arm64: Remove host FPSIMD saving for non-protected KVM
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Remove host FPSIMD saving for non-protected KVM
     
    +    [ Upstream commit 8eca7f6d5100b6997df4f532090bc3f7e0203bef ]
    +
         Now that the host eagerly saves its own FPSIMD/SVE/SME state,
         non-protected KVM never needs to save the host FPSIMD/SVE/SME state,
         and the code to do this is never used. Protected KVM still needs to
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-3-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    [CPACR_EL1_ZEN -> CPACR_ELx_ZEN -- broonie]
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/kvm_host.h ##
     @@ arch/arm64/include/asm/kvm_host.h: struct kvm_host_data {
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
     -	*host_data_ptr(fpsimd_state) = NULL;
     -	*host_data_ptr(fpmr_ptr) = NULL;
      
    - 	host_data_clear_flag(HOST_SVE_ENABLED);
    + 	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
      	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
    @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline void __hyp_sve_save_host(
     +
     +		/* Re-enable SVE traps if not supported for the guest vcpu. */
     +		if (!vcpu_has_sve(vcpu))
    -+			cpacr_clear_set(CPACR_EL1_ZEN, 0);
    ++			cpacr_clear_set(CPACR_ELx_ZEN, 0);
     +
     +	} else {
     +		__fpsimd_save_state(host_data_ptr(host_ctxt.fp_regs));
    @@ arch/arm64/kvm/hyp/nvhe/switch.c: static bool kvm_handle_pvm_sys64(struct kvm_vc
     -
     -		/* Re-enable SVE traps if not supported for the guest vcpu. */
     -		if (!vcpu_has_sve(vcpu))
    --			cpacr_clear_set(CPACR_EL1_ZEN, 0);
    +-			cpacr_clear_set(CPACR_ELx_ZEN, 0);
     -
     -	} else {
     -		__fpsimd_save_state(*host_data_ptr(fpsimd_state));
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

