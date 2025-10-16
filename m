Return-Path: <stable+bounces-186209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E822BE59E8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB1D1A66D20
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EB42E54A9;
	Thu, 16 Oct 2025 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oBxMDLIE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11042DE6F4
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651722; cv=none; b=OquNHryygj0thDAR0MXVE0fdzlTYIQKNp+dtvL9q+zgs2IQL8dEGKCnaF6yJzg5ROdENSsFpjr2S9eMIjmEM9nexuuyKUndCfHkvyMzzdKwdknk0ey/+VXwPWrQ1ww3mqEMi/itLNOLiLDsk/Uk0ZRZd/AcOMnatANGfCdzWeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651722; c=relaxed/simple;
	bh=xRovRRZ+Q8MAssX0EhIjKHS6/MLv6wb9Kke4rsCYiH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK+9SkEAisCRKQkZbR5Yr+Qktgli2OUeb4ZUjWChpOMM1yVfq+QKk4ZPtzldamdxdG32Wqo9H1Zp/EpghJ+mJ4LtlIPpyUnB5+fpv7MbZjiwzex8Xx9bKsPv4L2OY7Q7VvHoLWeQVthPncNgOlIPJh5Ts0acUa0aYNSKRAYSBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oBxMDLIE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GI5Gv2021809;
	Thu, 16 Oct 2025 21:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XbaQ0ohpspogKSLvw
	fBnWCkWjyPjr/8W0LXsuZr583w=; b=oBxMDLIE7qsYwcOheXwWQH7xK5+mIuvko
	6r+wfD5qivQ3XvZckNJ0WeAeHMeHcpmxIBLloxJyYHpfv7ZrwvjJKzJXXLyvVdKj
	W1Onqnel62b0R/EJ+D6X35HDMixgQcEck6j4x8C/oIpzfekwLSGzCcTyb87Ja7QX
	l1sXtuDib3NS6iDdlDBiepHsSyWlurjPfQHy5ImkW6k6sGMl2HGY/rxw9aDbv6R8
	qnBhAMN64utGiTDJSmP1RQFeoiWPVvzaSsKBAJ5T/65GTNWXjTMQvNky1UWn6+Kz
	LtDv/G9zzWn+a3id/YC9zKDLWZBFWm9tZaJ2Zr0TBS0XF6W5LFeJA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey95f8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GK939E003663;
	Thu, 16 Oct 2025 21:55:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy850u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GLtCI033751454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 21:55:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4644920174;
	Thu, 16 Oct 2025 21:55:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1002F20176;
	Thu, 16 Oct 2025 21:55:12 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.6.y 3/5] s390/bpf: Describe the frame using a struct instead of constants
Date: Thu, 16 Oct 2025 23:51:26 +0200
Message-ID: <20251016215450.53494-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016215450.53494-1-iii@linux.ibm.com>
References: <20251016215450.53494-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Efx0vexQisjEL7Y_UVgOft5y33v6ufsl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXy5ySRFqvPBoj
 UybUegOkw+sWas5OnC5V/TBKrw0RVm6p1Sj9BkamIcy+x4+KYSVym96ldQyGQOFA3xKVraimox0
 tsnJIVf6AwxyBkU7QWbiuC7i9QJPlN4pkDdqS2ZGqWabJ1dWZWagyZTJVwV1pBVPkibqy5PI0vM
 epFTbbQ0K3iWc7yo3j4YbyvzgUEPzcd899SfKwKQHyQQkp9clcyF2vyZq1WJKhA1OioFtULbCjP
 PsJ40VtRe/PQcTGjqy3dC/zco3zsGDve/1PTELbcbMW27lp2dBLMU03umgdJWA4uB38VbwDgcQK
 yqAwbXDl7dESLVqGVtdzEvw60S6m2bZ2u3lpH9CVcrvggtNPAFGlNXsGs6SkW2c92KTpqvp9yAq
 EKnJ4UKDfTbxien7bu/7msPbL7GGmA==
X-Proofpoint-GUID: Efx0vexQisjEL7Y_UVgOft5y33v6ufsl
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f169c5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=04KB4t3DcwN-hSm8:21 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=3Mzdi6lvbL40coBWrpEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

commit e26d523edf2a62b142d2dd2dd9b87f61ed92f33a upstream.

Currently the caller-allocated portion of the stack frame is described
using constants, hardcoded values, and an ASCII drawing, making it
harder than necessary to ensure that everything is in sync.

Declare a struct and use offsetof() and offsetofend() macros to refer
to various values stored within the frame.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/r/20250624121501.50536-3-iii@linux.ibm.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/s390/net/bpf_jit.h      | 55 ----------------------------
 arch/s390/net/bpf_jit_comp.c | 69 ++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 77 deletions(-)
 delete mode 100644 arch/s390/net/bpf_jit.h

