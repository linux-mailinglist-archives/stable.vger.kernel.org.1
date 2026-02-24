Return-Path: <stable+bounces-217885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPSkOs5hnWksPQQAu9opvQ
	(envelope-from <stable+bounces-217885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:31:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8820D183B41
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 09:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35F713034A04
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD2D1624C5;
	Tue, 24 Feb 2026 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZtjWJuRE"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D013DBA0
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921861; cv=none; b=eSLyKsN22/DlsfrWLMRwCXCICBrzyUiPZZrbxfnK0CTZnUuRShFZ3mxUExZENDTn9C+AVrU5LLtUzxhY8VdRhoxmN1o499NttPdljvFTk42X0o50oZsp93g5Q6VAvyt8lGvRZaPJx8ymxSYtYNIFASnZgrStH9oAyGISdabD2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921861; c=relaxed/simple;
	bh=WADcdGXCoslAaneV5m2SgHVCPXT/9Ed7MDtsogC7iBM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Lr06BgxFj6j7IC3V6j4I0mmk6Nb1QmoMhMT2IpuVstZnZeqSpBfDir7M5f5D5dpIQEjiO8bQliEbmyPOkPSgBmU4uc5RkbQhtmcc77VJWngJFb/CLH+UljZoJvxpcXsCjUPdILhFAc2zRFexHsZxfRT5PM65eZV1Lc3g2tfbWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZtjWJuRE; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1771921845;
	bh=Eign7jUK1zEqGWwqMuCmgxU7FIGP40VhdHOKRcXbIxc=;
	h=From:To:Cc:Subject:Date;
	b=ZtjWJuREpvjZZLvIglHQx91CHeysIRU8SUUCfGB0FrY8WcPmlRW64rcVk3D4q4Qe7
	 Jz2iATUAbsUNr4RtKzalzRcnpG4IABeZZ72AAodB9yDqhAsgFF+fAQC7YaL3YIllSf
	 9pHjqLuq7yBVKDZ2uSVKLs/tltc9aF4p0WMyf6EI=
Received: from ubuntu24.corp.ad.wrs.com ([120.244.194.215])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 6A3B6442; Tue, 24 Feb 2026 15:26:35 +0800
X-QQ-mid: xmsmtpt1771917995t5oyc3vzs
Message-ID: <tencent_3FBE2535ACAD7066608E1AB4691F6A5E3F09@qq.com>
X-QQ-XMAILINFO: MiBwBRx9btb5UID/33LMZq1i8RPYpjDJjyvtEoJ4L5ElFxdFk5mMcjfUnrRyiG
	 c4Q9zYdRs9ekP0lw1yCMXQHjWkLNkI7G+DHCer38crdUBnglV3g9SNph36ff+hHT765bxIY7CKyr
	 fExXJkY2/pyG2mWkTaz9B5iaCCak9ewgHo/mlaq2FAiuzydTSEe2exNmXnCi1YhMYllTvK1c0cEO
	 /3zZcKHUQkUpeKgou7mHUJMLpa9ueKQ/VymlTRJfDeoUFrkEf85nhizekldRFWJMIcqU3xFVojYK
	 299x3V9sEm17GiM/2WLBIbozHCblkm49ue7V9mzga+YLUdGycA4qGlsv39GdT4tuA4Odk3WoVYQ2
	 6F200OSiX+Ra+/y71nMJlpBu4HthNJJXAfc2/t7T6OvNxISALAuiWYTK5IRb2t8KlxJlP6n42su5
	 h1r+LmmvjjYlhfDzRxLQozHEcJDlydZ9Gyi6FhoKHAt5p0a5YnHtGFBZPgGjIwanOOcWxZNyJohc
	 GxD1+UuwOxxjJtpzPoEOMgAlT4Z6uiS46TEeKkxDr/1I2QGtlJYP2UbXkMMHiwDTZPArGJYPz93A
	 GPNBx6BPwa60EbOdmudDirSAYgaBj+IqGtvIMkbdvGnj20Z13yGHSPR3SMBPbgixM+bkVXiVnCvz
	 cyV8yIq/K1sfL+ZPwQaxzg6i7u5Y8z7tNUSLKZKVnhFW1S6hOEetfuxFFsh0+B9LG6ZLUnTSqsAQ
	 zy4Ye/6K5N4wfr8NnlpDHb5XjxHse9LbF6T98X+NL40G2nB5dwDz1zAL0JYa8j8YRX9nihCIzSx4
	 LKGuDeEe77oQlG3gHOmWyAd8qpjjiETYOMrB69J6290ts74/cFhg4fVi4PSieWJ5M8KuTX5PAxl2
	 2ahSPL3ycYBcjBczRGyS53z8ATDWvLAby4reMu+hX/8O16o6louEr5uj9GsSwgUWWtVZdnLTd7wq
	 gUoisUpTE7fh4dT2Y/9JLAxgEdeY5DvKzMzUDtjmc6DsA4k6KjX7zBEAcs6G9xosoXdVerDlzQey
	 ClUP9km1OqugoqFqpmS7V1zywwXtq7aWnOI0iedzsejtmHVfHz65GlesIH8onerHOv7RQDlzmFOk
	 ZoWdTf
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: alvalan9@foxmail.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] blk-mq: use quiesced elevator switch when reinitializing queues
Date: Tue, 24 Feb 2026 07:26:24 +0000
X-OQ-MSGID: <20260224072624.4519-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217885-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,lst.de,kernel.dk,foxmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:?];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	DMARC_DNSFAIL(0.00)[foxmail.com : SPF/DKIM temp error,none];
	FROM_NO_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.460];
	R_DKIM_TEMPFAIL(0.00)[foxmail.com:s=s201512];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:mid]
