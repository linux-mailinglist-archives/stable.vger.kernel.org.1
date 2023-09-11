Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19979B87B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbjIKWmz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbjIKPQt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:16:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E994EFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:16:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E84CC433C7;
        Mon, 11 Sep 2023 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445404;
        bh=XcTKGLAp+5dh+5pLKZRXbbiz/rpnpH0ZbWMmUz00J0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKK5rV7eB2H+79I5Yns+0nbz8s5cZuBV7Fvg78kWsKO81DbxgpHYSElO35pOhnm4v
         7Z2ku8lKoW0uEWQZUyuXd+rLgZalpFdCz0sLBJq+iDZi0/Ll5HVWdBSjCxrIVD11ZC
         QMh+4il/0EUEEj2x1tAPxax/YJoYbQpGfU4DtSZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 291/600] drm: xlnx: zynqmp_dpsub: Add missing check for dma_set_mask
Date:   Mon, 11 Sep 2023 15:45:24 +0200
Message-ID: <20230911134642.197965232@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 1de2d927c32b0..fcaa958d841c9 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -201,7 +201,9 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
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



