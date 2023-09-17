Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D9A7A3A5B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbjIQUCZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbjIQUCD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:02:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC671AE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:01:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F89AC433CA;
        Sun, 17 Sep 2023 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980902;
        bh=XMR3j6uXeIJAtyCLPwYCzi9wVYfEfefUcY7cMNtKGTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPvSDJqEIzaKGJQ/h/SV5VWlmLz3KjyKgA8OIeknLyjI6LTpeNiA1jZs2GImO48hD
         5btpvu5NDR0DTbt3Ybc115TDD3Lq2rKulEj4QVTKcIn2mHGV+gJ2ktfEs6nY/AEgFV
         vrroihUZHuk4X9PWVuOT9hANRi7ojb/8oRBPDTAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 6.1 041/219] clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz
Date:   Sun, 17 Sep 2023 21:12:48 +0200
Message-ID: <20230917191042.486906133@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

commit 72d00e560d10665e6139c9431956a87ded6e9880 upstream.

Since commit b09c68dc57c9 ("clk: imx: pll14xx: Support dynamic rates"),
the driver has the ability to dynamically compute PLL parameters to
approximate the requested rates. This is not always used, because the
logic is as follows:

  - Check if the target rate is hardcoded in the frequency table
  - Check if varying only kdiv is possible, so switch over is glitch free
  - Compute rate dynamically by iterating over pdiv range

If we skip the frequency table for the 1443x PLL, we find that the
computed values differ to the hardcoded ones. This can be valid if the
hardcoded values guarantee for example an earlier lock-in or if the
divisors are chosen, so that other important rates are more likely to
be reached glitch-free.

For rates (393216000 and 361267200, this doesn't seem to be the case:
They are only approximated by existing parameters (393215995 and
361267196 Hz, respectively) and they aren't reachable glitch-free from
other hardcoded frequencies. Dropping them from the table allows us
to lock-in to these frequencies exactly.

This is immediately noticeable because they are the assigned-clock-rates
for IMX8MN_AUDIO_PLL1 and IMX8MN_AUDIO_PLL2, respectively and a look
into clk_summary so far showed that they were a few Hz short of the target:

imx8mn-board:~# grep audio_pll[12]_out /sys/kernel/debug/clk/clk_summary
audio_pll2_out           0        0        0   361267196 0     0  50000   N
audio_pll1_out           1        1        0   393215995 0     0  50000   Y

and afterwards:

imx8mn-board:~# grep audio_pll[12]_out /sys/kernel/debug/clk/clk_summary
audio_pll2_out           0        0        0   361267200 0     0  50000   N
audio_pll1_out           1        1        0   393216000 0     0  50000   Y

This change is equivalent to adding following hardcoded values:

  /*               rate     mdiv  pdiv  sdiv   kdiv */
  PLL_1443X_RATE(393216000, 655,    5,    3,  23593),
  PLL_1443X_RATE(361267200, 497,   33,    0, -16882),

Fixes: 053a4ffe2988 ("clk: imx: imx8mm: fix audio pll setting")
Cc: stable@vger.kernel.org # v5.18+
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20230807084744.1184791-2-m.felsch@pengutronix.de
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/imx/clk-pll14xx.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -62,8 +62,6 @@ static const struct imx_pll14xx_rate_tab
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
 	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
-	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
-	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
 };
 
 struct imx_pll14xx_clk imx_1443x_pll = {


