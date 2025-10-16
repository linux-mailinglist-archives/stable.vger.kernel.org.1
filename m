Return-Path: <stable+bounces-186210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FCBE59EB
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97C8540B16
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751C02E3B1C;
	Thu, 16 Oct 2025 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BL4c2SR7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885412E0B4B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651730; cv=none; b=SuUnbcDTtzvTjL3lUE7MckvEHYYUZZa0OpNdIJV+pkCVfn9H1pctFl1Zf0wi7Ifjb0M8JF0XhYDcLZTUFd2quaUn6OlA5S4cfsceCVVSo9z1AW0jp7/Z0Bzu8K5j6cMMWYBMdk8AAv2qYhrE9uIeGx4lqSB5b6kNQLCuXyRKGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651730; c=relaxed/simple;
	bh=EX+ane9cWMpvwcR0cuQx/GU8yoQ6Z/McqjVbgVePAeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmtSKyb/CSYeLQ8PR/tyaiLTC/8zSfoDaYNyos4sr2Bff2cN6vmw044AN1OGszcJ+w7Au6DHGfmGf3M3m/qbaD+thQoxyyswcdA8ZKuKpVAmuefKG6GzI27dHStpAmExLCMeonkyI4vspIvP9PX3tR3qAiyQnrdIlc8Z36DmW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BL4c2SR7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GK8rt0012279;
	Thu, 16 Oct 2025 21:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N0KE24pxqIv7CEP/E
	3nil5J8Y3uwXhLtUA1ivsWmXww=; b=BL4c2SR74+XD/TQuoq52kAy85jnO9656+
	tVn4+Xgv0mkPOk25pMvgi9HHsE7se304xO7UHgY6TXkiThU0xQLzRYa7mvUF1wLp
	UkNFW0CvXmmtzoZbNR3mwehLJ8/8mYNMmybv7UnCZiZlO/V97phQqP/UfB6LFJsN
	i33hSDQ+wtkvskB8R5Fre1GPw9k7RiwIHt1H25CgCBSFkYgWs3Ah1IUNxGnKqUxk
	/wpgknWRMg3bl/gjpBOu8M5mRaJXSz0aJ/hrYQMwekmWwWqYikzUaZ6KIC4nDJV4
	jfbhmfQvbu/68cfnclUGWFWBAU1nJYLCTnHCIjwJA/nSka1rPee2Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrmfpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKTOwx003603;
	Thu, 16 Oct 2025 21:55:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy850r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 21:55:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GLtBro36700602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 21:55:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC36D20174;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7896F20173;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 1/5] s390/bpf: Change seen_reg to a mask
Date: Thu, 16 Oct 2025 23:51:24 +0200
Message-ID: <20251016215450.53494-2-iii@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f169c4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hWMQpYRtAAAA:8 a=1smG7v4xQ4WWfQjGSpUA:9 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-GUID: 7le3KsZYJUg2nZ7TvTZynRAWw1wUn4ti
X-Proofpoint-ORIG-GUID: 7le3KsZYJUg2nZ7TvTZynRAWw1wUn4ti
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX3d/EgksKZEdi
 MpZopg/nw0CnvmM2DyWhfKaRZbq2BU3AiQQuOy+733lP81hgSX6rjCCOruhckDj39fV5AXEf3O3
 M9CEzmT3Ku5N8DpIScT7mKbNib9RxcjiYevmdXgzFtxutuZOqZluzqmfPthZZs6hwJP43WwGn7N
 Qg5h8SY+GsXOVB/4EBs3aHaBSvVb/7MNJfxndcxQrdZfXU8/nVGSSf97hakT+6ixmMAdZngUyin
 98H1yQu9yifyvzSa075Ex5OFNaayYzJ6tjUYvWdA2568pF2W0MYyL3auWwXak/ny+SMtRH3Kt7M
 mtkwPR4H6L4Bwmgc7vqu7fuwW6F7fK9OV96oRPLSMQwCqzreejNP+o7KVfDAFhCtKGoPl5A1e8P
 VKKID391OdNf8qfGfUzr/7oyivD0yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140

commit 7ba4f43e16de351fe9821de80e15d88c884b2967 upstream.

