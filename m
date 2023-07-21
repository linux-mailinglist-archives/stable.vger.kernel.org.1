Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6108575BD72
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 06:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGUEiu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 00:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjGUEiX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 00:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FE2D45
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 21:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FE86112C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 04:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A852FC433C7;
        Fri, 21 Jul 2023 04:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689914244;
        bh=beZZC7kVVvLcM2lYKPFcYsSryOzxT0WjZr94RjYNfg4=;
        h=Subject:To:Cc:From:Date:From;
        b=jg8pZak6Cq+Wgh3WTgvN90Wp5qlpovvx/G5n7Bp+trVCRnf3b/dBYx5Yy3k+MGFoa
         jMKGR6xYnEefd6zwleusRIBjLV2MxhbXoqZLIwsSd+1rFBd3TVLFBPudcIQgpCJddz
         oNBz7og494X/CufQrj9wvrjM9C/TH82M7AJg1H0Q=
Subject: FAILED: patch "[PATCH] i2c: nomadik: Remove a useless call in the remove function" failed to apply to 4.14-stable tree
To:     christophe.jaillet@wanadoo.fr, andi.shyti@kernel.org,
        linus.walleij@linaro.org, stable@vger.kernel.org, wsa@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 06:36:59 +0200
Message-ID: <2023072159-contour-busily-038e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 05f933d5f7318b03ff2028c1704dc867ac16f2c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072159-contour-busily-038e@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

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
726eb70e0d34 ("Merge tag 'char-misc-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")

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

