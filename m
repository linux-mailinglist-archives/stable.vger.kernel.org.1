Return-Path: <stable+bounces-144324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D06AB62C3
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DDE461261
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A11F9F7C;
	Wed, 14 May 2025 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVeuYZ3v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827B1DF751
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202972; cv=none; b=mplYI/P5YYOMW/h3ZxK5bQJ16V/ViUJ8agW/3UD0aCbxF2B8bWEzgd8KsGE1c0YUJ9yTxwYVLRkayfGGqm04auMerk8EguhM/A3zpH0+dSdyOOzF/nBy7mu2LNhoxZR1aiVPMbPUasWRg0mxYxIObLyTbdbwUcwrU/wGicyvESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202972; c=relaxed/simple;
	bh=Y94pK2HHCx9187X+EDy2T5cu3LWMqy5/to36jO+Ag6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXHDxMT5IQsWNod8CRLrPXtBZm2mPwEVymU+3iBtsY9qySStxOtjYzI8S0rw3U0oVLjivbeJUYiaz9HrQHyRPyI+MndA1QJiJ0HhA/rCOEGI0VGBoquBtqJlnciFy0sCQBLGpXn06f7VBw60K8pVeC1SinNwr3FUu3cpD+cquhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVeuYZ3v; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202970; x=1778738970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y94pK2HHCx9187X+EDy2T5cu3LWMqy5/to36jO+Ag6o=;
  b=KVeuYZ3v+CtppcwflOTb01/tbPtdmrJK/EihhB0iK6rjJKwLYRPfCVLP
   AD6il6MBvKN0ULFWIaX0P5cc79NpZXZjSkNeJqVC4D0TXGcI+Z7KhkbsK
   hKqhjeVOS6na9X6ReNHQTRdzI5frOLVOg9mMsNBMFdKEut1RfGutjB6t/
   i8L6MC7x9WRFPPkstB0d8EfW9JUd/JZA2borojrR+pfGMpAaOCM2hEHu1
   ZIZ+O06MtB+7PfIvuR/PeW41BYuZ8oqzSCIGXhy1HAdYKECGFKYDEkDUg
   JVizcTL4RRk2y668PX4XEpKLDSESuaD/+grXBNGseyWu0QqHVGDZux5Ee
   Q==;
X-CSE-ConnectionGUID: FkYw2GFRSS2xlnr6KkZQmw==
X-CSE-MsgGUID: n95oC7x6SGOSpNs1n4dMzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="52887772"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="52887772"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:09:30 -0700
X-CSE-ConnectionGUID: DsoPUlo7QsiRh3Ne/6aK/A==
X-CSE-MsgGUID: /YQL63V6TyiNW/UjLyqPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142698153"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:09:30 -0700
Date: Tue, 13 May 2025 23:09:29 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.15 v2 11/14] x86/its: Enable Indirect Target Selection
 mitigation
Message-ID: <20250513-its-5-15-v2-11-90690efdc7e0@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>

commit f4818881c47fd91fcb6d62373c57c7844e3de1c0 upstream.

Indirect Target Selection (ITS) is a bug in some pre-ADL Intel CPUs with
eIBRS. It affects prediction of indirect branch and RETs in the
lower half of cacheline. Due to ITS such branches may get wrongly predicted
to a target of (direct or indirect) branch that is located in the upper
half of the cacheline.

Scope of impact
===============

Guest/host isolation
--------------------
When eIBRS is used for guest/host isolation, the indirect branches in the
VMM may still be predicted with targets corresponding to branches in the
guest.

Intra-mode
----------
cBPF or other native gadgets can be used for intra-mode training and
disclosure using ITS.

User/kernel isolation
---------------------
When eIBRS is enabled user/kernel isolation is not impacted.

Indirect Branch Prediction Barrier (IBPB)
-----------------------------------------
After an IBPB, indirect branches may be predicted with targets
corresponding to direct branches which were executed prior to IBPB. This is
mitigated by a microcode update.

Add cmdline parameter indirect_target_selection=off|on|force to control the
mitigation to relocate the affected branches to an ITS-safe thunk i.e.
located in the upper half of cacheline. Also add the sysfs reporting.

