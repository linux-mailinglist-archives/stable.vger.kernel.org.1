Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE66FA790
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjEHKcM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjEHKbu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FBE32913
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B4E6626E0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E58C433EF;
        Mon,  8 May 2023 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541885;
        bh=RpvIW+Ft0dC7DEmCAfNsCksIyZQLKRaSClsheU1onvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2M2wUn8fq6u7DPU+qZDXQ5Snzl75oprlxPX/b7wTmc7u5iCQxRwOVL6Vd+map790g
         nxLEkZ/1fAwFDwxEYwPxbA9v6VRBBiq3+4MDHExndT3ps+bFdyB4Iy2EJ34IW3Rjqp
         b8Ud6jeZhxbZxyEPDgu4yqO7AnuYNvM3xyQXflk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miaoqian Lin <linmq006@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 259/663] media: rcar_fdp1: Fix refcount leak in probe and remove function
Date:   Mon,  8 May 2023 11:41:25 +0200
Message-Id: <20230508094436.653621688@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit c766c90faf93897b77c9c5daa603cffab85ba907 ]

rcar_fcp_get() take reference, which should be balanced with
rcar_fcp_put(). Add missing rcar_fcp_put() in fdp1_remove and
the error paths of fdp1_probe() to fix this.

Fixes: 4710b752e029 ("[media] v4l: Add Renesas R-Car FDP1 Driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[hverkuil: resolve merge conflict, remove() is now void]
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/renesas/rcar_fdp1.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_fdp1.c b/drivers/media/platform/renesas/rcar_fdp1.c
index d80b3214dfae1..c548cb01957b0 100644
--- a/drivers/media/platform/renesas/rcar_fdp1.c
+++ b/drivers/media/platform/renesas/rcar_fdp1.c
@@ -2313,8 +2313,10 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	/* Determine our clock rate */
 	clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto put_dev;
+	}
 
 	fdp1->clk_rate = clk_get_rate(clk);
 	clk_put(clk);
@@ -2323,7 +2325,7 @@ static int fdp1_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(&pdev->dev, &fdp1->v4l2_dev);
 	if (ret) {
 		v4l2_err(&fdp1->v4l2_dev, "Failed to register video device\n");
-		return ret;
+		goto put_dev;
 	}
 
 	/* M2M registration */
@@ -2393,6 +2395,8 @@ static int fdp1_probe(struct platform_device *pdev)
 unreg_dev:
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 
+put_dev:
+	rcar_fcp_put(fdp1->fcp);
 	return ret;
 }
 
@@ -2404,6 +2408,7 @@ static void fdp1_remove(struct platform_device *pdev)
 	video_unregister_device(&fdp1->vfd);
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 	pm_runtime_disable(&pdev->dev);
+	rcar_fcp_put(fdp1->fcp);
 }
 
 static int __maybe_unused fdp1_pm_runtime_suspend(struct device *dev)
-- 
2.39.2



