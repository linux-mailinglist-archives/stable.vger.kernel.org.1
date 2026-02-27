Return-Path: <stable+bounces-219992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DJEB+3joWmUwwQAu9opvQ
	(envelope-from <stable+bounces-219992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:35:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9482F1BC085
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96BDC300AC39
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0B2C15BE;
	Fri, 27 Feb 2026 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZMsUPZ8J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894438F920
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217307; cv=none; b=u+UWJLpNRsmUDI/6I4ZzAcwQNgaV1oF61DYNoEImOS7hX9YW9kiBc6N/iARazDbBjWPae3Bt/uWn4DMPcKz/nElISEsHw+h3WBt8+yHCc+UN2N2Rq/fo7Fx+FJSr8pD/HCGjj86OHFTNlZVMOs7PQhPOP1U+MBKhDgrVADm+kPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217307; c=relaxed/simple;
	bh=gqO8z8OsfxJsRBE2z2+7P3a9ryiV3Y5qfS2YEgMFFBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeuhcIKcyDVTbja37cvc3eVpbahZDbiOTMgmsDywnYtOjZw2k0tBHRwTGpbUonpB5dz5uCWE8GoAyWir4RCM4vzqotjBugKHN9q29vTnlsbx8E6DoKxyoOZTGRsQM7hmv1uFco6FUhaHU9QKPPpkbvBxqT/3lGKsJMU8DPiyXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZMsUPZ8J; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2aaed195901so12244605ad.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 10:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217305; x=1772822105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x44Ec2X/jCXrdA7XafgcLtw7ueaDoGHme779WdlZZN8=;
        b=qlnowKs9cnk2ku9qc7KTM6JeFEznc+Xaw+lIDvGCJOfG9xlJqvMYmprev0PmrD8m3H
         YmXtOIoDLY6QvZXbylqk163i6navG0zC6/siCALxB/+7DdbRu+3lwWLGr80CPbqV94kW
         e8TrOhjYrq1zOZrhRpbSItmM3jzVLsKd4mEJ6UyCQOBg+usq3zDYdEIJ434pUYt59S4w
         gPQFCHFnHDDUcFhXX5gHK0ZWMuicUUtYxDFGtsAtULU13bcddzIw2DM+U/xOJXWF0VLL
         WIlsr9p1ZplKJecmoV+qMW0TvZAsgKjO1Wcjr1S1VHlnnDFL5UIA8WYEzCtzb4F4rXF2
         wgrQ==
X-Gm-Message-State: AOJu0Yy6c9gSIL8ESoueUt2v2kRHjv3IOviHpkGH79lTQQj3ZhseW7Wo
	9lAGlLytBdSa+nqaaCrM66vUFHkfgYYRPimESfpcz//TjGjm1eeMpWuwe2Q0SBfuZskErF6wFVS
	vsDHykSwkR6qe5YV1DrIT422VdKYE2GugZOif3aM746dSADJQSOZqh+r/eF7udlS8fjhMv27TV4
	Cg8Fn3APj5g4o6QF+VLlXN20yU/flleRXQ/rjdnebhMTMz9eai3NOt16izkd6E8ac9XXZzJGrqV
	rPeTomZFlRpcxsy2w==
X-Gm-Gg: ATEYQzyT4wpOqZD4XZrU6wVzcaAEZU5ZeqQuOGdqCl0BlqgGXN07yaBS76h5DFyYpHZ
	yAckpwqVR2l6F9gxwE7ycnGmd18sVleZ17WGIGMOYr6oX4GVmgXncExMt4yGL72WAD9kl4WHVdG
	kqEZ+OPb42aRmTxkdD8FAT2LyMZuo+BvB3RTMvuNSIXciAW6B6R+/zan7a0OTEREedO4Nhkdc8Z
	sGZUfQl1B2f8HBsE2IMSdIWRmuh0ag71XgG+jVnRzUar8JwMcX2X3Av13s+mCvlsxCe1FI+HqKq
	MI3o2pqnVb1lq172VM2O/HOMq/PanNu6NMnrQdhIW2z4xy9uYGnIOuvIt1alhzqMix0NIMmi7Xl
	iANd7R1bHMDu3oyjee6OoCeiESgJIjh3eIv6TmzuItYJ4E5Jrmqwuo2wHVl9OuGb297/zRwegO9
	JburTJ0niqlAMJGXgL/b4vVr5HKdkuZtR2cgS1EQ7npB0LPwgLraiLqEVLvAif
X-Received: by 2002:a17:903:1a10:b0:2aa:f9d7:68aa with SMTP id d9443c01a7336-2ae2e3f049bmr33444085ad.21.1772217304639;
        Fri, 27 Feb 2026 10:35:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb05e500sm7248895ad.11.2026.02.27.10.35.04
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 10:35:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-506ae021853so181985581cf.1
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772217303; x=1772822103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x44Ec2X/jCXrdA7XafgcLtw7ueaDoGHme779WdlZZN8=;
        b=ZMsUPZ8J8yXxFE7tEQLOEkL8Y5bolyqctI1qa2SWw8u1yhJV7kBixu5Oe+9hP3xdXd
         0noQuO7IFGvxGOV60NA7SCZYXdxV9/ADATqrCMNK50PyXVLhg8Rgq6I8/KpBHf1UCmnv
         KsqMhIE9R2G/tvikMZMpntf0ojhvhwk5QNNGI=
X-Received: by 2002:a05:622a:188c:b0:4f0:24e2:8de6 with SMTP id d75a77b69052e-5075287da44mr52743721cf.64.1772217303085;
        Fri, 27 Feb 2026 10:35:03 -0800 (PST)
X-Received: by 2002:a05:622a:188c:b0:4f0:24e2:8de6 with SMTP id d75a77b69052e-5075287da44mr52743161cf.64.1772217302495;
        Fri, 27 Feb 2026 10:35:02 -0800 (PST)
Received: from photon-blam.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ad8f8bsm50876731cf.27.2026.02.27.10.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:35:02 -0800 (PST)
From: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Subject: [PATCH v5.10] blk-mq: use quiesced elevator switch when reinitializing queues
Date: Fri, 27 Feb 2026 11:01:50 -0800
Message-ID: <20260227190150.27445-1-brennan.lamoreaux@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219992-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[brennan.lamoreaux@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9482F1BC085
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
---
 block/blk-mq.c   | 6 +++---
 block/blk.h      | 3 +--
 block/elevator.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a72009746067..b5f3e2d04560 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3689,14 +3689,14 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 
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
@@ -3721,7 +3721,7 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 	kfree(qe);
 
 	mutex_lock(&q->sysfs_lock);
-	elevator_switch_mq(q, t);
+	elevator_switch(q, t);
 	mutex_unlock(&q->sysfs_lock);
 }
 
diff --git a/block/blk.h b/block/blk.h
index 997941cd999f..c3e704e00a9d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -202,8 +202,7 @@ void blk_account_io_done(struct request *req, u64 now);
 void blk_insert_flush(struct request *rq);
 
 void elevator_init_mq(struct request_queue *q);
-int elevator_switch_mq(struct request_queue *q,
-			      struct elevator_type *new_e);
+int elevator_switch(struct request_queue *q, struct elevator_type *new_e);
 void __elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index 2f962662c32a..fc4ae13cb33f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -572,7 +572,7 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
 
-int elevator_switch_mq(struct request_queue *q,
+static int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e)
 {
 	int ret;
@@ -701,7 +701,7 @@ void elevator_init_mq(struct request_queue *q)
  * need for the new one. this way we have a chance of going back to the old
  * one, if the new one fails init for some reason.
  */
-static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
+int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
 	int err;
 
-- 
2.43.7


