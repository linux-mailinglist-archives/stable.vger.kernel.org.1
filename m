Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51397ED0AF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbjKOT5E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbjKOT4u (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499AD4B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C91C433C9;
        Wed, 15 Nov 2023 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078206;
        bh=colsCBiZ5rEuEKm8hctz+RNECfyn8Sk5X8ahyDvL5cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxmZEKG9ijvmzFsEMK28dW6ISwsfXSmyJOOQWYGzOZWXQEP9W2k/bIysoP4VY7sKt
         VCpa3PuQHOmWTITaOel3TcFkUj90maXMX/NiNQ+kA2qZyMZYafSB1wjjUxi0I5mDqi
         4dfOGxokr6nZpnDN2jyG/1zGu/aNXTpZA6Crs630=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 178/379] clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped
Date:   Wed, 15 Nov 2023 14:24:13 -0500
Message-ID: <20231115192655.635718403@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 2c7a830ce3080..fdec715c9ba9b 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -213,6 +213,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->info = scmi_proto_clk_ops->info_get(ph, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
+			devm_kfree(dev, sclk);
 			continue;
 		}
 
-- 
2.42.0