X-Rspamd-Queue-Id: 8820D183B41
X-Rspamd-Action: no action

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 8237c01f1696bc53c470493bf1fe092a107648a6 ]

The hctx's run_work may be racing with the elevator switch when
reinitializing hardware queues. The queue is merely frozen in this
context, but that only prevents requests from allocating and doesn't
stop the hctx work from running. The work may get an elevator pointer
that's being torn down, and can result in use-after-free errors and
kernel panics (example below). Use the quiesced elevator switch instead,
and make the previous one static since it is now only used locally.

  nvme nvme0: resetting controller
  nvme nvme0: 32/0/0 default/read/poll queues
  BUG: kernel NULL pointer dereference, address: 0000000000000008
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 80000020c8861067 P4D 80000020c8861067 PUD 250f8c8067 PMD 0
  Oops: 0000 [#1] SMP PTI
  Workqueue: kblockd blk_mq_run_work_fn
  RIP: 0010:kyber_has_work+0x29/0x70

...

  Call Trace:
   __blk_mq_do_dispatch_sched+0x83/0x2b0
   __blk_mq_sched_dispatch_requests+0x12e/0x170
   blk_mq_sched_dispatch_requests+0x30/0x60
   __blk_mq_run_hw_queue+0x2b/0x50
   process_one_work+0x1ef/0x380
   worker_thread+0x2d/0x3e0

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20220927155652.3260724-1-kbusch@fb.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ Adjust context ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 block/blk-mq.c   | 6 +++---
 block/blk.h      | 3 +--
 block/elevator.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 48827708200b..17795b3ae7f3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3732,14 +3732,14 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 
 	mutex_lock(&q->sysfs_lock);
 	/*
-	 * After elevator_switch_mq, the previous elevator_queue will be
+	 * After elevator_switch, the previous elevator_queue will be
 	 * released by elevator_release. The reference of the io scheduler
 	 * module get by elevator_get will also be put. So we need to get
 	 * a reference of the io scheduler module here to prevent it to be
 	 * removed.
 	 */
 	__module_get(qe->type->elevator_owner);
-	elevator_switch_mq(q, NULL);
+	elevator_switch(q, NULL);
 	mutex_unlock(&q->sysfs_lock);
 
 	return true;
@@ -3764,7 +3764,7 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	kfree(qe);
 
 	mutex_lock(&q->sysfs_lock);
-	elevator_switch_mq(q, t);
+	elevator_switch(q, t);
 	mutex_unlock(&q->sysfs_lock);
 }
 
diff --git a/block/blk.h b/block/blk.h
index e90a5e348512..07f571e1ece0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -189,8 +189,7 @@ void blk_account_io_done(struct request *req, u64 now);
 
 void blk_insert_flush(struct request *rq);
 
-int elevator_switch_mq(struct request_queue *q,
-			      struct elevator_type *new_e);
+int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
 void __elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index a98e8356f1b8..0d1edf1f0503 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -581,7 +581,7 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
 
-int elevator_switch_mq(struct request_queue *q,
+static int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e)
 {
 	int ret;
@@ -719,7 +719,7 @@ void elevator_init_mq(struct request_queue *q)
  * need for the new one. this way we have a chance of going back to the old
  * one, if the new one fails init for some reason.
  */
-static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
 	int err;
 
-- 
2.43.0


