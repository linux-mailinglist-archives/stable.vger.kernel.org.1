Return-Path: <stable+bounces-125783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB66A6C186
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8978C3B9AA1
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A322DFAD;
	Fri, 21 Mar 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMySIbD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87C1DE3A7
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578223; cv=none; b=bqe7VKa7/EnfL47n1IjXYU0pql/Z7UGqUrOjL2oLF6XXcpAOHDMYTsnHoLbMDHKxv1Jnv2jOqRUlK5Y1Pm3QoOExOzPW59ob1YsHJf+biRiQujaSkeTw/3g+slXerp8JodYKEYhlaC0cUjMjrPSEibpC8gBINN0TqgOpJPaGXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578223; c=relaxed/simple;
	bh=/T0SNS+x+OZITn4AIXOcAZ26EC6hx8mbI1yJBlHT1gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAhVNdWvdIiuKf3O2Lq6z3iD2OKaHIRqTW//mm4P+Ve2wRpwSSiJeTSakYWMRcyDDd78p3j2r43dvLAJgAr3WkVIqWh2vp+MXgZhqiXfZLM0lU49mCicv6l54p2VFGWec539cc4DgqiJ7+0pQ/I5LkLJ8iOXHwU+5lstdMss9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMySIbD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31186C4CEE3;
	Fri, 21 Mar 2025 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578222;
	bh=/T0SNS+x+OZITn4AIXOcAZ26EC6hx8mbI1yJBlHT1gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMySIbD2Qi72cTiJZ+a4/htX+Pd5d6gAVID3jRqvlEl6Q81ZKUsD7Ntkqr+mNPS/X
	 2xjWufHraG9RHEWqpzvM8E5OTHDcOLJx4JTwVw3GDDuoKpXtyqN4QuXa/md6eG4Cip
	 wdpYTtZywgXvmupTckxK4TDRU0WWIuH6EWVetNRAVpAL0hDohEpx3eYMQcVFi3rcpb
	 g8dS7k1QNyfYBUXOxqb/gYsPZ//xKyHIpv0BN9cd0u9CFepC0xg4qhceb70n4EwwTi
	 bDM4Kzv9DtrRNPkSOtZdX+FIeAkGLAE0yTylnrAp1fNqyPW2AkCmFN+aLRYWrI3t/M
	 edM4L4De1Q+yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 v2 2/8] KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
Date: Fri, 21 Mar 2025 13:30:10 -0400
Message-Id: <20250321124715-bcf8c5f38326714b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-13-v2-2-3150e3370c40@kernel.org>
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

The upstream commit SHA1 provided is correct: fbc7e61195e23f744814e78524b73b59faa54ab4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Note: The patch differs from the upstream commit:
---
1:  fbc7e61195e23 ! 1:  e49a8986cc91c KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
     
    +    [ Upstream commit fbc7e61195e23f744814e78524b73b59faa54ab4 ]
    +
         There are several problems with the way hyp code lazily saves the host's
         FPSIMD/SVE state, including:
     
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-2-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    [ Mark: Handle vcpu/host flag conflict ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kernel/fpsimd.c ##
     @@ arch/arm64/kernel/fpsimd.c: void fpsimd_signal_preserve_current_state(void)
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
     +	*host_data_ptr(fpsimd_state) = NULL;
     +	*host_data_ptr(fpmr_ptr) = NULL;
      
    - 	host_data_clear_flag(HOST_SVE_ENABLED);
    + 	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
      	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
    - 		host_data_clear_flag(HOST_SME_ENABLED);
    + 		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
      		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
    - 			host_data_set_flag(HOST_SME_ENABLED);
    + 			vcpu_set_flag(vcpu, HOST_SME_ENABLED);
     -
     -		/*
     -		 * If PSTATE.SM is enabled then save any pending FP
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

