Return-Path: <stable+bounces-144437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A419CAB7697
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411011BA66B2
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D62951A5;
	Wed, 14 May 2025 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfVJxIag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90A296157
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253663; cv=none; b=FwQlTHvBLZikTi4mblQeR0ZrCQfcHYPlt6BAvsrLw6bmp+RWHlK+SK1zdudOkhSQRnFoQM1Vz2gyRTWThzu4SRLXTAiMC8btY4m5XVBLOLe2LeiVDV1zHeoejSHEhaw5xW8HLie3m5rHC9fn7EDujExYTrS1PbRXNy14I8WwfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253663; c=relaxed/simple;
	bh=CLDKtYPJe6DE211m6hONvG0MTfB70HqqHKWwg8Div50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1ivqZ+h8BFCGecaTqgGXX8DvK+UjI19G8aR5MygQgDlSphgONgqRhevjaB6Chaa08OvC5xMaYtcSenvxW5rrLNpukvVFW3iWKeM8ATrVBhH/yR0kAI8mN7QFCxwewV5gIoJnOFZJwLGVvP5e4HR+nv+1slRMylBX1KrjhRrX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfVJxIag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2143CC4CEE3;
	Wed, 14 May 2025 20:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253663;
	bh=CLDKtYPJe6DE211m6hONvG0MTfB70HqqHKWwg8Div50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfVJxIagU0KcnWfINRIQisvS4wq6GwXTVZBfi/VQhRB3JVEBvhjvlz8xu5gEzok5R
	 Khz+bRBH4EZ3K8kZt3jwttLu+o0r0M5Jr01aC1NqDwLNPBpIRnjXe1TzMOFtgZJb7j
	 IwJq6GvAIICbqImFygy0AZ76xXEi4nA4mSkURJuNe/NNWDd4a7i7Y+EXOoxK8gwcqC
	 3aBJb4lpGqfb4MnCT8gTDiORpFG9YEolwhMsF2Mmk2VvWLIpWKV/Ed4wI9fCzWzKg5
	 CdeEwotWbhcafTo73+IgY4lzigj9ryVxE+ZbQZXN9uVtOpqZWK4ZLbEHCrjuRofvfw
	 8nJ/fvGMkd/cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 11/14] x86/its: Enable Indirect Target Selection mitigation
Date: Wed, 14 May 2025 16:14:18 -0400
Message-Id: <20250514113200-185cc2962e9d31fa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-11-90690efdc7e0@linux.intel.com>
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

The upstream commit SHA1 provided is correct: f4818881c47fd91fcb6d62373c57c7844e3de1c0

Status in newer kernel trees:
6.14.y | Present (different SHA1: 2530e9327957)
6.12.y | Present (different SHA1: 29a3e7d59cac)
6.6.y | Present (different SHA1: 527b6f385495)
6.1.y | Present (different SHA1: 39fdd17f075d)

