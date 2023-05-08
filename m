Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AC86FADCF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjEHLik (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbjEHLiG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECA411AC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 335D163371
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477EFC4339B;
        Mon,  8 May 2023 11:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545815;
        bh=UAYDq2d8QCp4887q7fg9uozIF1oDeXULnMyW1/2JJhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M64iSERdTPlMxqBUbQhzeZY32hAzzqLR3r36uWSTzDrmGdAa1VIrbGxx4ClJwbXbt
         gBsxjAc6Sgdu5pm1Ed28rw6GLU21ronF869ZopTSwjockkEKQBo0qjCTmbKN3DIL8c
         ibe7Jq5tPF6UZhoifplOmLcnSeb8NJK8OFXt2T68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cai Huoqing <caihuoqing@baidu.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 134/371] media: rcar_fdp1: Make use of the helper function devm_platform_ioremap_resource()
Date:   Mon,  8 May 2023 11:45:35 +0200
Message-Id: <20230508094817.355254100@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Cai Huoqing <caihuoqing@baidu.com>

[ Upstream commit 736cce12fa630e28705de06570d74f0513d948d5 ]

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: c766c90faf93 ("media: rcar_fdp1: Fix refcount leak in probe and remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_fdp1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index 89aac60066d91..19de3c19bcca2 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -2256,7 +2256,6 @@ static int fdp1_probe(struct platform_device *pdev)
 	struct fdp1_dev *fdp1;
 	struct video_device *vfd;
 	struct device_node *fcp_node;
-	struct resource *res;
 	struct clk *clk;
 	unsigned int i;
 
@@ -2283,8 +2282,7 @@ static int fdp1_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fdp1);
 
 	/* Memory-mapped registers */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fdp1->regs = devm_ioremap_resource(&pdev->dev, res);
+	fdp1->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fdp1->regs))
 		return PTR_ERR(fdp1->regs);
 
-- 
2.39.2



