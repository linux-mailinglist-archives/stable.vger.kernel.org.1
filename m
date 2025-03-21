Return-Path: <stable+bounces-125781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A2A6C185
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA297A8D24
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629722E3E9;
	Fri, 21 Mar 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkOODAHd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F522DFAC
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578198; cv=none; b=ITvYNxzQ1+Si2rz8NQBNUnGGgfLYw5NZce8GCDpXjIQWy/Ltrl/XWP3O6ki/icCy7BEeRpdQtvyapcGm1D2dZgR2WDyQAFgegoka4HZbiRawbSNkpe0NJaxytyoWuyweqkgMLCNm3sxKl+DHU4MPFkR4iAbpwrQJrIXIvGGcwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578198; c=relaxed/simple;
	bh=VOoKe8uP9iYJZTmUTEWNqC3FiV18kh+C5x60VoB4J/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aObxqHmtqNATdCZ/FXnrB5O3VPuL+b8cqypemAINokTIprUrg6yRSDfVTzatuRDaKfFdZBxqdjgqXZmpGWLT4Qy1mdx97g26NEyknrjMRXD6yyJSNBSJ/FFhF+qCCEX3cWnVLdfHI6ZpgmZgpjHFHvw5ykHcIlg52HGOuRR5ryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkOODAHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C31EC4CEE8;
	Fri, 21 Mar 2025 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578197;
	bh=VOoKe8uP9iYJZTmUTEWNqC3FiV18kh+C5x60VoB4J/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkOODAHd6op3a7TV1a+t8qWK5Ein4cnWplNssEWLr+Tu8jy1q0C5EqlaXZ6Lda6k8
	 zdhj4eqfyywId4zvLSinXni8ltzzL+IJvATGAz3aFWtaoF9XLdUmaIc14V1GC6zNjq
	 hbFkDsO8+qABy2CrZaRFKjp4QuAntyJLlekxlHpYN0/OIYDndgGa8YLgx3wpObrZRn
	 CrJBDmYmf1VXPLc8BKK5axXKZ4WQ1s9Fy8mgGOCQfszi+MiEFMSupnGNmc5DG9zw9A
	 I5N5ATjuutvIPvkg/1i6CCi07Zh3oEcP276LfUreZVzxUEX0gs3bbsbGc0f30Ex/Pk
	 O1uej7JNJTMEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 6/8] KVM: arm64: Refactor exit handlers
Date: Fri, 21 Mar 2025 13:29:45 -0400
Message-Id: <20250321122229-0babb15d2822d69c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-6-v1-6-0b3a6a14ea53@kernel.org>
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

The upstream commit SHA1 provided is correct: 9b66195063c5a145843547b1d692bd189be85287

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 4c68a146aaaa)
6.12.y | Present (different SHA1: 14aab4391836)

Note: The patch differs from the upstream commit:
---
1:  9b66195063c5a ! 1:  15cf8a2271ac3 KVM: arm64: Refactor exit handlers
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Refactor exit handlers
     
    +    [ Upstream commit 9b66195063c5a145843547b1d692bd189be85287 ]
    +
         The hyp exit handling logic is largely shared between VHE and nVHE/hVHE,
         with common logic in arch/arm64/kvm/hyp/include/hyp/switch.h. The code
         in the header depends on function definitions provided by
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-7-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
    @@ arch/arm64/kvm/hyp/nvhe/switch.c: static const exit_handler_fn *kvm_get_exit_han
     +static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
      {
     +	const exit_handler_fn *handlers = kvm_get_exit_handler_array(vcpu);
    -+
    + 	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
    + 
     +	synchronize_vcpu_pstate(vcpu, exit_code);
     +
     +	/*
    @@ arch/arm64/kvm/hyp/nvhe/switch.c: static const exit_handler_fn *kvm_get_exit_han
     +	 * it.  The check below is based on the one in
     +	 * kvm_arch_vcpu_ioctl_run().
     +	 */
    - 	if (unlikely(vcpu_is_protected(vcpu) && vcpu_mode_is_32bit(vcpu))) {
    + 	if (kvm_vm_is_protected(kvm) && vcpu_mode_is_32bit(vcpu)) {
      		/*
      		 * As we have caught the guest red-handed, decide that it isn't
     @@ arch/arm64/kvm/hyp/nvhe/switch.c: static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
    @@ arch/arm64/kvm/hyp/nvhe/switch.c: static void early_exit_filter(struct kvm_vcpu
     
      ## arch/arm64/kvm/hyp/vhe/switch.c ##
     @@ arch/arm64/kvm/hyp/vhe/switch.c: static const exit_handler_fn hyp_exit_handlers[] = {
    - 	[ESR_ELx_EC_MOPS]		= kvm_hyp_handle_mops,
    + 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
      };
      
     -static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

