Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB77A3BDD
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbjIQUX3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbjIQUW5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:22:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBBF18D
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:22:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E283C433C8;
        Sun, 17 Sep 2023 20:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982167;
        bh=I+k5n8m7NGd3mfSo+6Qh7w2JywNZ9GDrCkrq7X8KYUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJKxXHyyqcalhxQmVHZg70d5vA347ElEqI1UDDB06++ih3bTSNyOi6lu8ZypWAAbH
         +3xp855m6fVtlKs4EV6rWpuXhJz2UMNWVOmUBr+3VjmykFzudqJPVDnV+KgZgSZron
         2V+n2GuTotjmkgiEVBZeQ9nx6Cl9YBQiCvpt7mWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 172/511] drm: xlnx: zynqmp_dpsub: Add missing check for dma_set_mask
Date:   Sun, 17 Sep 2023 21:09:59 +0200
Message-ID: <20230917191117.989255085@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 1832fba7f9780aff67c96ad30f397c2d76141833 ]

Add check for dma_set_mask() and return the error if it fails.

Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index ac37053412a13..5bb42d0a2de98 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -200,7 +200,9 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	dpsub->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dpsub);
 
-	dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
+	ret = dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
+	if (ret)
+		return ret;
 
 	/* Try the reserved memory. Proceed if there's none. */
 	of_reserved_mem_device_init(&pdev->dev);
-- 
2.40.1



