Return-Path: <stable+bounces-219892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AmYAB7/oGmqowQAu9opvQ
	(envelope-from <stable+bounces-219892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:19:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06A1B1FA5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041F1304C979
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A30286D4D;
	Fri, 27 Feb 2026 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="kAD/csUa"
X-Original-To: stable@vger.kernel.org
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8312EA473
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772158737; cv=none; b=MRIFFZrli3SOKLK4y/Dja2ssg3S7Z//YdyH4xbkGZb15Y98OuJV2M+OAr2t1YaWhx1Jg4DTHxPkw7JiRu2bkig6l2O3tqr7nondM1SzooSgZ3cP5eDDPG7puUTKtxK69SB8a3LTKRuze9WkZiA0H1bp9wYGkqwql1CUoeKAv0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772158737; c=relaxed/simple;
	bh=yoBeoacMbK1NAn82kU0drfaAQYOiincR4WZfeQfH/ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClvqnRE2N08bewknXoqxEIwJM4BKWQ5Ra65lgTXhg9jRZLO6dmvv/XVIYiMVDfddqn9FwVClaSX18NuaSLWA7uzfQnHGNoKfXhigaK0cRlBJErVxD95rSTy7jLQ1wLi0LF94yJOP+ZDn4Vw1iJA2iafgJBNa4TC6UEK8AfVn+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=kAD/csUa; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1772158734;
	bh=+ll0j7P6gB1YHU/QPLWIwnmbPeyItOm5mPcLbuIqgOg=;
	h=From:Subject:Date:Message-Id;
	b=kAD/csUa70XJSbgSuc1Wk3iqb1/gW+9NEqLvGY1El63d4L8vao75gPGNjv6nCWkas
	 5qcI+hnVzeUuyQwSndCPRiRIeeOxnLFUydVGHh64d0CZjVEgfi1GoM2mKWK5eTvD8s
	 rtIteWLVP/bKJT39hidlGJj3GNr/qDoNbsRUO8Tk=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.22) with ESMTP
	id 69A0FF0700000E95; Fri, 27 Feb 2026 10:18:50 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 5772687602230
X-SMAIL-UIID: BCC5C971CE1645018EB779524CAFFB85-20260227-101850-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	axboe@kernel.dk
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org
Subject: [PATCH 5.10.y] io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop
Date: Fri, 27 Feb 2026 10:18:47 +0800
Message-Id: <20260227021847.1242260-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219892-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.cn];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sina.cn:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7B06A1B1FA5
X-Rspamd-Action: no action

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 10dc959398175736e495f71c771f8641e1ca1907 ]

Currently this is checked before running the pending work. Normally this
is quite fine, as work items either end up blocking (which will create a
new worker for other items), or they complete fairly quickly. But syzbot
reports an issue where io-wq takes seemingly forever to exit, and with a
bit of debugging, this turns out to be because it queues a bunch of big
(2GB - 4096b) reads with a /dev/msr* file. Since this file type doesn't
support ->read_iter(), loop_rw_iter() ends up handling them. Each read
returns 16MB of data read, which takes 20 (!!) seconds. With a bunch of
these pending, processing the whole chain can take a long time. Easily
longer than the syzbot uninterruptible sleep timeout of 140 seconds.
This then triggers a complaint off the io-wq exit path:

INFO: task syz.4.135:6326 blocked for more than 143 seconds.
      Not tainted syzkaller #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.135       state:D stack:26824 pid:6326  tgid:6324  ppid:5957   task_flags:0x400548 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:121
 io_wq_exit_workers io_uring/io-wq.c:1328 [inline]
 io_wq_put_and_exit+0x271/0x8a0 io_uring/io-wq.c:1356
 io_uring_clean_tctx+0x10d/0x190 io_uring/tctx.c:203
 io_uring_cancel_generic+0x69c/0x9a0 io_uring/cancel.c:651
 io_uring_files_cancel include/linux/io_uring.h:19 [inline]
 do_exit+0x2ce/0x2bd0 kernel/exit.c:911
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1112
 get_signal+0x2671/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7e0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x8c/0x540 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x4ee/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa02738f749
RSP: 002b:00007fa0281ae0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fa0275e6098 RCX: 00007fa02738f749
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fa0275e6098
RBP: 00007fa0275e6090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa0275e6128 R14: 00007fff14e4fcb0 R15: 00007fff14e4fd98

There's really nothing wrong here, outside of processing these reads
will take a LONG time. However, we can speed up the exit by checking the
IO_WQ_BIT_EXIT inside the io_worker_handle_work() loop, as syzbot will
exit the ring after queueing up all of these reads. Then once the first
item is processed, io-wq will simply cancel the rest. That should avoid
syzbot running into this complaint again.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/68a2decc.050a0220.e29e5.0099.GAE@google.com/
Reported-by: syzbot+4eb282331cab6d5b6588@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ Minor conflict resolved. ]
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 io_uring/io-wq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index c5d249f5d214..926890f5086e 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -554,9 +554,9 @@ static void io_worker_handle_work(struct io_worker *worker)
 	struct io_wqe_acct *acct = io_wqe_get_acct(worker);
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
-	bool do_kill = test_bit(IO_WQ_BIT_EXIT, &wq->state);
 
 	do {
+		bool do_kill = test_bit(IO_WQ_BIT_EXIT, &wq->state);
 		struct io_wq_work *work;
 get_next:
 		/*
-- 
2.34.1


