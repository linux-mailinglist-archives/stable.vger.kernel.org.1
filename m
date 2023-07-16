Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741997552FA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGPUOO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGPUON (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E6C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A258560EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B391FC433C7;
        Sun, 16 Jul 2023 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538451;
        bh=u8e4v7kWNC7Kf+jiNNDBRfdWx1M+qFexhf8Aymt5Jj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yZ5kyrNgzRLroRvLPT79AqPdoTlXzpGeAm2kbDqsxLTUYRWsWlC4N/q2mwjnVvZi3
         45EAeaTrlwP6g46c8kORX3Hwepk1AZvD4f0YPbH4WqHhdszkZUKy+Dulp4Ykii0H3G
         ryF/p+LveDUGXQcHUvE3TIjvfIiM70VrTVCvRmnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 454/800] pinctrl: tegra: Duplicate pinmux functions table
Date:   Sun, 16 Jul 2023 21:45:07 +0200
Message-ID: <20230716194959.628680444@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit fad57233501beb5bd25f037cb9128a533e710600 ]

The function table is filled with group information based on other
instance-specific data at runtime. However, the function table can be
shared between multiple instances, causing the ->probe() function for
one instance to overwrite the table of a previously probed instance.

Fix this by sharing only the function names and allocating a separate
function table for each instance.

