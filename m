Return-Path: <stable+bounces-264183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SBHwH3FxMWrAjQUAu9opvQ
	(envelope-from <stable+bounces-264183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:53:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC988691782
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:53:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=sP+hsZ48;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264183-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264183-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1553431714FF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266BA44D686;
	Tue, 16 Jun 2026 15:42:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7544CAE6;
	Tue, 16 Jun 2026 15:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624566; cv=none; b=B4+xXPwRMxTvLnLYiT4a6+C5USeABvosOImcyxDeLY3747PLC5zsFUR6PlztZxoYlbmcQW/D9xja+wRf3tRsv2UnyyzuOovTcJTQYm4XB2NOIN9m17NkFLRmXIW1h9pbOfBV3ughgJRnSHOsp96Z5OZh9YDv/HtlmbvzHcBVuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624566; c=relaxed/simple;
	bh=ClQVqsAG81BCO0PKM4YDAUoXUzgp24sRADkCVMtNGH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoJfSPUNmWPynPAmiEh1uXv+Gpwgo+TyKCv53LM+rTDEy/rEigKXRaT/6ZKbMOZt/nHhM8e9TT7d1KG0chqyZa83qZeuuj5+S691DgZP6qmT7IgQIT4gx5NIJe267g0iKFdKIMBO+WP44HRAM0nEGzBvvJc0jefftNCN+jPTDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sP+hsZ48; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15E91F000E9;
	Tue, 16 Jun 2026 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624565;
	bh=0S2LuaTtGIUHArMTdc1clrys25xiJOlxFMVcWnMPnc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sP+hsZ48QlrFyAfwz6Q/Olk7oBCX1igySZH0jcrJNMMLfokRjj/mf++cgQhu/1Gwy
	 dTr/zoqAY9UUxy1DdBznrYTFoRF03QxsHEU2njtwDhRp6oRgNDexLOQ5HIKI9COs22
	 vNLmkiflAYz3JXzPdNrlrebb/m9Jic/yr2ThcL9s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: [PATCH 7.0 359/378] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync signaling
Date: Tue, 16 Jun 2026 20:29:50 +0530
Message-ID: <20260616145129.041037462@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264183-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jlayton@kernel.org,m:25181214217@stu.xidian.edu.cn,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,xidian.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC988691782

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

commit 00633c4683828acd5256fa8d5163f440d74bbe71 upstream.

A SOFTIRQ-safe to SOFTIRQ-unsafe lock order deadlock can occur in
send_sigio() and send_sigurg() when a process group receives a signal.

When FASYNC is configured for a process group (PIDTYPE_PGID), both
functions use read_lock(&tasklist_lock) to traverse the task list.
However, they are frequently called from softirq context:
- send_sigio() via input_inject_event -> kill_fasync
- send_sigurg() via tcp_check_urg -> sk_send_sigurg (NET_RX_SOFTIRQ)

The deadlock is caused by the rwlock writer fairness mechanism:
1. CPU 0 (process context) holds read_lock(&tasklist_lock) in do_wait().
2. CPU 1 (process context) attempts write_lock(&tasklist_lock) in
   fork() or exit() and spins, which blocks all new readers.
3. CPU 0 is interrupted by a softirq (e.g., TCP URG packet reception).
4. The softirq calls send_sigurg() and attempts to acquire
   read_lock(&tasklist_lock), deadlocking because CPU 1 is waiting.

Since PID hashing and do_each_pid_task() traversals are already
RCU-protected, the read_lock on tasklist_lock is no longer strictly
required for safe traversal. Fix this by replacing tasklist_lock with
rcu_read_lock(), aligning the process group signaling path with the
single-PID path. This also mitigates a potential remote denial of
service vector via TCP URG packets.

Lockdep splat:
=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
[...]
Chain exists of:
  &dev->event_lock --> &f_owner->lock --> tasklist_lock

Possible interrupt unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                           local_irq_disable();
                           lock(&dev->event_lock);
                           lock(&f_owner->lock);
  <Interrupt>
    lock(&dev->event_lock);

*** DEADLOCK ***

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Link: https://patch.msgid.link/20260523135210.590928-1-w15303746062@163.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fcntl.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -929,11 +929,11 @@ void send_sigio(struct fown_struct *fown
 			send_sigio_to_task(p, fown, fd, band, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_pid_task(pid, type, p) {
 			send_sigio_to_task(p, fown, fd, band, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
@@ -975,11 +975,11 @@ int send_sigurg(struct file *file)
 			send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_pid_task(pid, type, p) {
 			send_sigurg_to_task(p, fown, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);



