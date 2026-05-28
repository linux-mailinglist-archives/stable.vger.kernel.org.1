Return-Path: <stable+bounces-255555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGcWDaaiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8515F83C3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 611DC3026A6B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4533F5BE;
	Thu, 28 May 2026 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V5uAy0qf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ABB33CE8A;
	Thu, 28 May 2026 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999242; cv=none; b=t3DJnJ0mKy2Xj14Zmo7TlzK+nQgVxVoiklDXSZ8CQneAOQ+DUWUB+BzkVddRnMGn2NlVB3JnjqYNxTSou3tNdHvYrMkoBqYMonrPIDaMgLWJc3nDUTsAC+g6qKfaJUJvk9QeXFwxk/T4oL+brKrXEckZE7XbWJaGuK1b0FmlyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999242; c=relaxed/simple;
	bh=M1YLri2ABMydREqkz8nYd4YNeN+7p0NB3rNrBT62O6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPUHrYmnPhoryD9vp1Yc3PpwDgNKZihQZaiLPNZW6M60DKtVUCT26ZqB5Ubp2gw+uBKwkqqAB3/1iDjj2I96QnJbnWusA48Qzi5dhgEdT7tEYF0iF/Q7OKHundR/kHqNlFRKWfpjFzBa7nvqXrOJD8qG0u3byXn13hUdNlOzIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V5uAy0qf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447801F000E9;
	Thu, 28 May 2026 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999240;
	bh=tePnbSJKUweS1oLA2XJd86RJBAR0QTI+wMM8rt94Il0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V5uAy0qf3YzUchV70OS/97WzUKuK9kH549rmTXD2W+N/7rMfCeH0PB5s7nTMEEINn
	 EXouUH4RfENFjQhYrkcllz9yBgm7cCHysKZJptXu/i6BUTTp5AbxDxJ2RtOQ+2qQls
	 /RpJJDhVM4M0LimLZbhC2WhmTJgeIZKv3DYTtl/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 458/461] LoongArch: kprobes: Fix handling of fatal unrecoverable recursions
Date: Thu, 28 May 2026 21:49:47 +0200
Message-ID: <20260528194700.797873021@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255555-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,loongson.cn:email]
X-Rspamd-Queue-Id: 3C8515F83C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 1c856e158fd34ef2c4475a81c1dc386329989938 ]

KPROBE_HIT_SS and KPROBE_REENTER are two types of fatal recursions that
can not be safely recovered in kprobes.

KPROBE_HIT_SS means that a kprobe is hit during single-stepping. At
this point, the architecture-specific single-step context is already
active. Nested single-stepping would corrupt the state, as the kprobe
control block (kcb) and hardware registers cannot safely store multiple
levels of stepping state.

KPROBE_REENTER means that a third-level recursion occurs when a probe
is hit while the system is already handling a nested probe (second-
level). The kcb only provides a single slot (prev_kprobe) to backup the
state. When a third probe is hit, there is no more space to save the
state without corrupting the first-level backup.

Kprobes work by replacing instructions with breakpoints. In order to
execute the original instruction and continue, it must be moved to a
temporary "single-step" slot. Since there is no backup space left to
set up this slot safely, the CPU would be forced to return to the same
original breakpoint address, triggering an endless loop.

Currently, the code only prints a warning and returns. This leads to
an infinite re-entry loop as the CPU repeatedly hits the same trap and
a "stuck" CPU core because preemption was disabled at the start of the
handler and never re-enabled in this early return path.

Fix the logic by:
1. Merging KPROBE_HIT_SS and KPROBE_REENTER cases, as both represent
   fatal recursions that cannot be safely recovered.
2. Replacing WARN_ON_ONCE() with BUG() to terminate the system. This
   aligns LoongArch with other architectures (x86, arm64, riscv) and
   prevents stack overflow while providing diagnostic information.

Fixes: 6d4cc40fb5f5 ("LoongArch: Add kprobes support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
index 04b5b05715cdc..1985ed30dd16f 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -186,16 +186,16 @@ static bool reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 			   struct kprobe_ctlblk *kcb)
 {
 	switch (kcb->kprobe_status) {
-	case KPROBE_HIT_SS:
 	case KPROBE_HIT_SSDONE:
 	case KPROBE_HIT_ACTIVE:
 		kprobes_inc_nmissed_count(p);
 		setup_singlestep(p, regs, kcb, 1);
 		break;
+	case KPROBE_HIT_SS:
 	case KPROBE_REENTER:
 		pr_warn("Failed to recover from reentered kprobes.\n");
 		dump_kprobe(p);
-		WARN_ON_ONCE(1);
+		BUG();
 		break;
 	default:
 		WARN_ON(1);
-- 
2.53.0




