Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2FA7A7C7A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjITMBl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjITMBj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:01:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA050CE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:01:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3697C433C7;
        Wed, 20 Sep 2023 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211293;
        bh=iszfESyXn0hHc+j6u+207Rkxi1C/GmsHaLuaHCN4Pb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yp/c53XYzdrdhXuChkS+FazLjHMcwtxJlUAl7Muxxsr02XWfappqrI0iHpAYyxbMf
         4x+uaggeC1tcOwLyATj02LRwRceb2l+vZu8epmJbuk1D/59CMVAlZdW5o2cQjCUFFk
         ZP7yOsyJ0XPVbi5YOClbSxdaPmueKZBGb7Z7HYwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 039/186] spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()
Date:   Wed, 20 Sep 2023 13:29:02 +0200
Message-ID: <20230920112838.363636108@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 29a449e765ff70a5bd533be94babb6d36985d096 ]

The platform_get_irq might be failed and return a negative result. So
there should have an error handling code.

Fixed this by adding an error handling code.

Fixes: 8528547bcc33 ("spi: tegra: add spi driver for sflash controller")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Link: https://lore.kernel.org/r/tencent_71FC162D589E4788C2152AAC84CD8D5C6D06@qq.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra20-sflash.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 749288310c36c..2989795272a16 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -469,7 +469,11 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
-	tsd->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto exit_free_master;
+	tsd->irq = ret;
+
 	ret = request_irq(tsd->irq, tegra_sflash_isr, 0,
 			dev_name(&pdev->dev), tsd);
 	if (ret < 0) {
-- 
2.40.1



