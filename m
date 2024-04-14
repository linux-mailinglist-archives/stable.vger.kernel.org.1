Return-Path: <stable+bounces-38746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1338A1031
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89899B22B23
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929761474C3;
	Thu, 11 Apr 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OgovJ7ED"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F961D558;
	Thu, 11 Apr 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831468; cv=none; b=lTagoxtYwsYAAq6FA+O2w+EQv48sP/3IOLzAbfrBbAZLR4DwnmdVIFkiyL6DOvoNo8kqaspa8h1VfSEPLAwmO+2SkJQEzuB02kpzpwpjzi4eoiyIIz0ieBhb4R1w611bNduTL7ulbGwkpSefOJ5xmKS5aVkAcZMXT09viC8p3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831468; c=relaxed/simple;
	bh=1TFVLGueVGlN4DMtbl8WJ1S5wq2YamsR0S+VsMAw6t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tr+EIoN8hdVreY3Y0SDLemDGYW/vO1U6LO8gIPFfPOmlaZSkD2gBMF2yJXAIOOQHubBomgA28QpiC8otBje78xHOa/iwLuBdkXJwa/slwhAp642CheOAJXDM86T6fi48cPFGRV5dkkbAio1j0L24Hf1/zsCg1RJF6OkDB84BbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OgovJ7ED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C128CC43394;
	Thu, 11 Apr 2024 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831468;
	bh=1TFVLGueVGlN4DMtbl8WJ1S5wq2YamsR0S+VsMAw6t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgovJ7EDPQbMgyjNEIEchhyqI7Ggk+ve3wqIp1bCfShjSxAFOFTO+wnMB27+Qi/rp
	 lXhCfS9Spg9riezNl+BUCuEb4JFrhS2qAk1N9q754Q3C4HxHm/VAObtJnpYyTNId2T
	 9rnvaGodGBCbqVeu2tncw9YwwqYLqq847cJwp8YA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH 5.10 003/294] x86/bugs: Use sysfs_emit()
Date: Thu, 11 Apr 2024 11:52:46 +0200
Message-ID: <20240411095435.741440247@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 1d30800c0c0ae1d086ffad2bdf0ba4403370f132 upstream.

Those mitigations are very talkative; use the printing helper which pays
attention to the buffer size.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220809153419.10182-1-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |  105 ++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2436,74 +2436,74 @@ static const char * const l1tf_vmx_state
 static ssize_t l1tf_show_state(char *buf)
 {
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_AUTO)
-		return sprintf(buf, "%s\n", L1TF_DEFAULT_MSG);
+		return sysfs_emit(buf, "%s\n", L1TF_DEFAULT_MSG);
 
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_EPT_DISABLED ||
 	    (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER &&
 	     sched_smt_active())) {
-		return sprintf(buf, "%s; VMX: %s\n", L1TF_DEFAULT_MSG,
-			       l1tf_vmx_states[l1tf_vmx_mitigation]);
+		return sysfs_emit(buf, "%s; VMX: %s\n", L1TF_DEFAULT_MSG,
+				  l1tf_vmx_states[l1tf_vmx_mitigation]);
 	}
 
