Return-Path: <stable+bounces-186208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87508BE59E5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5311A66CE4
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448852E3B1C;
	Thu, 16 Oct 2025 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n/Kn2K5T"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2E2E426A
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651722; cv=none; b=eiscub9U1TH2vhrTZMc1AxzRi0PyvygeOtomS8ctJTXfT9M5Sr2XyopdmWZ3IsxoMfydTPiE/l5xR1BlJVj8FRCCKJp1oDNnr5EzrZLzcvfO9fT/V310Gvp/FQz+g611LuWuWFuZYnn5ccG7YMOfkJAYDawzcwPf8PH+EISKWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651722; c=relaxed/simple;
	bh=TOY31KhP4BLEWg5QoQBwRQ20XplZCQ6BcT9tzH6eLE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXjCO+h0KexBP+owNh/1ulHkYZtwLrqCL7lTmLrDJLesmTdbKKYJ6MwAakY1G6ZPrnc/ZY3FFMESzc5IyPhfT7ESXTo4lapX2Kk0m7bBcQZ6MUy8/6AfwUxccChFEifIZwwCVs3eByNkUje3oSHrmLLwGwsYrpkEyaLRrr0nvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n/Kn2K5T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFS1Xo024872;
	Thu, 16 Oct 2025 21:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SYtiQMGRSgvtjdgT4
	VAwWdkZWFNvXDACm4go2M0Jm9s=; b=n/Kn2K5T7Vcmw3gjJ4hVC5R+PG9XRWWkO
	mc9+7tpXhkPAkbeXMFyyTlY5A70kFHkb28fG1qKQ5188IUyKmxpnFxJsZE6WteU0
	AlioU1H4bBLxi+uslm77ZwnPxUb+MbebpditAGgFaxWJzkNh7XhD2HZqxYYvLHXc
	coq1UtoALhvvZb+3mu62yYl8p2/kvv/RwJQGQzoUcpaimEHnSivwaNLoBdiaKYdn
	M00djYnDML/w/a7dAeLZdPFe1fjYR4nrAILO0GaWzdRqV7wj8hoy4XJuPMkgpDO3
	Tb8Kc76f8rDKLQUN3O7NnGr7liSuyvyj7GzUmhIWXOrWzoF4gVcTg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpq235-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GK1IUi015219;
	Thu, 16 Oct 2025 21:55:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jsg9we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GLtCIa33751452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 21:55:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3B7020174;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC60020175;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.6.y 2/5] s390/bpf: Centralize frame offset calculations
Date: Thu, 16 Oct 2025 23:51:25 +0200
Message-ID: <20251016215450.53494-3-iii@linux.ibm.com>
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
X-Proofpoint-GUID: yyBLx9Uvi0tEs4G-OPssjQJl6HbPStlx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfX+r8lVjj6XtVO
 J3IFqbtC/r69vwPkmrCZW+CsOumDY1dVDpcXBdB+imt8KLdmo7jlLe2RGNGrWLbP03nFWCREPBT
 FgpQB8I0bQSfCzkEsFUvUdLVuK/4GGa6CzY+1UYfUejId2LMhEUWFVeHk/M8Y5B5trLJjHdu7SL
 DlpjWfG3mDVk7X8oYKV4MbDG+8Re/NprV6HExchSmgwORrPXqMocdrBDLstXRTajPfunEIBu6Ux
 Ixs/xpTPgZ5Ahf7egRL09ztZ91VorAtiZInPS8hbJAbHkhBw5MrevZuhGHguI8kGLyKtduBCZgE
 mdwS5UvkjChU0x6PWKkpi14nifuu47r4lyXfSEIcF1Ga9ER9mNYIIiH+GYjy0UiW4hYv8iQuV3m
 xq+fWaubAbGh8b4EN66AvAi0G7CeWQ==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f169c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rAoO7cwStkBkSWgSXe0A:9
X-Proofpoint-ORIG-GUID: yyBLx9Uvi0tEs4G-OPssjQJl6HbPStlx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125

