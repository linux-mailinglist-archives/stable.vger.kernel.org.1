Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B37A3AA2
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbjIQUG5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbjIQUGb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A6EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:06:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C610C433C7;
        Sun, 17 Sep 2023 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981185;
        bh=8jK7EhDNA1KsBEyvwM3dBFG9a8pV44wR2iDzrkR8gvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnIk6eiXeuMx2bR4k1UCSUOLO2L27uHmi1xiDiBGcSxVVW32u1MZPNHJVMe72QS3U
         hl0LR2d7bs0Mc4YkX/lEcq4ADMc2UKM1sfKyfFWdTWCWT96QEdD7lKIK0re+MMUlG2
         QbTh3Boph9QjWTPv4hcDatxEU1UmMgylHVPupPNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 017/511] s390/dasd: fix hanging device after request requeue
Date:   Sun, 17 Sep 2023 21:07:24 +0200
Message-ID: <20230917191114.248125383@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 8a2278ce9c25048d999fe1a3561def75d963f471 ]

The DASD device driver has a function to requeue requests to the
blocklayer.
This function is used in various cases when basic settings for the device
have to be changed like High Performance Ficon related parameters or copy
pair settings.

The functions iterates over the device->ccw_queue and also removes the
requests from the block->ccw_queue.
In case the device is started on an alias device instead of the base
device it might be removed from the block->ccw_queue without having it
canceled properly before. This might lead to a hanging device since the
request is no longer on a queue and can not be handled properly.

Fix by iterating over the block->ccw_queue instead of the
device->ccw_queue. This will take care of all blocklayer related requests
and handle them on all associated DASD devices.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20230721193647.3889634-4-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c | 125 +++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 77 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ed897dc499ff6..0c6ab288201e5 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2948,41 +2948,32 @@ static void _dasd_wake_block_flush_cb(struct dasd_ccw_req *cqr, void *data)
  * Requeue a request back to the block request queue
  * only works for block requests
  */
-static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
+static void _dasd_requeue_request(struct dasd_ccw_req *cqr)
 {
-	struct dasd_block *block = cqr->block;
 	struct request *req;
 
-	if (!block)
-		return -EINVAL;
 	/*
 	 * If the request is an ERP request there is nothing to requeue.
 	 * This will be done with the remaining original request.
 	 */
 	if (cqr->refers)
-		return 0;
+		return;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
 	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
-	return 0;
+	return;
 }
 
