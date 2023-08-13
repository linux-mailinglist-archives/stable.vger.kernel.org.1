Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB3C77A6ED
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHMO3i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMO3h (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 10:29:37 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28DB10FC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:29:38 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5230963f636so1046358a12.0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 07:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936977; x=1692541777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUuuKbL8ydFNPda8N4HOTsW5STdP9ERZYuHURXlNIxg=;
        b=era47y43+H3gYPFi6VAVhB9ISdJ/iVJXGMCFsmpoh4D9rwBceGv7kEi/T+dL/9Zla5
         qzze2trFZ2ZqthlLAkKYbLw8Fq1+quHuABYaS47YwVfT7h7JAUgKdifLvPXY51MYzHEo
         QVp9C2sB9s0zwUiWJ6fRf9gT+nZigZa5ijk6Rnb0QnT/IBNd/MmcDvp8C5mnhS8D1+/v
         /6/YTrqDbKNWzbEdoc/zq6WfEyQyTjDhijiASxYkpZPVilvL2qdxuph0jJwSgs8DnTTa
         NJxsWQpdSpyBFBF8ZeFtdfPIV6+J7hEurBug9N6LfWrR3Wj2BEvC4unkWfBiADVcZsbv
         a6vg==
X-Gm-Message-State: AOJu0Ywv7BUKZ8dKvNE0CpyPNboes9obLPL/CnOqnGzbMJ5XTUEc5jOm
        cPLSwMGHsiu3hXK2a2ppC5CsRsf77Jg=
X-Google-Smtp-Source: AGHT+IEoYQjkNlZYlXMUTBn2A9gDQCzE4R8WIEaAngEv0BnC8sjVzTMCgl5Jcg54IZMgmkcX1IN0PQ==
X-Received: by 2002:a17:906:7390:b0:994:539d:f98b with SMTP id f16-20020a170906739000b00994539df98bmr5049869ejl.6.1691936976697;
        Sun, 13 Aug 2023 07:29:36 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170906a0cc00b009888aa1da11sm4625225ejb.188.2023.08.13.07.29.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:29:36 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     stable@vger.kernel.org
Subject: [PATCH 6.1.y] nvme-tcp: fix potential unbalanced freeze & unfreeze
Date:   Sun, 13 Aug 2023 17:29:34 +0300
Message-ID: <20230813142934.12311-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081225-impotence-uncurious-0ad9@gregkh>
References: <2023081225-impotence-uncurious-0ad9@gregkh>
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

