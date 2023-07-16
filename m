Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF3755273
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjGPUIC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGPUIB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D7C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0BCA60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48D3C433C8;
        Sun, 16 Jul 2023 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538080;
        bh=DKwoDzISkE9wh3vvu2XI482adqoYiLokyx+1GWjJ6Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ll3jeaKJ1E14YYHJGA5EhZI2d52+GARSur1vkDSOsYrYF2l3hVvBVwfu9ZI/7+ACz
         Ma4Ug0AS6+rXCdctt9zcnV3+NSfbPAaxIvzfwicNA0Zgu5OtbuIzfFl2FdtGsO+B0L
         Yh4DvdvfhkLIiM/a12oXIexRByQ0Gxxmp/EiTjlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 324/800] ARM: omap2: fix missing tick_broadcast() prototype
Date:   Sun, 16 Jul 2023 21:42:57 +0200
Message-ID: <20230716194956.596434772@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 861bc1d2886d47bd57a2cbf2cda87fdbe3eb9d08 ]

omap2 contains a hack to define tick_broadcast() on non-SMP
configurations in place of the normal SMP definition. This one
causes a warning because of a missing prototype:

arch/arm/mach-omap2/board-generic.c:44:6: error: no previous prototype for 'tick_broadcast'

Make sure to always include the header with the declaration.

Fixes: d86ad463d670 ("ARM: OMAP2+: Fix regression for using local timer on non-SMP SoCs")
Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Link: https://lore.kernel.org/r/20230516153109.514251-9-arnd@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/board-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 1610c567a6a3a..10d2f078e4a8e 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -13,6 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/setup.h>
 #include <asm/mach/arch.h>
-- 
2.39.2