diff --git a/arch/s390/net/bpf_jit.h b/arch/s390/net/bpf_jit.h
deleted file mode 100644
index 7822ea92e54af..0000000000000
--- a/arch/s390/net/bpf_jit.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * BPF Jit compiler defines
- *
- * Copyright IBM Corp. 2012,2015
- *
- * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
- *	      Michael Holzheu <holzheu@linux.vnet.ibm.com>
- */
-
-#ifndef __ARCH_S390_NET_BPF_JIT_H
-#define __ARCH_S390_NET_BPF_JIT_H
-
-#ifndef __ASSEMBLY__
-
-#include <linux/filter.h>
-#include <linux/types.h>
-
-#endif /* __ASSEMBLY__ */
-
-/*
- * Stackframe layout (packed stack):
- *
- *				    ^ high
- *	      +---------------+     |
- *	      | old backchain |     |
- *	      +---------------+     |
- *	      |   r15 - r6    |     |
- *	      +---------------+     |
- *	      | 4 byte align  |     |
- *	      | tail_call_cnt |     |
- * BFP	   -> +===============+     |
- *	      |		      |     |
- *	      |   BPF stack   |     |
- *	      |		      |     |
- * R15+160 -> +---------------+     |
- *	      | new backchain |     |
- * R15+152 -> +---------------+     |
- *	      | + 152 byte SA |     |
- * R15	   -> +---------------+     + low
- *
- * We get 160 bytes stack space from calling function, but only use
- * 12 * 8 byte for old backchain, r15..r6, and tail_call_cnt.
- *
- * The stack size used by the BPF program ("BPF stack" above) is passed
- * via "aux->stack_depth".
- */
-#define STK_SPACE_ADD	(160)
-#define STK_160_UNUSED	(160 - 12 * 8)
-#define STK_OFF		(STK_SPACE_ADD - STK_160_UNUSED)
-
-#define STK_OFF_R6	(160 - 11 * 8)	/* Offset of r6 on stack */
-#define STK_OFF_TCCNT	(160 - 12 * 8)	/* Offset of tail_call_cnt on stack */
-
-#endif /* __ARCH_S390_NET_BPF_JIT_H */
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0137fb579fdb9..cfcf2ee960944 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -31,7 +31,6 @@
 #include <asm/nospec-branch.h>
 #include <asm/set_memory.h>
 #include <asm/text-patching.h>