When retpoline mitigation is deployed, ITS safe-thunks are not needed,
because retpoline sequence is already ITS-safe. Similarly, when call depth
tracking (CDT) mitigation is deployed (retbleed=stuff), ITS safe return
thunk is not used, as CDT prevents RSB-underflow.

To not overcomplicate things, ITS mitigation is not supported with
spectre-v2 lfence;jmp mitigation. Moreover, it is less practical to deploy
lfence;jmp mitigation on ITS affected parts anyways.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/kernel-parameters.txt    |  13 +++
 arch/x86/kernel/cpu/bugs.c                         | 128 ++++++++++++++++++++-
 drivers/base/cpu.c                                 |   8 ++
 include/linux/cpu.h                                |   2 +
 5 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 23e0537f6e0c79ac5448b81fb47221a9771bda18..1d657a6b1b53bd055407b1abc75e2eb49667672e 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -512,6 +512,7 @@ Description:	information about CPUs heterogeneity.
 
 What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/gather_data_sampling
+		/sys/devices/system/cpu/vulnerabilities/indirect_target_selection
 		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
 		/sys/devices/system/cpu/vulnerabilities/l1tf
 		/sys/devices/system/cpu/vulnerabilities/mds
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ede522c60ac4f1790f25c0cb5244590168608b93..e3619e868c884ca4bd786d6049d407c28e0fd994 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1926,6 +1926,18 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	indirect_target_selection= [X86,Intel] Mitigation control for Indirect
+			Target Selection(ITS) bug in Intel CPUs. Updated
+			microcode is also required for a fix in IBPB.
+
+			on:     Enable mitigation (default).
+			off:    Disable mitigation.
+			force:	Force the ITS bug and deploy default
+				mitigation.
+
+			For details see:
+			Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
+
 	init=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /sbin/init as init
@@ -3073,6 +3085,7 @@
 				improves system performance, but it may also
 				expose users to several CPU vulnerabilities.
 				Equivalent to: gather_data_sampling=off [X86]
+					       indirect_target_selection=off [X86]
 					       kpti=0 [ARM64]
 					       kvm.nx_huge_pages=off [X86]
 					       l1tf=off [X86]
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 75cd45f2338dccb9708d07af58173d0be41c9e6e..8e3fe0514144f5518755f2bc0579260e1b88d776 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -48,6 +48,7 @@ static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init srso_select_mitigation(void);
+static void __init its_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -66,6 +67,14 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
 
 void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
 
