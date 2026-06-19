Return-Path: <stable+bounces-267340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k/ysERvzNGq1kwYAu9opvQ
	(envelope-from <stable+bounces-267340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 09:43:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BDC6A4672
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 09:43:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=E2sqEzuw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267340-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267340-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD2C30277D2
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C0344DAE;
	Fri, 19 Jun 2026 07:43:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B122E3FE;
	Fri, 19 Jun 2026 07:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854997; cv=none; b=ptaGUAw/EU6vls4rlLBhdkSsXcblZ8ePTApNPmGLjRK6iEsVhazO3BAFnEJRRVUsZDgPdTsEoYokFXHXEOs7c07zJvOT29pXgMBvZgFDu4eRa5WZRoYUf8zVJLn7/nvz8lUhi1oxtWMgy9vy9YIbt7Acrv+XyBsfeYwSGiEce5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854997; c=relaxed/simple;
	bh=FOgKStLzO0xOF0jO7bzXqhVD0/V66GPgX0shuXv/kGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5GJKEmYcMUgg9X2aIVM3u9Z/zvc5d1PggKIOZjzptrmFeVJd6vG0rIvWe3byNM+Z/Ws62vQ0yie/g7msSAYAuRAFMGBlmiLgJTWrdA3PaqBxo3gKamwa5x9Mo1bv9aosNI9EOZMqpDvUTLaFHcFyj3XY9gOEyo0vvjNmQm64ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E2sqEzuw; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=7A/B2ddRDY+Y78/x8MCWrdcZlXw9tB+5L+xXJCdcCFY=;
	b=E2sqEzuwyLGrtoqXOxH/v4eMZMLBT8ABAj227TdiHJI7AqnfNpoJhTahbnynC4
	9V8iJUPs2U6g0wY5RUllKcyYoxpmL/PdxhLr5rzHDdjKpHemUBA/WmAxT36PlnXT
	Z7dtbPG/2lIkIkVNcK2LH2ZDecMXpheDpLSd+fWk5OF78=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnT8328jRq9k3FDw--.7545S2;
	Fri, 19 Jun 2026 15:42:47 +0800 (CST)
From: Chi Wang <wangchi@kylinos.cn>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>,
	Chi Wang <wangchi@kylinos.cn>
Subject: [PATCH v2] audit: Fix data races of skb_queue_len() readers on audit_queue
Date: Fri, 19 Jun 2026 15:42:44 +0800
Message-Id: <20260619074244.377226-1-wangchi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260617130038.57465-1-wangchi@kylinos.cn>
References: <20260617130038.57465-1-wangchi@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnT8328jRq9k3FDw--.7545S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWxtFyDtrW7XFWDKrWfZrb_yoWrAr1kpr
	yDWFWIyrs5ZFy8Xr18AF10vr4Yva18KF13Jrs3tF1ayr98KF1jgF1xJF4aqry8Crs8Aa1U
	JFn8tayDtr4kGrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFhFxUUUUU=
Sender: wangchi05@163.com
X-CM-SenderInfo: 5zdqwulklqkqqrwthudrp/xtbC4RiixWo08vgiKwAA3D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:eparis@redhat.com,m:audit@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:rrobaina@redhat.com,m:wangchi@kylinos.cn,s:lists@lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_SENDER(0.00)[wangchi@kylinos.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267340-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangchi@kylinos.cn,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94BDC6A4672

Multiple readers access audit_queue.qlen via skb_queue_len() without
holding the queue lock or using READ_ONCE(), while kauditd writes to
this field via the skb_dequeue() → __skb_unlink() path with WRITE_ONCE()
protected by a spinlock. This constitutes data races.

All affected skb_queue_len(&audit_queue) call sites:
  - kauditd_thread() wait_event_freezable() condition
  - audit_receive_msg() AUDIT_GET handler (s.backlog assignment)
  - audit_receive() backlog check
  - audit_log_start() backlog check and pr_warn()

KCSAN reports the following conflicting access pattern (one example):
==================================================================
BUG: KCSAN: data-race in audit_log_start / skb_dequeue

write (marked) to 0xffffffff8512ee20 of 4 bytes by task 661 on cpu 57:
 skb_dequeue+0x70/0xf0
 kauditd_send_queue+0x71/0x220
 kauditd_thread+0x1cb/0x430
 kthread+0x1c2/0x210
 ret_from_fork+0x162/0x1a0
 ret_from_fork_asm+0x1a/0x30

read to 0xffffffff8512ee20 of 4 bytes by task 36586 on cpu 1:
 audit_log_start+0x2a0/0x6b0
 audit_core_dumps+0x64/0xa0
 do_coredump+0x14b/0x1260
 get_signal+0xeb2/0xf70
 arch_do_signal_or_restart+0x41/0x170
 exit_to_user_mode_loop+0xa2/0x1c0
 do_syscall_64+0x1a3/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0xe0

value changed: 0x00000001 -> 0x00000000
==================================================================

Resolve the race by switching to lockless helper skb_queue_len_lockless(),
which internally uses READ_ONCE() and properly pairs with the WRITE_ONCE()
write accesses already present on the writer side.

Fixes: 3197542482df ("audit: rework audit_log_start()")
Signed-off-by: Chi Wang <wangchi@kylinos.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/audit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 34dc7cb246ff..cf385393d1ed 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -950,7 +950,7 @@ static int kauditd_thread(void *dummy)
 		 *       do the multicast send and rotate records from the
 		 *       main queue to the retry/hold queues */
 		wait_event_freezable(kauditd_wait,
-				     (skb_queue_len(&audit_queue) ? 1 : 0));
+				     (skb_queue_len_lockless(&audit_queue) ? 1 : 0));
 	}

 	return 0;
@@ -1283,7 +1283,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		s.rate_limit		   = audit_rate_limit;
 		s.backlog_limit		   = audit_backlog_limit;
 		s.lost			   = atomic_read(&audit_lost);
-		s.backlog		   = skb_queue_len(&audit_queue);
+		s.backlog		   = skb_queue_len_lockless(&audit_queue);
 		s.feature_bitmap	   = AUDIT_FEATURE_BITMAP_ALL;
 		s.backlog_wait_time	   = audit_backlog_wait_time;
 		s.backlog_wait_time_actual = atomic_read(&audit_backlog_wait_time_actual);
@@ -1627,7 +1627,7 @@ static void audit_receive(struct sk_buff *skb)

 	/* can't block with the ctrl lock, so penalize the sender now */
 	if (audit_backlog_limit &&
-	    (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+	    (skb_queue_len_lockless(&audit_queue) > audit_backlog_limit)) {
 		DECLARE_WAITQUEUE(wait, current);

 		/* wake kauditd to try and flush the queue */
@@ -1933,7 +1933,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		long stime = audit_backlog_wait_time;

 		while (audit_backlog_limit &&
-		       (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+			(skb_queue_len_lockless(&audit_queue) > audit_backlog_limit)) {
 			/* wake kauditd to try and flush the queue */
 			wake_up_interruptible(&kauditd_wait);

@@ -1953,7 +1953,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 			} else {
 				if (audit_rate_check() && printk_ratelimit())
 					pr_warn("audit_backlog=%d > audit_backlog_limit=%d\n",
-						skb_queue_len(&audit_queue),
+						skb_queue_len_lockless(&audit_queue),
 						audit_backlog_limit);
 				audit_log_lost("backlog limit exceeded");
 				return NULL;
--
2.25.1