-#include "bpf_jit.h"
 
 struct bpf_jit {
 	u32 seen;		/* Flags to remember seen eBPF instructions */
@@ -53,7 +52,7 @@ struct bpf_jit {
 	int excnt;		/* Number of exception table entries */
 	int prologue_plt_ret;	/* Return address for prologue hotpatch PLT */
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
-	u32 frame_off;		/* Offset of frame from %r15 */
+	u32 frame_off;		/* Offset of struct bpf_prog from %r15 */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -399,12 +398,26 @@ static void jit_fill_hole(void *area, unsigned int size)
 	memset(area, 0, size);
 }
 
+/*
+ * Caller-allocated part of the frame.
+ * Thanks to packed stack, its otherwise unused initial part can be used for
+ * the BPF stack and for the next frame.
+ */
+struct prog_frame {
+	u64 unused[8];
+	/* BPF stack starts here and grows towards 0 */
+	u32 tail_call_cnt;
+	u32 pad;
+	u64 r6[10];  /* r6 - r15 */
+	u64 backchain;
+} __packed;
+
 /*
  * Save registers from "rs" (register start) to "re" (register end) on stack
  */
 static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
 {
-	u32 off = STK_OFF_R6 + (rs - 6) * 8;
+	u32 off = offsetof(struct prog_frame, r6) + (rs - 6) * 8;
 
 	if (rs == re)
 		/* stg %rs,off(%r15) */
@@ -419,7 +432,7 @@ static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
  */
 static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re)
 {
-	u32 off = jit->frame_off + STK_OFF_R6 + (rs - 6) * 8;
+	u32 off = jit->frame_off + offsetof(struct prog_frame, r6) + (rs - 6) * 8;
 
 	if (rs == re)
 		/* lg %rs,off(%r15) */
@@ -551,10 +564,12 @@ static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
  * Emit function prologue
  *
  * Save registers and create stack frame if necessary.
- * See stack frame layout description in "bpf_jit.h"!
+ * Stack frame layout is described by struct prog_frame.
  */
 static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 {
+	BUILD_BUG_ON(sizeof(struct prog_frame) != STACK_FRAME_OVERHEAD);
+
 	/* No-op for hotpatching */
 	/* brcl 0,prologue_plt */
 	EMIT6_PCREL_RILC(0xc0040000, 0, jit->prologue_plt);
@@ -562,8 +577,9 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 
 	if (fp->aux->func_idx == 0) {
 		/* Initialize the tail call counter in the main program. */
-		/* xc STK_OFF_TCCNT(4,%r15),STK_OFF_TCCNT(%r15) */
-		_EMIT6(0xd703f000 | STK_OFF_TCCNT, 0xf000 | STK_OFF_TCCNT);
+		/* xc tail_call_cnt(4,%r15),tail_call_cnt(%r15) */
+		_EMIT6(0xd703f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
 	} else {
 		/*
 		 * Skip the tail call counter initialization in subprograms.
@@ -593,13 +609,15 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK)) {
 		/* lgr %w1,%r15 (backchain) */
 		EMIT4(0xb9040000, REG_W1, REG_15);
-		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
-		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
+		/* la %bfp,unused_end(%r15) (BPF frame pointer) */
+		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15,
+			   offsetofend(struct prog_frame, unused));
 		/* aghi %r15,-frame_off */
 		EMIT4_IMM(0xa70b0000, REG_15, -jit->frame_off);
-		/* stg %w1,152(%r15) (backchain) */
+		/* stg %w1,backchain(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
-			      REG_15, 152);
+			      REG_15,
+			      offsetof(struct prog_frame, backchain));
 	}
 }
 
@@ -1429,9 +1447,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 * Note 2: We assume that the verifier does not let us call the
 		 * main program, which clears the tail call counter on entry.
 		 */
-		/* mvc STK_OFF_TCCNT(4,%r15),frame_off+STK_OFF_TCCNT(%r15) */
-		_EMIT6(0xd203f000 | STK_OFF_TCCNT,
-		       0xf000 | (jit->frame_off + STK_OFF_TCCNT));
+		/* mvc tail_call_cnt(4,%r15),frame_off+tail_call_cnt(%r15) */
+		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | (jit->frame_off +
+				 offsetof(struct prog_frame, tail_call_cnt)));
 
 		/* Sign-extend the kfunc arguments. */
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
@@ -1482,7 +1501,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 *         goto out;
 		 */
 
-		off = jit->frame_off + STK_OFF_TCCNT;
+		off = jit->frame_off +
+		      offsetof(struct prog_frame, tail_call_cnt);
 		/* lhi %w0,1 */
 		EMIT4_IMM(0xa7080000, REG_W0, 1);
 		/* laal %w1,%w0,off(%r15) */
@@ -1824,7 +1844,9 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->prg = 0;
 	jit->excnt = 0;
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK))
-		jit->frame_off = STK_OFF + round_up(fp->aux->stack_depth, 8);
+		jit->frame_off = sizeof(struct prog_frame) -
+				 offsetofend(struct prog_frame, unused) +
+				 round_up(fp->aux->stack_depth, 8);
 	else
 		jit->frame_off = 0;
 
@@ -2281,9 +2303,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	/* stg %r1,backchain_off(%r15) */
 	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_1, REG_0, REG_15,
 		      tjit->backchain_off);
-	/* mvc tccnt_off(4,%r15),stack_size+STK_OFF_TCCNT(%r15) */
+	/* mvc tccnt_off(4,%r15),stack_size+tail_call_cnt(%r15) */
 	_EMIT6(0xd203f000 | tjit->tccnt_off,
-	       0xf000 | (tjit->stack_size + STK_OFF_TCCNT));
+	       0xf000 | (tjit->stack_size +
+			 offsetof(struct prog_frame, tail_call_cnt)));
 	/* stmg %r2,%rN,fwd_reg_args_off(%r15) */
 	if (nr_reg_args)
 		EMIT6_DISP_LH(0xeb000000, 0x0024, REG_2,
@@ -2420,8 +2443,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 				       (nr_stack_args * sizeof(u64) - 1) << 16 |
 				       tjit->stack_args_off,
 			       0xf000 | tjit->orig_stack_args_off);
-		/* mvc STK_OFF_TCCNT(4,%r15),tccnt_off(%r15) */
-		_EMIT6(0xd203f000 | STK_OFF_TCCNT, 0xf000 | tjit->tccnt_off);
+		/* mvc tail_call_cnt(4,%r15),tccnt_off(%r15) */
+		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | tjit->tccnt_off);
 		/* lgr %r1,%r8 */
 		EMIT4(0xb9040000, REG_1, REG_8);
 		/* %r1() */
@@ -2478,8 +2502,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET))
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
-	/* mvc stack_size+STK_OFF_TCCNT(4,%r15),tccnt_off(%r15) */
-	_EMIT6(0xd203f000 | (tjit->stack_size + STK_OFF_TCCNT),
+	/* mvc stack_size+tail_call_cnt(4,%r15),tccnt_off(%r15) */
+	_EMIT6(0xd203f000 | (tjit->stack_size +
+			     offsetof(struct prog_frame, tail_call_cnt)),
 	       0xf000 | tjit->tccnt_off);
 	/* aghi %r15,stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, tjit->stack_size);
-- 
2.51.0


