Return-Path: <stable+bounces-125763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D8A6C16C
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14803B63B8
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555E22D7B2;
	Fri, 21 Mar 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrCPLZaJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B61DEFFC
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577975; cv=none; b=rCgQ/3qlD/H79NVyhuLe0+OJlyOb/rqh5uutTb5L11Y6ZnK24pslicvj4QYZPisrAqQFidr0937y8CjNxywxoerlXC1q1ffGtoUKoGbY5Do1/Btk5WsWQ88mvoIZhGucQTXG3uRo1krlqTpVrCfjQgCsiMvkSiH5MAWUzLxYe4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577975; c=relaxed/simple;
	bh=75A/ibOLnxF1FArN0BXtwbBE9R8R3gBGM9nHTuy/nUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rljhBLdW53i/DfahQyjnn1gazpQrRi8EgyLavEB4wpFDokRnmMEozS0mk1VJEpC9yzoMknkiFoKAaqK2FIleJGZekfbQi89YDj6QtMQySd/M8od6KupLtn6dqNcIKvziayHXmKjowNU/UygOkjqOJ3s/Pfyx45HjGw+WmdNmk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrCPLZaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA53C4CEE3;
	Fri, 21 Mar 2025 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577974;
	bh=75A/ibOLnxF1FArN0BXtwbBE9R8R3gBGM9nHTuy/nUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrCPLZaJRwpWCiz3MQaM4LlPOXOQkZwC6Q+caFdC7TO1JGECudnoDw/W5GxcuT3dv
	 QPPsBdhAtBngmNn6Vb4cbG7KXo8ZoRMaAN0mPc7RkyRRbP6lHSuFBfgffA0yHhPw6k
	 NdmJjPGkTC8NXLod/fwS3BovXWTEKowHw2JfBUYXN2DJ/Zei2sEjau/qTpqk48bKHg
	 0IZCJ8rpUrilV4xDuhKHbOMt6+UJXz2BUFh5sXKoU1HI4EtjaL0EWtVgbDkJCxp6Ae
	 JYecblFy9KDblL5lEfyas4Ioj7Wc1AYZlTWrIIbuPJuTwWX1NUOvPiETGEmf720UDm
	 sO2Zz2M3u9TuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 4/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
Date: Fri, 21 Mar 2025 13:26:02 -0400
Message-Id: <20250321111017-2c5cd1053133bcc8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-12-v2-4-417ca2278d18@kernel.org>
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

The upstream commit SHA1 provided is correct: 459f059be702056d91537b99a129994aa6ccdd35

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 73882a98030a)

Note: The patch differs from the upstream commit:
---
1:  459f059be7020 ! 1:  416ce5863c885 KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
     
    +    [ Upstream commit 459f059be702056d91537b99a129994aa6ccdd35 ]
    +
         When KVM is in VHE mode, the host kernel tries to save and restore the
         configuration of CPACR_EL1.ZEN (i.e. CPTR_EL2.ZEN when HCR_EL2.E2H=1)
         across kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp(), since the
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-4-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    [Rework for refactoring of where the flags are stored -- broonie]
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/include/asm/kvm_host.h ##
    -@@ arch/arm64/include/asm/kvm_host.h: struct cpu_sve_state {
    - struct kvm_host_data {
    - #define KVM_HOST_DATA_FLAG_HAS_SPE			0
    - #define KVM_HOST_DATA_FLAG_HAS_TRBE			1
    --#define KVM_HOST_DATA_FLAG_HOST_SVE_ENABLED		2
    - #define KVM_HOST_DATA_FLAG_HOST_SME_ENABLED		3
    - #define KVM_HOST_DATA_FLAG_TRBE_ENABLED			4
    - #define KVM_HOST_DATA_FLAG_EL1_TRACING_CONFIGURED	5
    +@@ arch/arm64/include/asm/kvm_host.h: struct kvm_vcpu_arch {
    + /* Save TRBE context if active  */
    + #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
    + 
    +-/* SVE enabled for host EL0 */
    +-#define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
    + /* SME enabled for EL0 */
    + #define HOST_SME_ENABLED	__vcpu_single_flag(sflags, BIT(1))
    + /* Physical CPU not in supported_cpus */
     
      ## arch/arm64/kvm/fpsimd.c ##
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
      	fpsimd_save_and_flush_cpu_state();
      	*host_data_ptr(fp_owner) = FP_STATE_FREE;
      
    --	host_data_clear_flag(HOST_SVE_ENABLED);
    +-	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
     -	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
    --		host_data_set_flag(HOST_SVE_ENABLED);
    +-		vcpu_set_flag(vcpu, HOST_SVE_ENABLED);
     -
      	if (system_supports_sme()) {
    - 		host_data_clear_flag(HOST_SME_ENABLED);
    + 		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
      		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
     @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
      		 * when needed.
    @@ arch/arm64/kvm/fpsimd.c: void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
     -		 * for EL0.  To avoid spurious traps, restore the trap state
     -		 * seen by kvm_arch_vcpu_load_fp():
     -		 */
    --		if (host_data_test_flag(HOST_SVE_ENABLED))
    +-		if (vcpu_get_flag(vcpu, HOST_SVE_ENABLED))
     -			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
     -		else
     -			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

