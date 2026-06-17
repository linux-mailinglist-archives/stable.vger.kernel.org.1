Return-Path: <stable+bounces-266750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EKfBI6KaMmrv2gUAu9opvQ
	(envelope-from <stable+bounces-266750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:01:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4B699ED9
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:01:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=oEGEGcm0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266750-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266750-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CDB0301D5B4
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76D3FBEB8;
	Wed, 17 Jun 2026 13:01:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB4399CED;
	Wed, 17 Jun 2026 13:01:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701276; cv=none; b=Wf6Tnp0ZhU6ir5ILdG/higY387CFRxRZpYaHnnUXj/+jztu4lhiihA7hXXJwDp/xC2aPfIQIrM0T5egkBqCauqH6Bfh546nvyTOiQA/1iyYexhLxGDRL7Vx/cVk3Ki5SKNomoMSoZEXAa1yuEHxLHWOu4Clrsm3O9ZmWhg7NWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701276; c=relaxed/simple;
	bh=9LtdsQ0JuTmnog+dZGRky7Krtq9AFORvGdYo58efK2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UC+7n8uJEkX5fmHnLXe0qG8T4vjqCF3mCA0h/bzNLdm0I85d7XEaU2d0FE8Y5slRROei+/jGQo0llbb6yePyX8dqvkMSExMPdUcMqs9FG0XXSm8T5xoKSjEfEMTylUVoIcSTnhB5LmdJpmTqVT3iSHv3ORcBadYqpzhUKhISw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oEGEGcm0; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=xONk+ffBgrjTmNSftucSe+Xthn1FutDtUdHp6px0APg=;
	b=oEGEGcm0VIZIvbvy5ejGNAOBE4UILLQyuzKxiWz8isjLoA3szTSqBpLe3Ok2C6
	YEtRTwZLjmdyfjkeGoN9JvDBr8cXSyVb18zEG2S35z4NLxzUtUiirMl4DtPZ2vDw
	LNbeUeMPwJoopUQfkcyKpEGyjDFihzI52ugVCW/y6Ec38=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHrPp5mjJqerv4CQ--.23392S2;
	Wed, 17 Jun 2026 21:00:41 +0800 (CST)
From: Chi Wang <wangchi@kylinos.cn>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chi Wang <wangchi@kylinos.cn>
Subject: [PATCH] audit: Fix data race in audit_log_start()
Date: Wed, 17 Jun 2026 21:00:38 +0800
Message-Id: <20260617130038.57465-1-wangchi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAHrPp5mjJqerv4CQ--.23392S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWxtFyDuw4rtFy3tryDtrb_yoW5Grykpr
	yDWFWxArs5ZFyUJ3W8A3WUZrW5ta15KF13Grn3tF1ayr98KF1jgr1UJa1aqryUCrs8A3W7
	JFn8tayqvw4DGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeUDJUUUUU=
Sender: wangchi05@163.com
X-CM-SenderInfo: 5zdqwulklqkqqrwthudrp/xtbC4RnrD2oymnnOzQAA3k
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:eparis@redhat.com,m:audit@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:wangchi@kylinos.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wangchi@kylinos.cn,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangchi@kylinos.cn,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266750-lists,stable=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BE4B699ED9

audit_log_start() reads audit_queue.qlen via skb_queue_len() without
holding the queue lock or using READ_ONCE(), while kauditd writes to
this field via the skb_dequeue() → __skb_unlink() path with WRITE_ONCE()
protected by a spinlock. This constitutes a data race.

KCSAN reports the following conflicting access pattern:
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
---
 kernel/audit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 34dc7cb246ff..e4c095017302 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
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


