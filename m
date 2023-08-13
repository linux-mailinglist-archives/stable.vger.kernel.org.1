Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2577A705
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHMOpF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjHMOpE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:45:04 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBAC10FD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:45:05 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99bded9d93dso81022966b.1
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937903; x=1692542703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=;
        b=Exj/A5y/byUp+Hu0AI3VRrqRx8pIiuFryY+BW4gXOUdJBzSg/myA7EKYNdzRe6coh+
         09s4rSny8+mOAyjOJ09ox3S7Oick6vgv+/W+pQney9FUipLJWDJoGELdvxSNjUMBq1r/
         ErAXSWGrt5nWb/Fvrff3rV9RD/SPZX1mMAuqJJgvVc4sWpKZ5KUcUgPYeT8kh0KVQd7N
         mOqQ2B6JEB+3OmVLLnV4qrFqwnXDFAMAKKQQM45JjkG4CPOIiwu94rzG3GTVmo/pV3kG
         cCf8iiE8eL9FYRZ7kF0j9LRzVNfXFpW7pVN1B1fLcn7lqoYTd8+TE+sTRbwgyxdM4ClA
         RiPQ==
X-Gm-Message-State: AOJu0YxpQTz7IBln9o5uf3zxL9584DXOT5FOLydLaQ1vAFQyOMPXW7nd
        9cqeExgJT1MRKHaflg2j85hqMq+nDqY=
X-Google-Smtp-Source: AGHT+IGZM1qYkBktaWviYMhvhRd2I8b2PoUwBCntgMUqmL9huiI//X6jdvuIouNEpBOQZxmtPJQx8Q==
X-Received: by 2002:a17:906:19:b0:993:d0e1:f308 with SMTP id 25-20020a170906001900b00993d0e1f308mr5254691eja.2.1691937902935;
        Sun, 13 Aug 2023 07:45:02 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906110b00b00977cad140a8sm4618761eja.218.2023.08.13.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:45:02 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     <stable@vger.kernel.org>
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH 6.1.y 1/2] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:44:59 +0300
Message-ID: <20230813144500.15339-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
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

