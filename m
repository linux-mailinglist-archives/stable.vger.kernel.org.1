Return-Path: <stable+bounces-180681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB36B8AC60
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F39B1CC53E1
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1A322A09;
	Fri, 19 Sep 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="To2CVCDy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81226F443
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303224; cv=none; b=lsUZPb6rrVladvpcKdls0Dxu0QKRRnrNx1tGNAC/SiFhxVrgnZbgsHJ4v5qr/Rj2pzictNlK21MY/FauGIpMUf3/9rpLslD65GUjqV/su0pmOxNhY8oqc/FbNUagMdd/FiU9xYnfIveIwICrq3lp+C233qG3dUYg8ItdedqA3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303224; c=relaxed/simple;
	bh=rsAr6UxMmg4vfLXGAp0KiyZP3Ps94DrmauEvezhxoTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUq2b6Dq9CELgAd6arXyKoEKL27Mr4ZEvZrE9ZmcNMmE6vs1HOEuC2Owtyp1zDF8MuHFO60tNxsHS1B6/L7Cv6Mv0jLGUv+vFjT8lLue1VBjPYyM0Iq+RXNnC0dGl0omYKLZtlXtq99enNE9xHeB8NA2EpvtJC8/6cHLTt8EBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=To2CVCDy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpNW003406;
	Fri, 19 Sep 2025 17:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=MQtX2
	2+7kVpUr5TqFfMOFO18OSPeIo79v9MtMkVrXbQ=; b=To2CVCDyk4kkmZnlRneD+
	vXosJOPEsAP6J6+Oc0QEJKY/lexhFuoPO3IpPymrz95tJjed4LRd1HPr3I7NNOHu
	hpcv+DKDMeOgXSyGs3GW+EjF38uKxD+5SZb+4d8iRF3Vln3qdZ8zcX1S9vJ3X1Ga
	6zRUPdHc7/Z8JBFluY7AwzAKijq5OWKNsDiZNPtzxj3LC+TZMZvdrIvPDl15aDFN
	jmns2Xh6ApUAvLjT3C1nPFDxN0k2/nkeh801tgwhMeYnFS87WwmqwJdFgWjHaWac
	zgGjwa9XgGLr20zk1M/C+mZ080WFdauL2TkGFte8KxQYM3oCgdhfIs8FbtriS/D5
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8nvny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:33:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JGUCVl001582;
	Fri, 19 Sep 2025 17:33:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gy150-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:33:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JHXUuh001465;
	Fri, 19 Sep 2025 17:33:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 494y2gy0w9-3;
	Fri, 19 Sep 2025 17:33:33 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ankur.a.arora@oracle.com,
        boris.ostrovsky@oracle.com, bp@alien8.de, darren.kenny@oracle.com,
        Sean Christopherson <seanjc@google.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 2/3] x86/bugs: KVM: Add support for SRSO_MSR_FIX
Date: Fri, 19 Sep 2025 10:32:59 -0700
Message-ID: <20250919173300.2508056-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919173300.2508056-1-harshit.m.mogalapalli@oracle.com>
References: <20250919173300.2508056-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190164
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cd93ef cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=Ctw2KAfkhUj_M1e0kCgA:9
X-Proofpoint-ORIG-GUID: 3ITH5tb6N3ySeMqIjMUGSdHtmjkO2fBr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1v2GEJsvbr/7
 Bybi9oiN18Rw0xvzCdDWv4uc0JChhje2zou6yGfHA9u37MgE+F08+bQ1fYIfWCB+f7lqhopAi5G
 JH4YL20VilTZV2bluXocf/xJM81zXwO0Dgd7QJaBQyToLyzPYrtemLWMcr1Y6V8fEvH5VjHM0h5
 1x1SJbfqySaSQfGbvfjV4kdeFlG8FQQB1KwmKPMnze0H9GbVwYVrteDHWK/VMKcRtn3s1WyaUUg
 SOvJ7tvfAnt7HrvFk24OzZ9v6+qri2Bv55w6YISsI1jZT031t7PR7wxwloY4ia9JWo2R3a+o3zp
 ZBs2G81iGXa465JFvWi7KTcT8dVhzxd11GJkiLw7mIurPY7+qa8p5CofuW9fujOGpj9YeyXO6sx
 pBB/lDQX
