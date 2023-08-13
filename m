Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502C77A6EE
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjHMObI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMObI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:31:08 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2D1707
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:31:10 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3fe8d816a40so3430325e9.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937068; x=1692541868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=;
        b=YWt+FutshAUEZMJwmXm+H4CQPe7Zwja+q3ydbUg2zTlgp3EgRz6VVLlZxfzk2QrAvT
         z/eM/xDulkkxpXVHqrIbrV+lu9oTzpeOdZ7R/ai4W7FdQEYnGEIi6ariiYLBV02D4mzM
         1NL+Rmyijo8YAU2E4RY2ubT6z1nXmWA6A1VifuNGBp3q5EHp+WPbuEFf5lNVkoZrFSgw
         CMZ7Zke7sDcrlTA93+d5yM8sliuAkz9eF9a2ribE934lnk/i59Wrd4JhWFMgvwlXY0bV
         vE5IvHG+4SDqlojGscdebyk5YmkjIzwA50n1wEEv6q23RIv+JGURtf7JWl6ca0oC+F/a
         KCbw==
X-Gm-Message-State: AOJu0YzA0hHm0u8oadJEIsORog5+1DuhBJC2LLwmp3c2yT3lD7g8ASXj
        Ai7N2V5FZXNxDZtJfG16Ut/i5stp0/g=
X-Google-Smtp-Source: AGHT+IGd2hPeaEh7kNTz5il4uY8J2DCXyPRPmXa8I13qfg2Tvp0zsvrPETGq8PATbl4Ea3sAn+YmBA==
X-Received: by 2002:a05:600c:5111:b0:3fe:5228:b78c with SMTP id o17-20020a05600c511100b003fe5228b78cmr7207790wms.1.1691937068577;
        Sun, 13 Aug 2023 07:31:08 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b00992c92af6f4sm4655213ejp.144.2023.08.13.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:31:08 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     stable@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:31:06 +0300
Message-ID: <20230813143106.12390-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081226-oak-cartoon-6115@gregkh>
References: <2023081226-oak-cartoon-6115@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Move start_freeze into nvme_tcp_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1dc7c733c7e3..8d67cdd844f5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1884,6 +1884,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_start_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1892,6 +1893,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -1996,7 +1998,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_stop_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.41.0

