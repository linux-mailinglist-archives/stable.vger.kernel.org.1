Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B5C7ED3EF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjKOUz3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjKOUz0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:55:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA81A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECB3C4E779;
        Wed, 15 Nov 2023 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081721;
        bh=Tk6FlykPT0C2bataSAvfQ1Zjh2TQCTwcBnUkBaGTQ2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzyBxqnkksDOKDS9puquMfdpQL8neQVu/FYmu+YICo8WPtIRR5b6NLdTgLw3I2YH4
         M7lg1R3nPQmL+rWLA8cWfmhaLUNeSWDALNsjLu6db5T/gcnfStnhaGBG2XnjLQyihw
         OZ/PeMxDwzrFoI7Pizn07xKWaCEfRtTAdrcxiOnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 085/191] clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped
Date:   Wed, 15 Nov 2023 15:46:00 -0500
Message-ID: <20231115204649.682548269@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 3537a75e73f3420614a358d0c8b390ea483cc87d ]

Add the missing devm_kfree() when we skip the clocks with invalid or
missing information from the firmware.

Cc: Cristian Marussi <cristian.marussi@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Fixes: 6d6a1d82eaef ("clk: add support for clocks provided by SCMI")
Link: https://lore.kernel.org/r/20231004193600.66232-1-sudeep.holla@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-scmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index c754dfbb73fd4..c62636fb4aca8 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -170,6 +170,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->info = handle->clk_ops->info_get(handle, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
+			devm_kfree(dev, sclk);
 			continue;
 		}
 
-- 
2.42.0



