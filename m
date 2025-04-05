Return-Path: <stable+bounces-128394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE898A7C903
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0543BBFC8
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA55C2FD;
	Sat,  5 Apr 2025 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re8wFtsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88728F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854282; cv=none; b=hqYqJVj6SRroujbI6oDdURdN5vfMjoMGwxb98lB9/7lcTLrsE3+AF6lq57P2HCshjH1ixLU0UGjSYb/wiDeOEeo4t+uouKTgJg1uCUe5JRwawcsI1rwNR6IEHFTdG0j0twWD0wMEHEjKi7/3Bht8MFKmp12hkwo6E5zPODtbfqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854282; c=relaxed/simple;
	bh=z1tCHu4GSM9g+B82FPdWmX6woqsAI9D+VDuM0S+bV18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzNEwnqvRbj81iJ5mldEv23bMEtDjJeSIDX76q1uf9V+4woBzsIBJkb/eFJlEhu1UA9vB82VgbgHMjErtqAPX5XBDrZ3qZnzkfRCb4uwzfqTtJLaF/ZcT/DSPDoFMJuI9U16v4eViR83QoV0tSNcJj8YeV62oic9y6ui4Q6wjjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re8wFtsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C968C4CEE4;
	Sat,  5 Apr 2025 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854282;
	bh=z1tCHu4GSM9g+B82FPdWmX6woqsAI9D+VDuM0S+bV18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re8wFtsMbsWoGPJ6qn79yitYmTXWmkmcEAf8fbxMLheDtkMbGJx7sxtFJsic6d/L3
	 w/d1eVSqhNO+ewrh6P6bFmjHmBq8vQtMQHyJAbD8hwUIJUPBrMSOs0lOPGWiQmBavP
	 Yr0ahYa/eht1BqscbF7s/7EQtnotY4CgYu/EI/cwisOdzgIxlVZQ/l92598bfl74v7
	 3PMY4vJzdLDZENvnNo6QyTuupYzmF4fMRj3TjgGhDCpQHcZkW9m9m0Lte2KHS3jWfJ
	 zK/3Ez1zPLcYDjAsQwTrIw77S0Nu2rtGvoIV+O9hojaIIcDPEzgQtRb3FRR8t06hAv
	 fSoGPnBMJv4nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 09/12] KVM: arm64: Refactor exit handlers
Date: Sat,  5 Apr 2025 07:58:00 -0400
Message-Id: <20250405023730-2517bc9ae5a7bc03@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-9-cd5c9eb52d49@kernel.org>
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
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: 8ca75010aaab)
6.12.y | Present (different SHA1: 2e4f2c20db53)
6.6.y | Present (different SHA1: 2afe039450a0)

Note: The patch differs from the upstream commit:
---
1:  9b66195063c5a ! 1:  a592d3131f595 KVM: arm64: Refactor exit handlers
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
    @@ arch/arm64/kvm/hyp/vhe/switch.c: static const exit_handler_fn hyp_exit_handlers[
      
     -static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
     -{
    - 	/*
    - 	 * If we were in HYP context on entry, adjust the PSTATE view
    - 	 * so that the usual helpers work correctly.
    -@@ arch/arm64/kvm/hyp/vhe/switch.c: static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
    - 		*vcpu_cpsr(vcpu) &= ~(PSR_MODE_MASK | PSR_MODE32_BIT);
    - 		*vcpu_cpsr(vcpu) |= mode;
    - 	}
    -+
     +	return __fixup_guest_exit(vcpu, exit_code, hyp_exit_handlers);
      }
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

