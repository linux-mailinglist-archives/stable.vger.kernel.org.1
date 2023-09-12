Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B679B039
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbjIKVLF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbjIKPJc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:09:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78334FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:09:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB31C433C8;
        Mon, 11 Sep 2023 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444968;
        bh=R3+gZK2MTaadtJXnNeHOEQZ21nJANvf6k0HyEYscSxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JN0ImLJWUc9orMpzkmv9knY4fGhVCvf+4c2TI5GVPSH7xJWDUkeFfDy9rRBQ/xJ9
         RprJ8ZtaPSBmEbQC7CJZZeO9qMaS0i7N5oGWpXr2ptd/9Qev0a9aGNtR1sVRGhq5vu
         QuQ68WNviGdh7yFegvcl6qZDPiigfm8xElEjh1t4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 181/600] hwrng: iproc-rng200 - Implement suspend and resume calls
Date:   Mon, 11 Sep 2023 15:43:34 +0200
Message-ID: <20230911134638.945483615@linuxfoundation.org>
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

From: Florian Fainelli <florian.fainelli@broadcom.com>

[ Upstream commit 8e03dd62e5be811efbf0cbeba47e79e793519105 ]

Chips such as BCM7278 support system wide suspend/resume which will
cause the HWRNG block to lose its state and reset to its power on reset
register values. We need to cleanup and re-initialize the HWRNG for it
to be functional coming out of a system suspend cycle.

Fixes: c3577f6100ca ("hwrng: iproc-rng200 - Add support for BCM7278")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/iproc-rng200.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
index 06bc060534d81..c0df053cbe4b2 100644
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -182,6 +182,8 @@ static int iproc_rng200_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 	}
 
+	dev_set_drvdata(dev, priv);
+
 	priv->rng.name = "iproc-rng200";
 	priv->rng.read = iproc_rng200_read;
 	priv->rng.init = iproc_rng200_init;
@@ -199,6 +201,28 @@ static int iproc_rng200_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused iproc_rng200_suspend(struct device *dev)
+{
+	struct iproc_rng200_dev *priv = dev_get_drvdata(dev);
+
+	iproc_rng200_cleanup(&priv->rng);
+
+	return 0;
+}
+
+static int __maybe_unused iproc_rng200_resume(struct device *dev)
+{
+	struct iproc_rng200_dev *priv =  dev_get_drvdata(dev);
+
+	iproc_rng200_init(&priv->rng);
+
+	return 0;
+}
+
+static const struct dev_pm_ops iproc_rng200_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(iproc_rng200_suspend, iproc_rng200_resume)
+};
+
 static const struct of_device_id iproc_rng200_of_match[] = {
 	{ .compatible = "brcm,bcm2711-rng200", },
 	{ .compatible = "brcm,bcm7211-rng200", },
@@ -212,6 +236,7 @@ static struct platform_driver iproc_rng200_driver = {
 	.driver = {
 		.name		= "iproc-rng200",
 		.of_match_table = iproc_rng200_of_match,
+		.pm		= &iproc_rng200_pm_ops,
 	},
 	.probe		= iproc_rng200_probe,
 };
-- 
2.40.1



