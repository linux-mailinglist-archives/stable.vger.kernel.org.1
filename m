Return-Path: <stable+bounces-124296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C5A5F48D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB7219C22D6
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477A26770C;
	Thu, 13 Mar 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQUtQoqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93479266EFE
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869103; cv=none; b=ApQY/K8GKx6gHWlXq+Wqz8mpqC7TEYOPZhbYY8Qdj/n1wZt45EjfdBd2+j9o5Z1/mUd4Is/ZL7tdIZXw8FMUWMY4mymU7b2X3F5UvnVUTLrNuHXpm1yE4SM1GGk0Nbg0qCN1NZCpoEOvbkL1htZB7eKn70f+Z1yG7EEtqC1Em/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869103; c=relaxed/simple;
	bh=AoMOSF0E6sCxqDBILL8VhXD8l2YjSdTf9MBYCKHbCHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmFGxR4NOlVA3jg0ElFp/Jh8DMgZXd1QrTqgV9KZZGLD5EF2cWoQhYu1qq3w410/8QqHUdE/BQ/RuN7zrG3LZuGlbcf/VprH72aWRrFkzQyG3MhJXlX0SSY4l8LSss6o2mssfI9ac3wdn9FO8/m4WGYSHNgyZTL2bkcJ/rxEmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQUtQoqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9875FC4CEEA;
	Thu, 13 Mar 2025 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869101;
	bh=AoMOSF0E6sCxqDBILL8VhXD8l2YjSdTf9MBYCKHbCHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQUtQoqKI120h1PnREbHNY5cWvVoXSQk+pffj1mzJ8hD5/JaMu5RXLxM+t211UUby
	 KtwPoh02C4yybGHiyXTMf1JaenNywkmSSJFFHoHCIRM+lxO5qEwygVzGkph2ZK2sbQ
	 RdwzBZZeFIZmoE5VtQHlJbjfruLMxXM4VoH8sm+FWL5NzuAWELRT8NV6RR+sLXvQW8
	 8kSKQIN8aCSUMvc8kckR4vdIJwfGZUrUEfFLOKY5ctnrf/UrYpehTB5GsExGRnyzuq
	 AzkIQRIC4pEFgpoDlYP9gSC+fy010KyXCeE1XxpLq0dmZgH1m9fPSdL1OkQcZ5mGKH
	 nc9kqy29k4Qwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 3/8] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Date: Thu, 13 Mar 2025 08:31:39 -0400
Message-Id: <20250313054807-6da803b7c80a3ecb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250312-stable-sve-6-13-v1-3-c7ba07a6f4f7@kernel.org>
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
1:  8eca7f6d5100b ! 1:  bbc2654d04d6e KVM: arm64: Remove host FPSIMD saving for non-protected KVM
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
| stable/linux-6.13.y       |  Success    |  Success   |

