Return-Path: <stable+bounces-180682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04497B8AC84
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF39A565A91
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7731FEFC;
	Fri, 19 Sep 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljwVWDNl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502753D6F
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303296; cv=none; b=q9+Ibo+LcSCLvOKvx/et3p0CBBLKUHyQsiC1U/RuBDGMP6meC4BzqmBUlDApoKS+VRos91KSEAgToaMaKLMTtr/tN/ebFUSwcZr3lsa/eMKR8x88dIXUkAx4fJttk2TTh1si9IY3LDXwAn9LEmHT6zwh5Y0KZ0TZVFen9OTDoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303296; c=relaxed/simple;
	bh=2msKzsh7jSGXF6FqN26vw3RR8atygGD7yc92bKXTO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDVbSWcs5lAGx6DMhgsfREs0Fxq3ZhtWOZg3LRilN8mIPHafMEq94p5oDmd9PcR5upOvHnFff2aAze5MdZ0+KuAjpqyfYMopdGfkxzIFFWIfzuTZIeSLNlsUDhbrHIziI4FE9BnMRLPboQ8UBVNX/2xw94OUtbgYBKGCK+VtKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ljwVWDNl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtouY006928;
	Fri, 19 Sep 2025 17:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=bLuqX
	oEHTsqsnP1jFrTXUOstirZ64qFIwG5flcl8pU4=; b=ljwVWDNl0b1RRGdWCiCGE
	BUMKM4Dl2ywTglw5V4trgYRWZYt2blzDAdVSHuOW/jmPYmT9s/NtbIpdWMnRcJN5
	y4YfVJR2XTeNoMooBWfZSweWigWMyT4R+L2/llAVdHYXr26s31LiCOxf4IX5YVWD
	fWSLsdVbT+7q1b8GEls8rJBDZuOuDhNXHr7dN1am5FLaT6ie6HoStjO21eJblZSl
	qZVKtvD4PhsLhtk4xNdbqr9RkjbFX/ChApCMYpMjifNj7Gzy2ASVYWsLpJkVOSs9
	x+m1S1yo576YBKOOBKyzUgE2u6wqNU0xqOhzicSeqtSdhUiK2r+K3riH6MlAzgS8
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd6174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:34:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JGBO8O001525;
	Fri, 19 Sep 2025 17:34:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gy1kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:34:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JHXUuj001465;
	Fri, 19 Sep 2025 17:34:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 494y2gy0w9-4;
	Fri, 19 Sep 2025 17:34:03 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ankur.a.arora@oracle.com,
        boris.ostrovsky@oracle.com, bp@alien8.de, darren.kenny@oracle.com,
        Sean Christopherson <seanjc@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 3/3] KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count transitions
Date: Fri, 19 Sep 2025 10:33:00 -0700
Message-ID: <20250919173300.2508056-4-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: L1BNonRcPiMguTQu5c59_3jtIpcC1CFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0oNlrB5lk1TR
 XOWDuIhkVyZ4f2iGAmWu14vAsQUAaSzGDkXtbwd3Spo4CVVDgyKa/ChaevuUrlMtBD+QWWHZVlZ
 HwMJ5mZTbTswjqGCgcAp1n56F/idQome267PLR6KlYqz3QIigozZLGkKAh2mgkJC8e9rGmnpC4h
 ToyEFhc1wumrc390e4sHkatZ59x+HAksavs67yVtsFRDwKkOrIBtInubJ2UuKf4uAdjxxyT9+oI
 8uPeyqus665d8Mai8Z0ufxIuT50IA570T+BK0vL5wqSjNIhmW+tAfk5/eVt5jWh1V5IanW+bTfm
 tUaUkwx/0pmLVxBkHrxuJoZGxLLHSpPDMZCMPB8mXnpa0F1tgNXDALyU+LNtlgKgtGzgOINFOE2
 G9QN+JbE
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cd940d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=8VpDeP3kAAAA:8
 a=vF1WI-rbAAAA:8 a=yPCof4ZbAAAA:8 a=EARzfgr3_4uq7gzjQS4A:9
 a=x58pXJj3Pl9T3GLWE5Uy:22 a=pFh3i3r9NVq0QCqMH2IY:22
X-Proofpoint-ORIG-GUID: L1BNonRcPiMguTQu5c59_3jtIpcC1CFx

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit e3417ab75ab2e7dca6372a1bfa26b1be3ac5889e ]

Set the magic BP_SPEC_REDUCE bit to mitigate SRSO when running VMs if and
only if KVM has at least one active VM.  Leaving the bit set at all times
unfortunately degrades performance by a wee bit more than expected.

Use a dedicated spinlock and counter instead of hooking virtualization
enablement, as changing the behavior of kvm.enable_virt_at_load based on
SRSO_BP_SPEC_REDUCE is painful, and has its own drawbacks, e.g. could
result in performance issues for flows that are sensitive to VM creation
latency.

