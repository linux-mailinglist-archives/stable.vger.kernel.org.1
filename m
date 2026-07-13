Return-Path: <stable+bounces-273575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ueIC3GEVGpumwMAu9opvQ
	(envelope-from <stable+bounces-273575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 08:23:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B89747822
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 08:23:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=UUznlGlc;
	dmarc=pass (policy=reject) header.from=grrlz.net;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273575-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273575-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ADEF300A102
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB93812F4;
	Mon, 13 Jul 2026 06:23:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191235FF6C;
	Mon, 13 Jul 2026 06:23:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923818; cv=none; b=Yvmhdmk3ahyyiDe9Na3jhK5+jb/BSsXkQVxXtVYyQ1f9ig10TryYM0iGJjCY1nYsSCC7DAtlvsurMXflTclj8gREzKFS0+yL37qm973T4DwL37HEL/o4WKH6aK1SYq6ncMytXZIYTXi0EfRmJ1S6j+V6akSv8rRuyUZ6Mwd4/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923818; c=relaxed/simple;
	bh=RLb0pm+9yPK1nQ0g33//9x7B4x58nm2+I1LtLRLEdhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBnzNIT2h0zS1ltOTUlV1jSM3NNAvS1ymRssWModmre7kYi3BdlmJu6r9uK31s8uSggDWUg7730xbq8n/r9K8Bi2gBUSVGcz4NzDMvFPgw2AciIhRuEoH8RVaT2skerzehcdaGPsrEQOkug3FFFqqKwClAQRYCZUq8HpEt3A/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=UUznlGlc; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783923814;
	bh=o26kPNK2GcAWLXC8xegg5XWjRtzp3asNmAkcVON04hg=;
	h=From:To:Cc:Subject:Date:From;
	b=UUznlGlcXLc16vzKnk7EOsKqUA+a66A9oatxT5gwzhOJmJ2q1mw+vSGE9FuoaReDf
	 2sN+Bc1eid7GVdjTzCBDtFi3XXUxzAe6+pcuMjMZellKs+iVcWCnJi3bPEOPKdc/tz
	 Rxmvq2C49Sro4xtNAa7tDL0U1906E/FU7zjyUfuE=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gzC7B16fqz10wc;
	Mon, 13 Jul 2026 06:23:34 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gzC791f5wz10wb;
	Mon, 13 Jul 2026 06:23:33 +0000 (UTC)
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
Subject: [PATCH] reboot: use make_task_dead for the halt and power off fallback
Date: Mon, 13 Jul 2026 06:23:32 +0000
Message-ID: <20260713062332.21131-1-include@grrlz.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,redhat.com,gmail.com,xmission.com,soleen.com,vger.kernel.org,grrlz.net,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:brauner@kernel.org,m:peterz@infradead.org,m:oleg@redhat.com,m:tglx@kernel.org,m:npiggin@gmail.com,m:ebiederm@xmission.com,m:pasha.tatashin@soleen.com,m:kees@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,m:syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,grrlz.net:from_mime,grrlz.net:email,grrlz.net:mid,grrlz.net:dkim,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78B89747822

The reboot syscall calls do_exit(0) after kernel_halt() or
kernel_power_off().  Those are expected to stop the machine and not
return.  When they do return, the shutdown path has already disabled
interrupts and torn down state, and do_exit() then hits its
WARN_ON(irqs_disabled()).

That is an error path, not a clean exit.  Use make_task_dead() instead
of do_exit(0): it is built for this, fixes up the irqs disabled and
preempt state, and bounds repeated failure via oops_limit.  This
matches the make_task_dead pattern that exit.c already uses for the
oops path.

Splat from syzbot:

  ACPI: PM: Preparing to enter system sleep state S5
  kvm: exiting hardware virtualization
  reboot: Power down
  ------------[ cut here ]------------
  irqs_disabled()
  WARNING: kernel/exit.c:930 at do_exit+0x1cf7/0x2ae0 kernel/exit.c:930, CPU#0: init/6193
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
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/reboot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Changes since v1: v1 enabled IRQs and kept do_exit, fixing the
symptom.  Eric Biederman pointed out the real fix is to treat the
returned halt or power off as the error path it is, and call
make_task_dead instead.

diff --git a/kernel/reboot.c b/kernel/reboot.c
index bed6967bfa96..c10ac6a0200d 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -14,6 +14,7 @@
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
 #include <linux/reboot.h>
+#include <linux/sched/task.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
@@ -777,11 +778,13 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 	case LINUX_REBOOT_CMD_HALT:
 		kernel_halt();
-		do_exit(0);
+		/* machine_halt() was expected to not return. */
+		make_task_dead(SIGKILL);
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		kernel_power_off();
-		do_exit(0);
+		/* machine_power_off() was expected to not return. */
+		make_task_dead(SIGKILL);
 		break;
 
 	case LINUX_REBOOT_CMD_RESTART2:
-- 
2.53.0


