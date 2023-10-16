Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2D7CA2FC
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjJPI7k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJPI7j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:59:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6623EAB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:59:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C381C433C7;
        Mon, 16 Oct 2023 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446778;
        bh=3kKt03rbLuEZRlvvLfdqeJoSA9R3ua4gQm+AOaPgMOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0q+TLek36kfA2AupJoD1gsImIu7jpfEq/szJwVyGddJ0dwWWCihF72HxDDX/QkmYJ
         VRPCKzpNl8ocvEZkVDqU5iYvJI/QSbrsTmbDxxdxCFMMYj8GuyczIkbDRJsKoeIS3S
         CUsBQtJS+PLzskOYCZL9UWuPP6qFXrQ4bKa/Yr/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
        John Watts <contact@jookia.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 044/131] can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set
Date:   Mon, 16 Oct 2023 10:40:27 +0200
Message-ID: <20231016084001.167746381@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Watts <contact@jookia.org>

[ Upstream commit 1f223208ebdef84f21c15e9958c005a93c871aa2 ]

When adding the RISCV option I didn't gate it behind ARCH_SUNXI.
As a result this option shows up with Allwinner support isn't enabled.
Fix that by requiring ARCH_SUNXI to be set if RISCV is set.

Fixes: 8abb95250ae6 ("can: sun4i_can: Add support for the Allwinner D1")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-sunxi/CAMuHMdV2m54UAH0X2dG7stEg=grFihrdsz4+o7=_DpBMhjTbkw@mail.gmail.com/
Signed-off-by: John Watts <contact@jookia.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20230905231342.2042759-2-contact@jookia.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 8236aabebb394..e45b95a13157b 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -174,7 +174,7 @@ config CAN_SLCAN
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
+	depends on MACH_SUN4I || MACH_SUN7I || (RISCV && ARCH_SUNXI) || COMPILE_TEST
 	help
 	  Say Y here if you want to use CAN controller found on Allwinner
 	  A10/A20/D1 SoCs.
-- 
2.40.1



