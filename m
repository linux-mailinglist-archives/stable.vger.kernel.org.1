Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E977A704
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjHMOpF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjHMOpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:45:04 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4761702
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:45:06 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bd67facffso81258966b.0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937904; x=1692542704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=;
        b=BgP99zH8e2yZbQdha6IjgxCb95cJcOPTtn9465yW10XQzTyKISMvRyKJw6acxorqxF
         1dlkjZpbmJS2IRO4KyXVoAyLBMXPvXBIdeU+wk357aWzjZ33Qa3M9mqBOSXX9w+Y/lZM
         4FaQZFHJtI8FYGclxnWtNyZSaaKe0HeugYl2hlY1oUL+xP4lEn089YOGjiBVX3smatLo
         vZP8pYbOM5zof6lys/8SgbgIl+nlLq/7H98qnxJPrYETOzju7hKEdIE+43BNHi99lndQ
         ArHbpKH5nuQBdfo6ODh6FZDpVDrgGnQ2WUVuIMuw3qqWUUkBxhdOnIRFwYzha8kVVPw2
         PCFw==
X-Gm-Message-State: AOJu0Yz85I13liMtHRiRYx3hQtwzhJdQcAG5ad1KBYv7J+eYU/ppgm/w
        JxasxRR9afVnIIf2YhMjJ2PJdgexM4I=
X-Google-Smtp-Source: AGHT+IFIRCwoxlLELSV6+nD2yzu51uet4FKj4HXaxSd/Tq89d9NcP9kV/g2lKC51F+pjVVWNPlqp3w==
X-Received: by 2002:a17:906:21c:b0:99c:c178:cef9 with SMTP id 28-20020a170906021c00b0099cc178cef9mr5573065ejd.2.1691937904256;
        Sun, 13 Aug 2023 07:45:04 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906110b00b00977cad140a8sm4618761eja.218.2023.08.13.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:45:03 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     <stable@vger.kernel.org>
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH 6.1.y 2/2] nvme-rdma: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:45:00 +0300
Message-ID: <20230813144500.15339-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813144500.15339-1-sagi@grimberg.me>
References: <20230813144500.15339-1-sagi@grimberg.me>
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