-/*
- * Go through all request on the dasd_block request queue, cancel them
- * on the respective dasd_device, and return them to the generic
- * block layer.
- */
-static int dasd_flush_block_queue(struct dasd_block *block)
+static int _dasd_requests_to_flushqueue(struct dasd_block *block,
+					struct list_head *flush_queue)
 {
 	struct dasd_ccw_req *cqr, *n;
-	int rc, i;
-	struct list_head flush_queue;
 	unsigned long flags;
+	int rc, i;
 
-	INIT_LIST_HEAD(&flush_queue);
-	spin_lock_bh(&block->queue_lock);
+	spin_lock_irqsave(&block->queue_lock, flags);
 	rc = 0;
 restart:
 	list_for_each_entry_safe(cqr, n, &block->ccw_queue, blocklist) {
@@ -2997,13 +2988,32 @@ static int dasd_flush_block_queue(struct dasd_block *block)
 		 * is returned from the dasd_device layer.
 		 */
 		cqr->callback = _dasd_wake_block_flush_cb;
-		for (i = 0; cqr != NULL; cqr = cqr->refers, i++)
-			list_move_tail(&cqr->blocklist, &flush_queue);
+		for (i = 0; cqr; cqr = cqr->refers, i++)
+			list_move_tail(&cqr->blocklist, flush_queue);
 		if (i > 1)
 			/* moved more than one request - need to restart */
 			goto restart;
 	}
-	spin_unlock_bh(&block->queue_lock);
+	spin_unlock_irqrestore(&block->queue_lock, flags);
+
+	return rc;
+}
+
+/*
+ * Go through all request on the dasd_block request queue, cancel them
+ * on the respective dasd_device, and return them to the generic
+ * block layer.
+ */
+static int dasd_flush_block_queue(struct dasd_block *block)
+{
+	struct dasd_ccw_req *cqr, *n;
+	struct list_head flush_queue;
+	unsigned long flags;
+	int rc;
+
+	INIT_LIST_HEAD(&flush_queue);
+	rc = _dasd_requests_to_flushqueue(block, &flush_queue);
+
 	/* Now call the callback function of flushed requests */
 restart_cb:
 	list_for_each_entry_safe(cqr, n, &flush_queue, blocklist) {
@@ -3926,75 +3936,36 @@ EXPORT_SYMBOL_GPL(dasd_generic_space_avail);
  */
 static int dasd_generic_requeue_all_requests(struct dasd_device *device)
 {
+	struct dasd_block *block = device->block;
 	struct list_head requeue_queue;
 	struct dasd_ccw_req *cqr, *n;
-	struct dasd_ccw_req *refers;
 	int rc;
 
-	INIT_LIST_HEAD(&requeue_queue);
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	rc = 0;
-	list_for_each_entry_safe(cqr, n, &device->ccw_queue, devlist) {
-		/* Check status and move request to flush_queue */
-		if (cqr->status == DASD_CQR_IN_IO) {
-			rc = device->discipline->term_IO(cqr);
-			if (rc) {
-				/* unable to terminate requeust */
-				dev_err(&device->cdev->dev,
-					"Unable to terminate request %p "
-					"on suspend\n", cqr);
-				spin_unlock_irq(get_ccwdev_lock(device->cdev));
-				dasd_put_device(device);
-				return rc;
-			}
-		}
-		list_move_tail(&cqr->devlist, &requeue_queue);
-	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-
-	list_for_each_entry_safe(cqr, n, &requeue_queue, devlist) {
-		wait_event(dasd_flush_wq,
-			   (cqr->status != DASD_CQR_CLEAR_PENDING));
+	if (!block)
+		return 0;
 
-		/*
-		 * requeue requests to blocklayer will only work
-		 * for block device requests
-		 */
-		if (_dasd_requeue_request(cqr))
-			continue;
+	INIT_LIST_HEAD(&requeue_queue);
+	rc = _dasd_requests_to_flushqueue(block, &requeue_queue);
 
-		/* remove requests from device and block queue */
-		list_del_init(&cqr->devlist);
-		while (cqr->refers != NULL) {
-			refers = cqr->refers;
-			/* remove the request from the block queue */
-			list_del(&cqr->blocklist);
-			/* free the finished erp request */
-			dasd_free_erp_request(cqr, cqr->memdev);
-			cqr = refers;
+	/* Now call the callback function of flushed requests */
+restart_cb:
+	list_for_each_entry_safe(cqr, n, &requeue_queue, blocklist) {
+		wait_event(dasd_flush_wq, (cqr->status < DASD_CQR_QUEUED));
+		/* Process finished ERP request. */
+		if (cqr->refers) {
+			spin_lock_bh(&block->queue_lock);
+			__dasd_process_erp(block->base, cqr);
+			spin_unlock_bh(&block->queue_lock);
+			/* restart list_for_xx loop since dasd_process_erp
+			 * might remove multiple elements
+			 */
+			goto restart_cb;
 		}
-
-		/*
-		 * _dasd_requeue_request already checked for a valid
-		 * blockdevice, no need to check again
-		 * all erp requests (cqr->refers) have a cqr->block
-		 * pointer copy from the original cqr
-		 */
+		_dasd_requeue_request(cqr);
 		list_del_init(&cqr->blocklist);
 		cqr->block->base->discipline->free_cp(
 			cqr, (struct request *) cqr->callback_data);
 	}
-
-	/*
-	 * if requests remain then they are internal request
-	 * and go back to the device queue
-	 */
-	if (!list_empty(&requeue_queue)) {
-		/* move freeze_queue to start of the ccw_queue */
-		spin_lock_irq(get_ccwdev_lock(device->cdev));
-		list_splice_tail(&requeue_queue, &device->ccw_queue);
-		spin_unlock_irq(get_ccwdev_lock(device->cdev));
-	}
 	dasd_schedule_device_bh(device);
 	return rc;
 }
-- 
2.40.1



