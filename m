Return-Path: <stable+bounces-241640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAMRAPui8GlAWgEAu9opvQ
	(envelope-from <stable+bounces-241640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:07:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0AF4848E5
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9394630193EC
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341653FBEA4;
	Tue, 28 Apr 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QQWrDjpI"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA303FB045
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378003; cv=none; b=MQ6GZq33uTOfbIKMNTnpcrR6rkKb7joK2/FlzSitHzRUw9agZnmZ3VmalTOvjvJGfFUe/imImd5n2SHD2xY/ZekSqDKhsnrQnKZTO0scXw60EsTdi8t0sMH1oMkifl9h/DvlsX1SwwT8sbWdbH+3QY4hH5DlIfQF3gSd4KgYIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378003; c=relaxed/simple;
	bh=6HRqXgO2bvQmkMLiVrfp8k6uBXGW7SPTuRth880qoC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfugGntwHw/orPpEyf4Va72M8ctxTwDCDdLxXN/rNmfhVW2NlKT15/rWzvqmkaDSIVLI7NtrNMY0bdfUrkNwHfBE8hBgbpfOvkzR9UsRAu4zPjJWHN+HdjSTGa92OPBh7A3tuR+i8fVRtNamp/f9O5QfMJIk+KUL2IgWhoIMWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=QQWrDjpI; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AAD058081B;
	Tue, 28 Apr 2026 15:06:25 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:116::1:0])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA id B6YlCK1L0W20-qjHnroY4;
	Tue, 28 Apr 2026 15:06:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1777377985;
	bh=danWFPdjmHJBht5IR30BFsDbuOKSFWd59KIx2DFOCZA=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=QQWrDjpIC/q97HevSVfzw3Ckmeq59o8ExuuphUnB42ypL0fMwNCt2ZETHBi0FRaFy
	 KvWQrs7rAJ7j4boz4BFRhh+EfJl6/SYQfklKSTIi5WrvVc2f/hn+hXVo6wieN9z12z
	 xdOat3zVAl/tjSSk2X0cl0VEquZnzgloFKwB3hiE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: stable@vger.kernel.org
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6.y 5/5] x86/bugs: KVM: Add support for SRSO_MSR_FIX
Date: Tue, 28 Apr 2026 15:05:45 +0300
Message-Id: <20260428120545.1970058-6-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428120545.1970058-1-d-tatianin@yandex-team.ru>
References: <20260428120545.1970058-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E0AF4848E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241640-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,yandex-team.ru:email,yandex-team.ru:dkim,yandex-team.ru:mid]

[ Upstream commit 8442df2b49ed9bcd67833ad4f091d15ac91efd00 ]

Add support for

  CPUID Fn8000_0021_EAX[31] (SRSO_MSR_FIX). If this bit is 1, it
  indicates that software may use MSR BP_CFG[BpSpecReduce] to mitigate
  SRSO.

Enable BpSpecReduce to mitigate SRSO across guest/host boundaries.

Switch back to enabling the bit when virtualization is enabled and to
clear the bit when virtualization is disabled because using a MSR slot
would clear the bit when the guest is exited and any training the guest
has done, would potentially influence the host kernel when execution
enters the kernel and hasn't VMRUN the guest yet.

More detail on the public thread in Link below.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241202120416.6054-1-bp@kernel.org
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 Documentation/admin-guide/hw-vuln/srso.rst | 13 ++++++++++++
 arch/x86/include/asm/cpufeatures.h         |  4 ++++
 arch/x86/include/asm/msr-index.h           |  1 +
 arch/x86/kernel/cpu/bugs.c                 | 24 ++++++++++++++++++----
 arch/x86/kvm/svm/svm.c                     |  6 ++++++
 arch/x86/lib/msr.c                         |  2 ++
 6 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index e715bfc09879a..68011add73834 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -104,7 +104,20 @@ The possible values in this file are:
 
    (spec_rstack_overflow=ibpb-vmexit)
 
+ * 'Mitigation: Reduced Speculation':
 
