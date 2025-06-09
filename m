Return-Path: <stable+bounces-151966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 255CDAD16D8
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D775F168EF8
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D572459F1;
	Mon,  9 Jun 2025 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkJH6IRS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123D2459C9
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436462; cv=none; b=BAqsaRI5YkQPRqD6FD/CI7Z6wRvYbDdUpCuzifWI8rG9j7/7oSIOV2me95DCaFmtg/c+6Ksq0OC6UuKWhyL2xtW3HQ07v/KK/r5Y6Yf5QK0yZpM9v8LpjPKFk2loVRoJxyKIMdFZap+FGbWdC86TLAeEQrDbVKlF7MuMN7CVkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436462; c=relaxed/simple;
	bh=S8UVx+rV6GbE2/xu9iQdfVh1NwSNU62Pdq2jUNThZb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3Nsqv2iw25PjoPDq/Td3zM50U75S3uwwyQRJF+WcVs0R/YUVEl3xCJsQUNjyT3Jkzn8Pl0pnvKFGaHKdoZjO+q4uBpn2td8s97IpcQF+hJ1nVx5Sa6h7Fm2UQsT72wkOvD4Dh8yvBI4y+Ugne0kHGFudKQRNftt3sNAe3/eiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkJH6IRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA27C4CEEE;
	Mon,  9 Jun 2025 02:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436461;
	bh=S8UVx+rV6GbE2/xu9iQdfVh1NwSNU62Pdq2jUNThZb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkJH6IRSRsWEcTGci/aVS3cUZCwFLm6J0rtkcaTrc9iPvZ5daDloi2uv/EWev0ClI
	 9xDU/26fh8LsN7+dDOOmaJypxz5QZghYjnXnYC8b4oqJJnSQG1/CwffiuG6bVq01+X
	 8RFN1E51Va29UpMinw+MLEYtg2gaqBSm3R0Cz3k2xdMmBJB1UosHLlWFJsqdEe/ZlJ
	 ldEaZ51dsOUR3sluw03s/kKOPnAu3CbMLzCesxLbUDM23FytrNkjKDqpBCPeFWgFnp
	 56UQvx+KmWbM0ohGtladQpGz/LuO7RoneoFXwJQXTnsOkZkqOdbkPv9hQBC7a/g7vW
	 IPHCM+EA/0RKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 06/14] arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
Date: Sun,  8 Jun 2025 22:34:20 -0400
Message-Id: <20250608191741-46a0167fe6ba9e1e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-7-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: e403e8538359d8580cbee1976ff71813e947101e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Douglas Anderson<dianders@chromium.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 1847162b0f1d)
6.12.y | Present (different SHA1: 3b0f2526c87e)
6.6.y | Present (different SHA1: 3ca6b0c9171b)
6.1.y | Present (different SHA1: f2e4ca0c40cd)
5.15.y | Present (different SHA1: 8cb58a817a45)

