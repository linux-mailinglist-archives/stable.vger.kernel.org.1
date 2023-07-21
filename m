Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7CB75D0D9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGURsL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGURsK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 13:48:10 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6335A30D4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 10:48:09 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MuEYqDog9Y7buMuEYq9QbO; Fri, 21 Jul 2023 19:48:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689961687;
        bh=+pEii1WNlWZ6XxWFToAW+yUf1RCHobmEFEIKPXxlfd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZoMEj8bHyyvuFnwnU2ChvVsxZ5sLt7fl69U1ZA00nRpxij6k/WmtEdWLWYYzpkGw2
         2+fg+jt7aoCC6kofJkHRS0VXLCRRCtoqd3/wU25TSwTK4VsIwqH1YdL/F3lyb31C13
         lT8T6XZi5ZVy1GMUSL3QqLWRMKwYIIMtjxCKt8SGwfGKWSS8kc1gp8fjzyxDLYJ1FJ
         IGx9xtqoeOniRsXnPM5YwhRZzMmv96Xji5dcvZpn1dUdy7GTCXKAR2ZTBq3zN3+Zdl
         +DglszP7NgL+gt2GvDxmzlPa0gXD3Q+LWgaiZZtDeLK8nStZmDpyDArYtO9sX+TY2g
         FpexEMy9VTN7Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Jul 2023 19:48:07 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.4.y] i2c: busses: i2c-nomadik: Remove a useless call in the remove function
Date:   Fri, 21 Jul 2023 19:47:41 +0200
Message-Id: <62fe6800d41e04a4eb5adfa18a9e1090cbc72256.1688160163.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023072154-animal-dropkick-6a92@gregkh>
References: <2023072154-animal-dropkick-6a92@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Since commit 235602146ec9 ("i2c-nomadik: turn the platform driver to an amba
driver"), there is no more request_mem_region() call in this driver.

So remove the release_mem_region() call from the remove function which is
likely a left over.

Fixes: 235602146ec9 ("i2c-nomadik: turn the platform driver to an amba driver")
Cc: <stable@vger.kernel.org> # v3.6+
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The patch below that should fix a merge conflict related to commit
9c7174db4cdd1 ("i2c: nomadik: Use devm_clk_get_enabled()") has been 
HAND MODIFIED.

I hope it is fine, but is provided as-is. Especially line numbers should be
wrong, but 'patch' should be able to deal with it. (sorry if it does not apply)

I guess that it should also apply to all previous branches.

I've left the commit description as it was. Not sure what to do with A-b and R-b
tags.
---
 drivers/i2c/busses/i2c-nomadik.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 1e5fd23ef45c..212f412f1c74 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1038,7 +1038,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 static void nmk_i2c_remove(struct amba_device *adev)
 {
-	struct resource *res = &adev->res;
 	struct nmk_i2c_dev *dev = amba_get_drvdata(adev);
 
 	i2c_del_adapter(&dev->adap);
@@ -1047,7 +1046,6 @@ static void nmk_i2c_remove(struct amba_device *adev)
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
 	clk_disable_unprepare(dev->clk);
-	release_mem_region(res->start, resource_size(res));
 }
 
 static struct i2c_vendor_data vendor_stn8815 = {
-- 
2.34.1

