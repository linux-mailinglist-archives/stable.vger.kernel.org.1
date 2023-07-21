Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C723075BD6F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 06:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGUEiW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 00:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjGUEhs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 00:37:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2815730F1
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 21:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D5C610A0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 04:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB29C433C8;
        Fri, 21 Jul 2023 04:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689914235;
        bh=WRKsmOR8DzqjNB6HCz2ZVS7/BJpOIK8PnJgCHApm65A=;
        h=Subject:To:Cc:From:Date:From;
        b=pZXHm9ZMgZLlzifUXkgXL1xenGIakBnaF2Nm5HfhopOY8uEIQk6MTpTjFenAncxlB
         oRx46P7AK4WqM+q1csGton0lJTwT6mpjKkturfQQFUZxmSwkZHjkVn1+6TH7byud/X
         0ZFZkFyolATm2x67p4juA4hmaya1aArPa7NIUjPE=
Subject: FAILED: patch "[PATCH] i2c: nomadik: Remove a useless call in the remove function" failed to apply to 5.10-stable tree
To:     christophe.jaillet@wanadoo.fr, andi.shyti@kernel.org,
        linus.walleij@linaro.org, stable@vger.kernel.org, wsa@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 06:36:56 +0200
Message-ID: <2023072156-surrender-undergrad-b32e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 05f933d5f7318b03ff2028c1704dc867ac16f2c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072156-surrender-undergrad-b32e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

05f933d5f731 ("i2c: nomadik: Remove a useless call in the remove function")
9c7174db4cdd ("i2c: nomadik: Use devm_clk_get_enabled()")
1c5d33fff0d3 ("i2c: nomadik: Remove unnecessary goto label")
06e989578232 ("i2c: Improve size determinations")
6b3b21a8542f ("i2c: Delete error messages for failed memory allocations")
3fd269e74f2f ("amba: Make the remove callback return void")
5b495ac8fe03 ("vfio: platform: simplify device removal")
de5d7adb8936 ("amba: Fix resource leak for drivers without .remove")
45fe7befe0db ("coresight: remove broken __exit annotations")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05f933d5f7318b03ff2028c1704dc867ac16f2c7 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 4 Jul 2023 21:50:28 +0200
Subject: [PATCH] i2c: nomadik: Remove a useless call in the remove function

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
 	clear_all_interrupts(dev);
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
-	release_mem_region(res->start, resource_size(res));
 }
 
 static struct i2c_vendor_data vendor_stn8815 = {

