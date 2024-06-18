Return-Path: <stable+bounces-53633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF04890D506
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5191D290933
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524FF13D8BC;
	Tue, 18 Jun 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBI5eMYD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1513C8E5
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719613; cv=none; b=ETTnuz6Wn2y6QQLSfYY5r958G1ml8Pcu4lW5LP1F+rBe31IXwuO4zehUOtWw19+tpt960iS/LMfjjIwJUJlX8jmqRxNXKRDOwHoOI/RCr7XscGJbkIP/+n7vK9ds3HUC14eMXrQSNKrgKbyZw4ctkNqXdIY4qSCvlrz+TYv82ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719613; c=relaxed/simple;
	bh=61lhsgudtRsYFrr9/pp85Tzto59v4r6+mFcLGw8bYIE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=maAs4yU/omn1hc3Y2MZ5f4x+TkZA8xya5Xl24jNSEi6xRaxRrgIL84HtXRxPHJg+P70uVHzUG0OWYNMlNMAhR4oX2wi2ciGqKEtJsJJyhQGACDzoSaU9xx6DNyLGJn/XlP5fcnVOIjUFtERtNBAUq0dHg+9s6i3a9+BjjEeWf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBI5eMYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B92BC3277B;
	Tue, 18 Jun 2024 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718719612;
	bh=61lhsgudtRsYFrr9/pp85Tzto59v4r6+mFcLGw8bYIE=;
	h=Subject:To:Cc:From:Date:From;
	b=vBI5eMYDD05NyJESunie2ucrqnOxnuY4AsizdvydP9QWauqlfHmN8aKHResEGUpU8
	 z4nof0z/k7XJWs41i6dAuMA3aQgs9wXKoldIm9WcGQWt9I1sufMbDJqgTH2iaTfiLK
	 CLGkF17e5zauNTpO7oRDa4rpSAMyKGJN2qxrNhOU=
Subject: FAILED: patch "[PATCH] nbd: Fix signal handling" failed to apply to 6.6-stable tree
To: bvanassche@acm.org,axboe@kernel.dk,hch@lst.de,jbacik@fb.com,mpa@pengutronix.de,yukuai3@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 16:06:47 +0200
Message-ID: <2024061847-dwindle-clamshell-1a09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e56d4b633fffea9510db468085bed0799cba4ecd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061847-dwindle-clamshell-1a09@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e56d4b633fff ("nbd: Fix signal handling")
2a6751e052ab ("nbd: Improve the documentation of the locking assumptions")
3123ac779233 ("nbd: factor out a helper to get nbd_config without holding 'config_lock'")
1b59860540a4 ("nbd: fold nbd config initialization into nbd_alloc_config()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e56d4b633fffea9510db468085bed0799cba4ecd Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Fri, 10 May 2024 13:23:13 -0700
Subject: [PATCH] nbd: Fix signal handling

Both nbd_send_cmd() and nbd_handle_cmd() return either a negative error
number or a positive blk_status_t value. nbd_queue_rq() converts these
return values into a blk_status_t value. There is a bug in the conversion
code: if nbd_send_cmd() returns BLK_STS_RESOURCE, nbd_queue_rq() should
return BLK_STS_RESOURCE instead of BLK_STS_OK. Fix this, move the
conversion code into nbd_handle_cmd() and fix the remaining sparse warnings.

This patch fixes the following sparse warnings:

drivers/block/nbd.c:673:32: warning: incorrect type in return expression (different base types)
drivers/block/nbd.c:673:32:    expected int
drivers/block/nbd.c:673:32:    got restricted blk_status_t [usertype]
drivers/block/nbd.c:714:48: warning: incorrect type in return expression (different base types)
drivers/block/nbd.c:714:48:    expected int
drivers/block/nbd.c:714:48:    got restricted blk_status_t [usertype]
drivers/block/nbd.c:1120:21: warning: incorrect type in assignment (different base types)
drivers/block/nbd.c:1120:21:    expected int [assigned] ret
drivers/block/nbd.c:1120:21:    got restricted blk_status_t [usertype]
drivers/block/nbd.c:1125:16: warning: incorrect type in return expression (different base types)
drivers/block/nbd.c:1125:16:    expected restricted blk_status_t
drivers/block/nbd.c:1125:16:    got int [assigned] ret

Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Fixes: fc17b6534eb8 ("blk-mq: switch ->queue_rq return value to blk_status_t")
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240510202313.25209-6-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 29e43ab1650c..22a79a62cc4e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -588,6 +588,10 @@ static inline int was_interrupted(int result)
 	return result == -ERESTARTSYS || result == -EINTR;
 }
 
+/*
+ * Returns BLK_STS_RESOURCE if the caller should retry after a delay. Returns
+ * -EAGAIN if the caller should requeue @cmd. Returns -EIO if sending failed.
+ */
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
@@ -670,7 +674,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 				nsock->sent = sent;
 			}
 			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return BLK_STS_RESOURCE;
+			return (__force int)BLK_STS_RESOURCE;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
@@ -711,7 +715,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 					nsock->pending = req;
 					nsock->sent = sent;
 					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-					return BLK_STS_RESOURCE;
+					return (__force int)BLK_STS_RESOURCE;
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
@@ -1008,7 +1012,7 @@ static int wait_for_reconnect(struct nbd_device *nbd)
 	return !test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
 }
 
-static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
+static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 	struct nbd_device *nbd = cmd->nbd;
@@ -1022,14 +1026,14 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	if (!config) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Socks array is empty\n");
-		return -EINVAL;
+		return BLK_STS_IOERR;
 	}
 
 	if (index >= config->num_connections) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Attempted send on invalid socket\n");
 		nbd_config_put(nbd);
-		return -EINVAL;
+		return BLK_STS_IOERR;
 	}
 	cmd->status = BLK_STS_OK;
 again:
@@ -1052,7 +1056,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 			 */
 			sock_shutdown(nbd);
 			nbd_config_put(nbd);
-			return -EIO;
+			return BLK_STS_IOERR;
 		}
 		goto again;
 	}
@@ -1065,7 +1069,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	blk_mq_start_request(req);
 	if (unlikely(nsock->pending && nsock->pending != req)) {
 		nbd_requeue_cmd(cmd);
-		ret = 0;
+		ret = BLK_STS_OK;
 		goto out;
 	}
 	/*
@@ -1084,19 +1088,19 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 				    "Request send failed, requeueing\n");
 		nbd_mark_nsock_dead(nbd, nsock, 1);
 		nbd_requeue_cmd(cmd);
-		ret = 0;
+		ret = BLK_STS_OK;
 	}
 out:
 	mutex_unlock(&nsock->tx_lock);
 	nbd_config_put(nbd);
-	return ret;
+	return ret < 0 ? BLK_STS_IOERR : (__force blk_status_t)ret;
 }
 
 static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
-	int ret;
+	blk_status_t ret;
 
 	/*
 	 * Since we look at the bio's to send the request over the network we
@@ -1116,10 +1120,6 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * appropriate.
 	 */
 	ret = nbd_handle_cmd(cmd, hctx->queue_num);
-	if (ret < 0)
-		ret = BLK_STS_IOERR;
-	else if (!ret)
-		ret = BLK_STS_OK;
 	mutex_unlock(&cmd->lock);
 
 	return ret;