+static void __init set_return_thunk(void *thunk)
+{
+	if (x86_return_thunk != __x86_return_thunk)
+		pr_warn("x86/bugs: return thunk changed\n");
+
+	x86_return_thunk = thunk;
+}
+
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
 static void update_spec_ctrl(u64 val)
 {
@@ -174,6 +183,7 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+	its_select_mitigation();
 }
 
 /*
@@ -1081,7 +1091,7 @@ static void __init retbleed_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
 		if (IS_ENABLED(CONFIG_RETHUNK))
-			x86_return_thunk = retbleed_return_thunk;
+			set_return_thunk(retbleed_return_thunk);
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
@@ -1142,6 +1152,105 @@ static void __init retbleed_select_mitigation(void)
 	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
+#undef pr_fmt
+#define pr_fmt(fmt)     "ITS: " fmt
+
+enum its_mitigation_cmd {
+	ITS_CMD_OFF,
+	ITS_CMD_ON,
+};
+
+enum its_mitigation {
+	ITS_MITIGATION_OFF,
+	ITS_MITIGATION_ALIGNED_THUNKS,
+};
+
+static const char * const its_strings[] = {
+	[ITS_MITIGATION_OFF]			= "Vulnerable",
+	[ITS_MITIGATION_ALIGNED_THUNKS]		= "Mitigation: Aligned branch/return thunks",
+};
+
+static enum its_mitigation its_mitigation __ro_after_init = ITS_MITIGATION_ALIGNED_THUNKS;
+
+static enum its_mitigation_cmd its_cmd __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_ITS) ? ITS_CMD_ON : ITS_CMD_OFF;
+
+static int __init its_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_MITIGATION_ITS)) {
+		pr_err("Mitigation disabled at compile time, ignoring option (%s)", str);
+		return 0;
+	}
+
+	if (!strcmp(str, "off")) {
+		its_cmd = ITS_CMD_OFF;
+	} else if (!strcmp(str, "on")) {
+		its_cmd = ITS_CMD_ON;
+	} else if (!strcmp(str, "force")) {
+		its_cmd = ITS_CMD_ON;
+		setup_force_cpu_bug(X86_BUG_ITS);
+	} else {
+		pr_err("Ignoring unknown indirect_target_selection option (%s).", str);
+	}
+
+	return 0;
+}
+early_param("indirect_target_selection", its_parse_cmdline);
+
+static void __init its_select_mitigation(void)
+{
+	enum its_mitigation_cmd cmd = its_cmd;
+
+	if (!boot_cpu_has_bug(X86_BUG_ITS) || cpu_mitigations_off()) {
+		its_mitigation = ITS_MITIGATION_OFF;
+		return;
+	}
+
+	/* Exit early to avoid irrelevant warnings */
+	if (cmd == ITS_CMD_OFF) {
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+	if (spectre_v2_enabled == SPECTRE_V2_NONE) {
+		pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+	if (!IS_ENABLED(CONFIG_RETPOLINE) || !IS_ENABLED(CONFIG_RETHUNK)) {
+		pr_err("WARNING: ITS mitigation depends on retpoline and rethunk support\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+	if (IS_ENABLED(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)) {
+		pr_err("WARNING: ITS mitigation is not compatible with CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+		pr_err("WARNING: ITS mitigation is not compatible with lfence mitigation\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+
+	switch (cmd) {
+	case ITS_CMD_OFF:
+		its_mitigation = ITS_MITIGATION_OFF;
+		break;
+	case ITS_CMD_ON:
+		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+		if (!boot_cpu_has(X86_FEATURE_RETPOLINE))
+			setup_force_cpu_cap(X86_FEATURE_INDIRECT_THUNK_ITS);
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		set_return_thunk(its_return_thunk);
+		break;
+	}
+out:
+	pr_info("%s\n", its_strings[its_mitigation]);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
@@ -2591,10 +2700,10 @@ static void __init srso_select_mitigation(void)
 
 			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				x86_return_thunk = srso_alias_return_thunk;
+				set_return_thunk(srso_alias_return_thunk);
 			} else {
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
-				x86_return_thunk = srso_return_thunk;
+				set_return_thunk(srso_return_thunk);
 			}
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 		} else {
@@ -2774,6 +2883,11 @@ static ssize_t rfds_show_state(char *buf)
 	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
 }
 
+static ssize_t its_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", its_strings[its_mitigation]);
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
@@ -2958,6 +3072,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_RFDS:
 		return rfds_show_state(buf);
 
+	case X86_BUG_ITS:
+		return its_show_state(buf);
+
 	default:
 		break;
 	}
@@ -3037,4 +3154,9 @@ ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attrib
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
 }
+
+ssize_t cpu_show_indirect_target_selection(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_ITS);
+}
 #endif
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 93222cf391576917e56249a585e3c93acb02d965..df196e0730972cc2bb435c01d938ce28ff5cbba0 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -595,6 +595,12 @@ ssize_t __weak cpu_show_reg_file_data_sampling(struct device *dev,
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_indirect_target_selection(struct device *dev,
+						  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -609,6 +615,7 @@ static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
+static DEVICE_ATTR(indirect_target_selection, 0444, cpu_show_indirect_target_selection, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -625,6 +632,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_spec_rstack_overflow.attr,
 	&dev_attr_reg_file_data_sampling.attr,
+	&dev_attr_indirect_target_selection.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index e1e6a045c38b77ad9984cee9e132097903c70617..87b5a176e8489756b0b5d174afc93328ee50233b 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -76,6 +76,8 @@ extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 					       struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_indirect_target_selection(struct device *dev,
+						  struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,

-- 
2.34.1



