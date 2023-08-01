Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2741076ADD2
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHAJdv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjHAJdV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE084C35
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1933361509
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237C1C433C8;
        Tue,  1 Aug 2023 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882281;
        bh=t7rHmNfJi8Xzf8k1L0tqxO6xhIyurqe/8uqRDwpI+zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRjdXJCNj+MaQtWYakXP0DjMvc7vw0NPm8+CthHl2Ajvn7MozcvdmvDygMoz4cz+B
         J+spHScBi9BpMVfJWrDNpqMLa9lw/IxJEJUMhk3o6fGyoImgpc9ruhGqkE60fe8I0g
         bMxbg3u9JrMRKcjDNjVZYj7iBaJZMLSPP77QhJvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andi Shyti <andi.shyti@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/228] i2c: nomadik: Remove unnecessary goto label
Date:   Tue,  1 Aug 2023 11:18:00 +0200
Message-ID: <20230801091923.662033496@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andi Shyti <andi.shyti@kernel.org>

[ Upstream commit 1c5d33fff0d375e4ab7c4261dc62a286babbb4c6 ]

The err_no_mem goto label doesn't do anything. Remove it.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 05f933d5f731 ("i2c: nomadik: Remove a useless call in the remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 5004b9dd98563..8b9577318388e 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -971,10 +971,9 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
 	dev = devm_kzalloc(&adev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto err_no_mem;
-	}
+	if (!dev)
+		return -ENOMEM;
+
 	dev->vendor = vendor;
 	dev->adev = adev;
 	nmk_i2c_of_probe(np, dev);
@@ -995,30 +994,27 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
 				resource_size(&adev->res));
-	if (!dev->virtbase) {
-		ret = -ENOMEM;
-		goto err_no_mem;
-	}
+	if (!dev->virtbase)
+		return -ENOMEM;
 
 	dev->irq = adev->irq[0];
 	ret = devm_request_irq(&adev->dev, dev->irq, i2c_irq_handler, 0,
 				DRIVER_NAME, dev);
 	if (ret) {
 		dev_err(&adev->dev, "cannot claim the irq %d\n", dev->irq);
-		goto err_no_mem;
+		return ret;
 	}
 
 	dev->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		dev_err(&adev->dev, "could not get i2c clock\n");
-		ret = PTR_ERR(dev->clk);
-		goto err_no_mem;
+		return PTR_ERR(dev->clk);
 	}
 
 	ret = clk_prepare_enable(dev->clk);
 	if (ret) {
 		dev_err(&adev->dev, "can't prepare_enable clock\n");
-		goto err_no_mem;
+		return ret;
 	}
 
 	init_hw(dev);
@@ -1049,7 +1045,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
  err_no_adap:
 	clk_disable_unprepare(dev->clk);
- err_no_mem:
 
 	return ret;
 }
-- 
2.39.2