commit b2268d550d20ff860bddfe3a91b1aec00414689a upstream.

The calculation of the distance from %r15 to the caller-allocated
portion of the stack frame is copy-pasted into multiple places in the
JIT code.

Move it to bpf_jit_prog() and save the result into bpf_jit::frame_off,
so that the other parts of the JIT can use it.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Link: https://lore.kernel.org/r/20250624121501.50536-2-iii@linux.ibm.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 56 +++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index fc61801c0f73c..0137fb579fdb9 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -53,6 +53,7 @@ struct bpf_jit {
 	int excnt;		/* Number of exception table entries */
 	int prologue_plt_ret;	/* Return address for prologue hotpatch PLT */
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
+	u32 frame_off;		/* Offset of frame from %r15 */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -416,12 +417,9 @@ static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
 /*
  * Restore registers from "rs" (register start) to "re" (register end) on stack
  */
-static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re, u32 stack_depth)
+static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re)
 {
-	u32 off = STK_OFF_R6 + (rs - 6) * 8;
-
-	if (jit->seen & SEEN_STACK)
-		off += STK_OFF + stack_depth;
+	u32 off = jit->frame_off + STK_OFF_R6 + (rs - 6) * 8;
 
 	if (rs == re)
 		/* lg %rs,off(%r15) */
@@ -465,8 +463,7 @@ static int get_end(u16 seen_regs, int start)
  * Save and restore clobbered registers (6-15) on stack.
  * We save/restore registers in chunks with gap >= 2 registers.
  */
-static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
-			      u16 extra_regs)
+static void save_restore_regs(struct bpf_jit *jit, int op, u16 extra_regs)
 {
 	u16 seen_regs = jit->seen_regs | extra_regs;
 	const int last = 15, save_restore_size = 6;
@@ -489,7 +486,7 @@ static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
 		if (op == REGS_SAVE)
 			save_regs(jit, rs, re);
 		else
-			restore_regs(jit, rs, re, stack_depth);
+			restore_regs(jit, rs, re);
 		re++;
 	} while (re <= last);
 }
@@ -556,8 +553,7 @@ static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
  * Save registers and create stack frame if necessary.
  * See stack frame layout description in "bpf_jit.h"!
  */
