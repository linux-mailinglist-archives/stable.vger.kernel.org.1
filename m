Return-Path: <stable+bounces-55398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB626916368
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419A61F21337
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E2148315;
	Tue, 25 Jun 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4yT9aRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984951465A8;
	Tue, 25 Jun 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308786; cv=none; b=T3s0Yk2P/JJzdMmZOAA3cUcK7FKb2ZU3uSnZkRDCI1PPWHC/f0EeHlhds4Fv5kYcTzyfJGYuM2CsbZf1fSIxCgHoDfnumLPfNLmAlTfA6rcYpJGW3SeiXapXf3yRf7Er6aK76RWbCZIyxvntJoHhgm7zA5Oc5eaw7SiioTjp46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308786; c=relaxed/simple;
	bh=QZF0OIJ1Tu0u4odz7DCuWZtwJiA/Sul1WtF+Pyu4I8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YS1y956I0jerVTdZJBXeFBp9ICgzymH1l9tXypTq7071jDVOkGGtuHtVEbsz/WoyAHAc5htgfdtzcwbaoZq34pXoPuD/LGYzNAB/JSk/F9r2PGkc2FXT85wHzuqKU51UUNwRmkSilbwmzm/o+k276dKW/N1H5lPvhwWwtAEDKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4yT9aRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E05AC32781;
	Tue, 25 Jun 2024 09:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308786;
	bh=QZF0OIJ1Tu0u4odz7DCuWZtwJiA/Sul1WtF+Pyu4I8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4yT9aRnp26eLP8RYzCF8CQ2Dv5Ea32v1Spdu2IcK7Yo+vuMjwscX6cDQrPS+2uMb
	 7KRE1oRJo5RCM9YQukjYayEIifP+SwgeCPM+Dr7d5nAvF1Od3VITyL78A88l+URw53
	 tdRIMaw7OG7mNga4LusCFSxP8oYURIHdQJd3E7SA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Josef Bacik <jbacik@fb.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 240/250] nbd: Fix signal handling
Date: Tue, 25 Jun 2024 11:33:18 +0200
Message-ID: <20240625085557.266204839@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit e56d4b633fffea9510db468085bed0799cba4ecd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 281df7bafc83c..1ddd3e5497896 100644
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
@@ -671,7 +675,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 				nsock->sent = sent;
 			}
 			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-			return BLK_STS_RESOURCE;
+			return (__force int)BLK_STS_RESOURCE;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 			"Send control failed (result %d)\n", result);
@@ -712,7 +716,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 					nsock->pending = req;
 					nsock->sent = sent;
 					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
-					return BLK_STS_RESOURCE;
+					return (__force int)BLK_STS_RESOURCE;
 				}
 				dev_err(disk_to_dev(nbd->disk),
 					"Send data failed (result %d)\n",
@@ -1009,7 +1013,7 @@ static int wait_for_reconnect(struct nbd_device *nbd)
 	return !test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
 }
 
-static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
+static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
 	struct nbd_device *nbd = cmd->nbd;
@@ -1023,14 +1027,14 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
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
@@ -1053,7 +1057,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 			 */
 			sock_shutdown(nbd);
 			nbd_config_put(nbd);
-			return -EIO;
+			return BLK_STS_IOERR;
 		}
 		goto again;
 	}
@@ -1066,7 +1070,7 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 	blk_mq_start_request(req);
 	if (unlikely(nsock->pending && nsock->pending != req)) {
 		nbd_requeue_cmd(cmd);
-		ret = 0;
+		ret = BLK_STS_OK;
 		goto out;
 	}
 	/*
@@ -1085,19 +1089,19 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
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
@@ -1117,10 +1121,6 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * appropriate.
 	 */
 	ret = nbd_handle_cmd(cmd, hctx->queue_num);
-	if (ret < 0)
-		ret = BLK_STS_IOERR;
-	else if (!ret)
-		ret = BLK_STS_OK;
 	mutex_unlock(&cmd->lock);
 
 	return ret;
-- 
2.43.0




