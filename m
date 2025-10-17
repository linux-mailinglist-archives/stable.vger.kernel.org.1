Return-Path: <stable+bounces-186297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCB6BE7CF1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 11:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9305652AC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E332DAFA3;
	Fri, 17 Oct 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oaVoorf/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0392DA74C
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693168; cv=none; b=mmwMJwqDvHKMvuPadhHPgQyW/kWPaJVZwPonnHkDywHx+U+zjHi8UcnwT0WFWlt/z7G8M7to421EHlQ9N99CrDjnuzpgL6rlTECnTMrKEv97whAOZKB+9UStibijDeC1A18mKTIE+Y24XEp6k7j6+fBE+evdzAafYaZnhzbOqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693168; c=relaxed/simple;
	bh=SS8mChcxGCFJnv1M4QwqGaFx/BT+pyXczPuykk9seiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r53ZC+9JOvrB3XAuzRT/DP0d4uW2gC2w/ZTK/5kQuEU/nUnNIeL75EHGvBG/XiAqCWGqRE1t8kIGYNmVbNJUHUdpFLGjr+iPlh0Z3u7VwWQo3Win6+zS34DrGx29kZ5jbT5xOcA08zSjHeijm3HzZMB3Uki1Z9vXKXIJlPR5Ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oaVoorf/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H96RNT023560;
	Fri, 17 Oct 2025 09:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GOnqNVrwNyFs82fTU
	51Q4OFnYhLp+xA9idWlPWBKEMU=; b=oaVoorf/JVd9hcKD3HHdOR7/odWZF3uRC
	aSKiUZjFMiTCZK6ZkuAXSp02F237nOQqbS3AhfcN4GVxHHRU816gmrHVZ8eW+bqo
	/OqssACki8dacr2OxsnxXloHO0zWlsK79z2PsvGuInQ5SWlOyyncql+sB4fh3AxB
	4TRxJT030+FnYU0AaStXPCLDwnWv8YoNJRDyyxYaI5udBr+cIFT18dVuiQOU2SRV
	Kp6HULrwAGPBsxKqhOD+NpYFpMfdJKbGx9kqE8EjBus22J4nd0XPwLLwRD1L2nwb
	ITZNjK+zF5liLRibRYtNc/Wd0mYVZUu+mU5EaE323tEmyKtenTpHQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxpu7nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:25:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9EBmK003623;
	Fri, 17 Oct 2025 09:25:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xycgy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 09:25:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59H9PqB316843214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:25:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 503772023C;
	Fri, 17 Oct 2025 09:25:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10E6D2023B;
	Fri, 17 Oct 2025 09:25:52 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Oct 2025 09:25:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.12.y 1/4] s390/bpf: Centralize frame offset calculations
Date: Fri, 17 Oct 2025 11:19:04 +0200
Message-ID: <20251017092550.88640-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017092550.88640-1-iii@linux.ibm.com>
References: <20251017092550.88640-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3LxlQ0ygge-R3_AwZEqQZHv4yeukZkzi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfX9Qfiv5HtiPOm
 +W3pQmXvaSQjTFUxxstAXfqeLfVUxs53TDlPM6oY523dOX31k1zkBd3UZmPB4XCiKKzNnJurMLd
 KisfcocpKpeNWZmbEOPCBYUox51YcDDJ7YfhlBZYOlwTKZOyAdTd7glWqiErdIbmfwvyZ/D0CGd
 4drM9mw+gGh/ML1e6UEi9J7Mmpdkjz8vjupqlBnP2FGtsomixU4Pv1WXZtb9+Ypq8I3WCi7YNEI
 8+Nb1HYIWC8fCZXnVq23UwKBwsUK6fU77S7ntO++JxeNzp2/WeGpEE8TEtEW6arw1+UmIbvy2g1
 WtfFGRF5Etz8Ckor5eywv97vlHGHj276L1Q4UEexIt4ic1xqi6WUJNmmwpUoPztS6p5TJ8HKN63
 58eKLXRgD4SrBLjcLuz6oYxpAdQi4A==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f20ba5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=D2pd9Y9NvbT0Hdv2LDYA:9
