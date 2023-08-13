Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3E77A706
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjHMOpN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjHMOpM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:45:12 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C63B10DE
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:45:15 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99c3ca08c09so107759866b.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937913; x=1692542713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNGi8K3J7lw/ZSXS7j6v1SkrAVUpcZa/LdyjGxfu3pA=;
        b=L7xg4DE6U3OoMMVDdhf6wvOsrNDZGwosVkCKONM3dcytbAZGNCa3z6wJAtHGdgJSqb
         vglabDnFXKhsfdjxMdhREISqco6fml2q1BhF3tTd5FBgtXpluaHqTTEd/I7xmG4wrkM6
         lw1IF6tmlrmZjZ2LGQ2nqXYP40lK0O6wRcft51HQO7L+tZvc4gtdxSPiRMy4d4t3WgCT
         1rG1xO2KmqIqSA3gXPBgXA0lOnGpiSik4n3gtAfVQwT86T/mToKiJqDK4llxrnYKdX1e
         jLnkJd/p8CiIqUQluEABfEwss9XEsHrWtPariryMkGWicu3LxkJ+moChyT4/WbHFz+fn
         xf5w==
X-Gm-Message-State: AOJu0YxJNYOX5JeXdr1O7OgQujH7NiYpuRHLrsAQIl3deghFYjUYM5kU
        DFwRQDmUdXMkKhkIiBS+DGD7eqynXcA=
X-Google-Smtp-Source: AGHT+IEmlQCISV8xuYubpycyxGP0Hocr6owQNsOJL0RdozE0FVGdLDyTDQ7kzwHuZeUbpaz/KHYqqQ==
X-Received: by 2002:a17:906:73c6:b0:997:d069:a880 with SMTP id n6-20020a17090673c600b00997d069a880mr6142907ejl.1.1691937913126;
        Sun, 13 Aug 2023 07:45:13 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b0099c157cba46sm4574699ejb.119.2023.08.13.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:45:12 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     <stable@vger.kernel.org>
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y 5.10.y 5.4.y 1/2] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:45:09 +0300
Message-ID: <20230813144510.15401-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
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
index 96d8d7844e84..c2e037644ad1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1882,6 +1882,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(ctrl);
 		nvme_start_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1890,6 +1891,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -2008,7 +2010,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (ctrl->queue_count <= 1)
 		return;
 	blk_mq_quiesce_queue(ctrl->admin_q);
-	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.41.0

