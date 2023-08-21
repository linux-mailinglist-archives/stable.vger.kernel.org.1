Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05797830B3
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjHUTBU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHUTBT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333D535A0
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6FA163B36
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 18:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24E7C433C8;
        Mon, 21 Aug 2023 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692643847;
        bh=IfYWJxugv3t/t26QbkZA93BJb25wZGjH8tR/dNwpIQ4=;
        h=Subject:To:Cc:From:Date:From;
        b=X5BLfuIg7DaiEtgl0NBwFZ8k5UlT0Z2TtxjFlqtxppTq8oIXqzBJlqN0KtTH2naBx
         kMDbtUXlaAwjjurYQ8Qm8WzRhncHXhsKa/b3KV7xEMdwJ2EvgFlEXcpKauOv1RFApC
         o/oGrntPeTVFFfkm7Av7mLygTg081f7d8dXaaUlA=
Subject: FAILED: patch "[PATCH] net: phy: broadcom: stub c45 read/write for 54810" failed to apply to 4.14-stable tree
To:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 20:50:34 +0200
Message-ID: <2023082134-chain-tubular-c681@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 096516d092d54604d590827d05b1022c8f326639
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082134-chain-tubular-c681@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

096516d092d5 ("net: phy: broadcom: stub c45 read/write for 54810")
5a32fcdb1e68 ("net: phy: broadcom: Add statistics for all Gigabit PHYs")
1e2e61af1996 ("net: phy: broadcom: remove BCM5482 1000Base-BX support")
15772e4ddf3f ("net: phy: broadcom: remove use of ack_interrupt()")
4567d5c3eb9b ("net: phy: broadcom: implement generic .handle_interrupt() callback")
b0ed0bbfb304 ("net: phy: broadcom: add support for BCM54811 PHY")
9d42205036d4 ("net: phy: bcm54140: Make a bunch of functions static")
6937602ed3f9 ("net: phy: add Broadcom BCM54140 support")
123aff2a789c ("net: phy: broadcom: Add support for BCM53125 internal PHYs")
fe26821fa614 ("net: phy: broadcom: Wire suspend/resume for BCM54810")
0ececcfc9267 ("net: phy: broadcom: Allow BCM54810 to use bcm54xx_adjust_rxrefclk()")
75f4d8d10e01 ("net: phy: add Broadcom BCM84881 PHY driver")
b9bcb95315fe ("net: phy: broadcom: add 1000Base-X support for BCM54616S")
283da99af1d8 ("net: phy: broadcom: Add genphy_suspend and genphy_resume for BCM5464")
dcdecdcfe1fc ("net: phy: switch drivers to use dynamic feature detection")
5c3407abb338 ("net: phy: meson-gxl: add g12a support")
356d71e00d27 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 096516d092d54604d590827d05b1022c8f326639 Mon Sep 17 00:00:00 2001
From: Justin Chen <justin.chen@broadcom.com>
Date: Sat, 12 Aug 2023 21:41:47 -0700
Subject: [PATCH] net: phy: broadcom: stub c45 read/write for 54810

The 54810 does not support c45. The mmd_phy_indirect accesses return
arbirtary values leading to odd behavior like saying it supports EEE
when it doesn't. We also see that reading/writing these non-existent
MMD registers leads to phy instability in some cases.

Fixes: b14995ac2527 ("net: phy: broadcom: Add BCM54810 PHY entry")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/1691901708-28650-1-git-send-email-justin.chen@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 59cae0d808aa..04b2e6eeb195 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -542,6 +542,17 @@ static int bcm54xx_resume(struct phy_device *phydev)
 	return bcm54xx_config_init(phydev);
 }
 
+static int bcm54810_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
+			      u16 val)
+{
+	return -EOPNOTSUPP;
+}
+
 static int bcm54811_config_init(struct phy_device *phydev)
 {
 	int err, reg;
@@ -1103,6 +1114,8 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
 	.probe		= bcm54xx_phy_probe,
+	.read_mmd	= bcm54810_read_mmd,
+	.write_mmd	= bcm54810_write_mmd,
 	.config_init    = bcm54xx_config_init,
 	.config_aneg    = bcm5481_config_aneg,
 	.config_intr    = bcm_phy_config_intr,

