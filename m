Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669877553F6
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjGPUY7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGPUY7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0359F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0438860EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12778C433C8;
        Sun, 16 Jul 2023 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539097;
        bh=WwSY/OzZDkYBCgxMN7MkovpKxAtWMeVsWat8XJtkFZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHqNYq6j1QThV/nCrsdrqOg74RXw7y7aRfU2O/1wabFPlLo3btN56PijSKAs9Yhy1
         AyWf8CDbBEOHR7pMCwn+Bjti6XWukEM39hAWU1NkPU5Reyu03SvJrr9PbH+CN5cVlu
         6Wm6V+bIRKXJ+N350S39cauHW/MnLvXYRKPcK1Z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 659/800] media: tc358746: select CONFIG_GENERIC_PHY
Date:   Sun, 16 Jul 2023 21:48:32 +0200
Message-ID: <20230716195004.419151472@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 582d4ad468cbc6ef2db4689ff3bd5868d95402c9 ]

The tc358746 driver selects CONFIG_GENERIC_PHY_MIPI_DPHY and links to
that, but this fails when CONFIG_GENERIC_PHY is disabled, because Kbuild
then never enters the drivers/phy directory for building object files:

ERROR: modpost: "phy_mipi_dphy_get_default_config_for_hsclk" [drivers/media/i2c/tc358746.ko] undefined!

Add an explicit 'select GENERIC_PHY' here to ensure that the directory
is entered, and add another dependency on that symbol so make it
more obvious what is going on if another driver has the same problem,
as this will produce a Kconfig warning.

Link: https://lore.kernel.org/linux-media/20230623152318.2276816-1-arnd@kernel.org
Fixes: 80a21da360516 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/Kconfig | 1 +
 drivers/phy/Kconfig       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 256d55bb2b1da..76d1ee3cc1bab 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -1292,6 +1292,7 @@ config VIDEO_TC358746
 	select VIDEO_V4L2_SUBDEV_API
 	select MEDIA_CONTROLLER
 	select V4L2_FWNODE
+	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	select REGMAP_I2C
 	help
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index f46e3148d286d..8dba9596408f2 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -18,6 +18,7 @@ config GENERIC_PHY
 
 config GENERIC_PHY_MIPI_DPHY
 	bool
+	depends on GENERIC_PHY
 	help
 	  Generic MIPI D-PHY support.
 
-- 
2.39.2



