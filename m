Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1E77A707
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjHMOpO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjHMOpO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:45:14 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8443010DE
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:45:16 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99bded9d93dso81026166b.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937914; x=1692542714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ2cTXEltHCfVXnyLCfSTIsmKfECOAmh3JPWbPsMLMY=;
        b=EKQ0eVfB23X219FeFGGRgdxFFh9GBBxY/Ab8OYnGl+Zs1uFaDA0PgJ91tZuv9oVTl5
         OvbAnQLggBdxtIur0zozzZbxvlOjDD22OGzvPVUHc2918T5B4tTTzJR8B/JNOLrlA9N9
         hQHRosQ0RMEOVQwulV2GI4FNANv4bsWoCcgkJ2f38mnCLulJqfFfSjbbnRxzdmBeompG
         gG8AmLggBdOgdbNyvnE0bh9djofh7rJoV6P0BJOodEi8TfbO83PNsVCI/Z+mDcUdBWFb
         LbZv3seHUkpXdJFoxEElqVIHNaaDylWCN+VoexTO0r2M+/dTwJskN0OM/n0qLO6FkY9L
         NvaA==
X-Gm-Message-State: AOJu0YxzEFnd0HKt16+S0lo45S9LzyWHFxN/E8ZsJrEnm9q5kL7N2B9b
        a1QSmc7ZIL3HwJ4LEbi5+0nPuSaGHhE=
X-Google-Smtp-Source: AGHT+IHitYqQ2RuY/X6YIxQYqp2OwJkrUNKE/oC4VN8cCqNDu1e/sOR7dWb5UEeuMIbbjfLCJPF/3w==
X-Received: by 2002:a17:906:10d2:b0:99b:4670:aca9 with SMTP id v18-20020a17090610d200b0099b4670aca9mr5579963ejv.1.1691937914286;
        Sun, 13 Aug 2023 07:45:14 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906348600b0099c157cba46sm4574699ejb.119.2023.08.13.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:45:13 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     <stable@vger.kernel.org>
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH 5.15.y 5.10.y 5.4.y 2/2] nvme-rdma: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:45:10 +0300
Message-ID: <20230813144510.15401-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813144510.15401-1-sagi@grimberg.me>
References: <20230813144510.15401-1-sagi@grimberg.me>
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
index 2db9c166a1b7..b76e1d4adcc7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -989,6 +989,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_start_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -997,6 +998,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -1038,7 +1040,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-- 
2.41.0

