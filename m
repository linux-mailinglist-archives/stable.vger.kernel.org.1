Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD779F1BC
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjIMTJB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIMTJA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:09:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF4D1999
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:08:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB428C433C8;
        Wed, 13 Sep 2023 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694632136;
        bh=OU8z1QUu5HGISOoQAelWCBOzZzRGK+DsCZ8s4fdqCTQ=;
        h=Subject:To:Cc:From:Date:From;
        b=DeYyEjDU1+fplIgezbXOocLChw6F5wx26sRn7D1ACjIAgW6cA3Vt7Ie6GKAlepELu
         4vemKMX+Lk/pWbE4RVoKEhocfo52qNb6Ry+ZuSm2SZoD1rv6/mdXBP57/d3zcdRcOo
         OUTTMcvyyWLwoh2QUS8TIwMl1A1TLl13kOLdK0ps=
Subject: FAILED: patch "[PATCH] clk: imx: pll14xx: dynamically configure PLL for" failed to apply to 5.4-stable tree
To:     a.fatoum@pengutronix.de, abel.vesa@linaro.org,
        m.felsch@pengutronix.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:08:51 +0200
Message-ID: <2023091351-humongous-upriver-d78b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
git cherry-pick -x 72d00e560d10665e6139c9431956a87ded6e9880
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091351-humongous-upriver-d78b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

72d00e560d10 ("clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz")
57795654fb55 ("clk: imx: pll14xx: Add new frequency entries for pll1443x table")
8f2d3c1759d1 ("clk: imx: clk-pll14xx: Make two variables static")
43cdaa1567ad ("clk: imx8mm: Move 1443X/1416X PLL clock structure to common place")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72d00e560d10665e6139c9431956a87ded6e9880 Mon Sep 17 00:00:00 2001
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Mon, 7 Aug 2023 10:47:44 +0200
Subject: [PATCH] clk: imx: pll14xx: dynamically configure PLL for
 393216000/361267200Hz

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

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index dc6bc21dff41..0d58d85c375e 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -64,8 +64,6 @@ static const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
 	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
-	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
-	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
 };
 
 struct imx_pll14xx_clk imx_1443x_pll = {

