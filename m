Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B867ECE1D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjKOTkb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjKOTka (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD8F19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F79C433CA;
        Wed, 15 Nov 2023 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077225;
        bh=mmTCOZGGbdwL5tMy7/og1aisCQ5SqrY5NkSRV0KMg9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsutqjRXPqLi4/DOKNsgpmm4IaFHjUhWXntpy+jCr53UdiJO9fFiUQIgE2DRqBpR8
         OCXNwpQNvdzdqF4z71yPbRkaG6noAVwgX2ALUdSBdf+Mh4cjXLRtAYc9UYeI+9CUQG
         U02xo2+OWaHJk9n5miVg+sAp1pKFfccE8fYTS8Dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dirk Behme <dirk.behme@de.bosch.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 174/603] clk: renesas: rcar-gen3: Extend SDnH divider table
Date:   Wed, 15 Nov 2023 14:11:59 -0500
Message-ID: <20231115191625.267788622@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dirk Behme <dirk.behme@de.bosch.com>

[ Upstream commit d5252d9697a3e7007c741e9c103073868955a304 ]

The clock dividers might be used with clock stop bit enabled or not.
Current tables only support recommended values from the datasheet.  This
might result in warnings like below because no valid clock divider is
found. Resulting in a 0 divider.

There are Renesas ARM Trusted Firmware version out there which e.g.
configure 0x201 (shifted logical right by 2: 0x80) and with this match
the added { STPnHCK | 0, 1 }:

https://github.com/renesas-rcar/arm-trusted-firmware/blob/rcar_gen3_v2.3/drivers/renesas/rcar/emmc/emmc_init.c#L108

------------[ cut here ]------------
sd1h: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set
WARNING: CPU: 1 PID: 1 at drivers/clk/clk-divider.c:141 divider_recalc_rate+0x48/0x70
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.1.52 #1
Hardware name: Custom board based on r8a7796 (DT)
pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : divider_recalc_rate+0x48/0x70
...
------------[ cut here ]------------

Fixes: bb6d3fa98a41 ("clk: renesas: rcar-gen3: Switch to new SD clock handling")
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
[wsa: extended the table to 5 entries, added comments, reword commit message a little]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230928080317.28224-1-wsa+renesas@sang-engineering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rcar-cpg-lib.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rcar-cpg-lib.c b/drivers/clk/renesas/rcar-cpg-lib.c
index e2e0447de1901..5a15f8788b922 100644
--- a/drivers/clk/renesas/rcar-cpg-lib.c
+++ b/drivers/clk/renesas/rcar-cpg-lib.c
@@ -70,8 +70,21 @@ void cpg_simple_notifier_register(struct raw_notifier_head *notifiers,
 #define STPnHCK	BIT(9 - SDnSRCFC_SHIFT)
 
 static const struct clk_div_table cpg_sdh_div_table[] = {
+	/*
+	 * These values are recommended by the datasheet.  Because they come
+	 * first, Linux will only use these.
+	 */
 	{ 0, 1 }, { 1, 2 }, { STPnHCK | 2, 4 }, { STPnHCK | 3, 8 },
-	{ STPnHCK | 4, 16 }, { 0, 0 },
+	{ STPnHCK | 4, 16 },
+	/*
+	 * These values are not recommended because STPnHCK is wrong.  But they
+	 * have been seen because of broken firmware.  So, we support reading
+	 * them but Linux will sanitize them when initializing through
+	 * recalc_rate.
+	 */
+	{ STPnHCK | 0, 1 }, { STPnHCK | 1, 2 },  { 2, 4 }, { 3, 8 }, { 4, 16 },
+	/* Sentinel */
+	{ 0, 0 }
 };
 
 struct clk * __init cpg_sdh_clk_register(const char *name,
-- 
2.42.0



