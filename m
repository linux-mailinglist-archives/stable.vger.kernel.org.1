Return-Path: <stable+bounces-268305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4GNwCrHnPGquuAgAu9opvQ
	(envelope-from <stable+bounces-268305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:32:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAD16C3D45
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=fREn7Gog;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268305-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268305-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36DD23020676
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88737AA97;
	Thu, 25 Jun 2026 08:32:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1835DA5B;
	Thu, 25 Jun 2026 08:32:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376366; cv=none; b=pVXP8BMnR/KFsN91+ZXEGbSCy9qmP2/h3s97pQidrgSg3CWUsc1uH0JmkiTAP1vSlggS88/yjHw1/WoN/KomQutPHJKbAS1zWPGMeX55U+gr6L/MSgeIu6YtIpnakIr7+iEEM3BrAApZzyXBSxMuJaGclObUp5JHG0GIaJkl5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376366; c=relaxed/simple;
	bh=wxg03im1f3YOJxcnQ0xXatdZvR3HwBAxP3yyQlUmdzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTxHAJ3kLBJ8WCqmBczzdbnZG2FZ9AF6RcgCr5+jTmEnKQ+XFcZcUss1jGZ3egoSJp+vXW2390dYhZHaB89RXi9/w7kH2NUrTpmBX/EXhDl5b+w8h8VKQEKjLV+I7XJXSA5Knq2AaX3grHgq1igajq/InKIJt8cyJNhbQeOp+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fREn7Gog; arc=none smtp.client-ip=95.215.58.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782376363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdyWriMjR0iiOwFrvG83IYqEIicSTh+06bqz9e9I5vc=;
	b=fREn7GogwWL7B+cks1Y5M33kzKuDc9NGT21iUUrSVqNU89LJaNzaLBRQcuRltPPxdtHr/c
	YyR9EcWD8btzTadZ8js5jKswMfqbm1TVGrq+nfVaD1Kxuhn+yjrL8X5okLmMWaAlMNH1g7
	p9ArhScvl+oaRuU/BxTjb3F6zmcrF+k=
From: George Guo <dongtai.guo@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf 1/2] LoongArch: BPF: Fix tail call count pointer offset for arena programs
Date: Thu, 25 Jun 2026 16:32:11 +0800
Message-Id: <20260625083212.277417-2-dongtai.guo@linux.dev>
In-Reply-To: <20260625083212.277417-1-dongtai.guo@linux.dev>
References: <20260625083212.277417-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268305-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:chenhuacai@kernel.org,m:yangtiezhu@loongson.cn,m:hengqi.chen@gmail.com,m:kernel@xen0n.name,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:guodongtai@kylinos.cn,m:bpf@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hengqichen@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dongtai.guo@linux.dev,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,loongson.cn,gmail.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongtai.guo@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[xen0n.name,linux.dev,gmail.com,kernel.org,kylinos.cn,vger.kernel.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDAD16C3D45

From: George Guo <guodongtai@kylinos.cn>

The tail call count (TCC) and its pointer occupy the two deepest slots of
the callee-saved area set up by build_prologue(). An arena program reserves
one extra word for REG_ARENA (arena_vm_start) right above them:

    ra fp s0 s1 s2 s3 s4 s5      <- 8 words
    [ REG_ARENA ]                <- only if ctx->arena_vm_start
    tail_call_cnt
    tail_call_cnt_ptr            <- loaded on tail call / bpf2bpf call

BPF_TAIL_CALL_CNT_PTR_STACK_OFF() hardcodes the pointer at
round_up(stack, 16) - 80, which is only correct when REG_ARENA is absent.
For an arena program the extra word shifts every slot below it down by 8
bytes, so the macro resolves to the tail_call_cnt slot (the counter value)
instead of tail_call_cnt_ptr. The JIT then loads that small integer and
dereferences it as the TCC pointer, corrupting memory or panicking the
kernel whenever an arena program performs a tail call or a bpf2bpf call.

Replace the macro with a helper that accounts for the REG_ARENA slot,
mirroring the reservation logic in build_prologue().

Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")
Cc: stable@vger.kernel.org
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..f705de099f23 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -18,7 +18,23 @@
 
 #define REG_TCC		LOONGARCH_GPR_A6
 #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
-#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
+
+static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
+{
+	/* Ten words are pushed below the BPF stack: ra, fp, s0-s5, and the
+	 * tail call count plus its pointer, which occupy the two deepest
+	 * slots of the callee-saved area.
+	 */
+	int offset = sizeof(long) * 10;
+
+	/* An arena program reserves one extra word above them (REG_ARENA),
+	 * which pushes the tail call count pointer down by one slot.
+	 */
+	if (ctx->arena_vm_start)
+		offset += sizeof(long);
+
+	return round_up(ctx->stack_size, 16) - offset;
+}
 
 static const int regmap[] = {
 	/* return value from in-kernel function, and exit value for eBPF program */
@@ -278,7 +294,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
 	int off, tc_ninsn = 0;
-	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+	int tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
@@ -1153,7 +1169,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			return ret;
 
 		if (insn->src_reg == BPF_PSEUDO_CALL) {
-			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+			tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 		}
 
-- 
2.25.1


