Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB0C7552F3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjGPUNx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjGPUNx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69991C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F033260EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA06C433C7;
        Sun, 16 Jul 2023 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538431;
        bh=qsJg9YPDUjZzXA3TtHmIlEflCklqK3BxKeCriXpz3g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpSjMWrBb1KtG3Rk8iQJ6bY9bjyJvqpuUikw+1Sok8BRJ9ihZvszVhzPTFZgsDS8R
         LT7sBj7+YF8bqKLWjUalxCaPo9ZD+mHk4q7iO8oXNITowH3xP/VpT0pirdnEYY+oZw
         /xxaKimwEjOLfDGEFGvSHY8aeHTIRRtkzvQ5bamM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wells Lu <wellslutw@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 448/800] pinctrl: sunplus: Add check for kmalloc
Date:   Sun, 16 Jul 2023 21:45:01 +0200
Message-ID: <20230716194959.489810528@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wells Lu <wellslutw@gmail.com>

[ Upstream commit a5961bed5429cf1134d7f539b4ed60317012f84d ]

Fix Smatch static checker warning:
potential null dereference 'configs'. (kmalloc returns null)

Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
Signed-off-by: Wells Lu <wellslutw@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/1685277277-12209-1-git-send-email-wellslutw@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sunplus/sppctl.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 6bbbab3a6fdf3..e91ce5b5d5598 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -834,11 +834,6 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 	int i, size = 0;
 
 	list = of_get_property(np_config, "sunplus,pins", &size);
-
-	if (nmG <= 0)
-		nmG = 0;
-
-	parent = of_get_parent(np_config);
 	*num_maps = size / sizeof(*list);
 
 	/*
@@ -866,10 +861,14 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 		}
 	}
 
+	if (nmG <= 0)
+		nmG = 0;
+
 	*map = kcalloc(*num_maps + nmG, sizeof(**map), GFP_KERNEL);
-	if (*map == NULL)
+	if (!(*map))
 		return -ENOMEM;
 
+	parent = of_get_parent(np_config);
 	for (i = 0; i < (*num_maps); i++) {
 		dt_pin = be32_to_cpu(list[i]);
 		pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
@@ -883,6 +882,8 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 			(*map)[i].data.configs.num_configs = 1;
 			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
 			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
+			if (!configs)
+				goto sppctl_map_err;
 			*configs = FIELD_GET(GENMASK(7, 0), dt_pin);
 			(*map)[i].data.configs.configs = configs;
 
@@ -896,6 +897,8 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 			(*map)[i].data.configs.num_configs = 1;
 			(*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
 			configs = kmalloc(sizeof(*configs), GFP_KERNEL);
+			if (!configs)
+				goto sppctl_map_err;
 			*configs = SPPCTL_IOP_CONFIGS;
 			(*map)[i].data.configs.configs = configs;
 
@@ -965,6 +968,15 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 	of_node_put(parent);
 	dev_dbg(pctldev->dev, "%d pins mapped\n", *num_maps);
 	return 0;
+
+sppctl_map_err:
+	for (i = 0; i < (*num_maps); i++)
+		if (((*map)[i].type == PIN_MAP_TYPE_CONFIGS_PIN) &&
+		    (*map)[i].data.configs.configs)
+			kfree((*map)[i].data.configs.configs);
+	kfree(*map);
+	of_node_put(parent);
+	return -ENOMEM;
 }
 
 static const struct pinctrl_ops sppctl_pctl_ops = {
-- 
2.39.2



