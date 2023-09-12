Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE42879BD2B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjIKUva (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbjIKOtA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:49:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33977125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:48:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E3AC433C7;
        Mon, 11 Sep 2023 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443735;
        bh=rNspsJQQGqbKPJbYcwJjxSq32JgNcciypHGzRZ9Allc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VVqOh2WHCF2BJ8suCtOE7zHRz3BtKsD+77N/bQw8Sz8FNlHiZaaspdLHdbf4d7kt3
         k4PwqCCU6KOYafumNw278BO8c3rzKs3ukziOkKaTTkCT911fPXaIhSl4crEXsZ/tko
         p8sD8ddTrEKJ1Hk7jHSIRPyY85MdAnZOXW5+AgxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Golle <daniel@makrotopia.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 455/737] pinctrl: mediatek: assign functions to configure pin bias on MT7986
Date:   Mon, 11 Sep 2023 15:45:14 +0200
Message-ID: <20230911134703.309036503@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 0d8387fba9f151220e48dc3dcdc2335539708f13 ]

Assign bias_disable_get/set and bias_get/set functions to allow
configuring pin bias on MT7986.

Fixes: 2c58d8dc9cd0 ("pinctrl: mediatek: add pull_type attribute for mediatek MT7986 SoC")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/47f72372354312a839b9337e09476aadcc206e8b.1692327317.git.daniel@makrotopia.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt7986.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
index aa0ccd67f4f4e..acaac9b38aa8a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -922,6 +922,10 @@ static struct mtk_pin_soc mt7986a_data = {
 	.ies_present = false,
 	.base_names = mt7986_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7986_pinctrl_register_base_names),
+	.bias_disable_set = mtk_pinconf_bias_disable_set,
+	.bias_disable_get = mtk_pinconf_bias_disable_get,
+	.bias_set = mtk_pinconf_bias_set,
+	.bias_get = mtk_pinconf_bias_get,
 	.pull_type = mt7986_pull_type,
 	.bias_set_combo = mtk_pinconf_bias_set_combo,
 	.bias_get_combo = mtk_pinconf_bias_get_combo,
@@ -944,6 +948,10 @@ static struct mtk_pin_soc mt7986b_data = {
 	.ies_present = false,
 	.base_names = mt7986_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt7986_pinctrl_register_base_names),
+	.bias_disable_set = mtk_pinconf_bias_disable_set,
+	.bias_disable_get = mtk_pinconf_bias_disable_get,
+	.bias_set = mtk_pinconf_bias_set,
+	.bias_get = mtk_pinconf_bias_get,
 	.pull_type = mt7986_pull_type,
 	.bias_set_combo = mtk_pinconf_bias_set_combo,
 	.bias_get_combo = mtk_pinconf_bias_get_combo,
-- 
2.40.1



