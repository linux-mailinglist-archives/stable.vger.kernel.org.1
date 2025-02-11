Return-Path: <stable+bounces-114848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D119A3048B
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467CE188AB01
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361961EB186;
	Tue, 11 Feb 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j5D4ti9c"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350F26BD8B
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259295; cv=none; b=pOS3g3QQAQPw5rNaWeI3s7FBE0XOuHMGSYYzeslaU4+4E9oezu1BcjRtGlJFqMEu7kDNToQ80j62Z6I4kn0yP2PZXYxgyVmAoVXN/F1cN+3rmotIFDD42PcRxtaex2A3kvy43fYC8AY0iJ8ORsUqG7oTI+KL/uh+2ykQc9qaflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259295; c=relaxed/simple;
	bh=ynwm1bdzEF1ub54nG+ogujpMFyfu9aqbKs29ozNc6tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+Wr6pXUl4zeHUfQpoapLxbQ1r+lCYsQKBcCn9StwmorWEvA1DS8prOlXXeXgezMKdJ3r7E/WczYvvcc1tOCGsVPtbAuXMsP+KtjxFj6E+/ziw2oj8o5Us1iSist+r/3P3L+eLPU3U3oN3BaidYho5SuC6v03aNjC3Jc2xS0+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j5D4ti9c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B1fLZZ002074
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=36rbHyyIMconnVOEU
	ihPaqQC2OBIIf3fDahr2u5xYuc=; b=j5D4ti9ccg5sW3DCgMTOnEnf/bZjRMa2V
	aL3zcDTRl5pyu3TwlKJN3u5jHJA8d0fITWV9XVInskDxYVnXuILye6gB8i2qeb/G
	nkf3sqWvMU1rkWby48sGY0tTnsys0Y2TFKFsRJLUk68Kij0BPX7kinssXmc5l7wC
	X2mmN14NH8lczUxKmPOI0SzEBhr6XfwtX5rpoOUDlKCfiPDrcMXVQkKG4PAYi7Q3
	NhfJlLK2VqKG/qDlH4rXd0UHsSkFFFS5rJSKwHd+hCdaMkD4B+9le9sLG7yLLySO
	cdGvldb3JvsuFUcWYjhBoecYL3dvZhtASk4bxZAWA5Heah3BfgPhQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qvma18eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:34:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51B3Nci2021706
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:34:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phksjcmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:34:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51B7YlMR27590976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 07:34:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B920D20043;
	Tue, 11 Feb 2025 07:34:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E68720040;
	Tue, 11 Feb 2025 07:34:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Feb 2025 07:34:47 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.13.y] s390/fpu: Add fpc exception handler / remove fixup section again
Date: Tue, 11 Feb 2025 08:34:38 +0100
Message-ID: <20250211073438.3521869-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2025021057-charred-koala-8496@gregkh>
References: <2025021057-charred-koala-8496@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AJ8A5dJQqQW9Y_PmIcCr8Dj31nSNSWt_
X-Proofpoint-ORIG-GUID: AJ8A5dJQqQW9Y_PmIcCr8Dj31nSNSWt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_03,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 mlxlogscore=812 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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


