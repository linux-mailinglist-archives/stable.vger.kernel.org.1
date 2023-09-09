Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA7799B82
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbjIIVyR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIIVyR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 17:54:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72004BB
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 14:54:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4E6C433C9;
        Sat,  9 Sep 2023 21:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694296453;
        bh=kA5wmucvdvQeGdfFOAjkz8EYwQulAk+w89rdIln6YXI=;
        h=Subject:To:Cc:From:Date:From;
        b=0pG3jQmnPn5bqxOXJUM8FUSR+SA9mIQc+hzi2RnmdZurj+EfJeQ7haaAaEx/BvKWs
         jIMjkusEMre7uBlxEtNKlxRPC93kFz4Mv94of//IUPzHOSPm3AWP1oSqnSji/kn7bg
         3qVZLI8XjHTI5K+z0wDjAfNgpPSgNlgqI3Vm7w90=
Subject: FAILED: patch "[PATCH] regulator: raa215300: Fix resource leak in case of error" failed to apply to 6.5-stable tree
To:     biju.das.jz@bp.renesas.com, broonie@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 22:54:10 +0100
Message-ID: <2023090910-area-consoling-132c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x e21ac64e669e960688e79bf5babeed63132dac8a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090910-area-consoling-132c@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

e21ac64e669e ("regulator: raa215300: Fix resource leak in case of error")
42a95739c5bc ("regulator: raa215300: Change the scope of the variables {clkin_name, xin_name}")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e21ac64e669e960688e79bf5babeed63132dac8a Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Wed, 16 Aug 2023 14:55:49 +0100
Subject: [PATCH] regulator: raa215300: Fix resource leak in case of error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The clk_register_clkdev() allocates memory by calling vclkdev_alloc() and
this memory is not freed in the error path. Similarly, resources allocated
by clk_register_fixed_rate() are not freed in the error path.

Fix these issues by using devm_clk_hw_register_fixed_rate() and
devm_clk_hw_register_clkdev().

After this, the static variable clk is not needed. Replace it with 
local variable hw in probe() and drop calling clk_unregister_fixed_rate()
from raa215300_rtc_unregister_device().

Fixes: 7bce16630837 ("regulator: Add Renesas PMIC RAA215300 driver")
Cc: stable@kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230816135550.146657-2-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/regulator/raa215300.c b/drivers/regulator/raa215300.c
index 848a03a2fbd4..898f53cac02c 100644
--- a/drivers/regulator/raa215300.c
+++ b/drivers/regulator/raa215300.c
@@ -38,8 +38,6 @@
 #define RAA215300_REG_BLOCK_EN_RTC_EN	BIT(6)
 #define RAA215300_RTC_DEFAULT_ADDR	0x6f
 
-static struct clk *clk;
-
 static const struct regmap_config raa215300_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -49,10 +47,6 @@ static const struct regmap_config raa215300_regmap_config = {
 static void raa215300_rtc_unregister_device(void *data)
 {
 	i2c_unregister_device(data);
-	if (!clk) {
-		clk_unregister_fixed_rate(clk);
-		clk = NULL;
-	}
 }
 
 static int raa215300_clk_present(struct i2c_client *client, const char *name)
@@ -130,10 +124,16 @@ static int raa215300_i2c_probe(struct i2c_client *client)
 		u32 addr = RAA215300_RTC_DEFAULT_ADDR;
 		struct i2c_board_info info = {};
 		struct i2c_client *rtc_client;
+		struct clk_hw *hw;
 		ssize_t size;
 
-		clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 32000);
-		clk_register_clkdev(clk, clk_name, NULL);
+		hw = devm_clk_hw_register_fixed_rate(dev, clk_name, NULL, 0, 32000);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		ret = devm_clk_hw_register_clkdev(dev, hw, clk_name, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to initialize clkdev\n");
 
 		if (np) {
 			int i;

