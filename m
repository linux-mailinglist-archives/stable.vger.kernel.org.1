Return-Path: <stable+bounces-114849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF4A304AE
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2EB3A574D
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871961EDA11;
	Tue, 11 Feb 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q4C+y7eq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF71E3DF7
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259680; cv=none; b=mBurmGQIA+ZNsPNBCSKE2WoIkmL42kqduFKq7iEgcyFIRL0DUpY9zIFFLwac6pNcaQCijUBmHwbEpZXitLF/3rdjLbnsDnjpwwW94gSKA2MDE4QL2/pdrHk9W+aU1Z6dhbVwUJ0QHDaqMxHBdq/deLffkgn3fcQWBQSBYublPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259680; c=relaxed/simple;
	bh=ynwm1bdzEF1ub54nG+ogujpMFyfu9aqbKs29ozNc6tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcPtQvf+kdxzMFhOFHK36RzxdcyFpm7cCFRzsDYDk/wl5VGHpmv25BkIKslWvet/mtfJ0D3wLKwtBT//UOEAShDJ05Qja+SN+Vl20bGRPSH115d7yIVFW4xZXlNfv38ec9YwYEVxHsV969apm7EMMqKpFqcU6B/h72WZz5xUTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q4C+y7eq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B1fJfJ023563
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=36rbHyyIMconnVOEU
	ihPaqQC2OBIIf3fDahr2u5xYuc=; b=q4C+y7eqXBHaxtEAxKmnx1zwTIYYfTpZJ
	HOMRJJQxe17Um9ou+dobgAX2ad0MjwLACb1nsR6xzxGt9XU7JyCc7EzVPXRfT3+h
	4sxijSJfNcZG7QhYwquqeMwYh+OrZO2Y4+QLVqWv5qX5yi7IHWlkhXGynTIwAkGh
	6iMVR/37GWhayuq0hMeJCy5OTT7neUoNVNVO2iuzNNkbu+EKMcaelCIkDMrl0KOL
	STaL0er4kQ7PnIFVcFlB1efJnIA/BVLzJsxPiFGVRiOqtde5WU6zNFMV3Fpfv9/0
	2OzcvuFBmKFvsgFY84gzDcWDdbzQYGWuqQ8uZEohO9BkSUs/ctw0w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qm9tkh3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:41:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51B70YHH029203
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:41:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma1hufv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:41:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51B7fCRO44171722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 07:41:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC8AE20043;
	Tue, 11 Feb 2025 07:41:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C523820040;
	Tue, 11 Feb 2025 07:41:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Feb 2025 07:41:12 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.12.y] s390/fpu: Add fpc exception handler / remove fixup section again
Date: Tue, 11 Feb 2025 08:41:11 +0100
Message-ID: <20250211074111.3756357-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2025021058-supplier-busybody-2b89@gregkh>
References: <2025021058-supplier-busybody-2b89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C-xsGnjlXJdQmIzacQ8G_E36_4LQE31i
X-Proofpoint-ORIG-GUID: C-xsGnjlXJdQmIzacQ8G_E36_4LQE31i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_03,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 mlxlogscore=852 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110044

commit ae02615b7fcea9ce9a4ec40b3c5b5dafd322b179 upstream.

The fixup section was added again by mistake when test_fp_ctl() was
removed. The reason for the removal of the fixup section is described in
commit 484a8ed8b7d1 ("s390/extable: add dedicated uaccess handler").
Remove it again for the same reason.

Add an exception handler which handles exceptions when the floating point
control register is attempted to be set to invalid values. The exception
handler sets the floating point control register to zero and continues
execution at the specified address.

The new sfpc inline assembly is open-coded to make back porting a bit
easier.

Fixes: 702644249d3e ("s390/fpu: get rid of test_fp_ctl()")
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/asm-extable.h |  4 ++++
 arch/s390/include/asm/fpu-insn.h    | 17 +++++------------
 arch/s390/kernel/vmlinux.lds.S      |  1 -
 arch/s390/mm/extable.c              |  9 +++++++++
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index 4a6b0a8b6412..00a67464c445 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -14,6 +14,7 @@
 #define EX_TYPE_UA_LOAD_REG	5
 #define EX_TYPE_UA_LOAD_REGPAIR	6
 #define EX_TYPE_ZEROPAD		7
+#define EX_TYPE_FPC		8
 
 #define EX_DATA_REG_ERR_SHIFT	0
 #define EX_DATA_REG_ERR		GENMASK(3, 0)
@@ -84,4 +85,7 @@
 #define EX_TABLE_ZEROPAD(_fault, _target, _regdata, _regaddr)		\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_ZEROPAD, _regdata, _regaddr, 0)
 
+#define EX_TABLE_FPC(_fault, _target)					\
+	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FPC, __stringify(%%r0), __stringify(%%r0), 0)
+
 #endif /* __ASM_EXTABLE_H */
diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index c1e2e521d9af..a4c9b4db62ff 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -100,19 +100,12 @@ static __always_inline void fpu_lfpc(unsigned int *fpc)
  */
 static inline void fpu_lfpc_safe(unsigned int *fpc)
 {
-	u32 tmp;
-
 	instrument_read(fpc, sizeof(*fpc));
-	asm volatile("\n"
-		"0:	lfpc	%[fpc]\n"
-		"1:	nopr	%%r7\n"
-		".pushsection .fixup, \"ax\"\n"
-		"2:	lghi	%[tmp],0\n"
-		"	sfpc	%[tmp]\n"
-		"	jg	1b\n"
-		".popsection\n"
-		EX_TABLE(1b, 2b)
-		: [tmp] "=d" (tmp)
+	asm_inline volatile(
+		"	lfpc	%[fpc]\n"
+		"0:	nopr	%%r7\n"
+		EX_TABLE_FPC(0b, 0b)
+		:
 		: [fpc] "Q" (*fpc)
 		: "memory");
 }
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 377b9aaf8c92..ff1ddba96352 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,7 +52,6 @@ SECTIONS
 		SOFTIRQENTRY_TEXT
 		FTRACE_HOTPATCH_TRAMPOLINES_TEXT
 		*(.text.*_indirect_*)
-		*(.fixup)
 		*(.gnu.warning)
 		. = ALIGN(PAGE_SIZE);
 		_etext = .;		/* End of text section */
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 0a0738a473af..812ec5be1291 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -77,6 +77,13 @@ static bool ex_handler_zeropad(const struct exception_table_entry *ex, struct pt
 	return true;
 }
 
+static bool ex_handler_fpc(const struct exception_table_entry *ex, struct pt_regs *regs)
+{
+	asm volatile("sfpc	%[val]\n" : : [val] "d" (0));
+	regs->psw.addr = extable_fixup(ex);
+	return true;
+}
+
 bool fixup_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *ex;
@@ -99,6 +106,8 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_ua_load_reg(ex, true, regs);
 	case EX_TYPE_ZEROPAD:
 		return ex_handler_zeropad(ex, regs);
+	case EX_TYPE_FPC:
+		return ex_handler_fpc(ex, regs);
 	}
 	panic("invalid exception table entry");
 }
-- 
2.45.2


