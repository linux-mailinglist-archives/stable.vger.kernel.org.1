Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F577A6F8
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjHMOdR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjHMOdQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:33:16 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295410D0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:33:18 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-99c3ca08c09so107625566b.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937197; x=1692541997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=;
        b=Z2scGQs4BYJJGKt8iKHXdHu4xxPN3TUnOsDANpDP5othdXP8n0nemmpYs9quDhUipx
         YcS/oQzpI79lBLMMhaW7E6Ne6f93JNsbKes5xzmAvwkx8B2QRJN/mjAKqtxNTYodAXPf
         JcSC+RarlzgMwuSsPtc8k24ypnahDB2ZDGD+atGWc5+AiksSurPKc7q4UxpBzZkkCOwM
         BA5B4LrUdsgvC4OyMlmY/Uii+DN842pG4jQyV3TySQeut+FfmYzU69+BDbVQuDxXBxUu
         fL1UGBBkRV177hiJQ+0lu/YTy+jB7gcvVXLfTksNSRXzxbCDtHV4c6By34moDch7GeMy
         Jc6A==
X-Gm-Message-State: AOJu0Yxc6kgwdU+C2Fi5sGOQa3RRoOX+It+TKVFpiqsGqm9PC8VtzXeb
        54Son9QuOPZxiwEXp6wKBVDbJPyFg2Y=
X-Google-Smtp-Source: AGHT+IH/3SVrocrlNv7tLut8xuTnp+SfOb05qBfpzKkMLAjB1u5uRGZhVnFFHAar0t1m4vbV+ZvScg==
X-Received: by 2002:a17:906:220e:b0:99d:acdb:f709 with SMTP id s14-20020a170906220e00b0099dacdbf709mr330591ejs.5.1691937196739;
        Sun, 13 Aug 2023 07:33:16 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709066b8700b009737b8d47b6sm4598059ejr.203.2023.08.13.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:33:16 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     stable@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH 5.10.y] nvme-rdma: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:33:14 +0300
Message-ID: <20230813143314.12684-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081243-sleet-native-6d03@gregkh>
References: <2023081243-sleet-native-6d03@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Move start_freeze into nvme_rdma_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 80383213b882..c478480f54aa 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -923,6 +923,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_tagset;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_start_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -931,6 +932,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -980,7 +982,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-- 
2.41.0

