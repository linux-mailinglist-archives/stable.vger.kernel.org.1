Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7669D7614A4
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjGYLVT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjGYLVS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6DEB6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D3A615FE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD1FC433CA;
        Tue, 25 Jul 2023 11:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284077;
        bh=FaqdUIyMkvgk6FJ8+pmVw35p6XeNUShefM2Z/+8wY4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Udv2AGuS/uX5/vvGjWhKxJ22bNhhB0y4FNkduxEOVQmlMjxuZWYkxzWB2ET0BqKfQ
         R+5mwhoFmiWWAapRuRHU1w3r1qOAsC5XLmQi8fnkSKiGuIBjAeiVnyp7unBmzCAo8J
         I9YzUO9Y8wH5JMQ1LYyOcc/4BW1BHkh4l4Qnxd9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 227/509] clk: qcom: reset: support resetting multiple bits
Date:   Tue, 25 Jul 2023 12:42:46 +0200
Message-ID: <20230725104604.158678444@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robert Marko <robimarko@gmail.com>

[ Upstream commit 4a5210893625f89723ea210d7c630b730abb37ad ]

This patch adds the support for giving the complete bitmask
in reset structure and reset operation will use this bitmask
for all reset operations.

Currently, reset structure only takes a single bit for each reset
and then calculates the bitmask by using the BIT() macro.

However, this is not sufficient anymore for newer SoC-s like IPQ8074,
IPQ6018 and more, since their networking resets require multiple bits
to be asserted in order to properly reset the HW block completely.

So, in order to allow asserting multiple bits add "bitmask" field to
qcom_reset_map, and then use that bitmask value if its populated in the
driver, if its not populated, then we just default to existing behaviour
and calculate the bitmask on the fly.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20221107132901.489240-1-robimarko@gmail.com
Stable-dep-of: 349b5bed539b ("clk: qcom: ipq6018: fix networking resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/reset.c | 4 ++--
 drivers/clk/qcom/reset.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 2a16adb572d2b..0e914ec7aeae1 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -30,7 +30,7 @@ qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, mask);
 }
@@ -44,7 +44,7 @@ qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 	rst = to_qcom_reset_controller(rcdev);
 	map = &rst->reset_map[id];
-	mask = BIT(map->bit);
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	return regmap_update_bits(rst->regmap, map->reg, mask, 0);
 }
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index b8c113582072b..9a47c838d9b1b 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -12,6 +12,7 @@ struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
 	u8 udelay;
+	u32 bitmask;
 };
 
 struct regmap;
-- 
2.39.2