X-Proofpoint-ORIG-GUID: 3LxlQ0ygge-R3_AwZEqQZHv4yeukZkzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
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
index ead8d9ba9032c..12fda05aadf61 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -56,6 +56,7 @@ struct bpf_jit {
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
 	int kern_arena;		/* Pool offset of kernel arena address */
 	u64 user_arena;		/* User arena address */
+	u32 frame_off;		/* Offset of frame from %r15 */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -421,12 +422,9 @@ static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
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
@@ -470,8 +468,7 @@ static int get_end(u16 seen_regs, int start)
  * Save and restore clobbered registers (6-15) on stack.
  * We save/restore registers in chunks with gap >= 2 registers.
  */
-static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
-			      u16 extra_regs)
+static void save_restore_regs(struct bpf_jit *jit, int op, u16 extra_regs)
 {
 	u16 seen_regs = jit->seen_regs | extra_regs;
 	const int last = 15, save_restore_size = 6;
@@ -494,7 +491,7 @@ static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
 		if (op == REGS_SAVE)
 			save_regs(jit, rs, re);
 		else
-			restore_regs(jit, rs, re, stack_depth);
+			restore_regs(jit, rs, re);
 		re++;
 	} while (re <= last);
 }
@@ -561,8 +558,7 @@ static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
  * Save registers and create stack frame if necessary.
  * See stack frame layout description in "bpf_jit.h"!
  */
-static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
-			     u32 stack_depth)
+static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 {
 	/* No-op for hotpatching */
 	/* brcl 0,prologue_plt */
@@ -595,7 +591,7 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 		jit->seen_regs |= NVREGS;
 	} else {
 		/* Save registers */
-		save_restore_regs(jit, REGS_SAVE, stack_depth,
+		save_restore_regs(jit, REGS_SAVE,
 				  fp->aux->exception_boundary ? NVREGS : 0);
 	}
 	/* Setup literal pool */
@@ -617,8 +613,8 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
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
@@ -665,13 +661,13 @@ static void call_r1(struct bpf_jit *jit)
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
@@ -862,7 +858,7 @@ static int sign_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
  * stack space for the large switch statement.
  */
 static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
-				 int i, bool extra_pass, u32 stack_depth)
+				 int i, bool extra_pass)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
 	s32 branch_oc_off = insn->off;
@@ -1783,9 +1779,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
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
@@ -1836,10 +1832,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
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
@@ -1869,7 +1862,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/*
 		 * Restore registers before calling function
 		 */
-		save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
+		save_restore_regs(jit, REGS_RESTORE, 0);
 
 		/*
 		 * goto *(prog->bpf_func + tail_call_start);
@@ -2161,7 +2154,7 @@ static int bpf_set_addr(struct bpf_jit *jit, int i)
  * Compile eBPF program into s390x code
  */
 static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
-			bool extra_pass, u32 stack_depth)
+			bool extra_pass)
 {
 	int i, insn_count, lit32_size, lit64_size;
 	u64 kern_arena;
@@ -2170,24 +2163,28 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->lit64 = jit->lit64_start;
 	jit->prg = 0;
 	jit->excnt = 0;
+	if (is_first_pass(jit) || (jit->seen & SEEN_STACK))
+		jit->frame_off = STK_OFF + round_up(fp->aux->stack_depth, 8);
+	else
+		jit->frame_off = 0;
 
 	kern_arena = bpf_arena_get_kern_vm_start(fp->aux->arena);
 	if (kern_arena)
 		jit->kern_arena = _EMIT_CONST_U64(kern_arena);
 	jit->user_arena = bpf_arena_get_user_vm_start(fp->aux->arena);
 
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
@@ -2263,7 +2260,6 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
  */
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
-	u32 stack_depth = round_up(fp->aux->stack_depth, 8);
 	struct bpf_prog *tmp, *orig_fp = fp;
 	struct bpf_binary_header *header;
 	struct s390_jit_data *jit_data;
@@ -2316,7 +2312,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 *   - 3:   Calculate program size and addrs array
 	 */
 	for (pass = 1; pass <= 3; pass++) {
-		if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
+		if (bpf_jit_prog(&jit, fp, extra_pass)) {
 			fp = orig_fp;
 			goto free_addrs;
 		}
@@ -2330,7 +2326,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
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