Note: The patch differs from the upstream commit:
---
1:  f4818881c47fd ! 1:  e0aa87dadeb43 x86/its: Enable Indirect Target Selection mitigation
    @@ Metadata
      ## Commit message ##
         x86/its: Enable Indirect Target Selection mitigation
     
    +    commit f4818881c47fd91fcb6d62373c57c7844e3de1c0 upstream.
    +
         Indirect Target Selection (ITS) is a bug in some pre-ADL Intel CPUs with
         eIBRS. It affects prediction of indirect branch and RETs in the
         lower half of cacheline. Due to ITS such branches may get wrongly predicted
    @@ Documentation/admin-guide/kernel-parameters.txt
      			Format: <full_path>
      			Run specified binary instead of /sbin/init as init
     @@
    + 				improves system performance, but it may also
      				expose users to several CPU vulnerabilities.
    - 				Equivalent to: if nokaslr then kpti=0 [ARM64]
    - 					       gather_data_sampling=off [X86]
    + 				Equivalent to: gather_data_sampling=off [X86]
     +					       indirect_target_selection=off [X86]
    + 					       kpti=0 [ARM64]
      					       kvm.nx_huge_pages=off [X86]
      					       l1tf=off [X86]
    - 					       mds=off [X86]
     
      ## arch/x86/kernel/cpu/bugs.c ##
     @@ arch/x86/kernel/cpu/bugs.c: static void __init srbds_select_mitigation(void);
      static void __init l1d_flush_select_mitigation(void);
    - static void __init srso_select_mitigation(void);
      static void __init gds_select_mitigation(void);
    + static void __init srso_select_mitigation(void);
     +static void __init its_select_mitigation(void);
      
      /* The base value of the SPEC_CTRL MSR without task-specific bits set */
      u64 x86_spec_ctrl_base;
     @@ arch/x86/kernel/cpu/bugs.c: static DEFINE_MUTEX(spec_ctrl_mutex);
      
    - void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
    + void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
      
     +static void __init set_return_thunk(void *thunk)
     +{
    @@ arch/x86/kernel/cpu/bugs.c: void __init cpu_select_mitigations(void)
      
      /*
     @@ arch/x86/kernel/cpu/bugs.c: static void __init retbleed_select_mitigation(void)
    - 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
      		setup_force_cpu_cap(X86_FEATURE_UNRET);
      
    --		x86_return_thunk = retbleed_return_thunk;
    -+		set_return_thunk(retbleed_return_thunk);
    + 		if (IS_ENABLED(CONFIG_RETHUNK))
    +-			x86_return_thunk = retbleed_return_thunk;
    ++			set_return_thunk(retbleed_return_thunk);
      
      		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
      		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
    -@@ arch/x86/kernel/cpu/bugs.c: static void __init retbleed_select_mitigation(void)
    - 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
    - 		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
    - 
    --		x86_return_thunk = call_depth_return_thunk;
    -+		set_return_thunk(call_depth_return_thunk);
    - 		break;
    - 
    - 	default:
     @@ arch/x86/kernel/cpu/bugs.c: static void __init retbleed_select_mitigation(void)
      	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
      }
    @@ arch/x86/kernel/cpu/bugs.c: static void __init retbleed_select_mitigation(void)
     +enum its_mitigation {
     +	ITS_MITIGATION_OFF,
     +	ITS_MITIGATION_ALIGNED_THUNKS,
    -+	ITS_MITIGATION_RETPOLINE_STUFF,
     +};
     +
     +static const char * const its_strings[] = {
     +	[ITS_MITIGATION_OFF]			= "Vulnerable",
     +	[ITS_MITIGATION_ALIGNED_THUNKS]		= "Mitigation: Aligned branch/return thunks",
    -+	[ITS_MITIGATION_RETPOLINE_STUFF]	= "Mitigation: Retpolines, Stuffing RSB",
     +};
     +
     +static enum its_mitigation its_mitigation __ro_after_init = ITS_MITIGATION_ALIGNED_THUNKS;
    @@ arch/x86/kernel/cpu/bugs.c: static void __init retbleed_select_mitigation(void)
     +		return;
     +	}
     +
    -+	/* Retpoline+CDT mitigates ITS, bail out */
    -+	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
    -+	    boot_cpu_has(X86_FEATURE_CALL_DEPTH)) {
    -+		its_mitigation = ITS_MITIGATION_RETPOLINE_STUFF;
    -+		goto out;
    -+	}
    -+
     +	/* Exit early to avoid irrelevant warnings */
     +	if (cmd == ITS_CMD_OFF) {
     +		its_mitigation = ITS_MITIGATION_OFF;
    @@ arch/x86/kernel/cpu/bugs.c: static void __init retbleed_select_mitigation(void)
     +		its_mitigation = ITS_MITIGATION_OFF;
     +		goto out;
     +	}
    -+	if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) ||
    -+	    !IS_ENABLED(CONFIG_MITIGATION_RETHUNK)) {
    ++	if (!IS_ENABLED(CONFIG_RETPOLINE) || !IS_ENABLED(CONFIG_RETHUNK)) {
     +		pr_err("WARNING: ITS mitigation depends on retpoline and rethunk support\n");
     +		its_mitigation = ITS_MITIGATION_OFF;
     +		goto out;
    @@ arch/x86/kernel/cpu/bugs.c: static void __init srso_select_mitigation(void)
     -				x86_return_thunk = srso_return_thunk;
     +				set_return_thunk(srso_return_thunk);
      			}
    - 			if (has_microcode)
    - 				srso_mitigation = SRSO_MITIGATION_SAFE_RET;
    + 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
    + 		} else {
     @@ arch/x86/kernel/cpu/bugs.c: static ssize_t rfds_show_state(char *buf)
      	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
      }
    @@ arch/x86/kernel/cpu/bugs.c: ssize_t cpu_show_reg_file_data_sampling(struct devic
     +	return cpu_show_common(dev, attr, buf, X86_BUG_ITS);
     +}
      #endif
    - 
    - void __warn_thunk(void)
     
      ## drivers/base/cpu.c ##
    -@@ drivers/base/cpu.c: CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
    - CPU_SHOW_VULN_FALLBACK(gds);
    - CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
    - CPU_SHOW_VULN_FALLBACK(ghostwrite);
    -+CPU_SHOW_VULN_FALLBACK(indirect_target_selection);
    +@@ drivers/base/cpu.c: ssize_t __weak cpu_show_reg_file_data_sampling(struct device *dev,
    + 	return sysfs_emit(buf, "Not affected\n");
    + }
      
    ++ssize_t __weak cpu_show_indirect_target_selection(struct device *dev,
    ++						  struct device_attribute *attr, char *buf)
    ++{
    ++	return sysfs_emit(buf, "Not affected\n");
    ++}
    ++
      static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
      static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
    -@@ drivers/base/cpu.c: static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NU
    + static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
    +@@ drivers/base/cpu.c: static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
      static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
    + static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
      static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
    - static DEVICE_ATTR(ghostwrite, 0444, cpu_show_ghostwrite, NULL);
     +static DEVICE_ATTR(indirect_target_selection, 0444, cpu_show_indirect_target_selection, NULL);
      
      static struct attribute *cpu_root_vulnerabilities_attrs[] = {
      	&dev_attr_meltdown.attr,
     @@ drivers/base/cpu.c: static struct attribute *cpu_root_vulnerabilities_attrs[] = {
      	&dev_attr_gather_data_sampling.attr,
    + 	&dev_attr_spec_rstack_overflow.attr,
      	&dev_attr_reg_file_data_sampling.attr,
    - 	&dev_attr_ghostwrite.attr,
     +	&dev_attr_indirect_target_selection.attr,
      	NULL
      };
    @@ drivers/base/cpu.c: static struct attribute *cpu_root_vulnerabilities_attrs[] =
     
      ## include/linux/cpu.h ##
     @@ include/linux/cpu.h: extern ssize_t cpu_show_gds(struct device *dev,
    + 			    struct device_attribute *attr, char *buf);
      extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
      					       struct device_attribute *attr, char *buf);
    - extern ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute *attr, char *buf);
     +extern ssize_t cpu_show_indirect_target_selection(struct device *dev,
     +						  struct device_attribute *attr, char *buf);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