Note: The patch differs from the upstream commit:
---
1:  e403e8538359d ! 1:  85de55abe5b05 arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
    @@ Metadata
      ## Commit message ##
         arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
     
    +    [ Upstream commit e403e8538359d8580cbee1976ff71813e947101e ]
    +
         The code for detecting CPUs that are vulnerable to Spectre BHB was
         based on a hardcoded list of CPU IDs that were known to be affected.
         Unfortunately, the list mostly only contained the IDs of standard ARM
    @@ Commit message
         Signed-off-by: Douglas Anderson <dianders@chromium.org>
         Link: https://lore.kernel.org/r/20250107120555.v4.2.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Conflicts:
    +            arch/arm64/kernel/proton-pack.c
    +    [The conflicts were mainly due to LTS commit e192c8baa69a
    +    differ from mainline commit 558c303c9734]
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/spectre.h ##
    -@@ arch/arm64/include/asm/spectre.h: enum mitigation_state arm64_get_meltdown_state(void);
    - 
    +@@ arch/arm64/include/asm/spectre.h: void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
      enum mitigation_state arm64_get_spectre_bhb_state(void);
      bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
    + bool is_spectre_bhb_fw_mitigated(void);
     -u8 spectre_bhb_loop_affected(int scope);
      void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
      bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
    - 
    + #endif	/* __ASM_SPECTRE_H */
     
      ## arch/arm64/kernel/proton-pack.c ##
    -@@ arch/arm64/kernel/proton-pack.c: static unsigned long system_bhb_mitigations;
    +@@ arch/arm64/kernel/proton-pack.c: enum mitigation_state arm64_get_spectre_bhb_state(void)
       * This must be called with SCOPE_LOCAL_CPU for each type of CPU, before any
       * SCOPE_SYSTEM call will give the right answer.
       */
    @@ arch/arm64/kernel/proton-pack.c: static enum mitigation_state spectre_bhb_get_cp
      
      static bool supports_ecbhb(int scope)
     @@ arch/arm64/kernel/proton-pack.c: static bool supports_ecbhb(int scope)
    - 						    ID_AA64MMFR1_EL1_ECBHB_SHIFT);
    + 						    ID_AA64MMFR1_ECBHB_SHIFT);
      }
      
     +static u8 max_bhb_k;
    @@ arch/arm64/kernel/proton-pack.c: bool is_spectre_bhb_affected(const struct arm64
      }
      
      static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
    -@@ arch/arm64/kernel/proton-pack.c: early_param("nospectre_bhb", parse_spectre_bhb_param);
    +@@ arch/arm64/kernel/proton-pack.c: static bool spectre_bhb_fw_mitigated;
    + 
      void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
      {
    - 	bp_hardening_cb_t cpu_cb;
     -	enum mitigation_state fw_state, state = SPECTRE_VULNERABLE;
     +	enum mitigation_state state = SPECTRE_VULNERABLE;
    - 	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
      
      	if (!is_spectre_bhb_affected(entry, SCOPE_LOCAL_CPU))
    + 		return;
     @@ arch/arm64/kernel/proton-pack.c: void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
      		this_cpu_set_vectors(EL1_VECTOR_BHB_CLEAR_INSN);
    + 
      		state = SPECTRE_MITIGATED;
    - 		set_bit(BHB_INSN, &system_bhb_mitigations);
     -	} else if (spectre_bhb_loop_affected(SCOPE_LOCAL_CPU)) {
    +-		switch (spectre_bhb_loop_affected(SCOPE_SYSTEM)) {
     +	} else if (spectre_bhb_loop_affected()) {
    - 		/*
    - 		 * Ensure KVM uses the indirect vector which will have the
    - 		 * branchy-loop added. A57/A72-r0 will already have selected
    ++		switch (max_bhb_k) {
    + 		case 8:
    + 			kvm_setup_bhb_slot(__spectre_bhb_loop_k8);
    + 			break;
     @@ arch/arm64/kernel/proton-pack.c: void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
      		this_cpu_set_vectors(EL1_VECTOR_BHB_LOOP);
    + 
      		state = SPECTRE_MITIGATED;
    - 		set_bit(BHB_LOOP, &system_bhb_mitigations);
     -	} else if (is_spectre_bhb_fw_affected(SCOPE_LOCAL_CPU)) {
     -		fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
     -		if (fw_state == SPECTRE_MITIGATED) {
    --			/*
    --			 * Ensure KVM uses one of the spectre bp_hardening
    --			 * vectors. The indirect vector doesn't include the EL3
    --			 * call, so needs upgrading to
    --			 * HYP_VECTOR_SPECTRE_INDIRECT.
    --			 */
    --			if (!data->slot || data->slot == HYP_VECTOR_INDIRECT)
    --				data->slot += 1;
    --
    +-			kvm_setup_bhb_slot(__smccc_workaround_3_smc);
     -			this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
     -
    --			/*
    --			 * The WA3 call in the vectors supersedes the WA1 call
    --			 * made during context-switch. Uninstall any firmware
    --			 * bp_hardening callback.
    --			 */
    --			cpu_cb = spectre_v2_get_sw_mitigation_cb();
    --			if (__this_cpu_read(bp_hardening_data.fn) != cpu_cb)
    --				__this_cpu_write(bp_hardening_data.fn, NULL);
    --
     -			state = SPECTRE_MITIGATED;
    --			set_bit(BHB_FW, &system_bhb_mitigations);
    +-			spectre_bhb_fw_mitigated = true;
     -		}
     +	} else if (has_spectre_bhb_fw_mitigation()) {
    -+		/*
    -+		 * Ensure KVM uses one of the spectre bp_hardening
    -+		 * vectors. The indirect vector doesn't include the EL3
    -+		 * call, so needs upgrading to
    -+		 * HYP_VECTOR_SPECTRE_INDIRECT.
    -+		 */
    -+		if (!data->slot || data->slot == HYP_VECTOR_INDIRECT)
    -+			data->slot += 1;
    -+
    ++		kvm_setup_bhb_slot(__smccc_workaround_3_smc);
     +		this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
     +
    -+		/*
    -+		 * The WA3 call in the vectors supersedes the WA1 call
    -+		 * made during context-switch. Uninstall any firmware
    -+		 * bp_hardening callback.
    -+		 */
    -+		cpu_cb = spectre_v2_get_sw_mitigation_cb();
    -+		if (__this_cpu_read(bp_hardening_data.fn) != cpu_cb)
    -+			__this_cpu_write(bp_hardening_data.fn, NULL);
    -+
     +		state = SPECTRE_MITIGATED;
    -+		set_bit(BHB_FW, &system_bhb_mitigations);
    ++		spectre_bhb_fw_mitigated = true;
      	}
      
      	update_mitigation_state(&spectre_bhb_state, state);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

