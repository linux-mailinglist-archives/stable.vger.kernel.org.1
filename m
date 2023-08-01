Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C938376AEF2
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjHAJnZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjHAJnM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41EB5FD0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 684FB614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7767FC433C7;
        Tue,  1 Aug 2023 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882851;
        bh=GYRMifDyhnXB1Cz/4bFT/SPKGdSY5r0YuvITARtiFZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bd4VlTu4Xz6ePENmKfdqrCI6SVf/7Brbjqr7be6kz3yMHdwBj2buW5n5mFmMiAo9A
         t0mkotICFXwA2lWU8m0HxMVr4vaqQAAhODz++t3NAgRs11pexAdpqn+OkX9eVracCC
         73/ae1iZ1GBTjGKgsKdgHLddz5L/DzUlSu3Y+2Nk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 025/239] i2c: nomadik: Remove a useless call in the remove function
Date:   Tue,  1 Aug 2023 11:18:09 +0200
Message-ID: <20230801091926.535865762@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 05f933d5f7318b03ff2028c1704dc867ac16f2c7 ]

Since commit 235602146ec9 ("i2c-nomadik: turn the platform driver to an amba
driver"), there is no more request_mem_region() call in this driver.

So remove the release_mem_region() call from the remove function which is
likely a left over.

Fixes: 235602146ec9 ("i2c-nomadik: turn the platform driver to an amba driver")
Cc: <stable@vger.kernel.org> # v3.6+
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 2141ba05dfece..9c5d66bd6dc1c 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1040,7 +1040,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 static void nmk_i2c_remove(struct amba_device *adev)
 {
-	struct resource *res = &adev->res;
 	struct nmk_i2c_dev *dev = amba_get_drvdata(adev);
 
 	i2c_del_adapter(&dev->adap);
@@ -1049,7 +1048,6 @@ static void nmk_i2c_remove(struct amba_device *adev)
 	clear_all_interrupts(dev);
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
-	release_mem_region(res->start, resource_size(res));
 }
 
 static struct i2c_vendor_data vendor_stn8815 = {
-- 
2.39.2



