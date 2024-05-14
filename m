Return-Path: <stable+bounces-44731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C48C5425
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8152F1F2337A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747F139569;
	Tue, 14 May 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mgnLWHKf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B4133993;
	Tue, 14 May 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687013; cv=none; b=S4+Nl9psIOtfk8+482dbgr6/Su3kxqdwXcjhifI+0iIW39BJb9QTd8j3vWvjLln+7HjwFMmuQboC4kYafLyJ6CXswLTJEMefXIbmxE0p4uAtsNnWDeXzGm5r+Y1/MKvNMcNdE8N5D7Xs+CmHdTYBrx/F0LXdycwVPr2g5r7juWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687013; c=relaxed/simple;
	bh=MfE+aCw4kFN+rrIsp7+aeAEFs2zNlGpKVf8J70hquYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHCRcPZxzvd+iAxo3pbuLqFowrN2BRTxMKAfNaH/i4sZhH16kv+w2FeLrgiTnaq6IMBG6boxWqTA8vymOQEeIIHOO/msBNDU6HHvL+mepAFtbvl+/i7zBAdQWpHySXHhyjsAdFfaLGVs+LAz+g1Ptrf/QJ8xp2NzUoYnOozxhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mgnLWHKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD25FC2BD10;
	Tue, 14 May 2024 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687013;
	bh=MfE+aCw4kFN+rrIsp7+aeAEFs2zNlGpKVf8J70hquYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgnLWHKfU/4VfMkyZq+8Mt5qyXixWuMcLHFwseoLuyjhknhwF2NkdgOghGEHIyhuB
	 ZqAG69nYymzDof3jVGc6FndLZWGZqlGP129NXOphASrbCT8YrrFWWncyhIF2PPMKI9
	 iLcyop9jQHYIJD5XhrccoEijhyMAQCIu892EO6NE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Light Hsieh <light.hsieh@mediatek.com>,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 09/84] pinctrl: mediatek: Backward compatible to previous Mediateks bias-pull usage
Date: Tue, 14 May 2024 12:19:20 +0200
Message-ID: <20240514100952.043150169@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100951.686412426@linuxfoundation.org>
References: <20240514100951.686412426@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Light Hsieh <light.hsieh@mediatek.com>

[ Upstream commit cafe19db7751269bf6b4dd2148cbfa9fbe91d651 ]

Refine mtk_pinconf_set()/mtk_pinconf_get() for backward compatibility to
previous MediaTek's bias-pull usage.
In PINCTRL_MTK that use pinctrl-mtk-common.c, bias-pull setting for pins
with 2 pull resistors can be specified as value for bias-pull-up and
bias-pull-down. For example:
    bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
    bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
    bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
    bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
    bias-pull-down = <MTK_PUPD_SET_R1R0_00>;
    bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
    bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
    bias-pull-down = <MTK_PUPD_SET_R1R0_11>;

On the other hand, PINCTRL_MTK_PARIS use customized properties
"mediatek,pull-up-adv" and "mediatek,pull-down-adv" to specify bias-pull
setting for pins with 2 pull resistors.
This introduce in-compatibility in device tree and increase porting
effort to MediaTek's customer that had already used PINCTRL_MTK version.
Besides, if customers are not aware of this change and still write devicetree
for PINCTRL_MTK version, they may encounter runtime failure with pinctrl and
spent time to debug.

This patch adds backward compatible to previous MediaTek's bias-pull usage
so that Mediatek's customer need not use a new devicetree property name.
The rationale is that: changing driver implementation had better leave
interface unchanged.

