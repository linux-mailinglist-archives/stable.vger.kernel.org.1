Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461A77A6F4
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjHMOcx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOcx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:32:53 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727041717
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:32:55 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fe8f602e23so1361425e87.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937173; x=1692541973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=;
        b=UB1kBw7vVK3ewcaIVTDQo2a6PmiSaJNqm0Dwh3QyXkNu8bFxP6NlpF+3fNgIXzD9NY
         1V7cLtlgKQ83Sxp6PkY5whfC0c1qLB2P6KbO7f39b8H2bgL48HwNkoZekrYzQzQLmJac
         yf0dMvKvO3Q+Wn1/n3GecQoDtkDmNlXOMSTfNDZfJF/uMxnyUmB00hdBbXtfqUs+17/P
         H4v+tb0BtMhqDTD+i+/17SK0xI5QCkefVEEenZFLbpxLTBqg5KaUEzciDkrLoUvj34Zc
         SjKNFshi4S316cOgh1s5GJNImhSNZEFUcnO8vnfMAxpa/a+5RSJjqabNBd7FIAkzidLl
         uuYg==
X-Gm-Message-State: AOJu0Yzk4gc5QR+IL1XmW/BJS7xGS6STQiCzDag5fU4wLTVenCW0tAkZ
        2JrpmjQxSLOOpyjaXOG8+lpRhyYYawM=
X-Google-Smtp-Source: AGHT+IEMgr4cL72fjBoVIyNafC2S2sqmZAmXwlZ4lvT9BP+7xUMXncpZwcbs/1ab1EHGo0SlKnrpJg==
X-Received: by 2002:a05:651c:210d:b0:2b9:4bc3:c367 with SMTP id a13-20020a05651c210d00b002b94bc3c367mr5471629ljq.5.1691937173219;
        Sun, 13 Aug 2023 07:32:53 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id kg23-20020a17090776f700b0099cfd0b2437sm4672075ejc.99.2023.08.13.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:32:52 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     stable@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y] nvme-rdma: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:32:50 +0300
Message-ID: <20230813143250.12621-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081242-sage-caddy-ebf9@gregkh>
References: <2023081242-sage-caddy-ebf9@gregkh>
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

