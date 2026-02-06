Return-Path: <stable+bounces-214584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKlfFmpJhWkN/QMAu9opvQ
	(envelope-from <stable+bounces-214584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 02:52:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D272AF915D
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 02:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAD01306F03E
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7087247291;
	Fri,  6 Feb 2026 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ib1ygmZN"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503952475CE
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342453; cv=none; b=n118gddLMX/bc0kf0Dsur133U7bCZx9dxODceUYV+egPkdG8WHygT3s7WCttxvoyHMc6d2OdLRC8AI/QbDQUmTtBg6KegDkg7EaVAuzHvr0O2qokLoSu3W6TtDgQUEwdx8R6ZhPlCsQxFu0RiMrT1wlBY3BgcPHHKma16IguzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342453; c=relaxed/simple;
	bh=xhILa9tM/mMUiXJdDdHiarpbDtTrjTB4afazrWXzC3o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pex2s3/mdN/YRyHCN/0KImdB5m1t52DPvIJLkzVs7hjHJVx0j8A0yKv34MBXNbwAPpmv8KEcJuo/avoeMOiBRjv1sU9bGr9LBmFf/fXpD43rhto53k09+iYYY1TQwZSP9VIZ3U+8bBR00DXtf6T2Z9PZ5o+YzrsDtol/35EdVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ib1ygmZN; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1770342449;
	bh=3xWU18Si7MbG45q4kDeSWjMl7sTFP/o6JskP7HKJPjQ=;
	h=From:To:Cc:Subject:Date;
	b=ib1ygmZN5WkF1Jn/kq8sr9Ll/J8eYSrYzKt9hsnTVWoiO0HNYi1CnO0W1ckeRKtcj
	 fuVSoDS5oGI6KW5Z/42nFfPwnghujj0NYuc4AlCx1+3dXgEHCQN1WacPjeocQR2snp
	 y32o4AVBBePDdfn+3FA1u6gGz4CwJ0plL9VRpJyE=
Received: from ubuntu24.corp.ad.wrs.com ([183.241.55.101])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id BD90EE24; Fri, 06 Feb 2026 09:47:25 +0800
X-QQ-mid: xmsmtpt1770342445t9m932kye
Message-ID: <tencent_D2ADF3711C60041A8669356BBC3EFA25B909@qq.com>
X-QQ-XMAILINFO: Oayzr6Bt9/qs7WBMWzpmNtlxBgm4uzBGCu8pL81yyCOkp/Dg97H65I/f9aIsds
	 YqrUKikOPlKlrrgWxmRzk5powjN8iZC3MEqobRsyOe/WbCkhx2KWH/WmCm0KqGX3PVhnGjwS3zyu
	 18gN2ifZYqItKT9Nsp1LzPEXA5gsDjVazvyy5auRD36Y5ZenOOaLkXied3ENsH3VKfweYwFN+Rpw
	 gAEy1rZUiTJO20CVps4BAKJIMr/K8PV6rpTF0pjNSkiLOCSvxN472qF/RSxVNerWm1lwN24c5A7o
	 eb7EeEgAg8zPyNGVgGQiis9bM73OSrugNbZMb4Jf1YsE7MqNtYd031ARwMVJnYG5bDamnQtNLin8
	 5kLBPYlWgtoOW2BSsyrZmKEOpSXUE45qwXKoENw24LPd3149zoBCJ3YN9OVdtoOaU7HAsvDneuXm
	 brToyFi9gBOiHhB2LOGTPX/PgDMprDTkbqV0j7T4J6Pg5/pHCk2Ca6KetzHOEnJdCAfr5ggQ7Oqp
	 0rV2dHHfshKafral1dU6uIyhKW0+r4OgzK6p1KCnv9ZjpOcoeX9z/99M7abta2ZDKK8DHePruMay
	 Qw+aTLJmTpzDuLCyz5XZDADar0QTfvWIkPQNYyk7kn2Xv41faJpDQgnfFF45JoBfYq9OsSunOY81
	 doGANrP0Sc+sgo+9K/2mSoDHaJjSKFxtieXKDAs+WoJFTbgt6ClPJlDor9C4yzPVpMFKGYMyQWfZ
	 6GEEEu3ww6eskPtXR+aTu3Xvpvoe6JkxOYTtr9CssxvbpW6xjrRzZ0pcxm2L2EPu+R3ZDZTnYNgj
	 oJkgjhDRtnrtsVVCR2T70H4uUS3HvtCn2ouw4HzLao6qGkjQ2i+JskU2/VV3kHog9bpawvnCQfxB
	 XK6176QdeC3yDhH1p5TbvDmu92qdTT04FwRowU9a2WzgsSyvsemJIbX8gHmLYPV5KGj/IuXGIF6/
	 kvEQ5mxmwteDhQ8+rHyk2DdQjZah3a6L5fJkuHOadFOXfubtThntlf5OnYZVV53f1XsHq7PJqNds
	 x984MvW3zObpKG4dFjk92q6QvB1g4pWAbp2QoZTT6gJyYskz4AHFlhct//1uRVrMbj0J6OIXg78P
	 LrjqCLnSgnLNfFYsU=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: alvalan9@foxmail.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] ublk: fix deadlock when reading partition table