-	return sprintf(buf, "%s; VMX: %s, SMT %s\n", L1TF_DEFAULT_MSG,
-		       l1tf_vmx_states[l1tf_vmx_mitigation],
-		       sched_smt_active() ? "vulnerable" : "disabled");
+	return sysfs_emit(buf, "%s; VMX: %s, SMT %s\n", L1TF_DEFAULT_MSG,
+			  l1tf_vmx_states[l1tf_vmx_mitigation],
+			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
 static ssize_t itlb_multihit_show_state(char *buf)
 {
 	if (!boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
 	    !boot_cpu_has(X86_FEATURE_VMX))
-		return sprintf(buf, "KVM: Mitigation: VMX unsupported\n");
+		return sysfs_emit(buf, "KVM: Mitigation: VMX unsupported\n");
 	else if (!(cr4_read_shadow() & X86_CR4_VMXE))
-		return sprintf(buf, "KVM: Mitigation: VMX disabled\n");
+		return sysfs_emit(buf, "KVM: Mitigation: VMX disabled\n");
 	else if (itlb_multihit_kvm_mitigation)
-		return sprintf(buf, "KVM: Mitigation: Split huge pages\n");
+		return sysfs_emit(buf, "KVM: Mitigation: Split huge pages\n");
 	else
-		return sprintf(buf, "KVM: Vulnerable\n");
+		return sysfs_emit(buf, "KVM: Vulnerable\n");
 }
 #else
 static ssize_t l1tf_show_state(char *buf)
 {
-	return sprintf(buf, "%s\n", L1TF_DEFAULT_MSG);
+	return sysfs_emit(buf, "%s\n", L1TF_DEFAULT_MSG);
 }
 
 static ssize_t itlb_multihit_show_state(char *buf)
 {
-	return sprintf(buf, "Processor vulnerable\n");
+	return sysfs_emit(buf, "Processor vulnerable\n");
 }
 #endif
 
 static ssize_t mds_show_state(char *buf)
 {
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
-		return sprintf(buf, "%s; SMT Host state unknown\n",
-			       mds_strings[mds_mitigation]);
+		return sysfs_emit(buf, "%s; SMT Host state unknown\n",
+				  mds_strings[mds_mitigation]);
 	}
 
 	if (boot_cpu_has(X86_BUG_MSBDS_ONLY)) {
-		return sprintf(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
-			       (mds_mitigation == MDS_MITIGATION_OFF ? "vulnerable" :
-			        sched_smt_active() ? "mitigated" : "disabled"));
+		return sysfs_emit(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
+				  (mds_mitigation == MDS_MITIGATION_OFF ? "vulnerable" :
+				   sched_smt_active() ? "mitigated" : "disabled"));
 	}
 
-	return sprintf(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
-		       sched_smt_active() ? "vulnerable" : "disabled");
+	return sysfs_emit(buf, "%s; SMT %s\n", mds_strings[mds_mitigation],
+			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
 static ssize_t tsx_async_abort_show_state(char *buf)
 {
 	if ((taa_mitigation == TAA_MITIGATION_TSX_DISABLED) ||
 	    (taa_mitigation == TAA_MITIGATION_OFF))
-		return sprintf(buf, "%s\n", taa_strings[taa_mitigation]);
+		return sysfs_emit(buf, "%s\n", taa_strings[taa_mitigation]);
 
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
-		return sprintf(buf, "%s; SMT Host state unknown\n",
-			       taa_strings[taa_mitigation]);
+		return sysfs_emit(buf, "%s; SMT Host state unknown\n",
+				  taa_strings[taa_mitigation]);
 	}
 
-	return sprintf(buf, "%s; SMT %s\n", taa_strings[taa_mitigation],
-		       sched_smt_active() ? "vulnerable" : "disabled");
+	return sysfs_emit(buf, "%s; SMT %s\n", taa_strings[taa_mitigation],
+			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
 static ssize_t mmio_stale_data_show_state(char *buf)
@@ -2571,47 +2571,46 @@ static char *pbrsb_eibrs_state(void)
 static ssize_t spectre_v2_show_state(char *buf)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_LFENCE)
-		return sprintf(buf, "Vulnerable: LFENCE\n");
+		return sysfs_emit(buf, "Vulnerable: LFENCE\n");
 
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
-		return sprintf(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
+		return sysfs_emit(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
 
 	if (sched_smt_active() && unprivileged_ebpf_enabled() &&
 	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
-		return sprintf(buf, "Vulnerable: eIBRS+LFENCE with unprivileged eBPF and SMT\n");
+		return sysfs_emit(buf, "Vulnerable: eIBRS+LFENCE with unprivileged eBPF and SMT\n");
 
-	return sprintf(buf, "%s%s%s%s%s%s%s\n",
-		       spectre_v2_strings[spectre_v2_enabled],
-		       ibpb_state(),
-		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
-		       stibp_state(),
-		       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
-		       pbrsb_eibrs_state(),
-		       spectre_v2_module_string());
+	return sysfs_emit(buf, "%s%s%s%s%s%s%s\n",
+			  spectre_v2_strings[spectre_v2_enabled],
+			  ibpb_state(),
+			  boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
+			  stibp_state(),
+			  boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
+			  pbrsb_eibrs_state(),
+			  spectre_v2_module_string());
 }
 
 static ssize_t srbds_show_state(char *buf)
 {
-	return sprintf(buf, "%s\n", srbds_strings[srbds_mitigation]);
+	return sysfs_emit(buf, "%s\n", srbds_strings[srbds_mitigation]);
 }
 
 static ssize_t retbleed_show_state(char *buf)
 {
 	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
 	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-	    if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-		boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
-		    return sprintf(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
-
-	    return sprintf(buf, "%s; SMT %s\n",
-			   retbleed_strings[retbleed_mitigation],
-			   !sched_smt_active() ? "disabled" :
-			   spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
-			   spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ?
-			   "enabled with STIBP protection" : "vulnerable");
+		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+			return sysfs_emit(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
+
+		return sysfs_emit(buf, "%s; SMT %s\n", retbleed_strings[retbleed_mitigation],
+				  !sched_smt_active() ? "disabled" :
+				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ?
+				  "enabled with STIBP protection" : "vulnerable");
 	}
 
-	return sprintf(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
+	return sysfs_emit(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
 static ssize_t gds_show_state(char *buf)
@@ -2633,26 +2632,26 @@ static ssize_t cpu_show_common(struct de
 			       char *buf, unsigned int bug)
 {
 	if (!boot_cpu_has_bug(bug))
-		return sprintf(buf, "Not affected\n");
+		return sysfs_emit(buf, "Not affected\n");
 
 	switch (bug) {
 	case X86_BUG_CPU_MELTDOWN:
 		if (boot_cpu_has(X86_FEATURE_PTI))
-			return sprintf(buf, "Mitigation: PTI\n");
+			return sysfs_emit(buf, "Mitigation: PTI\n");
 
 		if (hypervisor_is_type(X86_HYPER_XEN_PV))
-			return sprintf(buf, "Unknown (XEN PV detected, hypervisor mitigation required)\n");
+			return sysfs_emit(buf, "Unknown (XEN PV detected, hypervisor mitigation required)\n");
 
 		break;
 
 	case X86_BUG_SPECTRE_V1:
-		return sprintf(buf, "%s\n", spectre_v1_strings[spectre_v1_mitigation]);
+		return sysfs_emit(buf, "%s\n", spectre_v1_strings[spectre_v1_mitigation]);
 
 	case X86_BUG_SPECTRE_V2:
 		return spectre_v2_show_state(buf);
 
 	case X86_BUG_SPEC_STORE_BYPASS:
-		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
+		return sysfs_emit(buf, "%s\n", ssb_strings[ssb_mode]);
 
 	case X86_BUG_L1TF:
 		if (boot_cpu_has(X86_FEATURE_L1TF_PTEINV))
@@ -2688,7 +2687,7 @@ static ssize_t cpu_show_common(struct de
 		break;
 	}
 
-	return sprintf(buf, "Vulnerable\n");
+	return sysfs_emit(buf, "Vulnerable\n");
 }
 
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)



