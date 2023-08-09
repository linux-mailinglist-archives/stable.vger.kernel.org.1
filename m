Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B884775D2E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjHILed (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjHILeb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA18FE3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E92634A0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A650C433C8;
        Wed,  9 Aug 2023 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580869;
        bh=b5h4jhaQJWH1WW1TbPEQPjJCBQtkjrKehN9WmPRs9J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h369V2xWgbbeF/qwQKk6JXiyyOU/hk0bwchtM/ShsPbQQceMbzQ6/5D7Qjjga3scX
         aw4j9slYLUcFLb2Zx+C+e26ez7HeP/9xwPIn9iSt+5IqNf6BVdgPE5+x7rRrvVdCTh
         L97+jaDik/igSlCepLiJbSaehgDqXOfufsafCeCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andi Shyti <andi.shyti@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 009/201] i2c: nomadik: Use devm_clk_get_enabled()
Date:   Wed,  9 Aug 2023 12:40:11 +0200
Message-ID: <20230809103644.121605845@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andi Shyti <andi.shyti@kernel.org>

[ Upstream commit 9c7174db4cdd111e10d19eed5c36fd978a14c8a2 ]

Replace the pair of functions, devm_clk_get() and
clk_prepare_enable(), with a single function
devm_clk_get_enabled().

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 05f933d5f731 ("i2c: nomadik: Remove a useless call in the remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 03a08fa679bb4..344d1daa4ea06 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1005,18 +1005,12 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		return ret;
 	}
 
-	dev->clk = devm_clk_get(&adev->dev, NULL);
+	dev->clk = devm_clk_get_enabled(&adev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
-		dev_err(&adev->dev, "could not get i2c clock\n");
+		dev_err(&adev->dev, "could enable i2c clock\n");
 		return PTR_ERR(dev->clk);
 	}
 
-	ret = clk_prepare_enable(dev->clk);
-	if (ret) {
-		dev_err(&adev->dev, "can't prepare_enable clock\n");
-		return ret;
-	}
-
 	init_hw(dev);
 
 	adap = &dev->adap;
@@ -1037,16 +1031,11 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	ret = i2c_add_adapter(adap);
 	if (ret)
-		goto err_no_adap;
+		return ret;
 
 	pm_runtime_put(&adev->dev);
 
 	return 0;
-
- err_no_adap:
-	clk_disable_unprepare(dev->clk);
-
-	return ret;
 }
 
 static void nmk_i2c_remove(struct amba_device *adev)
@@ -1060,7 +1049,6 @@ static void nmk_i2c_remove(struct amba_device *adev)
 	clear_all_interrupts(dev);
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
-	clk_disable_unprepare(dev->clk);
 	release_mem_region(res->start, resource_size(res));
 }
 
-- 
2.39.2