-static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
-			     u32 stack_depth)
+static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 {
 	/* No-op for hotpatching */
 	/* brcl 0,prologue_plt */
@@ -579,7 +575,7 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	/* Tail calls have to skip above initialization */
 	jit->tail_call_start = jit->prg;
 	/* Save registers */
-	save_restore_regs(jit, REGS_SAVE, stack_depth, 0);
+	save_restore_regs(jit, REGS_SAVE, 0);
 	/* Setup literal pool */
 	if (is_first_pass(jit) || (jit->seen & SEEN_LITERAL)) {
 		if (!is_first_pass(jit) &&
@@ -599,8 +595,8 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4(0xb9040000, REG_W1, REG_15);
 		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
 		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
-		/* aghi %r15,-STK_OFF */
-		EMIT4_IMM(0xa70b0000, REG_15, -(STK_OFF + stack_depth));
+		/* aghi %r15,-frame_off */
+		EMIT4_IMM(0xa70b0000, REG_15, -jit->frame_off);
 		/* stg %w1,152(%r15) (backchain) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
 			      REG_15, 152);
@@ -647,13 +643,13 @@ static void call_r1(struct bpf_jit *jit)
 /*
  * Function epilogue
  */
-static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
+static void bpf_jit_epilogue(struct bpf_jit *jit)
 {
 	jit->exit_ip = jit->prg;
 	/* Load exit code: lgr %r2,%b0 */
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
-	save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
+	save_restore_regs(jit, REGS_RESTORE, 0);
 	if (nospec_uses_trampoline()) {
 		jit->r14_thunk_ip = jit->prg;
 		/* Generate __s390_indirect_jump_r14 thunk */
@@ -779,7 +775,7 @@ static int sign_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
  * stack space for the large switch statement.
  */
 static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
-				 int i, bool extra_pass, u32 stack_depth)
+				 int i, bool extra_pass)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
 	u32 dst_reg = insn->dst_reg;
@@ -1433,9 +1429,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 * Note 2: We assume that the verifier does not let us call the
 		 * main program, which clears the tail call counter on entry.
 		 */
-		/* mvc STK_OFF_TCCNT(4,%r15),N(%r15) */
+		/* mvc STK_OFF_TCCNT(4,%r15),frame_off+STK_OFF_TCCNT(%r15) */
 		_EMIT6(0xd203f000 | STK_OFF_TCCNT,
-		       0xf000 | (STK_OFF_TCCNT + STK_OFF + stack_depth));
+		       0xf000 | (jit->frame_off + STK_OFF_TCCNT));
 
 		/* Sign-extend the kfunc arguments. */
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
@@ -1486,10 +1482,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 *         goto out;
 		 */
 
-		if (jit->seen & SEEN_STACK)
-			off = STK_OFF_TCCNT + STK_OFF + stack_depth;
-		else
-			off = STK_OFF_TCCNT;
+		off = jit->frame_off + STK_OFF_TCCNT;
 		/* lhi %w0,1 */
 		EMIT4_IMM(0xa7080000, REG_W0, 1);
 		/* laal %w1,%w0,off(%r15) */
@@ -1519,7 +1512,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/*
 		 * Restore registers before calling function
 		 */
-		save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
+		save_restore_regs(jit, REGS_RESTORE, 0);
 
 		/*
 		 * goto *(prog->bpf_func + tail_call_start);
@@ -1822,7 +1815,7 @@ static int bpf_set_addr(struct bpf_jit *jit, int i)
  * Compile eBPF program into s390x code
  */
 static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
-			bool extra_pass, u32 stack_depth)
+			bool extra_pass)
 {
 	int i, insn_count, lit32_size, lit64_size;
 
@@ -1830,19 +1823,23 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->lit64 = jit->lit64_start;
 	jit->prg = 0;
 	jit->excnt = 0;
+	if (is_first_pass(jit) || (jit->seen & SEEN_STACK))
+		jit->frame_off = STK_OFF + round_up(fp->aux->stack_depth, 8);
+	else
+		jit->frame_off = 0;
 
-	bpf_jit_prologue(jit, fp, stack_depth);
+	bpf_jit_prologue(jit, fp);
 	if (bpf_set_addr(jit, 0) < 0)
 		return -1;
 	for (i = 0; i < fp->len; i += insn_count) {
-		insn_count = bpf_jit_insn(jit, fp, i, extra_pass, stack_depth);
+		insn_count = bpf_jit_insn(jit, fp, i, extra_pass);
 		if (insn_count < 0)
 			return -1;
 		/* Next instruction address */
 		if (bpf_set_addr(jit, i + insn_count) < 0)
 			return -1;
 	}
-	bpf_jit_epilogue(jit, stack_depth);
+	bpf_jit_epilogue(jit);
 
 	lit32_size = jit->lit32 - jit->lit32_start;
 	lit64_size = jit->lit64 - jit->lit64_start;
@@ -1902,7 +1899,6 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
  */
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
-	u32 stack_depth = round_up(fp->aux->stack_depth, 8);
 	struct bpf_prog *tmp, *orig_fp = fp;
 	struct bpf_binary_header *header;
 	struct s390_jit_data *jit_data;
@@ -1955,7 +1951,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 *   - 3:   Calculate program size and addrs array
 	 */
 	for (pass = 1; pass <= 3; pass++) {
-		if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
+		if (bpf_jit_prog(&jit, fp, extra_pass)) {
 			fp = orig_fp;
 			goto free_addrs;
 		}
@@ -1969,7 +1965,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		goto free_addrs;
 	}
 skip_init_ctx:
-	if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
+	if (bpf_jit_prog(&jit, fp, extra_pass)) {
 		bpf_jit_binary_free(header);
 		fp = orig_fp;
 		goto free_addrs;
-- 
2.51.0


