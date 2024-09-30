Return-Path: <stable+bounces-78270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97DC98A6D6
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73391C21A62
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4DA17C22F;
	Mon, 30 Sep 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l4om+Mcw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA012CA5
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705850; cv=none; b=jDCDaZcMCnII3KTwdkyWNXeIC5jXehARLeTzZahqkAU3eCh6b1zqrMm9RWXQdD0L/qzSvsYEZYhfaylGfzIQH4M8u0i27QID+jtNugAVbIW9XN6Q7kUy4OEXBqkFYj99ghp12fqpp0j8tkkuu+9mcxVHmQkzLZ6Ax72Wiz/zIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705850; c=relaxed/simple;
	bh=wHGgrIxpVGzbjn2NFv9Bf6LWeQp8QvtI9N50A1MxkPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Le5eAuCEgK8tojy+qaoEb1OD6H2I+HrTXSIxyNH6rIrymxj3d+IiLCqutmPkb0aKEJHtXLnuzdrUw0TSdyu0iYjHh5kxfeXi55sZ4+aItzzXownP/SDvTJziN+ZPJLJhJEjE7EWemp7OI2EZXtUEkTPoTN0zQ6ueXBUv0lk1+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l4om+Mcw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U7jRkA014363
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 14:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=IJhJCQh3hrQ0oh5zhUMpXSHWmK
	zD3BMDflPu20FGD8U=; b=l4om+Mcw/DJmRqJJfIL7Y/TyEO0Q7bSW+1OmJ2I9FH
	STTxHbidQPsE1L48EtaqeHlVJgw4lrcVtiyGs/FILZMPWascoOo5AlaZvRa5M79T
	92IiWpsiH/j6t2itzj/rutWusHU469o3GCTcjL8NqFsEAqckxpKIioAjv+aE1xfC
	gWpVV/12eVxDRgyLLSOeRtCzC9cXSv/rmu63nH7xsIOtYJ2DywU+LR54LtGxwR5W
	UpWqJfJRmUT83SUzAsl0eieJRuBMlEHwLDyG+rQGFZfQ9FHMskusT2BT2E3L+ku/
	ND96X6mS8ehxk8x2UwQWJt4a54rGiNCb4pyN/eJDpvtw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apac1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 14:17:26 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UEHPgj024512;
	Mon, 30 Sep 2024 14:17:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apac1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 14:17:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCLG9P013047;
	Mon, 30 Sep 2024 14:17:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj6pn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 14:17:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UEHIqL57672022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 14:17:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73D572004B;
	Mon, 30 Sep 2024 14:17:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D320020040;
	Mon, 30 Sep 2024 14:17:16 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.43.17.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 14:17:16 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: ltc-india-dev@lists.linux.ibm.com, npiggin@gmail.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, ltc-kvm-dev@lists.linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Reset LPCR_MER before running a vCPU to avoid spurious interrupts
Date: Mon, 30 Sep 2024 19:47:10 +0530
Message-ID: <20240930141713.358654-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wJ672Qj7Ej5bSoGcz6AcezQypFgduL51
X-Proofpoint-GUID: CzsAC3rPc002FDsdChkP6dofE9M-qROz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=664 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300102

Reset LPCR_MER bit before running a vCPU to ensure that it is not set if
there are no pending interrupts. Running a vCPU with LPCR_MER bit set
and no pending interrupts results in L2 vCPU getting an infinite flood
of spurious interrupts. The 'if check' in kvmhv_run_single_vcpu() sets
the LPCR_MER bit if there are pending interrupts.

The spurious flood problem can be observed in 2 cases:
1. Crashing the guest while interrupt heavy workload is running
  a. Start a L2 guest and run an interrupt heavy workload (eg: ipistorm)
  b. While the workload is running, crash the guest (make sure kdump
     is configured)
  c. Any one of the vCPUs of the guest will start getting an infinite
     flood of spurious interrupts.

2. Running LTP stress tests in multiple guests at the same time
   a. Start 4 L2 guests.
   b. Start running LTP stress tests on all 4 guests at same time.
   c. In some time, any one/more of the vCPUs of any of the guests will
      start getting an infinite flood of spurious interrupts.

The root cause of both the above issues is the same:
1. A NMI is sent to a running vCPU that had LPCR_MER bit set.
2. In the NMI path, all registers are refreshed, i.e, H_GUEST_GET_STATE
   is called for all the registers.
3. When H_GUEST_GET_STATE is called for lpcr, the vcpu->arch.vcore->lpcr
   of that vCPU at L1 level gets updated with LPCR_MER set to 1, and this
   new value is always used whenever that vCPU runs, regardless of whether
   there was a pending interrupt.
4. Since LPCR_MER is set, the vCPU in L2 always jumps to the external
   interrupt handler, and this cycle never ends.

Fix the spurious flood by making sure LPCR_MER is always reset before
running a vCPU.

Fixes: ec0f6639fa88 ("KVM: PPC: Book3S HV nestedv2: Ensure LPCR_MER bit is passed to the L0")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8f7d7e37bc8c..3cc2f1691001 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -98,6 +98,13 @@
 /* Used to indicate that a guest passthrough interrupt needs to be handled */
 #define RESUME_PASSTHROUGH	(RESUME_GUEST | RESUME_FLAG_ARCH2)
 
+/* Clear LPCR_MER bit - If we run a L2 vCPU with LPCR_MER bit set but no pending external
+ * interrupts, we end up getting a flood of spurious interrupts in L2 KVM guests. To avoid
+ * that, reset LPCR_MER and let the 'if check' for pending interrupts in kvmhv_run_single_vcpu()
+ * set LPCR_MER if there are pending interrupts.
+ */
+#define kvmppc_reset_lpcr_mer(vcpu) (vcpu->arch.vcore->lpcr &= ~LPCR_MER)
+
 /* Used as a "null" value for timebase values */
 #define TB_NIL	(~(u64)0)
 
@@ -5091,7 +5098,7 @@ static int kvmppc_vcpu_run_hv(struct kvm_vcpu *vcpu)
 		accumulate_time(vcpu, &vcpu->arch.guest_entry);
 		if (cpu_has_feature(CPU_FTR_ARCH_300))
 			r = kvmhv_run_single_vcpu(vcpu, ~(u64)0,
-						  vcpu->arch.vcore->lpcr);
+						  kvmppc_reset_lpcr_mer(vcpu));
 		else
 			r = kvmppc_run_vcpu(vcpu);
 
-- 
2.46.0


