Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8AA7034CB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbjEOQwS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243149AbjEOQwE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2835C619A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:52:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D4662991
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B607BC433D2;
        Mon, 15 May 2023 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169522;
        bh=V81hWTmd0fhMNn6pO1pcM+wbPP2grJbG/ksdSvviqRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqDts810HTSYamid4tVcm37Pi9OVJYyI54eCPybYfVf1HmqJvjDhiCxqDIoxuqA5l
         hdZyycabTkFWf13IXw2qA/Y8jTun/PgkL8OK2qgoORVH3FhutpHvt0WOzRZ5PW8Zcw
         P7616ssRXjYxNSS+dgtlW+d1jK4op4C0ikCHMIww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 083/246] ublk: add timeout handler
Date:   Mon, 15 May 2023 18:24:55 +0200
Message-Id: <20230515161725.070616334@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit c0b79b0ff53be5b05be98e3caaa6a39de1fe9520 ]

Add timeout handler, so that we can provide forward progress guarantee for
unprivileged ublk, which can't be trusted.

One thing is that sync() calls sync_bdevs(wait) for all block devices after
running sync_bdevs(no_wait), and if one device can't move on, the sync() won't
return any more.

Add timeout for unprivileged ublk to avoid such affect for other users which call
sync() syscall.

Meantime clear UBLK_F_USER_RECOVERY_REISSUE for unprivileged ublk since
that feature may cause IO hang too.

Fixes: 4093cb5a0634 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230502024231.888498-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 604c1a13c76ef..41c35ab2c25a1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -128,6 +128,7 @@ struct ublk_queue {
 	unsigned long io_addr;	/* mapped vm address */
 	unsigned int max_io_sz;
 	bool force_abort;
+	bool timeout;
 	unsigned short nr_io_ready;	/* how many ios setup */
 	struct ublk_device *dev;
 	struct ublk_io ios[];
@@ -900,6 +901,22 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 	}
 }
 
+static enum blk_eh_timer_return ublk_timeout(struct request *rq)
+{
+	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+
+	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
+		if (!ubq->timeout) {
+			send_sig(SIGKILL, ubq->ubq_daemon, 0);
+			ubq->timeout = true;
+		}
+
+		return BLK_EH_DONE;
+	}
+
+	return BLK_EH_RESET_TIMER;
+}
+
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -959,6 +976,7 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rq       = ublk_queue_rq,
 	.init_hctx	= ublk_init_hctx,
 	.init_request   = ublk_init_rq,
+	.timeout	= ublk_timeout,
 };
 
 static int ublk_ch_open(struct inode *inode, struct file *filp)
@@ -1721,6 +1739,18 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))
 		return -EPERM;
 
+	/*
+	 * unprivileged device can't be trusted, but RECOVERY and
+	 * RECOVERY_REISSUE still may hang error handling, so can't
+	 * support recovery features for unprivileged ublk now
+	 *
+	 * TODO: provide forward progress for RECOVERY handler, so that
+	 * unprivileged device can benefit from it
+	 */
+	if (info.flags & UBLK_F_UNPRIVILEGED_DEV)
+		info.flags &= ~(UBLK_F_USER_RECOVERY_REISSUE |
+				UBLK_F_USER_RECOVERY);
+
 	/* the created device is always owned by current user */
 	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
@@ -1989,6 +2019,7 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	put_task_struct(ubq->ubq_daemon);
 	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
 	ubq->ubq_daemon = NULL;
+	ubq->timeout = false;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
-- 
2.39.2