+   This mitigation gets automatically enabled when the above one "IBPB on
+   VMEXIT" has been selected and the CPU supports the BpSpecReduce bit.
+
+   It gets automatically enabled on machines which have the
+   SRSO_USER_KERNEL_NO=1 CPUID bit. In that case, the code logic is to switch
+   to the above =ibpb-vmexit mitigation because the user/kernel boundary is
+   not affected anymore and thus "safe RET" is not needed.
+
+   After enabling the IBPB on VMEXIT mitigation option, the BpSpecReduce bit
+   is detected (functionality present on all such machines) and that
+   practically overrides IBPB on VMEXIT as it has a lot less performance
+   impact and takes care of the guest->host attack vector too.
 
 In order to exploit vulnerability, an attacker needs to:
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 154adb401a260..974c604dd81cd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -459,6 +459,10 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 #define X86_FEATURE_SRSO_USER_KERNEL_NO	(20*32+30) /* CPU is not affected by SRSO across user/kernel boundaries */
+#define X86_FEATURE_SRSO_BP_SPEC_REDUCE	(20*32+31) /*
+						    * BP_CFG[BpSpecReduce] can be used to mitigate SRSO for VMs.
+						    * (SRSO_MSR_FIX in the official doc).
+						    */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index deb5fe0017763..236abf51876c4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -674,6 +674,7 @@
 
 /* Zen4 */
 #define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT 4
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
 /* Zen 2 */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 916f36e23724d..818034819ee66 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2706,6 +2706,7 @@ enum srso_mitigation {
 	SRSO_MITIGATION_SAFE_RET,
 	SRSO_MITIGATION_IBPB,
 	SRSO_MITIGATION_IBPB_ON_VMEXIT,
+	SRSO_MITIGATION_BP_SPEC_REDUCE,
 };
 
 enum srso_mitigation_cmd {
@@ -2723,7 +2724,8 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_MICROCODE]		= "Vulnerable: Microcode, no safe RET",
 	[SRSO_MITIGATION_SAFE_RET]		= "Mitigation: Safe RET",
 	[SRSO_MITIGATION_IBPB]			= "Mitigation: IBPB",
-	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only"
+	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only",
+	[SRSO_MITIGATION_BP_SPEC_REDUCE]	= "Mitigation: Reduced Speculation"
 };
 
 static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
@@ -2762,7 +2764,7 @@ static void __init srso_select_mitigation(void)
 	    srso_cmd == SRSO_CMD_OFF) {
 		if (boot_cpu_has(X86_FEATURE_SBPB))
 			x86_pred_cmd = PRED_CMD_SBPB;
-		return;
+		goto out;
 	}
 
 	if (has_microcode) {
@@ -2774,7 +2776,7 @@ static void __init srso_select_mitigation(void)
 		 */
 		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
-			return;
+			goto out;
 		}
 
 		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
@@ -2854,6 +2856,12 @@ static void __init srso_select_mitigation(void)
 
 ibpb_on_vmexit:
 	case SRSO_CMD_IBPB_ON_VMEXIT:
+		if (boot_cpu_has(X86_FEATURE_SRSO_BP_SPEC_REDUCE)) {
+			pr_notice("Reducing speculation to address VM/HV SRSO attack vector.\n");
+			srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE;
+			break;
+		}
+
 		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
@@ -2876,7 +2884,15 @@ static void __init srso_select_mitigation(void)
 	}
 
 out:
-	pr_info("%s\n", srso_strings[srso_mitigation]);
+	/*
+	 * Clear the feature flag if this mitigation is not selected as that
+	 * feature flag controls the BpSpecReduce MSR bit toggling in KVM.
+	 */
+	if (srso_mitigation != SRSO_MITIGATION_BP_SPEC_REDUCE)
+		setup_clear_cpu_cap(X86_FEATURE_SRSO_BP_SPEC_REDUCE);
+
+	if (srso_mitigation != SRSO_MITIGATION_NONE)
+		pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
 #undef pr_fmt
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ff65fe7387332..ecb77ac074ea1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -623,6 +623,9 @@ static void svm_hardware_disable(void)
 	kvm_cpu_svm_disable();
 
 	amd_pmu_disable_virt();
+
+	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
+		msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
 }
 
 static int svm_hardware_enable(void)
@@ -703,6 +706,9 @@ static int svm_hardware_enable(void)
 		rdmsr(MSR_TSC_AUX, hostsa->tsc_aux, msr_hi);
 	}
 
+	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
+
 	return 0;
 }
 
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 47fd9bd6b91d8..f94d6f2b982d5 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -103,6 +103,7 @@ int msr_set_bit(u32 msr, u8 bit)
 {
 	return __flip_bit(msr, bit, true);
 }
+EXPORT_SYMBOL_GPL(msr_set_bit);
 
 /**
  * msr_clear_bit - Clear @bit in a MSR @msr.
@@ -118,6 +119,7 @@ int msr_clear_bit(u32 msr, u8 bit)
 {
 	return __flip_bit(msr, bit, false);
 }
+EXPORT_SYMBOL_GPL(msr_clear_bit);
 
 #ifdef CONFIG_TRACEPOINTS
 void do_trace_write_msr(unsigned int msr, u64 val, int failed)
-- 
2.34.1


