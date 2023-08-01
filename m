Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1576AF75
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjHAJrk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjHAJrW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7382D48
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B909614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ED0C433C8;
        Tue,  1 Aug 2023 09:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883154;
        bh=C8CPlToll0mO6Xsty4yPamI+ndE0Kmvq9Rp7Mpadweo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaTQwcstw3sYdDVZ1HuM9YOcSorNgH9w/fwbO0yBzpZ8OOK3GF4YtOpvD1rMwwASt
         DQF5V4/rkOW7K9IPTKM+Ammew+bu2H5+40eb6bqNnGxj0GB2g+2SlaChBQCEzKvigx
         CyVrUM8TQ2pzFrDujH4QfQcFz9GvcovviN3PixCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 135/239] ublk: fail to recover device if queue setup is interrupted
Date:   Tue,  1 Aug 2023 11:19:59 +0200
Message-ID: <20230801091930.560422205@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 0c0cbd4ebc375ceebc75c89df04b74f215fab23a ]

In ublk_ctrl_end_recovery(), if wait_for_completion_interruptible() is
interrupted by signal, queues aren't setup successfully yet, so we
have to fail UBLK_CMD_END_USER_RECOVERY, otherwise kernel oops can be
triggered.

Fixes: c732a852b419 ("ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support")
Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20230726144502.566785-3-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index dc2856d1241fc..bf0711894c0a2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2107,7 +2107,9 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 	/* wait until new ubq_daemon sending all FETCH_REQ */
-	wait_for_completion_interruptible(&ub->completion);
+	if (wait_for_completion_interruptible(&ub->completion))
+		return -EINTR;
+
 	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 
-- 
2.40.1



