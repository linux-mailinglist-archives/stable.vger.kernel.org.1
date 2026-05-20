Return-Path: <stable+bounces-251319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI4+Ocf8DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA64B59622D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FA453062C58
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDED36A376;
	Wed, 20 May 2026 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TvPMkwIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379C637754D;
	Wed, 20 May 2026 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297673; cv=none; b=KUX/wngPfca633gBvOCGIxpSEG/bqqnp9CWGNpvP12V+yupESf8Mb9H43JeFgR51EhxCzJ7fN1mxETOIxWgcGrkXu5YPZZaI8jEPJo5AF9kHK7gm7AzeXxptOLS50HKvZEVEIfxksVC0l2zZwkJGAfDipHMgqOw6+WYZLFP3bnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297673; c=relaxed/simple;
	bh=dCx4iCdgy8VMgP0F7+3yPNjzI83kf/QmVZYDeGp4vtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PE3TXPfI7ccZKz5oLZQ5HqC3YOrKlgkT8tF0EBjr7EdpckPoDNP969qDJurYgsdVgvEWuGJ9X1ODGYEfm9vO891iPxFAAyOEVhi2lqelInnPJJ0y95YH/0GDmRPfVgLKPJCUyFyiD/DYvE3tOGxlnT7/UjWpsuPzSTzD+QLknUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TvPMkwIR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B651F000E9;
	Wed, 20 May 2026 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297672;
	bh=12BalTkcldi3pefJUN2YDQwNktKxI/LSeJvK9aEjuvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvPMkwIRrnphPIcD1Ks3pRfQAegzLf9FN8iwz31OMjRLN3kkQYvgJnYdG+X+Em0vM
	 oA5rP6UIi04JNuNN9QPsg5teDu8FscjWTsBud8a+b0gSn3ro5F//do+6505CUE7LLx
	 UGooCe60sLA6s0iJiunBvJymqk3c1X9cz8UYZG8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 119/957] bpf: Fix abuse of kprobe_write_ctx via freplace
Date: Wed, 20 May 2026 18:10:02 +0200
Message-ID: <20260520162137.140608167@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251319-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EA64B59622D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Hwang <leon.hwang@linux.dev>

[ Upstream commit 611fe4b79af72d00d80f2223354284447daafae9 ]

uprobe programs are allowed to modify struct pt_regs.

Since the actual program type of uprobe is KPROBE, it can be abused to
modify struct pt_regs via kprobe+freplace when the kprobe attaches to
kernel functions.

For example,

SEC("?kprobe")
int kprobe(struct pt_regs *regs)
{
	return 0;
}

SEC("?freplace")
int freplace_kprobe(struct pt_regs *regs)
{
	regs->di = 0;
	return 0;
}

freplace_kprobe prog will attach to kprobe prog.
kprobe prog will attach to a kernel function.

Without this patch, when the kernel function runs, its first arg will
always be set as 0 via the freplace_kprobe prog.

To fix the abuse of kprobe_write_ctx=true via kprobe+freplace, disallow
attaching freplace programs on kprobe programs with different
kprobe_write_ctx values.

Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/r/20260331145353.87606-2-leon.hwang@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 586ece78f783a..ff268fd2ff8b5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3708,6 +3708,23 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		tr = prog->aux->dst_trampoline;
 		tgt_prog = prog->aux->dst_prog;
 	}
+	/*
+	 * It is to prevent modifying struct pt_regs via kprobe_write_ctx=true
+	 * freplace prog. Without this check, kprobe_write_ctx=true freplace
+	 * prog is allowed to attach to kprobe_write_ctx=false kprobe prog, and
+	 * then modify the registers of the kprobe prog's target kernel
+	 * function.
+	 *
+	 * This also blocks the combination of uprobe+freplace, because it is
+	 * unable to recognize the use of the tgt_prog as an uprobe or a kprobe
+	 * by tgt_prog itself. At attach time, uprobe/kprobe is recognized by
+	 * the target perf event flags in __perf_event_set_bpf_prog().
+	 */
+	if (prog->type == BPF_PROG_TYPE_EXT &&
+	    prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	err = bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
-- 
2.53.0




