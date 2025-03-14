Return-Path: <stable+bounces-124489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A6A62153
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0348F462817
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440915D5C4;
	Fri, 14 Mar 2025 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an6hZJVZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142081F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993831; cv=none; b=k2NcfNlzB6oWfHo46XuoWL3moRUFLz7fuqSR9xGXnIJfPoj4GDHPo19F2U50iArMASSJdVDqaoalZHlVCBm2hvIg5aM2cM7eO9ODyQ/XhScpYbkswNnwWXb34XFXqzr0g7zwauzQ9XY2PQ27EBVBrxMITo7yns3Uo24LEKYpGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993831; c=relaxed/simple;
	bh=nxFMc+L9YfP1v8IogO45rGla5D6pWHDVUGjWz308pKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0VXKcI/fiSR43fW6kQ3AejnBlGBzSm/pXC1TVhvJbedpQ0Ht98UvUMtQ1qQibrXtOOrWVmBfOnB7AWT9hUXnEpvkucvlMEMez1I4J8DKNx92MGouwMQUqd9u9YcwWHTsbYIrCiuKNgAIoW1x5fkhFyI0yAocvggX2sFPaZevVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an6hZJVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D35FC4CEE3;
	Fri, 14 Mar 2025 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993830;
	bh=nxFMc+L9YfP1v8IogO45rGla5D6pWHDVUGjWz308pKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=an6hZJVZ/aFWr3zRnuNzx+reNo4nx9rixUZ5qFTV1H+HYPZFIJj/qHyA6OkGqoW37
	 QBXhjvD4n2QKoY2OCY7fRBIuOcMTqhQZOXRQrTxXoyyhuRCt1vtrK+eGsbeURH07/w
	 rdSA5vA+1GM5ZLdP/KoMQyEbh7asM5EuwmAA1JTqgMMwl62XqlQ6B56KcEF59lmDJy
	 SP71bFEK85Xi8dSIiuoV0RbjA8ewNcaRT+GrOZ6Aqgk/RXOjw8ncLbJSY9Av6kojLc
	 Sq9vzZdT91f1JPHjPPIxxuptNs9yubG4mu0UpyY+aqTsdqfBFWePoWXoAQyYRLRghe
	 F56LLLz7N/92g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 2/8] KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
Date: Fri, 14 Mar 2025 19:10:29 -0400
Message-Id: <20250314084454-f6b9eefa880238c8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250314-stable-sve-6-12-v1-2-ddc16609d9ba@kernel.org>
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

Status in newer kernel trees:
6.13.y | Present (different SHA1: 366facfeda71)

Note: The patch differs from the upstream commit:
---
1:  fbc7e61195e23 ! 1:  1fefc174e3c48 KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
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
| stable/linux-6.12.y       |  Success    |  Success   |

