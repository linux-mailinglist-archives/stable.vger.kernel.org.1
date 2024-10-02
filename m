Return-Path: <stable+bounces-80276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353ED98DCCA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11EFB2333E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643561D2F5C;
	Wed,  2 Oct 2024 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YDcW8rwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2219752C;
	Wed,  2 Oct 2024 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879897; cv=none; b=na0M8Sc+ijUzn06F5UbqOR4qT2xYbhRgI87Yjfc0dZZwxVlNmRa97zDG9f+c2xZMmTcqQp6uyE7USVgW+ZxbnFpylqV1qgEBFlDCyPqHvST4Jb9bQR5FbY3AVadjtaB12EhDvjDcroCgB5wxL5B8xBJFJOdAkLMKynwJFvGNVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879897; c=relaxed/simple;
	bh=XHXgRuv8eE+g5CLftEYeAFai6UVGa/U1LqUA8MO4e7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyNllp8IlIm1E+G3eI6zouKchHBICYahotL0EANudDzOJuobWw0Xr1YQAkU9VD+oEosKs+mmfdHyFC/p6nCA0SXTFHPLMsLS2LdJU9MpW+kQXu53tARl0/Jo/xDGQ3cI/KXlBSruYwlAGATq7AWiqGKT9NV6/kMmmgTmTNRVDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YDcW8rwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992B2C4CEC2;
	Wed,  2 Oct 2024 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879897;
	bh=XHXgRuv8eE+g5CLftEYeAFai6UVGa/U1LqUA8MO4e7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDcW8rwmo3xSFWjW0dQEYH3em3tOH4aRHIjaXo7xrvH42hxwrsJoBqfMgO+Hwz9Ou
	 8u17sWMB8Qt1NJDKRemEBwCtv3LbT8u05y3v5ski5SFBrz4yTrNVWIpSQFRmL6dcuW
	 fq+0TVVJISaPEODOKip5BfJgtnB/vomX29wypfA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 276/538] pinctrl: Use device_get_match_data()
