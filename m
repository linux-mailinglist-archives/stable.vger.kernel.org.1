Return-Path: <stable+bounces-268307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3IGoEOPnPGrDuAgAu9opvQ
	(envelope-from <stable+bounces-268307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:33:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AF6C3D71
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:33:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=tKFX3rij;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268307-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268307-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B66F03017CD6
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981ED37B03E;
	Thu, 25 Jun 2026 08:33:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2B36EAAC
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376382; cv=none; b=bRL/W+Wp8yZFgU9gDHCt14YfuIozbbZE3ydlrt6uJlssj5dVB/zgAanUiLB87ll00Za4yc6dPsQ/msqPYJoDo2W4Lk85rQxgDo5WYyL0rl7HEO4K+X5iM0KBaSwK2Tibv2boCNejYAs/VHk+gU4UbYCEJ6zBPiKP5B1vckuwI20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376382; c=relaxed/simple;
	bh=yThKp5mFhuRuvb6z97ASLajoXXHye6N71J4ltOFHR/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpLhBqRL1I4vr3fjutlOrPMxNd7JIAEfwPAT9omVqXrd5LMKgeDejnJKdKKj/bqgsLoicKYlAdYSTlwsSkjkMBTzJHV1DxnQ9tL9hjzLlQiE4fi9OuzbUrDkbEylbSZKwsxFfYrQpUgKtnCUmGJ6783ENmpbOMFafcP3AoYaz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tKFX3rij; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782376369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUNI9HVJojfD4QXjQosjhgaZEtAM61ThFHovUKlA78o=;
	b=tKFX3rijkHIvpaRTLtYUWBP+vVHJYVFOVBtx43BhVE5xCTtwDKHoULneghqJTlVDgkpEVi
	2TK6P/HCx3Z98Q+sYRWbZ3I+MAGVnJVBAKbhrFxKPbaOC0kH3hrRT7lWYDDeCdrtC42uvV
	RETfyOImHnF0/0+evGHHOqHRPdJYxbo=
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
Subject: [PATCH bpf 2/2] LoongArch: BPF: Don't charge an empty prog_array slot to the tail call count
Date: Thu, 25 Jun 2026 16:32:12 +0800
Message-Id: <20260625083212.277417-3-dongtai.guo@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268307-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:chenhuacai@kernel.org,m:yangtiezhu@loongson.cn,m:hengqi.chen@gmail.com,m:kernel@xen0n.name,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:guodongtai@kylinos.cn,m:bpf@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hengqichen@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 621AF6C3D71

From: George Guo <guodongtai@kylinos.cn>

emit_bpf_tail_call() bumped the tail call count and stored it back to
*tcc_ptr before loading array->ptrs[index] and testing it for NULL.  A
tail call that targets an empty slot therefore consumed one unit of the
tail call budget even though control never transferred.

The interpreter increments tail_call_cnt only after the prog pointer is
found to be non-NULL (kernel/bpf/core.c, BPF_TAIL_CALL), so a fall-through
to an empty slot leaves the count untouched.  The JIT must do the same.

This is visible with selftests/bpf tailcalls/tailcall_3, whose entry prog
tail-calls an empty slot before the real target: the observed count is 32
instead of the expected 33.

Defer the store of the bumped count until after the NULL check.  The limit
comparison is unchanged: t3 = *tcc_ptr + 1, and "t3 > MAX_TAIL_CALL_CNT" is
equivalent to "*tcc_ptr >= MAX_TAIL_CALL_CNT".

The check-before-NULL ordering dates back to the original JIT; commit
c0fcc955ff82 ("LoongArch: BPF: Fix the tailcall hierarchy") reworked the
counter into the *tcc_ptr form but preserved the same ordering.

Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Cc: stable@vger.kernel.org
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index f705de099f23..f2aa0b7f65ad 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -323,13 +323,18 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 		goto toofar;
 
 	/*
-	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
+	 * if (*tcc_ptr + 1 > MAX_TAIL_CALL_CNT)
 	 *      goto out;
+	 *
+	 * Compute the bumped count but do not write it back yet: the
+	 * interpreter increments tail_call_cnt only after the prog pointer is
+	 * found to be non-NULL, so a tail call to an empty slot must not
+	 * consume the tail call budget.  The store is deferred until the call
+	 * is known to be taken (below).
 	 */
 	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 	emit_insn(ctx, ldd, t3, REG_TCC, 0);
 	emit_insn(ctx, addid, t3, t3, 1);
-	emit_insn(ctx, std, t3, REG_TCC, 0);
 	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
 	if (emit_tailcall_jmp(ctx, BPF_JSGT, t3, t2, jmp_offset) < 0)
 		goto toofar;
@@ -346,6 +351,9 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	if (emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
 		goto toofar;
 
+	/* (*tcc_ptr)++; the tail call is taken, so commit the bumped count */
+	emit_insn(ctx, std, t3, REG_TCC, 0);
+
 	/* goto *(prog->bpf_func + 4); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	emit_insn(ctx, ldd, t3, t2, off);
-- 
2.25.1


