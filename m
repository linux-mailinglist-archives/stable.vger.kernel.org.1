Return-Path: <stable+bounces-273493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HVyVAU+OU2pfbwMAu9opvQ
	(envelope-from <stable+bounces-273493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 14:53:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49311744BDC
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 14:53:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=S5qH8t6d;
	dmarc=pass (policy=reject) header.from=grrlz.net;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273493-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273493-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F033014DB3
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0D3AA1BB;
	Sun, 12 Jul 2026 12:53:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82300313293;
	Sun, 12 Jul 2026 12:53:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860791; cv=none; b=DpOMvC/0GWbARgjiVKr6T5DqxAblHBzpdoit6DLWTsVwZzEnyZ++IDJnp7bVym2oV7i2lWkE41Opk0Uchaq2DvLcf0jR288DIhVcjbZF6u7uYiVN8ORfSNYRH5k3JyNhwwoNf7U+XrSlQmZvb0O+lwa21BsO+5W2y7fuK9LvgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860791; c=relaxed/simple;
	bh=LJesPh72EO3tUS3w7PPGoF/P/tb9ZCstzdE11Z+tB2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPtLKijdEalIDpYESGqeERSGH3Cq4ZuGkBR5Yp9EQbCegQtXlI3GN25BU5zmlxoCQD/zjsISdxoERuz6UQD1itWi4nUEUl23rCi1biR3kI25kt++h8A3MBUudolhSnA8rF44tAaF5lpjxrp763LnpdPXZhakReTD4cSMIh+hc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=S5qH8t6d; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783860780;
	bh=0MIItIbwDqUH6rTnfoNK9FrKtcAdKxkBjO5LSqBZtNI=;
	h=From:To:Cc:Subject:Date:From;
	b=S5qH8t6dC9BokalEZhDBO6LCLVUSyZHK1DQ1O1imz7irY7db2rXdRYSM2l5cSWTc6
	 Z2i1nf0NkplTJL0C0MT25+pnnjtdy4GovZZFZSCJas8grlE97aKrMSMiG1rB0HUsfD
	 uWMZnfub6V0nQfNfIuMnHY6REadVEW6ncqbAY670=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gylq00m38z10xS;
	Sun, 12 Jul 2026 12:53:00 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gylpz0y12z10vV;
	Sun, 12 Jul 2026 12:52:59 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Cc: brauner@kernel.org,
	peterz@infradead.org,
	oleg@redhat.com,
	tglx@kernel.org,
	npiggin@gmail.com,
	ebiederm@xmission.com,
	pasha.tatashin@soleen.com,
	kees@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	include@grrlz.net,
	syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Subject: [PATCH] reboot: enable IRQs before do_exit in the halt and power off fallback
Date: Sun, 12 Jul 2026 12:52:59 +0000
Message-ID: <20260712125300.31501-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,redhat.com,gmail.com,xmission.com,soleen.com,vger.kernel.org,grrlz.net,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:brauner@kernel.org,m:peterz@infradead.org,m:oleg@redhat.com,m:tglx@kernel.org,m:npiggin@gmail.com,m:ebiederm@xmission.com,m:pasha.tatashin@soleen.com,m:kees@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,m:syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,8fdf0d8e10bdde1c2e88];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,grrlz.net:from_mime,grrlz.net:email,grrlz.net:mid,grrlz.net:dkim,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49311744BDC

The reboot syscall calls do_exit(0) after kernel_halt() or
kernel_power_off().  Those are expected to stop the machine and not
return.  When they do return (no PM info, power off failed), the
shutdown path has already disabled interrupts: native_machine_shutdown()
calls local_irq_disable() on x86, and do_exit() then hits its
WARN_ON(irqs_disabled()) at kernel/exit.c:930.

do_exit only warns by design; make_task_dead() is the path that fixes
the IRQs disabled state (commit 001c28e57187 ("exit: Detect and fix irq
disabled state in oops")).  The reboot fallback is not an oops and wants
a clean do_exit, so enable IRQs at the two call sites instead, matching
the make_task_dead pattern.

Splat from syzbot:

  ACPI: PM: Preparing to enter system sleep state S5
  kvm: exiting hardware virtualization
  reboot: Power down
  ------------[ cut here ]------------
  irqs_disabled()
  WARNING: kernel/exit.c:930 at do_exit+0x1cf7/0x2ae0 kernel/exit.c:930, CPU#0: init/6193
  CPU: 0 UID: 0 PID: 6193 Comm: init Tainted: G             L      syzkaller #0 PREEMPT(full)
  Tainted: [L]=SOFTLOCKUP
  Call Trace:
   <TASK>
   __do_sys_reboot+0x36e/0x400 kernel/reboot.c:784
   do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Fixes: 001c28e57187 ("exit: Detect and fix irq disabled state in oops")
Reported-by: syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8fdf0d8e10bdde1c2e88
Closes: https://lore.kernel.org/all/69f5ec0c.050a0220.312cd3.0023.GAE@google.com/T/
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/reboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index bed6967bfa96..7e8ebb470721 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -777,10 +777,20 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 	case LINUX_REBOOT_CMD_HALT:
 		kernel_halt();
+		/* kernel_halt() was expected to not return. */
+		if (irqs_disabled()) {
+			pr_info("reboot: halt returned with irqs disabled\n");
+			local_irq_enable();
+		}
 		do_exit(0);
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		kernel_power_off();
+		/* kernel_power_off() was expected to not return. */
+		if (irqs_disabled()) {
+			pr_info("reboot: power off returned with irqs disabled\n");
+			local_irq_enable();
+		}
 		do_exit(0);
 		break;
 
-- 
2.53.0