Fixes: 5a0047360743 ("pinctrl: tegra: Separate Tegra194 instances")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20230530105308.1292852-1-thierry.reding@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c    | 15 +++++++++++----
 drivers/pinctrl/tegra/pinctrl-tegra.h    |  3 ++-
 drivers/pinctrl/tegra/pinctrl-tegra114.c |  7 ++-----
 drivers/pinctrl/tegra/pinctrl-tegra124.c |  7 ++-----
 drivers/pinctrl/tegra/pinctrl-tegra194.c |  7 ++-----
 drivers/pinctrl/tegra/pinctrl-tegra20.c  |  7 ++-----
 drivers/pinctrl/tegra/pinctrl-tegra210.c |  7 ++-----
 drivers/pinctrl/tegra/pinctrl-tegra30.c  |  7 ++-----
 8 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 1729b7ddfa946..21e08fbd1df0e 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -232,7 +232,7 @@ static const char *tegra_pinctrl_get_func_name(struct pinctrl_dev *pctldev,
 {
 	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	return pmx->soc->functions[function].name;
+	return pmx->functions[function].name;
 }
 
 static int tegra_pinctrl_get_func_groups(struct pinctrl_dev *pctldev,
@@ -242,8 +242,8 @@ static int tegra_pinctrl_get_func_groups(struct pinctrl_dev *pctldev,
 {
 	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups = pmx->soc->functions[function].groups;
-	*num_groups = pmx->soc->functions[function].ngroups;
+	*groups = pmx->functions[function].groups;
+	*num_groups = pmx->functions[function].ngroups;
 
 	return 0;
 }
@@ -795,10 +795,17 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 	if (!pmx->group_pins)
 		return -ENOMEM;
 
+	pmx->functions = devm_kcalloc(&pdev->dev, pmx->soc->nfunctions,
+				      sizeof(*pmx->functions), GFP_KERNEL);
+	if (!pmx->functions)
+		return -ENOMEM;
+
 	group_pins = pmx->group_pins;
+
 	for (fn = 0; fn < soc_data->nfunctions; fn++) {
-		struct tegra_function *func = &soc_data->functions[fn];
+		struct tegra_function *func = &pmx->functions[fn];
 
+		func->name = pmx->soc->functions[fn];
 		func->groups = group_pins;
 
 		for (gn = 0; gn < soc_data->ngroups; gn++) {
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
index 6130cba7cce54..b3289bdf727d8 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.h
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
@@ -13,6 +13,7 @@ struct tegra_pmx {
 	struct pinctrl_dev *pctl;
 
 	const struct tegra_pinctrl_soc_data *soc;
+	struct tegra_function *functions;
 	const char **group_pins;
 
 	struct pinctrl_gpio_range gpio_range;
@@ -191,7 +192,7 @@ struct tegra_pinctrl_soc_data {
 	const char *gpio_compatible;
 	const struct pinctrl_pin_desc *pins;
 	unsigned npins;
-	struct tegra_function *functions;
+	const char * const *functions;
 	unsigned nfunctions;
 	const struct tegra_pingroup *groups;
 	unsigned ngroups;
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra114.c b/drivers/pinctrl/tegra/pinctrl-tegra114.c
index e72ab1eb23983..3d425b2018e78 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra114.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra114.c
@@ -1452,12 +1452,9 @@ enum tegra_mux {
 	TEGRA_MUX_VI_ALT3,
 };
 
-#define FUNCTION(fname)					\
-	{						\
-		.name = #fname,				\
-	}
+#define FUNCTION(fname) #fname
 
-static struct tegra_function tegra114_functions[] = {
+static const char * const tegra114_functions[] = {
 	FUNCTION(blink),
 	FUNCTION(cec),
 	FUNCTION(cldvfs),
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra124.c b/drivers/pinctrl/tegra/pinctrl-tegra124.c
index 26096c6b967e2..2a50c5c7516c3 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra124.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra124.c
@@ -1611,12 +1611,9 @@ enum tegra_mux {
 	TEGRA_MUX_VIMCLK2_ALT,
 };
 
-#define FUNCTION(fname)					\
-	{						\
-		.name = #fname,				\
-	}
+#define FUNCTION(fname) #fname
 
-static struct tegra_function tegra124_functions[] = {
+static const char * const tegra124_functions[] = {
 	FUNCTION(blink),
 	FUNCTION(ccla),
 	FUNCTION(cec),
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra194.c b/drivers/pinctrl/tegra/pinctrl-tegra194.c
index 277973c884344..69f58df628977 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra194.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra194.c
@@ -1189,12 +1189,9 @@ enum tegra_mux_dt {
 };
 
 /* Make list of each function name */
-#define TEGRA_PIN_FUNCTION(lid)			\
-	{					\
-		.name = #lid,			\
-	}
+#define TEGRA_PIN_FUNCTION(lid) #lid
 
-static struct tegra_function tegra194_functions[] = {
+static const char * const tegra194_functions[] = {
 	TEGRA_PIN_FUNCTION(rsvd0),
 	TEGRA_PIN_FUNCTION(rsvd1),
 	TEGRA_PIN_FUNCTION(rsvd2),
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index 0dc2cf0d05b1e..737fc2000f66b 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -1889,12 +1889,9 @@ enum tegra_mux {
 	TEGRA_MUX_XIO,
 };
 
-#define FUNCTION(fname)					\
-	{						\
-		.name = #fname,				\
-	}
+#define FUNCTION(fname) #fname
 
-static struct tegra_function tegra20_functions[] = {
+static const char * const tegra20_functions[] = {
 	FUNCTION(ahb_clk),
 	FUNCTION(apb_clk),
 	FUNCTION(audio_sync),
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c b/drivers/pinctrl/tegra/pinctrl-tegra210.c
index b480f607fa16f..9bb29146dfff7 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
@@ -1185,12 +1185,9 @@ enum tegra_mux {
 	TEGRA_MUX_VIMCLK2,
 };
 
-#define FUNCTION(fname)					\
-	{						\
-		.name = #fname,				\
-	}
+#define FUNCTION(fname) #fname
 
-static struct tegra_function tegra210_functions[] = {
+static const char * const tegra210_functions[] = {
 	FUNCTION(aud),
 	FUNCTION(bcl),
 	FUNCTION(blink),
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra30.c b/drivers/pinctrl/tegra/pinctrl-tegra30.c
index 7299a371827f1..de5aa2d4d28d3 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra30.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra30.c
@@ -2010,12 +2010,9 @@ enum tegra_mux {
 	TEGRA_MUX_VI_ALT3,
 };
 
-#define FUNCTION(fname)					\
-	{						\
-		.name = #fname,				\
-	}
+#define FUNCTION(fname) #fname
 
-static struct tegra_function tegra30_functions[] = {
+static const char * const tegra30_functions[] = {
 	FUNCTION(blink),
 	FUNCTION(cec),
 	FUNCTION(clk_12m_out),
-- 
2.39.2



