Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51D57ECBCD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjKOTYf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjKOTYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:24:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F712C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F27C433C7;
        Wed, 15 Nov 2023 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076271;
        bh=DRO8m4KIvRiVdrGMKLl6xVTIzfpfkDanecjexnLjwLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBlyAoGxnZAtmPjoMczbQz8O0ut88m+to+6AWJnigNO93DxyEDqSayzWf2aYauELk
         U/3K0bcoryQw300Rge7X5wbEqYrL0K3sRZv9HBa8DzTQNTO9aGaRErOLiA5LiVbQXX
         4IpLkjvg1AfK8lfLmN4wb/6Ni/YVasdcJuNsZ3Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 167/550] clk: renesas: rzg2l: Use FIELD_GET() for PLL register fields
Date:   Wed, 15 Nov 2023 14:12:31 -0500
Message-ID: <20231115191612.293659850@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 72977f07b035e488c3f1928832a1616c6cae7278 ]

Use FIELD_GET() for PLL register fields.  This is its purpose.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-14-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Stable-dep-of: a2b23159499e ("clk: renesas: rzg2l: Fix computation formula")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rzg2l-cpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index a0970f77c473f..03028362cf619 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
@@ -39,14 +40,13 @@
 #define WARN_DEBUG(x)	do { } while (0)
 #endif
 
-#define DIV_RSMASK(v, s, m)	((v >> s) & m)
 #define GET_SHIFT(val)		((val >> 12) & 0xff)
 #define GET_WIDTH(val)		((val >> 8) & 0xf)
 
-#define KDIV(val)		DIV_RSMASK(val, 16, 0xffff)
-#define MDIV(val)		DIV_RSMASK(val, 6, 0x3ff)
-#define PDIV(val)		DIV_RSMASK(val, 0, 0x3f)
-#define SDIV(val)		DIV_RSMASK(val, 0, 0x7)
+#define KDIV(val)		FIELD_GET(GENMASK(31, 16), val)
+#define MDIV(val)		FIELD_GET(GENMASK(15, 6), val)
+#define PDIV(val)		FIELD_GET(GENMASK(5, 0), val)
+#define SDIV(val)		FIELD_GET(GENMASK(2, 0), val)
 
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
-- 
2.42.0