Defer setting BP_SPEC_REDUCE until VMRUN is imminent to avoid impacting
performance on CPUs that aren't running VMs, e.g. if a setup is using
housekeeping CPUs.  Setting BP_SPEC_REDUCE in task context, i.e. without
blasting IPIs to all CPUs, also helps avoid serializing 1<=>N transitions
without incurring a gross amount of complexity (see the Link for details
on how ugly coordinating via IPIs gets).

Link: https://lore.kernel.org/all/aBOnzNCngyS_pQIW@google.com
Fixes: 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX")
Reported-by: Michael Larabel <Michael@michaellarabel.com>
Closes: https://www.phoronix.com/review/linux-615-amd-regression
Cc: Borislav Petkov <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250505180300.973137-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
(cherry picked from commit e3417ab75ab2e7dca6372a1bfa26b1be3ac5889e)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 arch/x86/kvm/svm/svm.c | 71 ++++++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/svm/svm.h |  2 ++
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2984851ba890..ed609e4f0d06 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -608,9 +608,6 @@ static void svm_disable_virtualization_cpu(void)
 	kvm_cpu_svm_disable();
 
 	amd_pmu_disable_virt();
-
-	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
-		msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
 }
 
 static int svm_enable_virtualization_cpu(void)
@@ -688,9 +685,6 @@ static int svm_enable_virtualization_cpu(void)
 		rdmsr(MSR_TSC_AUX, sev_es_host_save_area(sd)->tsc_aux, msr_hi);
 	}
 
-	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
-		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
-
 	return 0;
 }
 
@@ -1513,6 +1507,63 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 	__free_pages(virt_to_page(svm->msrpm), get_order(MSRPM_SIZE));
 }
 
+#ifdef CONFIG_CPU_MITIGATIONS
+static DEFINE_SPINLOCK(srso_lock);
+static atomic_t srso_nr_vms;
+
+static void svm_srso_clear_bp_spec_reduce(void *ign)
+{
+	struct svm_cpu_data *sd = this_cpu_ptr(&svm_data);
+
+	if (!sd->bp_spec_reduce_set)
+		return;
+
+	msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
+	sd->bp_spec_reduce_set = false;
+}
+
+static void svm_srso_vm_destroy(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
+		return;
+
+	if (atomic_dec_return(&srso_nr_vms))
+		return;
+
+	guard(spinlock)(&srso_lock);
+
+	/*
+	 * Verify a new VM didn't come along, acquire the lock, and increment
+	 * the count before this task acquired the lock.
+	 */
+	if (atomic_read(&srso_nr_vms))
+		return;
+
+	on_each_cpu(svm_srso_clear_bp_spec_reduce, NULL, 1);
+}
+
+static void svm_srso_vm_init(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
+		return;
+
+	/*
+	 * Acquire the lock on 0 => 1 transitions to ensure a potential 1 => 0
+	 * transition, i.e. destroying the last VM, is fully complete, e.g. so
+	 * that a delayed IPI doesn't clear BP_SPEC_REDUCE after a vCPU runs.
+	 */
+	if (atomic_inc_not_zero(&srso_nr_vms))
+		return;
+
+	guard(spinlock)(&srso_lock);
+
+	atomic_inc(&srso_nr_vms);
+}
+#else
+static void svm_srso_vm_init(void) { }
+static void svm_srso_vm_destroy(void) { }
+#endif
+
 static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -1545,6 +1596,11 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	    (!boot_cpu_has(X86_FEATURE_V_TSC_AUX) || !sev_es_guest(vcpu->kvm)))
 		kvm_set_user_return_msr(tsc_aux_uret_slot, svm->tsc_aux, -1ull);
 
+	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE) &&
+	    !sd->bp_spec_reduce_set) {
+		sd->bp_spec_reduce_set = true;
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
+	}
 	svm->guest_state_loaded = true;
 }
 
@@ -5011,6 +5067,8 @@ static void svm_vm_destroy(struct kvm *kvm)
 {
 	avic_vm_destroy(kvm);
 	sev_vm_destroy(kvm);
+
+	svm_srso_vm_destroy();
 }
 
 static int svm_vm_init(struct kvm *kvm)
@@ -5036,6 +5094,7 @@ static int svm_vm_init(struct kvm *kvm)
 			return ret;
 	}
 
+	svm_srso_vm_init();
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d114efac7af7..1aa9b1e468cb 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -335,6 +335,8 @@ struct svm_cpu_data {
 	u32 next_asid;
 	u32 min_asid;
 
+	bool bp_spec_reduce_set;
+
 	struct vmcb *save_area;
 	unsigned long save_area_pa;
 
-- 
2.50.1


