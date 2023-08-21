Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5563578309A
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjHUTBh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHUTBg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4B2128
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A1AA61C27
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 18:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7468FC433C7;
        Mon, 21 Aug 2023 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692643835;
        bh=BFDZ73ab/I273tY/C7Luv6czjchgW7z+fzViBPjS8kA=;
        h=Subject:To:Cc:From:Date:From;
        b=rZH/ReXaVJDyogPTi9olxbS9Wm9NTKqog0uOUjqFGN92BYrlEwAk9wh87DNNq7OoA
         0PhPw7l9DdWhb8nfWeXfIaJleRq5E79dez1azdhktkFBPeb5au/WpTURtCXTptn36G
         Tzp6e9RGrFGwIqjzoLNB7V7rWWnFvpLIxuIM3rGY=
Subject: FAILED: patch "[PATCH] net: phy: broadcom: stub c45 read/write for 54810" failed to apply to 5.4-stable tree
To:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 20:50:32 +0200
Message-ID: <2023082132-jaundice-applaud-eb72@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 096516d092d54604d590827d05b1022c8f326639
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082132-jaundice-applaud-eb72@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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

