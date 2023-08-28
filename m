Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A65578ABEE
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjH1Kff (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjH1KfK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:35:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B667B9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C589A63E3C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D468DC433C7;
        Mon, 28 Aug 2023 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218906;
        bh=CVG/sUN9nSJrYcnvMNPkXmWNPeczgFNgd5LbLZHwgLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TN6rWoMPogTGB8P89+bvVlQHsgh1dbt+81Hd9i3yKqeaqSuOloJwMMfrZHeCwVjGW
         qVjUSz63DyfZZP/R/1KkA4wg39otrCjHogr+U9tHLZZSbjPhTJZfPwgZpWLvVPuroQ
         2dP8UG8PZlRLF163wQYzJI9ssI9ul2z8gU+gXtKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 116/122] pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}
Date:   Mon, 28 Aug 2023 12:13:51 +0200
Message-ID: <20230828101200.277285413@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 8fcc1c40b747069644db6102c1d84c942c9d4d86 ]

The pinctrl group and function creation/remove calls expect
caller to take care of locking. Add lock around these functions.

Fixes: b59d0e782706 ("pinctrl: Add RZ/A2 pin and gpio controller")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230815131558.33787-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rza2.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index c0a04f1ee994e..12126e30dc20f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -14,6 +14,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinmux.h>
 
@@ -46,6 +47,7 @@ struct rza2_pinctrl_priv {
 	struct pinctrl_dev *pctl;
 	struct pinctrl_gpio_range gpio_range;
 	int npins;
+	struct mutex mutex; /* serialize adding groups and functions */
 };
 
 #define RZA2_PDR(port)		(0x0000 + (port) * 2)	/* Direction 16-bit */
@@ -358,10 +360,14 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 		psel_val[i] = MUX_FUNC(value);
 	}
 
+	mutex_lock(&priv->mutex);
+
 	/* Register a single pin group listing all the pins we read from DT */
 	gsel = pinctrl_generic_add_group(pctldev, np->name, pins, npins, NULL);
-	if (gsel < 0)
-		return gsel;
+	if (gsel < 0) {
+		ret = gsel;
+		goto unlock;
+	}
 
 	/*
 	 * Register a single group function where the 'data' is an array PSEL
@@ -390,6 +396,8 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 	(*map)->data.mux.function = np->name;
 	*num_maps = 1;
 
+	mutex_unlock(&priv->mutex);
+
 	return 0;
 
 remove_function:
@@ -398,6 +406,9 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 remove_group:
 	pinctrl_generic_remove_group(pctldev, gsel);
 
+unlock:
+	mutex_unlock(&priv->mutex);
+
 	dev_err(priv->dev, "Unable to parse DT node %s\n", np->name);
 
 	return ret;
@@ -473,6 +484,8 @@ static int rza2_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	mutex_init(&priv->mutex);
+
 	platform_set_drvdata(pdev, priv);
 
 	priv->npins = (int)(uintptr_t)of_device_get_match_data(&pdev->dev) *
-- 
2.40.1