X-Proofpoint-GUID: 3ITH5tb6N3ySeMqIjMUGSdHtmjkO2fBr

From: Borislav Petkov <bp@alien8.de>

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
(cherry picked from commit 8442df2b49ed9bcd67833ad4f091d15ac91efd00)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 Documentation/admin-guide/hw-vuln/srso.rst | 13 ++++++++++++
 arch/x86/include/asm/cpufeatures.h         |  4 ++++
 arch/x86/include/asm/msr-index.h           |  1 +
 arch/x86/kernel/cpu/bugs.c                 | 24 ++++++++++++++++++----
 arch/x86/kvm/svm/svm.c                     |  6 ++++++
 arch/x86/lib/msr.c                         |  2 ++
 6 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index 2ad1c05b8c88..66af95251a3d 100644
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
index 3fc47f25cafc..16a8c1f3ff65 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -465,6 +465,10 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* CPU is not affected by SRSO */
 #define X86_FEATURE_SRSO_USER_KERNEL_NO	(20*32+30) /* CPU is not affected by SRSO across user/kernel boundaries */
+#define X86_FEATURE_SRSO_BP_SPEC_REDUCE	(20*32+31) /*
+						    * BP_CFG[BpSpecReduce] can be used to mitigate SRSO for VMs.
+						    * (SRSO_MSR_FIX in the official doc).
+						    */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2b6e3127ef4e..21d07aa9400c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -728,6 +728,7 @@
 
 /* Zen4 */
 #define MSR_ZEN4_BP_CFG                 0xc001102e
+#define MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT 4
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
 /* Fam 19h MSRs */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c3ea29efe26f..f3cb559a598d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2718,6 +2718,7 @@ enum srso_mitigation {
 	SRSO_MITIGATION_SAFE_RET,
 	SRSO_MITIGATION_IBPB,
 	SRSO_MITIGATION_IBPB_ON_VMEXIT,
+	SRSO_MITIGATION_BP_SPEC_REDUCE,
 };
 
 enum srso_mitigation_cmd {
@@ -2735,7 +2736,8 @@ static const char * const srso_strings[] = {
 	[SRSO_MITIGATION_MICROCODE]		= "Vulnerable: Microcode, no safe RET",
 	[SRSO_MITIGATION_SAFE_RET]		= "Mitigation: Safe RET",
 	[SRSO_MITIGATION_IBPB]			= "Mitigation: IBPB",
-	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only"
+	[SRSO_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT only",
+	[SRSO_MITIGATION_BP_SPEC_REDUCE]	= "Mitigation: Reduced Speculation"
 };
 
 static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
@@ -2774,7 +2776,7 @@ static void __init srso_select_mitigation(void)
 	    srso_cmd == SRSO_CMD_OFF) {
 		if (boot_cpu_has(X86_FEATURE_SBPB))
 			x86_pred_cmd = PRED_CMD_SBPB;
-		return;
+		goto out;
 	}
 
 	if (has_microcode) {
@@ -2786,7 +2788,7 @@ static void __init srso_select_mitigation(void)
 		 */
 		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
-			return;
+			goto out;
 		}
 
 		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
@@ -2866,6 +2868,12 @@ static void __init srso_select_mitigation(void)
 
 ibpb_on_vmexit:
 	case SRSO_CMD_IBPB_ON_VMEXIT:
+		if (boot_cpu_has(X86_FEATURE_SRSO_BP_SPEC_REDUCE)) {
+			pr_notice("Reducing speculation to address VM/HV SRSO attack vector.\n");
+			srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE;
+			break;
+		}
+
 		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
@@ -2887,7 +2895,15 @@ static void __init srso_select_mitigation(void)
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
index 800f781475c0..2984851ba890 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -608,6 +608,9 @@ static void svm_disable_virtualization_cpu(void)
 	kvm_cpu_svm_disable();
 
 	amd_pmu_disable_virt();
+
+	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
+		msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
 }
 
 static int svm_enable_virtualization_cpu(void)
@@ -685,6 +688,9 @@ static int svm_enable_virtualization_cpu(void)
 		rdmsr(MSR_TSC_AUX, sev_es_host_save_area(sd)->tsc_aux, msr_hi);
 	}
 
+	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
+
 	return 0;
 }
 
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 4bf4fad5b148..5a18ecc04a6c 100644
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
2.50.1


