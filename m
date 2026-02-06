Return-Path: <stable+bounces-214583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKo7NrFIhWkN/QMAu9opvQ
	(envelope-from <stable+bounces-214583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 02:49:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B7F911A
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 02:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9506C3034553
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830B248861;
	Fri,  6 Feb 2026 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="lF3G/MAh"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602EE246766
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342428; cv=none; b=PqGePkiqTaHf2kw5N3ygMjPiG00eiYHad67Rld2N9CU6qEQ0ct3X6qnEyamsJ5AWaCqzNDwoAK/2J6T6m/Pl7NFbcyCfZ0dfUbL8l4q1KqpaQ4KcJ2GbTkCK1frDIha6t6hX5N0hAwRNiTCy0JVP6X0dI1XDnwWYmFCjBJvcobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342428; c=relaxed/simple;
	bh=3ibxz+s4gf8V8aSQh1sVx5rWOACbOVeYfzzRXi/ixDU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=S0+/ItN9sW8mDMWHOUAavPR76sIMDEQVwX4E3jGMElka9k9/D8c8WW7bnn5BfM+5a0CvQfl2IsOjS28RDnoxsTUVv8nXLLDuDQEr3c9Sa3XNB3OMadwsc29qN8u25+N/5SfnQct2FFDLYI54Y26JtRaU7nufmldk2q29ax0bX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=lF3G/MAh; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1770342424;
	bh=uw1r32b0CM640eCQc9QjEzgmUnvpFEhZUc97VyBDdbw=;
	h=From:To:Cc:Subject:Date;
	b=lF3G/MAhGjNaPzxEacgLSiieTfQdSe8FC7tzv63p3hLGuHOLfho4sXiJi6I32QWSe
	 Cs15t6+KsUayFI4i0wm9gTDlydUSEBVjkmFkw10iWlcHPkHSlyl3RntwudfPiN/gO2
	 MVx77UxMfgyAlFHqi8QcZ2HFCvecTu/+TrhtJmr0=
Received: from ubuntu24.corp.ad.wrs.com ([183.241.55.101])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id BBA18C31; Fri, 06 Feb 2026 09:46:58 +0800
X-QQ-mid: xmsmtpt1770342418ta2exuq5k
Message-ID: <tencent_50D01A0E470EA6A8A19E36A3C6EF034CB205@qq.com>
X-QQ-XMAILINFO: NsiJGDfdhhZG062EfB9J/jro9OpnylRtjIDFDsrB3tE4pLBp2qIRfXV56rAV8c
	 aktM8bgYNCn02DROffXefsrHZHqPHrfCJRbEnx4vyq8W0g1EqJ9p/z5BCrnalvAQpgEyhjwOHclO
	 WzhoRrl07JW6sksh5mHzoEodR0Gw3kconzatWT/3EHOPgE/Z4CsctC3QpCqztkqvGX2TTyjjzSJx
	 QG0bY53Kq9ImF/XqH4aZLXzWoIkD7beRMoKStWasL3K51qKP586xDguVRRKM5JaYUgqgB2NEZHIF
	 CkImuy4xXNoboucE8U8AQb3GifKqtosOPxiEZ/7I8gwBSTsTElFK8kf+XVhnmhp5SjpPuvD4rEg+
	 HSPNvU6rC8DUmXUvQMdXpmZKeEUH85+8UQpBHDBC3X4yUZdIJftyXqALhNmWs7hctPgmF9qP0j1Y
	 hF4yf5Xx0pDhuN3T/saHzhFgluH1EaBkPRXozY5Su/EFimKRe8Vj0MBAOcrRJ3mVYrr0Z86cGksv
	 om7Kgr4/ghk3fX3KyqGuG90+9U+dbtc9Fhg/YeCO9qSt5MFERdqhfk1Vcrj1ULJ6k17GwLYm3JJG
	 CrYqJAXsjM+rYhxZTOfK/xTEVLh0Iu0I/QQydXHDl1R5i7T6+S9EZxZYXLC6nWnnwEefkVbuds2b
	 h3hovMMxKM5wR8iNmRStKKUk4O4CIbcs8inqQRzlxocboYxbsPZjbuTQVtxaxzSbBC6I4jJsb5EF
	 uOILRAwgSfgujmi2H2OCDL+XoqRkc6GEf+h9HIkFonpBxW8Ym2g2sKxkWnf+Dhehau/WFAs6uGtF
	 +EBGpZrYR1xDx/FJIPNu5boMsDPn+gCEvLg6GuDoXwAEEiY2GM9xpvnSEDdNJIZI8PWK6ZatLwPB
	 F+0JBlaGv08+SPDhKPaX4Oa3HdnTJeLZ5ATWoFUTO9+lNFYiB1xsLVrePeDmAa8gMrf/VNOjw3D9
	 slN3P89KSAA7PnDJ+i4qsMGD+fDFiqq6cUTz7lHsZi8zpAKsXBef6ot1OLgcuK9dntvxdEBUv1/0
	 NzxRGHIzbI2d9xCOwAiX2mmW3DmtQk6yWaNMYVqo+B/HHiN32wHUIou3u9bRr34kufjqrcNA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: alvalan9@foxmail.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12.y] ublk: fix deadlock when reading partition table
Date: Fri,  6 Feb 2026 01:46:46 +0000
X-OQ-MSGID: <20260206014646.4203-1-alvalan9@foxmail.com>
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
	TAGGED_FROM(0.00)[bounces-214583-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email,foxmail.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:mid,kernel.dk:email]
X-Rspamd-Queue-Id: 391B7F911A
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
  doesn't exist in Linux 6.12. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/block/ublk_drv.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b874cb84bad9..2d46383e8d26 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1020,6 +1020,13 @@ static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
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
@@ -1027,6 +1034,7 @@ static inline void __ublk_complete_rq(struct request *req)
 	struct ublk_io *io = &ubq->ios[req->tag];
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
+	bool requeue;
 
 	/* called from ublk_abort_queue() code path */
 	if (io->flags & UBLK_IO_FLAG_ABORTED) {
@@ -1064,14 +1072,30 @@ static inline void __ublk_complete_rq(struct request *req)
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
@@ -1149,7 +1173,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 	if (ublk_nosrv_dev_should_queue_io(ubq->dev))
 		blk_mq_requeue_request(rq, false);
 	else
-		blk_mq_end_request(rq, BLK_STS_IOERR);
+		ublk_end_request(rq, BLK_STS_IOERR);
 }
 
 static inline void __ublk_rq_task_work(struct request *req,
-- 
2.43.0


