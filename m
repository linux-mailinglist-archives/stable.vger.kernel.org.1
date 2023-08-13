Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0197B77A6EF
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjHMObu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMObu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:31:50 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FC910FC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:31:52 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99bd67facffso81106866b.0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937110; x=1692541910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=;
        b=ZMtaCIUDIGiGELYv6fk4WnLtNi0lQmqrm6j00wr2CEL7Hdiugoim0yCav7eJCDJowm
         gj8U6bvbYJ+lmwgCZN7NHTXEsJRgrCPsrZLwN7NDcwxuJFnsNgoappa8tvJoLWIHskq4
         Xw4upkGoCiKRmvOR9yV23IaMR9Q0FA1L+ayHrAgkGVKDcMxin6SF1XDU/otWcmutMQEH
         /zlGC5V3uzFTWOm00/jQdH6DxvkO6Bo1+A2I+TjqtHRhs0KYth3Pu04hA86Fqqft0j9W
         4A5VU3hJvRSpJxpxVAA049qd5mLtv8Q20g6GJelRl+LBErzWZNISmU/T1BS7V8ZD0xD8
         IAhw==
X-Gm-Message-State: AOJu0Yzkyuw27HlSOlMU5Ebi9hXGiCtSz1AECFnD10zpSsMDux+VlL9f
        09+5Jl6NTA2ewMibmEf+lO0PJ6tD4vo=
X-Google-Smtp-Source: AGHT+IF7AyJqz3aIfRpSbZ9xLZ1M+kSDJRrU7dv6kXD6bIh27hcxdNqbXzo9iNEUYDD7slY/fB5r4Q==
X-Received: by 2002:a17:906:74d9:b0:99c:adfb:713 with SMTP id z25-20020a17090674d900b0099cadfb0713mr5140735ejl.5.1691937110413;
        Sun, 13 Aug 2023 07:31:50 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id pj18-20020a170906d79200b009932337747esm4612773ejb.86.2023.08.13.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:31:49 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     stable@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org
Subject: [PATCH 5.10.y] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:31:48 +0300
Message-ID: <20230813143148.12471-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081227-freeing-squeak-4a28@gregkh>
References: <2023081227-freeing-squeak-4a28@gregkh>
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