Date: Wed,  2 Oct 2024 14:58:35 +0200
Message-ID: <20241002125803.152213255@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit 63bffc2d3a99eaabc786c513eea71be3f597f175 ]

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20231009172923.2457844-18-robh@kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: a9f2b249adee ("pinctrl: ti: ti-iodelay: Fix some error handling paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/bcm/pinctrl-ns.c             |  8 ++------
 drivers/pinctrl/berlin/berlin-bg2.c          |  8 +++-----
 drivers/pinctrl/berlin/berlin-bg2cd.c        |  8 +++-----
 drivers/pinctrl/berlin/berlin-bg2q.c         |  8 +++-----
 drivers/pinctrl/berlin/berlin-bg4ct.c        |  9 +++++----
 drivers/pinctrl/berlin/pinctrl-as370.c       |  9 +++++----
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c   |  9 ++-------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c   |  9 ++-------
 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c |  5 +----
 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c |  6 ++----
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c    |  9 ++-------
 drivers/pinctrl/mvebu/pinctrl-dove.c         |  6 ++----
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c     |  7 ++-----
 drivers/pinctrl/mvebu/pinctrl-orion.c        |  7 ++-----
 drivers/pinctrl/nomadik/pinctrl-abx500.c     |  9 ++-------
 drivers/pinctrl/nomadik/pinctrl-nomadik.c    | 10 ++++------
 drivers/pinctrl/pinctrl-at91.c               | 11 +++++------
 drivers/pinctrl/pinctrl-xway.c               | 11 ++++-------
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c      | 18 ++++++++----------
 19 files changed, 59 insertions(+), 108 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-ns.c b/drivers/pinctrl/bcm/pinctrl-ns.c
index f80630a74d34a..d099a7f25f64c 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns.c
@@ -7,11 +7,11 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include "../core.h"
@@ -208,7 +208,6 @@ static const struct of_device_id ns_pinctrl_of_match_table[] = {
 static int ns_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct ns_pinctrl *ns_pinctrl;
 	struct pinctrl_desc *pctldesc;
 	struct pinctrl_pin_desc *pin;
@@ -225,10 +224,7 @@ static int ns_pinctrl_probe(struct platform_device *pdev)
 
 	ns_pinctrl->dev = dev;
 
-	of_id = of_match_device(ns_pinctrl_of_match_table, dev);
-	if (!of_id)
-		return -EINVAL;
-	ns_pinctrl->chipset_flag = (uintptr_t)of_id->data;
+	ns_pinctrl->chipset_flag = (uintptr_t)device_get_match_data(dev);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "cru_gpio_control");
diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index acbd413340e8b..15aed44676271 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -8,8 +8,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "berlin.h"
@@ -227,10 +228,7 @@ static const struct of_device_id berlin2_pinctrl_match[] = {
 
 static int berlin2_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(berlin2_pinctrl_match, &pdev->dev);
-
-	return berlin_pinctrl_probe(pdev, match->data);
+	return berlin_pinctrl_probe(pdev, device_get_match_data(&pdev->dev));
 }
 
 static struct platform_driver berlin2_pinctrl_driver = {
diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index c0f5d86d5d01d..73a1d8c230886 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -8,8 +8,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "berlin.h"
@@ -172,10 +173,7 @@ static const struct of_device_id berlin2cd_pinctrl_match[] = {
 
 static int berlin2cd_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(berlin2cd_pinctrl_match, &pdev->dev);
-
-	return berlin_pinctrl_probe(pdev, match->data);
+	return berlin_pinctrl_probe(pdev, device_get_match_data(&pdev->dev));
 }
 
 static struct platform_driver berlin2cd_pinctrl_driver = {
diff --git a/drivers/pinctrl/berlin/berlin-bg2q.c b/drivers/pinctrl/berlin/berlin-bg2q.c
index 20a3216ede07a..a5dbc8f279e70 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -8,8 +8,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "berlin.h"
@@ -389,10 +390,7 @@ static const struct of_device_id berlin2q_pinctrl_match[] = {
 
 static int berlin2q_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(berlin2q_pinctrl_match, &pdev->dev);
-
-	return berlin_pinctrl_probe(pdev, match->data);
+	return berlin_pinctrl_probe(pdev, device_get_match_data(&pdev->dev));
 }
 
 static struct platform_driver berlin2q_pinctrl_driver = {
diff --git a/drivers/pinctrl/berlin/berlin-bg4ct.c b/drivers/pinctrl/berlin/berlin-bg4ct.c
index 3026a3b3da2dd..9bf0a54f2798a 100644
--- a/drivers/pinctrl/berlin/berlin-bg4ct.c
+++ b/drivers/pinctrl/berlin/berlin-bg4ct.c
@@ -8,8 +8,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "berlin.h"
@@ -449,8 +450,8 @@ static const struct of_device_id berlin4ct_pinctrl_match[] = {
 
 static int berlin4ct_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(berlin4ct_pinctrl_match, &pdev->dev);
+	const struct berlin_pinctrl_desc *desc =
+		device_get_match_data(&pdev->dev);
 	struct regmap_config *rmconfig;
 	struct regmap *regmap;
 	struct resource *res;
@@ -473,7 +474,7 @@ static int berlin4ct_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return berlin_pinctrl_probe_regmap(pdev, match->data, regmap);
+	return berlin_pinctrl_probe_regmap(pdev, desc, regmap);
 }
 
 static struct platform_driver berlin4ct_pinctrl_driver = {
diff --git a/drivers/pinctrl/berlin/pinctrl-as370.c b/drivers/pinctrl/berlin/pinctrl-as370.c
index b631c14813a7d..fc0daec94e105 100644
--- a/drivers/pinctrl/berlin/pinctrl-as370.c
+++ b/drivers/pinctrl/berlin/pinctrl-as370.c
@@ -8,8 +8,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "berlin.h"
@@ -330,8 +331,8 @@ static const struct of_device_id as370_pinctrl_match[] = {
 
 static int as370_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(as370_pinctrl_match, &pdev->dev);
+	const struct berlin_pinctrl_desc *desc =
+		device_get_match_data(&pdev->dev);
 	struct regmap_config *rmconfig;
 	struct regmap *regmap;
 	struct resource *res;
@@ -354,7 +355,7 @@ static int as370_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return berlin_pinctrl_probe_regmap(pdev, match->data, regmap);
+	return berlin_pinctrl_probe_regmap(pdev, desc, regmap);
 }
 
 static struct platform_driver as370_pinctrl_driver = {
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 040e418dbfc1b..162dfc213669a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -12,8 +12,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/property.h>
 
 #include "pinctrl-mvebu.h"
 
@@ -404,13 +404,8 @@ static struct pinctrl_gpio_range armada_38x_mpp_gpio_ranges[] = {
 static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_38x_pinctrl_info;
-	const struct of_device_id *match =
-		of_match_device(armada_38x_pinctrl_of_match, &pdev->dev);
 
-	if (!match)
-		return -ENODEV;
-
-	soc->variant = (unsigned) match->data & 0xff;
+	soc->variant = (unsigned)device_get_match_data(&pdev->dev) & 0xff;
 	soc->controls = armada_38x_mpp_controls;
 	soc->ncontrols = ARRAY_SIZE(armada_38x_mpp_controls);
 	soc->gpioranges = armada_38x_mpp_gpio_ranges;
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index c33f1cbaf661a..d9c98faa7b0e9 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -12,8 +12,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/property.h>
 
 #include "pinctrl-mvebu.h"
 
@@ -386,13 +386,8 @@ static struct pinctrl_gpio_range armada_39x_mpp_gpio_ranges[] = {
 static int armada_39x_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_39x_pinctrl_info;
-	const struct of_device_id *match =
-		of_match_device(armada_39x_pinctrl_of_match, &pdev->dev);
 
-	if (!match)
-		return -ENODEV;
-
-	soc->variant = (unsigned) match->data & 0xff;
+	soc->variant = (unsigned)device_get_match_data(&pdev->dev) & 0xff;
 	soc->controls = armada_39x_mpp_controls;
 	soc->ncontrols = ARRAY_SIZE(armada_39x_mpp_controls);
 	soc->gpioranges = armada_39x_mpp_gpio_ranges;
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-ap806.c b/drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
index 89bab536717df..7becf2781a0b9 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
@@ -13,7 +13,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-mvebu.h"
@@ -106,10 +105,8 @@ static struct pinctrl_gpio_range armada_ap806_mpp_gpio_ranges[] = {
 static int armada_ap806_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_ap806_pinctrl_info;
-	const struct of_device_id *match =
-		of_match_device(armada_ap806_pinctrl_of_match, &pdev->dev);
 
-	if (!match || !pdev->dev.parent)
+	if (!pdev->dev.parent)
 		return -ENODEV;
 
 	soc->variant = 0; /* no variants for Armada AP806 */
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-cp110.c b/drivers/pinctrl/mvebu/pinctrl-armada-cp110.c
index 8ba8f3e9121f0..9a250c491f33d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-cp110.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-cp110.c
@@ -12,9 +12,9 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include "pinctrl-mvebu.h"
 
@@ -638,8 +638,6 @@ static void mvebu_pinctrl_assign_variant(struct mvebu_mpp_mode *m,
 static int armada_cp110_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc;
-	const struct of_device_id *match =
-		of_match_device(armada_cp110_pinctrl_of_match, &pdev->dev);
 	int i;
 
 	if (!pdev->dev.parent)
@@ -650,7 +648,7 @@ static int armada_cp110_pinctrl_probe(struct platform_device *pdev)
 	if (!soc)
 		return -ENOMEM;
 
-	soc->variant = (unsigned long) match->data & 0xff;
+	soc->variant = (unsigned long)device_get_match_data(&pdev->dev) & 0xff;
 	soc->controls = armada_cp110_mpp_controls;
 	soc->ncontrols = ARRAY_SIZE(armada_cp110_mpp_controls);
 	soc->modes = armada_cp110_mpp_modes;
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 48e2a6c56a83b..487825bfd125f 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -19,8 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/property.h>
 #include <linux/bitops.h>
 
 #include "pinctrl-mvebu.h"
@@ -568,14 +568,9 @@ static int armada_xp_pinctrl_resume(struct platform_device *pdev)
 static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_xp_pinctrl_info;
-	const struct of_device_id *match =
-		of_match_device(armada_xp_pinctrl_of_match, &pdev->dev);
 	int nregs;
 
-	if (!match)
-		return -ENODEV;
-
-	soc->variant = (unsigned) match->data & 0xff;
+	soc->variant = (unsigned)device_get_match_data(&pdev->dev) & 0xff;
 
 	switch (soc->variant) {
 	case V_MV78230:
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index bd74daa9ed666..1947da73e5121 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -12,9 +12,9 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "pinctrl-mvebu.h"
@@ -765,13 +765,11 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 {
 	struct resource *res, *mpp_res;
 	struct resource fb_res;
-	const struct of_device_id *match =
-		of_match_device(dove_pinctrl_of_match, &pdev->dev);
 	struct mvebu_mpp_ctrl_data *mpp_data;
 	void __iomem *base;
 	int i;
 
-	pdev->dev.platform_data = (void *)match->data;
+	pdev->dev.platform_data = (void *)device_get_match_data(&pdev->dev);
 
 	/*
 	 * General MPP Configuration Register is part of pdma registers.
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index d45c31f281c85..4789d7442f788 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -11,8 +11,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/property.h>
 
 #include "pinctrl-mvebu.h"
 
@@ -470,10 +470,7 @@ static const struct of_device_id kirkwood_pinctrl_of_match[] = {
 
 static int kirkwood_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(kirkwood_pinctrl_of_match, &pdev->dev);
-
-	pdev->dev.platform_data = (void *)match->data;
+	pdev->dev.platform_data = (void *)device_get_match_data(&pdev->dev);
 
 	return mvebu_pinctrl_simple_mmio_probe(pdev);
 }
diff --git a/drivers/pinctrl/mvebu/pinctrl-orion.c b/drivers/pinctrl/mvebu/pinctrl-orion.c
index cc97d270be61b..2b6ab7f2afc78 100644
--- a/drivers/pinctrl/mvebu/pinctrl-orion.c
+++ b/drivers/pinctrl/mvebu/pinctrl-orion.c
@@ -19,8 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/property.h>
 
 #include "pinctrl-mvebu.h"
 
@@ -218,10 +218,7 @@ static const struct of_device_id orion_pinctrl_of_match[] = {
 
 static int orion_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(orion_pinctrl_of_match, &pdev->dev);
-
-	pdev->dev.platform_data = (void*)match->data;
+	pdev->dev.platform_data = (void*)device_get_match_data(&pdev->dev);
 
 	mpp_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mpp_base))
diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 6b90051af2067..0cfa74365733c 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -985,7 +986,6 @@ static const struct of_device_id abx500_gpio_match[] = {
 static int abx500_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct abx500_pinctrl *pct;
 	unsigned int id = -1;
 	int ret;
@@ -1006,12 +1006,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 	pct->chip.parent = &pdev->dev;
 	pct->chip.base = -1; /* Dynamic allocation */
 
-	match = of_match_device(abx500_gpio_match, &pdev->dev);
-	if (!match) {
-		dev_err(&pdev->dev, "gpio dt not matching\n");
-		return -ENODEV;
-	}
-	id = (unsigned long)match->data;
+	id = (unsigned long)device_get_match_data(&pdev->dev);
 
 	/* Poke in other ASIC variants here */
 	switch (id) {
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index e7d33093994b2..445c61a4a7e55 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -16,9 +16,11 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -1840,7 +1842,6 @@ static int nmk_pinctrl_resume(struct device *dev)
 
 static int nmk_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *prcm_np;
 	struct nmk_pinctrl *npct;
@@ -1851,10 +1852,7 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	if (!npct)
 		return -ENOMEM;
 
-	match = of_match_device(nmk_pinctrl_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-	version = (unsigned int) match->data;
+	version = (unsigned int)device_get_match_data(&pdev->dev);
 
 	/* Poke in other ASIC variants here */
 	if (version == PINCTRL_NMK_STN8815)
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index ad30fd47a4bb0..d7b66928a4e50 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -12,10 +12,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string_helpers.h>
@@ -1302,8 +1301,8 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	info->dev = dev;
-	info->ops = of_device_get_match_data(dev);
+	info->dev = &pdev->dev;
+	info->ops = device_get_match_data(&pdev->dev);
 	at91_pinctrl_child_count(info, np);
 
 	/*
@@ -1848,7 +1847,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(at91_chip->regbase))
 		return PTR_ERR(at91_chip->regbase);
 
-	at91_chip->ops = of_device_get_match_data(dev);
+	at91_chip->ops = device_get_match_data(dev);
 	at91_chip->pioc_virq = irq;
 
 	at91_chip->clock = devm_clk_get_enabled(dev, NULL);
diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index cf0383f575d9c..f4256a918165f 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -11,12 +11,12 @@
 #include <linux/gpio/driver.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include "pinctrl-lantiq.h"
 
@@ -1451,7 +1451,6 @@ MODULE_DEVICE_TABLE(of, xway_match);
 
 static int pinmux_xway_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	const struct pinctrl_xway_soc *xway_soc;
 	int ret, i;
 
@@ -1460,10 +1459,8 @@ static int pinmux_xway_probe(struct platform_device *pdev)
 	if (IS_ERR(xway_info.membase[0]))
 		return PTR_ERR(xway_info.membase[0]);
 
-	match = of_match_device(xway_match, &pdev->dev);
-	if (match)
-		xway_soc = (const struct pinctrl_xway_soc *) match->data;
-	else
+	xway_soc = device_get_match_data(&pdev->dev);
+	if (!xway_soc)
 		xway_soc = &danube_pinctrl;
 
 	/* find out how many pads we have */
diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index 81ae6737928a5..ef97586385019 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -14,7 +14,8 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -822,7 +823,6 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = of_node_get(dev->of_node);
-	const struct of_device_id *match;
 	struct resource *res;
 	struct ti_iodelay_device *iod;
 	int ret = 0;
@@ -833,20 +833,18 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 		goto exit_out;
 	}
 
-	match = of_match_device(ti_iodelay_of_match, dev);
-	if (!match) {
-		ret = -EINVAL;
-		dev_err(dev, "No DATA match\n");
-		goto exit_out;
-	}
-
 	iod = devm_kzalloc(dev, sizeof(*iod), GFP_KERNEL);
 	if (!iod) {
 		ret = -ENOMEM;
 		goto exit_out;
 	}
 	iod->dev = dev;
-	iod->reg_data = match->data;
+	iod->reg_data = device_get_match_data(dev);
+	if (!iod->reg_data) {
+		ret = -EINVAL;
+		dev_err(dev, "No DATA match\n");
+		goto exit_out;
+	}
 
 	/* So far We can assume there is only 1 bank of registers */
 	iod->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-- 
2.43.0