Signed-off-by: Light Hsieh <light.hsieh@mediatek.com>
Link: https://lore.kernel.org/r/1579675994-7001-5-git-send-email-light.hsieh@mediatek.com
Acked-by: Sean Wang <sean.wang@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: c5d3b64c568a ("pinctrl: mediatek: paris: Rework support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt6765.c     |   6 +-
 drivers/pinctrl/mediatek/pinctrl-mt8183.c     |   6 +-
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.c  | 221 ++++++++++++++++++
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.h  |  11 +
 drivers/pinctrl/mediatek/pinctrl-paris.c      |  49 ++--
 5 files changed, 265 insertions(+), 28 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6765.c b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
index 7fae397fe27c1..905dae8c3fd86 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6765.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
@@ -1072,10 +1072,8 @@ static const struct mtk_pin_soc mt6765_data = {
 	.gpio_m = 0,
 	.base_names = mt6765_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt6765_pinctrl_register_base_names),
-	.bias_disable_set = mtk_pinconf_bias_disable_set,
-	.bias_disable_get = mtk_pinconf_bias_disable_get,
-	.bias_set = mtk_pinconf_bias_set,
-	.bias_get = mtk_pinconf_bias_get,
+	.bias_set_combo = mtk_pinconf_bias_set_combo,
+	.bias_get_combo = mtk_pinconf_bias_get_combo,
 	.drive_set = mtk_pinconf_drive_set_raw,
 	.drive_get = mtk_pinconf_drive_get_raw,
 	.adv_pull_get = mtk_pinconf_adv_pull_get,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index 4eca81864a965..60318339b6183 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -556,10 +556,8 @@ static const struct mtk_pin_soc mt8183_data = {
 	.gpio_m = 0,
 	.base_names = mt8183_pinctrl_register_base_names,
 	.nbase_names = ARRAY_SIZE(mt8183_pinctrl_register_base_names),
-	.bias_disable_set = mtk_pinconf_bias_disable_set_rev1,
-	.bias_disable_get = mtk_pinconf_bias_disable_get_rev1,
-	.bias_set = mtk_pinconf_bias_set_rev1,
-	.bias_get = mtk_pinconf_bias_get_rev1,
+	.bias_set_combo = mtk_pinconf_bias_set_combo,
+	.bias_get_combo = mtk_pinconf_bias_get_combo,
 	.drive_set = mtk_pinconf_drive_set_rev1,
 	.drive_get = mtk_pinconf_drive_get_rev1,
 	.adv_pull_get = mtk_pinconf_adv_pull_get,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index fb87feec7bd3f..634d652aed671 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <dt-bindings/pinctrl/mt65xx.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
@@ -521,6 +522,226 @@ int mtk_pinconf_bias_get_rev1(struct mtk_pinctrl *hw,
 	return 0;
 }
 
+/* Combo for the following pull register type:
+ * 1. PU + PD
+ * 2. PULLSEL + PULLEN
+ * 3. PUPD + R0 + R1
+ */
+static int mtk_pinconf_bias_set_pu_pd(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
+				u32 pullup, u32 arg)
+{
+	int err, pu, pd;
+
+	if (arg == MTK_DISABLE) {
+		pu = 0;
+		pd = 0;
+	} else if ((arg == MTK_ENABLE) && pullup) {
+		pu = 1;
+		pd = 0;
+	} else if ((arg == MTK_ENABLE) && !pullup) {
+		pu = 0;
+		pd = 1;
+	} else {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PU, pu);
+	if (err)
+		goto out;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PD, pd);
+
+out:
+	return err;
+}
+
+static int mtk_pinconf_bias_set_pullsel_pullen(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
+				u32 pullup, u32 arg)
+{
+	int err, enable;
+
+	if (arg == MTK_DISABLE)
+		enable = 0;
+	else if (arg == MTK_ENABLE)
+		enable = 1;
+	else {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PULLEN, enable);
+	if (err)
+		goto out;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PULLSEL, pullup);
+
+out:
+	return err;
+}
+
+static int mtk_pinconf_bias_set_pupd_r1_r0(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
+				u32 pullup, u32 arg)
+{
+	int err, r0, r1;
+
+	if ((arg == MTK_DISABLE) || (arg == MTK_PUPD_SET_R1R0_00)) {
+		pullup = 0;
+		r0 = 0;
+		r1 = 0;
+	} else if (arg == MTK_PUPD_SET_R1R0_01) {
+		r0 = 1;
+		r1 = 0;
+	} else if (arg == MTK_PUPD_SET_R1R0_10) {
+		r0 = 0;
+		r1 = 1;
+	} else if (arg == MTK_PUPD_SET_R1R0_11) {
+		r0 = 1;
+		r1 = 1;
+	} else {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* MTK HW PUPD bit: 1 for pull-down, 0 for pull-up */
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PUPD, !pullup);
+	if (err)
+		goto out;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_R0, r0);
+	if (err)
+		goto out;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_R1, r1);
+
+out:
+	return err;
+}
+
+static int mtk_pinconf_bias_get_pu_pd(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
+				u32 *pullup, u32 *enable)
+{
+	int err, pu, pd;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PU, &pu);
+	if (err)
+		goto out;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PD, &pd);
+	if (err)
+		goto out;
+
+	if (pu == 0 && pd == 0) {
+		*pullup = 0;
+		*enable = MTK_DISABLE;
+	} else if (pu == 1 && pd == 0) {
+		*pullup = 1;
+		*enable = MTK_ENABLE;
+	} else if (pu == 0 && pd == 1) {
+		*pullup = 0;
+		*enable = MTK_ENABLE;
+	} else
+		err = -EINVAL;
+
+out:
+	return err;
+}
+
+static int mtk_pinconf_bias_get_pullsel_pullen(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
+				u32 *pullup, u32 *enable)
+{
+	int err;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PULLSEL, pullup);
+	if (err)
+		goto out;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PULLEN, enable);
+
+out:
+	return err;
+}
+
+static int mtk_pinconf_bias_get_pupd_r1_r0(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
+				u32 *pullup, u32 *enable)
+{
+	int err, r0, r1;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PUPD, pullup);
+	if (err)
+		goto out;
+	/* MTK HW PUPD bit: 1 for pull-down, 0 for pull-up */
+	*pullup = !(*pullup);
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_R0, &r0);
+	if (err)
+		goto out;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_R1, &r1);
+	if (err)
+		goto out;
+
+	if ((r1 == 0) && (r0 == 0))
+		*enable = MTK_PUPD_SET_R1R0_00;
+	else if ((r1 == 0) && (r0 == 1))
+		*enable = MTK_PUPD_SET_R1R0_01;
+	else if ((r1 == 1) && (r0 == 0))
+		*enable = MTK_PUPD_SET_R1R0_10;
+	else if ((r1 == 1) && (r0 == 1))
+		*enable = MTK_PUPD_SET_R1R0_11;
+	else
+		err = -EINVAL;
+
+out:
+	return err;
+}
+
+int mtk_pinconf_bias_set_combo(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
+				u32 pullup, u32 arg)
+{
+	int err;
+
+	err = mtk_pinconf_bias_set_pu_pd(hw, desc, pullup, arg);
+	if (!err)
+		goto out;
+
+	err = mtk_pinconf_bias_set_pullsel_pullen(hw, desc, pullup, arg);
+	if (!err)
+		goto out;
+
+	err = mtk_pinconf_bias_set_pupd_r1_r0(hw, desc, pullup, arg);
+
+out:
+	return err;
+}
+
+int mtk_pinconf_bias_get_combo(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc,
+			      u32 *pullup, u32 *enable)
+{
+	int err;
+
+	err = mtk_pinconf_bias_get_pu_pd(hw, desc, pullup, enable);
+	if (!err)
+		goto out;
+
+	err = mtk_pinconf_bias_get_pullsel_pullen(hw, desc, pullup, enable);
+	if (!err)
+		goto out;
+
+	err = mtk_pinconf_bias_get_pupd_r1_r0(hw, desc, pullup, enable);
+
+out:
+	return err;
+}
+
 /* Revision 0 */
 int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 			  const struct mtk_pin_desc *desc, u32 arg)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 75d0e0712c03f..27df087363960 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -216,6 +216,11 @@ struct mtk_pin_soc {
 	int (*bias_get)(struct mtk_pinctrl *hw,
 			const struct mtk_pin_desc *desc, bool pullup, int *res);
 
+	int (*bias_set_combo)(struct mtk_pinctrl *hw,
+			const struct mtk_pin_desc *desc, u32 pullup, u32 arg);
+	int (*bias_get_combo)(struct mtk_pinctrl *hw,
+			const struct mtk_pin_desc *desc, u32 *pullup, u32 *arg);
+
 	int (*drive_set)(struct mtk_pinctrl *hw,
 			 const struct mtk_pin_desc *desc, u32 arg);
 	int (*drive_get)(struct mtk_pinctrl *hw,
@@ -277,6 +282,12 @@ int mtk_pinconf_bias_set_rev1(struct mtk_pinctrl *hw,
 int mtk_pinconf_bias_get_rev1(struct mtk_pinctrl *hw,
 			      const struct mtk_pin_desc *desc, bool pullup,
 			      int *res);
+int mtk_pinconf_bias_set_combo(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc,
+				u32 pullup, u32 enable);
+int mtk_pinconf_bias_get_combo(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc,
+			      u32 *pullup, u32 *enable);
 
 int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 			  const struct mtk_pin_desc *desc, u32 arg);
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 9bd62c22128f2..18706c46d46ba 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -78,7 +78,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	u32 param = pinconf_to_config_param(*config);
-	int err, reg, ret = 1;
+	int pullup, err, reg, ret = 1;
 	const struct mtk_pin_desc *desc;
 
 	if (pin >= hw->soc->npins) {
@@ -89,22 +89,31 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		if (hw->soc->bias_disable_get)
-			err = hw->soc->bias_disable_get(hw, desc, &ret);
-		else
-			err = -ENOTSUPP;
-		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		if (hw->soc->bias_get)
-			err = hw->soc->bias_get(hw, desc, 1, &ret);
-		else
-			err = -ENOTSUPP;
-		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_get)
-			err = hw->soc->bias_get(hw, desc, 0, &ret);
-		else
+		if (hw->soc->bias_get_combo) {
+			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
+			if (err)
+				goto out;
+			if (param == PIN_CONFIG_BIAS_DISABLE) {
+				if (ret == MTK_PUPD_SET_R1R0_00)
+					ret = MTK_DISABLE;
+			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
+				/* When desire to get pull-up value, return
+				 *  error if current setting is pull-down
+				 */
+				if (!pullup)
+					err = -EINVAL;
+			} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
+				/* When desire to get pull-down value, return
+				 *  error if current setting is pull-up
+				 */
+				if (pullup)
+					err = -EINVAL;
+			}
+		} else {
 			err = -ENOTSUPP;
+		}
 		break;
 	case PIN_CONFIG_SLEW_RATE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SR, &ret);
@@ -195,20 +204,20 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 	switch ((u32)param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		if (hw->soc->bias_disable_set)
-			err = hw->soc->bias_disable_set(hw, desc);
+		if (hw->soc->bias_set_combo)
+			err = hw->soc->bias_set_combo(hw, desc, 0, MTK_DISABLE);
 		else
 			err = -ENOTSUPP;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		if (hw->soc->bias_set)
-			err = hw->soc->bias_set(hw, desc, 1);
+		if (hw->soc->bias_set_combo)
+			err = hw->soc->bias_set_combo(hw, desc, 1, arg);
 		else
 			err = -ENOTSUPP;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_set)
-			err = hw->soc->bias_set(hw, desc, 0);
+		if (hw->soc->bias_set_combo)
+			err = hw->soc->bias_set_combo(hw, desc, 0, arg);
 		else
 			err = -ENOTSUPP;
 		break;
-- 
2.43.0




