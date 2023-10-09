Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE507BE07F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376845AbjJINkt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377330AbjJINkr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:40:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBA89D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:40:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0207C433C8;
        Mon,  9 Oct 2023 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858845;
        bh=sEwV8bRreVXLFUFcxanyqA0FvWQzyfyu0//M4BghbrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b48StawnHeWwovgFV1IPdHeg2wSzHF8BLi9fqjcFjdl78lWbnB/36eSYDbdyZwUQu
         4V2pms7qXyduBLxXhUUzQFYGbFjnAR72JzcfL8by6BlGqBYBcQekBkTD/mPcJsY64/
         HW6KaZQYIUL5v+OmAbI+CsWrgv7onx/L5BWbniOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 090/226] bus: ti-sysc: Fix missing AM35xx SoC matching
Date:   Mon,  9 Oct 2023 15:00:51 +0200
Message-ID: <20231009130129.123437449@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 11729caa520950e17cd81bc43ffc477c46cf791e ]

Commit feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")
created a list of SoC types searching for strings based on names
and wildcards which associates the SoC to different families.

The OMAP34xx and OMAP35xx are treated as SOC_3430 while
OMAP36xx and OMAP37xx are treated as SOC_3630, but the AM35xx
isn't listed.

The AM35xx is mostly an OMAP3430, and a later commit a12315d6d270
("bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific") looks
for the SOC type and behaves in a certain way if it's SOC_3430.

This caused a regression on the AM3517 causing it to return two
errors:

 ti-sysc: probe of 48318000.target-module failed with error -16
 ti-sysc: probe of 49032000.target-module failed with error -16

Fix this by treating the creating SOC_AM35 and inserting it between
the SOC_3430 and SOC_3630.  If it is treaed the same way as the
SOC_3430 when checking the status of sysc_check_active_timer,
the error conditions will disappear.

Fixes: a12315d6d270 ("bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific")
Fixes: feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")
Signed-off-by: Adam Ford <aford173@gmail.com>
Message-ID: <20230906233442.270835-1-aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 24d589b43dfe7..5dba06ed61bf8 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -38,6 +38,7 @@ enum sysc_soc {
 	SOC_2420,
 	SOC_2430,
 	SOC_3430,
+	SOC_AM35,
 	SOC_3630,
 	SOC_4430,
 	SOC_4460,
@@ -1818,7 +1819,7 @@ static void sysc_pre_reset_quirk_dss(struct sysc *ddata)
 		dev_warn(ddata->dev, "%s: timed out %08x !+ %08x\n",
 			 __func__, val, irq_mask);
 
-	if (sysc_soc->soc == SOC_3430) {
+	if (sysc_soc->soc == SOC_3430 || sysc_soc->soc == SOC_AM35) {
 		/* Clear DSS_SDI_CONTROL */
 		sysc_write(ddata, 0x44, 0);
 
@@ -2959,6 +2960,7 @@ static void ti_sysc_idle(struct work_struct *work)
 static const struct soc_device_attribute sysc_soc_match[] = {
 	SOC_FLAG("OMAP242*", SOC_2420),
 	SOC_FLAG("OMAP243*", SOC_2430),
+	SOC_FLAG("AM35*", SOC_AM35),
 	SOC_FLAG("OMAP3[45]*", SOC_3430),
 	SOC_FLAG("OMAP3[67]*", SOC_3630),
 	SOC_FLAG("OMAP443*", SOC_4430),
@@ -3146,7 +3148,7 @@ static int sysc_check_active_timer(struct sysc *ddata)
 	 * can be dropped if we stop supporting old beagleboard revisions
 	 * A to B4 at some point.
 	 */
-	if (sysc_soc->soc == SOC_3430)
+	if (sysc_soc->soc == SOC_3430 || sysc_soc->soc == SOC_AM35)
 		error = -ENXIO;
 	else
 		error = -EBUSY;
-- 
2.40.1



