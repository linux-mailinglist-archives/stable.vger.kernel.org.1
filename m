Return-Path: <stable+bounces-255220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJGOA1+eGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF2E5F78CC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 552C630144C6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD5344DAC;
	Thu, 28 May 2026 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hveX7Kua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4834040F;
	Thu, 28 May 2026 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998300; cv=none; b=LH67UraDimjQ7E0tUDLsLTk8ohJMUUVvKFjSTr/zzyg37kztSw+33tOPiDEK2IVuf9+9olNaZlWpStrUurXqt7f1nk1jsjS+bffDqBqjLavpNa61XtABF4bInMkqZUOUeKx7gDa6nlPEE+rlEBXw3W1lrW59FvPq3lVmQE8DDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998300; c=relaxed/simple;
	bh=6PaE4H+UpHxqVLWgvffdXb4YpqWgWS7/LE56/JxcDHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7jCYE/qts+VG9Q9Dqy4/zqBNkbxz0OSUV+6Xbtdq+8b10b8IPnlKbAEailKCwP0aNR6xGL//1Adg9ZjjSOF7J8GKQhw0MRuRp02I3YAdS/BmpiBzji5xcP91Km8BSueAosncZSW7DEBWwFz4IsAbBunu1ILQXDj26zkWum1JUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hveX7Kua; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4E21F000E9;
	Thu, 28 May 2026 19:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998298;
	bh=U1lU1OsDVXjJzOCo5/LCWy9ci1sZErqUJZfqibx0XIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hveX7KuaXJHnfeUn/76jk0f1kkekfciRSdr9Sa50+VlR8xD9vbyqtbH8wIpoiQKi+
	 sA2p6EmZfqSAGBcKKd9H0xLaryw0DsVCbQ4GyD2ogxvLahy1KPDydoHhtMAsMYJwNB
	 T3rT/Q3oQpvGkmLAdlpcIGxhiM9IsMxYKOviewL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 7.0 125/461] LoongArch: kprobes: Use larch_insn_text_copy() to patch instructions
Date: Thu, 28 May 2026 21:44:14 +0200
Message-ID: <20260528194650.602464486@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255220-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,loongson.cn:email]
X-Rspamd-Queue-Id: 9FF2E5F78CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

commit e3ef9a28f558d1cbf0b42d6dcd16c60da557562b upstream.

On SMP systems, kprobe handlers would occasionally fail to execute on
certain CPU cores. The issue is hard to reproduce and typically occurs
randomly under high system load.

The root cause is a software-side instruction hazard. According to the
LoongArch Reference Manual, while the cache coherency is maintained by
hardware, software must explicitly use the "IBAR" instruction to ensure
the instruction fetch unit (IFU) observes the effects of recent stores.

The current arch_arm_kprobe() and arch_disarm_kprobe() only execute the
"IBAR" barrier (via flush_insn_slot -> local_flush_icache_range) on the
local CPU. This leaves a vulnerable window where remote CPU cores may
continue executing stale instructions from their pipelines or prefetch
buffers, as they have not executed an "IBAR" since the code modification.

Switch to larch_insn_text_copy() to fix this:
1. Synchronization: It uses stop_machine_cpuslocked() to synchronize all
   online CPUs, ensuring no CPU is executing the target code area during
   modification.
2. Visibility: By passing cpu_online_mask to stop_machine_cpuslocked(),
   the callback text_copy_cb() is executed on all online cores. Each CPU
   core invokes local_flush_icache_range() to execute "IBAR", clearing
   instruction hazards system-wide and ensuring the "break" instruction
   is visible to the fetch units of all cores.
3. Robustness: It properly manages memory write permissions (ROX/RW) for
   the kernel text segment during patching, ensuring compatibility with
   CONFIG_STRICT_KERNEL_RWX.

Cc: <stable@vger.kernel.org>  # 6.18+
Fixes: 6d4cc40fb5f5 ("LoongArch: Add kprobes support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/kprobes.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -60,16 +60,18 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
 /* Install breakpoint in text */
 void arch_arm_kprobe(struct kprobe *p)
 {
-	*p->addr = KPROBE_BP_INSN;
-	flush_insn_slot(p);
+	u32 insn = KPROBE_BP_INSN;
+
+	larch_insn_text_copy(p->addr, &insn, LOONGARCH_INSN_SIZE);
 }
 NOKPROBE_SYMBOL(arch_arm_kprobe);
 
 /* Remove breakpoint from text */
 void arch_disarm_kprobe(struct kprobe *p)
 {
-	*p->addr = p->opcode;
-	flush_insn_slot(p);
+	u32 insn = p->opcode;
+
+	larch_insn_text_copy(p->addr, &insn, LOONGARCH_INSN_SIZE);
 }
 NOKPROBE_SYMBOL(arch_disarm_kprobe);
 