Date: Fri,  6 Feb 2026 01:47:17 +0000
X-OQ-MSGID: <20260206014717.4227-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214584-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	FREEMAIL_CC(0.00)[redhat.com,purestorage.com,kernel.dk,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,qq.com:mid,kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foxmail.com:email,foxmail.com:dkim]
X-Rspamd-Queue-Id: D272AF915D
X-Rspamd-Action: no action

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit c258f5c4502c9667bccf5d76fa731ab9c96687c1 ]

When one process(such as udev) opens ublk block device (e.g., to read
the partition table via bdev_open()), a deadlock[1] can occur:

1. bdev_open() grabs disk->open_mutex
2. The process issues read I/O to ublk backend to read partition table
3. In __ublk_complete_rq(), blk_update_request() or blk_mq_end_request()
   runs bio->bi_end_io() callbacks
4. If this triggers fput() on file descriptor of ublk block device, the
   work may be deferred to current task's task work (see fput() implementation)
5. This eventually calls blkdev_release() from the same context
6. blkdev_release() tries to grab disk->open_mutex again
7. Deadlock: same task waiting for a mutex it already holds

The fix is to run blk_update_request() and blk_mq_end_request() with bottom
halves disabled. This forces blkdev_release() to run in kernel work-queue
context instead of current task work context, and allows ublk server to make
forward progress, and avoids the deadlock.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Link: https://github.com/ublk-org/ublksrv/issues/170 [1]
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
[axboe: rewrite comment in ublk]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ The fix omits the change in __ublk_do_auto_buf_reg() since this function
  doesn't exist in Linux 6.6. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/block/ublk_drv.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 563b2a94d4c3..44f630a3f610 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1050,6 +1050,13 @@ static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 	return ubq->ubq_daemon->flags & PF_EXITING;
 }
 
+static void ublk_end_request(struct request *req, blk_status_t error)
+{
+	local_bh_disable();
+	blk_mq_end_request(req, error);
+	local_bh_enable();
+}
+
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req)
 {
@@ -1057,6 +1064,7 @@ static inline void __ublk_complete_rq(struct request *req)
 	struct ublk_io *io = &ubq->ios[req->tag];
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
+	bool requeue;
 
 	/* called from ublk_abort_queue() code path */
 	if (io->flags & UBLK_IO_FLAG_ABORTED) {
@@ -1094,14 +1102,30 @@ static inline void __ublk_complete_rq(struct request *req)
 	if (unlikely(unmapped_bytes < io->res))
 		io->res = unmapped_bytes;
 
-	if (blk_update_request(req, BLK_STS_OK, io->res))
+	/*
+	 * Run bio->bi_end_io() with softirqs disabled. If the final fput
+	 * happens off this path, then that will prevent ublk's blkdev_release()
+	 * from being called on current's task work, see fput() implementation.
+	 *
+	 * Otherwise, ublk server may not provide forward progress in case of
+	 * reading the partition table from bdev_open() with disk->open_mutex
+	 * held, and causes dead lock as we could already be holding
+	 * disk->open_mutex here.
+	 *
+	 * Preferably we would not be doing IO with a mutex held that is also
+	 * used for release, but this work-around will suffice for now.
+	 */
+	local_bh_disable();
+	requeue = blk_update_request(req, BLK_STS_OK, io->res);
+	local_bh_enable();
+	if (requeue)
 		blk_mq_requeue_request(req, true);
 	else
 		__blk_mq_end_request(req, BLK_STS_OK);
 
 	return;
 exit:
-	blk_mq_end_request(req, res);
+	ublk_end_request(req, res);
 }
 
 static void ublk_complete_rq(struct kref *ref)
@@ -1160,7 +1184,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 	if (ublk_queue_can_use_recovery(ubq))
 		blk_mq_requeue_request(rq, false);
 	else
-		blk_mq_end_request(rq, BLK_STS_IOERR);
+		ublk_end_request(rq, BLK_STS_IOERR);
 
 	mod_delayed_work(system_wq, &ubq->dev->monitor_work, 0);
 }
-- 
2.43.0


