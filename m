Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A6755665
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjGPUuH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGPUuG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E768AD9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F38860EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E120C433C7;
        Sun, 16 Jul 2023 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540604;
        bh=hDpL2A7ocdiTfNxc9l3GHz7iVW4RnqulqfgJ/1KS4Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXjUcPA93nW+rWHgl+JzNyTALHotuWPR/dGhuEtUhsDAvjm3nX6Ya4sBmHG1FkYNK
         LpC2mffKG2gq7YMYariFB363E9gQjIUy3zj6sgl7U4FoSvIbqOCsUqejhNnIvPZvu/
         FEhB8tnC+/t55DCdCP4FqwVB88jF4XWyWDdipgdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Clark Wang <xiaoning.wang@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 422/591] i3c: master: svc: fix cpu schedule in spin lock
Date:   Sun, 16 Jul 2023 21:49:21 +0200
Message-ID: <20230716194934.833584091@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

[ Upstream commit 33beadb3b1ab74e69db2c49d9663f3a93a273943 ]

pm_runtime_resume_and_get() may call sleep(). It cannot be used in
svc_i3c_master_start_xfer_locked(), because it is in a spin lock.

Move the pm runtime operations to svc_i3c_master_enqueue_xfer().

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Fixes: 05be23ef78f7 ("i3c: master: svc: add runtime pm support")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20230517033030.3068085-2-xiaoning.wang@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/svc-i3c-master.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6e9ed74cdcf4..d47360f8a1f36 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1090,12 +1090,6 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	if (!xfer)
 		return;
 
-	ret = pm_runtime_resume_and_get(master->dev);
-	if (ret < 0) {
-		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
-		return;
-	}
-
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1110,9 +1104,6 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 			break;
 	}
 
-	pm_runtime_mark_last_busy(master->dev);
-	pm_runtime_put_autosuspend(master->dev);
-
 	xfer->ret = ret;
 	complete(&xfer->comp);
 
@@ -1133,6 +1124,13 @@ static void svc_i3c_master_enqueue_xfer(struct svc_i3c_master *master,
 					struct svc_i3c_xfer *xfer)
 {
 	unsigned long flags;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return;
+	}
 
 	init_completion(&xfer->comp);
 	spin_lock_irqsave(&master->xferqueue.lock, flags);
@@ -1143,6 +1141,9 @@ static void svc_i3c_master_enqueue_xfer(struct svc_i3c_master *master,
 		svc_i3c_master_start_xfer_locked(master);
 	}
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 }
 
 static bool
-- 
2.39.2



