Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6AF78321C
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjHUUFE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjHUUFD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:05:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C472A8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4FF648FA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A2EC433C8;
        Mon, 21 Aug 2023 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648301;
        bh=Jbt2T6KoxiVbkUDt2iIRta1b8VX2wnBp0If+XSIOZ/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGhoRFWfKOT2xS0bIKsRpe6rI6bWTri+FTmTKWlzBmfdNptfjbbAwXl9Jj9/+evoP
         QP0q/9Zt2NLZWN2u9X1Nk/JbjKoysLLN4fnbsSDSYnvJwA8HSyvxtlwUTvZ94pnEzD
         tto3vN5FSW1qTZkWM+xwoMB49tzUlJu8VyYkzQns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 6.4 098/234] media: mtk-jpeg: Set platform driver data earlier
Date:   Mon, 21 Aug 2023 21:41:01 +0200
Message-ID: <20230821194133.142695813@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chen-Yu Tsai <wenst@chromium.org>

commit 8329d0c7355bfb7237baf09ec979c3e8144d2781 upstream.

In the multi-core JPEG encoder/decoder setup, the driver for the
individual cores references the parent device's platform driver data.
However, in the parent driver, this is only set at the end of the probe
function, way later than devm_of_platform_populate(), which triggers
the probe of the cores. This causes a kernel splat in the sub-device
probe function.

Move platform_set_drvdata() to before devm_of_platform_populate() to
fix this.

Fixes: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1310,6 +1310,8 @@ static int mtk_jpeg_probe(struct platfor
 	jpeg->dev = &pdev->dev;
 	jpeg->variant = of_device_get_match_data(jpeg->dev);
 
+	platform_set_drvdata(pdev, jpeg);
+
 	ret = devm_of_platform_populate(&pdev->dev);
 	if (ret) {
 		v4l2_err(&jpeg->v4l2_dev, "Master of platform populate failed.");
@@ -1381,8 +1383,6 @@ static int mtk_jpeg_probe(struct platfor
 		  jpeg->variant->dev_name, jpeg->vdev->num,
 		  VIDEO_MAJOR, jpeg->vdev->minor);
 
-	platform_set_drvdata(pdev, jpeg);
-
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;


