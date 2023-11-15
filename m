Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40967ECBFA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjKOTZv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjKOTZf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7063F1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E42C433C8;
        Wed, 15 Nov 2023 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076332;
        bh=2OYHN4cpgIzJZeCryhP612pvUgB5xh7eeZPfpuCd82g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/dix27WyXSchZA1MrbUzpL3NvTHnzQoTg32bnUNaLaC2cKYRMaAWiuzAzpg+w4u+
         gotDHd0fwyLcjlLkbyqM8IRr3Mjwqo1Vej3J5XRp/Rdk9vAYYUl1ZhZH5pTXDHf2v3
         eSCHoGkh8snoB9k3GfDA4MekJjAOJaIXvTXTOQio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhu Wang <wangzhu9@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 199/550] spi: omap2-mcspi: remove redundant dev_err_probe()
Date:   Wed, 15 Nov 2023 14:13:03 -0500
Message-ID: <20231115191614.564630996@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhu Wang <wangzhu9@huawei.com>

[ Upstream commit 142c61a5fddeb755c420cb2e23b4bc0c0901308f ]

When platform_get_irq() is called, the error message has been printed,
so it need not to call dev_err_probe() to print error, we remove the
redundant platform_get_irq().

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Link: https://lore.kernel.org/r/20230801135442.255604-1-wangzhu9@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 2d9f4877988f ("spi: omap2-mcspi: Fix hardcoded reference clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 8331e247bf5ca..e5cd82eb9e549 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1508,10 +1508,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	status = platform_get_irq(pdev, 0);
-	if (status < 0) {
-		dev_err_probe(&pdev->dev, status, "no irq resource found\n");
+	if (status < 0)
 		goto free_master;
-	}
 	init_completion(&mcspi->txdone);
 	status = devm_request_irq(&pdev->dev, status,
 				  omap2_mcspi_irq_handler, 0, pdev->name,
-- 
2.42.0



