Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3BE6FAB05
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjEHLIo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjEHLIM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F630E42
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E008862AF8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4180C433D2;
        Mon,  8 May 2023 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544089;
        bh=A/G/qIIkVXdZxnyHqJNtSfAfP5uBuVotfaZ4wm5O3TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrKWkzjsWGIU0JWYYpW9Jn7xsmue8tp7b2W3SJD0Z0BaN7pGpfM/XUiP1rHSnUKfw
         cyti6gfFhrDVYKOhPDvYmd4XDu2NOA5ozHFbDyQJ5jnQJ7hAf5AdawXmfYyTLQTH5I
         LQ9EGr+Wr0S85fDbgBa19NO94e1Xup3iUEh1Kk+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 298/694] media: rcar_fdp1: Convert to platform remove callback returning void
Date:   Mon,  8 May 2023 11:42:13 +0200
Message-Id: <20230508094441.948536388@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 0e82d3715fd208de567b8e4307fbf91ae5e57db4 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: c766c90faf93 ("media: rcar_fdp1: Fix refcount leak in probe and remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/renesas/rcar_fdp1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_fdp1.c b/drivers/media/platform/renesas/rcar_fdp1.c
index 37ecf489d112e..d80b3214dfae1 100644
--- a/drivers/media/platform/renesas/rcar_fdp1.c
+++ b/drivers/media/platform/renesas/rcar_fdp1.c
@@ -2396,7 +2396,7 @@ static int fdp1_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int fdp1_remove(struct platform_device *pdev)
+static void fdp1_remove(struct platform_device *pdev)
 {
 	struct fdp1_dev *fdp1 = platform_get_drvdata(pdev);
 
@@ -2404,8 +2404,6 @@ static int fdp1_remove(struct platform_device *pdev)
 	video_unregister_device(&fdp1->vfd);
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused fdp1_pm_runtime_suspend(struct device *dev)
@@ -2441,7 +2439,7 @@ MODULE_DEVICE_TABLE(of, fdp1_dt_ids);
 
 static struct platform_driver fdp1_pdrv = {
 	.probe		= fdp1_probe,
-	.remove		= fdp1_remove,
+	.remove_new	= fdp1_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = fdp1_dt_ids,
-- 
2.39.2