Using a mask instead of an array saves a small amount of memory and
allows marking multiple registers as seen with a simple "or". Another
positive side-effect is that it speeds up verification with jitterbug.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240703005047.40915-2-iii@linux.ibm.com
---
 arch/s390/net/bpf_jit_comp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 2d8facfd4e425..fc61801c0f73c 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -35,7 +35,7 @@
 
 struct bpf_jit {
 	u32 seen;		/* Flags to remember seen eBPF instructions */
-	u32 seen_reg[16];	/* Array to remember which registers are used */
+	u16 seen_regs;		/* Mask to remember which registers are used */
 	u32 *addrs;		/* Array with relative instruction addresses */
 	u8 *prg_buf;		/* Start of program */
 	int size;		/* Size of program and literal pool */
@@ -118,8 +118,8 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 {
 	u32 r1 = reg2hex[b1];
 
-	if (r1 >= 6 && r1 <= 15 && !jit->seen_reg[r1])
-		jit->seen_reg[r1] = 1;
+	if (r1 >= 6 && r1 <= 15)
+		jit->seen_regs |= (1 << r1);
 }
 
 #define REG_SET_SEEN(b1)					\
@@ -127,8 +127,6 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	reg_set_seen(jit, b1);					\
 })
 
-#define REG_SEEN(b1) jit->seen_reg[reg2hex[(b1)]]
-
 /*
  * EMIT macros for code generation
  */
@@ -436,12 +434,12 @@ static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re, u32 stack_depth)
 /*
  * Return first seen register (from start)
  */
-static int get_start(struct bpf_jit *jit, int start)
+static int get_start(u16 seen_regs, int start)
 {
 	int i;
 
 	for (i = start; i <= 15; i++) {
-		if (jit->seen_reg[i])
+		if (seen_regs & (1 << i))
 			return i;
 	}
 	return 0;
@@ -450,15 +448,15 @@ static int get_start(struct bpf_jit *jit, int start)
 /*
  * Return last seen register (from start) (gap >= 2)
  */
-static int get_end(struct bpf_jit *jit, int start)
+static int get_end(u16 seen_regs, int start)
 {
 	int i;
 
 	for (i = start; i < 15; i++) {
-		if (!jit->seen_reg[i] && !jit->seen_reg[i + 1])
+		if (!(seen_regs & (3 << i)))
 			return i - 1;
 	}
-	return jit->seen_reg[15] ? 15 : 14;
+	return (seen_regs & (1 << 15)) ? 15 : 14;
 }
 
 #define REGS_SAVE	1
@@ -467,8 +465,10 @@ static int get_end(struct bpf_jit *jit, int start)
  * Save and restore clobbered registers (6-15) on stack.
  * We save/restore registers in chunks with gap >= 2 registers.
  */
-static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth)
+static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
+			      u16 extra_regs)
 {
+	u16 seen_regs = jit->seen_regs | extra_regs;
 	const int last = 15, save_restore_size = 6;
 	int re = 6, rs;
 
@@ -482,10 +482,10 @@ static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth)
 	}
 
 	do {
-		rs = get_start(jit, re);
+		rs = get_start(seen_regs, re);
 		if (!rs)
 			break;
-		re = get_end(jit, rs + 1);
+		re = get_end(seen_regs, rs + 1);
 		if (op == REGS_SAVE)
 			save_regs(jit, rs, re);
 		else
@@ -579,7 +579,7 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 	/* Tail calls have to skip above initialization */
 	jit->tail_call_start = jit->prg;
 	/* Save registers */
-	save_restore_regs(jit, REGS_SAVE, stack_depth);
+	save_restore_regs(jit, REGS_SAVE, stack_depth, 0);
 	/* Setup literal pool */
 	if (is_first_pass(jit) || (jit->seen & SEEN_LITERAL)) {
 		if (!is_first_pass(jit) &&
@@ -653,7 +653,7 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	/* Load exit code: lgr %r2,%b0 */
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
-	save_restore_regs(jit, REGS_RESTORE, stack_depth);
+	save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
 	if (nospec_uses_trampoline()) {
 		jit->r14_thunk_ip = jit->prg;
 		/* Generate __s390_indirect_jump_r14 thunk */
@@ -1519,7 +1519,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/*
 		 * Restore registers before calling function
 		 */
-		save_restore_regs(jit, REGS_RESTORE, stack_depth);
+		save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
 
 		/*
 		 * goto *(prog->bpf_func + tail_call_start);
-- 
2.51.0


