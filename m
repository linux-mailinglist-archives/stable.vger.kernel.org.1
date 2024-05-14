Return-Path: <stable+bounces-44938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98D8C550C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCEA1F22CE1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F23D971;
	Tue, 14 May 2024 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gl/9LoBh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C9B320F;
	Tue, 14 May 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687613; cv=none; b=nnbDvthWWFMwBNaOcIoCN0re+BfSfwdUwJ1TsLy6bqwDLmurRKaTibeoMFOpVkTqGONXZvsX+ar9nIWybSUFlLH4mvw0NDSGyae7Y1Xe9EGJYkQkeJVzxylyrbzkELr8iZ/cHKRGLcc3xuno4xunB2WIac4ip+gPENB+HHcI9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687613; c=relaxed/simple;
	bh=6OmtiUvY2ZeQlT8lzG4p5C+xosPtQMRPiJkuTJA0bus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E39D6kiu987UTw2lQa6KvCdQaylMU47mlGbmwKWVo2Ga5k2BQhsbelOl6SJCsUlqQ5j+wc3YjMx6+bSHAVvf2OHJM+7/+9lQOUmidIdSJTIe/GdKdK8ZC/JR09Kl7x2hmoMDnm48GXsErVqVpz5ejnwaNFtz2J6EBqAGaF62O0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gl/9LoBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE94C2BD10;
	Tue, 14 May 2024 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687612;
	bh=6OmtiUvY2ZeQlT8lzG4p5C+xosPtQMRPiJkuTJA0bus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gl/9LoBhU0lpgegW0FYe50wMPJ5rK5ecNELiu/2DI7e+Ne22PVNDiVd0CNhRVd2x4
	 UQ72BPc1ptoz6c/GZwiDFipq2uRj4gxrFOeX+R7G7VR0OnFtdxGzyLFUrzynohA5tv
	 Y8ZgLkWTsDOkN4mBOxV5AihX2OEcEMGBO1QkaIcE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 013/168] pinctrl: mediatek: paris: Rework mtk_pinconf_{get,set} switch/case logic
Date: Tue, 14 May 2024 12:18:31 +0200
Message-ID: <20240514101007.188252802@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 9b780fa1ff14663c2e0f07ad098b96b8337f27a4 ]

The current code deals with optional features by testing for the
function pointers and returning -ENOTSUPP if it is not valid. This is
done for multiple pin config settings and results in the code that
handles the supporting cases to get indented by one level. This is
aggrevated by the fact that some features require another level of
conditionals.

Instead of assigning the same error code in all unsupported optional
feature cases, simply have that error code as the default, and break
out of the switch/case block whenever a feature is unsupported, or an
error is returned. This reduces indentation by one level for the useful
code.

Also replace the goto statements with break statements. The result is
the same, as the gotos simply exit the switch/case block, which can
also be achieved with a break statement. With the latter the intent
is clear and easier to understand.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20220308100956.2750295-8-wenst@chromium.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: 08f66a8edd08 ("pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 144 ++++++++++-------------
 1 file changed, 61 insertions(+), 83 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 0fa1c36148c23..f17325a738eaa 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -79,37 +79,34 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	u32 param = pinconf_to_config_param(*config);
-	int pullup, err, reg, ret = 1;
+	int pullup, reg, err = -ENOTSUPP, ret = 1;
 	const struct mtk_pin_desc *desc;
 
-	if (pin >= hw->soc->npins) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (pin >= hw->soc->npins)
+		return -EINVAL;
+
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_get_combo) {
-			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
-			if (err)
-				goto out;
-			if (ret == MTK_PUPD_SET_R1R0_00)
-				ret = MTK_DISABLE;
-			if (param == PIN_CONFIG_BIAS_DISABLE) {
-				if (ret != MTK_DISABLE)
-					err = -EINVAL;
-			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
-				if (!pullup || ret == MTK_DISABLE)
-					err = -EINVAL;
-			} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
-				if (pullup || ret == MTK_DISABLE)
-					err = -EINVAL;
-			}
-		} else {
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_get_combo)
+			break;
+		err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
+		if (err)
+			break;
+		if (ret == MTK_PUPD_SET_R1R0_00)
+			ret = MTK_DISABLE;
+		if (param == PIN_CONFIG_BIAS_DISABLE) {
+			if (ret != MTK_DISABLE)
+				err = -EINVAL;
+		} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
+			if (!pullup || ret == MTK_DISABLE)
+				err = -EINVAL;
+		} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
+			if (pullup || ret == MTK_DISABLE)
+				err = -EINVAL;
 		}
 		break;
 	case PIN_CONFIG_SLEW_RATE:
@@ -119,7 +116,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_OUTPUT_ENABLE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
 		if (err)
-			goto out;
+			break;
 		/*     CONFIG     Current direction return value
 		 * -------------  ----------------- ----------------------
 		 * OUTPUT_ENABLE       output       1 (= HW value)
@@ -134,23 +131,21 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &ret);
 		if (err)
-			goto out;
+			break;
 		/* return error when in output mode
 		 * because schmitt trigger only work in input mode
 		 */
 		if (ret) {
 			err = -EINVAL;
-			goto out;
+			break;
 		}
 
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SMT, &ret);
-
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		if (hw->soc->drive_get)
-			err = hw->soc->drive_get(hw, desc, &ret);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->drive_get)
+			break;
+		err = hw->soc->drive_get(hw, desc, &ret);
 		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
@@ -160,23 +155,18 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 	case MTK_PIN_CONFIG_PU_ADV:
 	case MTK_PIN_CONFIG_PD_ADV:
-		if (hw->soc->adv_pull_get) {
-			pullup = param == MTK_PIN_CONFIG_PU_ADV;
-			err = hw->soc->adv_pull_get(hw, desc, pullup, &ret);
-		} else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_pull_get)
+			break;
+		pullup = param == MTK_PIN_CONFIG_PU_ADV;
+		err = hw->soc->adv_pull_get(hw, desc, pullup, &ret);
 		break;
 	case MTK_PIN_CONFIG_DRV_ADV:
-		if (hw->soc->adv_drive_get)
-			err = hw->soc->adv_drive_get(hw, desc, &ret);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_drive_get)
+			break;
+		err = hw->soc->adv_drive_get(hw, desc, &ret);
 		break;
-	default:
-		err = -ENOTSUPP;
 	}
 
-out:
 	if (!err)
 		*config = pinconf_to_config_packed(param, ret);
 
@@ -188,33 +178,29 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	const struct mtk_pin_desc *desc;
-	int err = 0;
+	int err = -ENOTSUPP;
 	u32 reg;
 
-	if (pin >= hw->soc->npins) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (pin >= hw->soc->npins)
+		return -EINVAL;
+
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
 	switch ((u32)param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 0, MTK_DISABLE);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 0, MTK_DISABLE);
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 1, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 1, arg);
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		if (hw->soc->bias_set_combo)
-			err = hw->soc->bias_set_combo(hw, desc, 0, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->bias_set_combo)
+			break;
+		err = hw->soc->bias_set_combo(hw, desc, 0, arg);
 		break;
 	case PIN_CONFIG_OUTPUT_ENABLE:
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
@@ -223,7 +209,7 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		 *  does not have SMT control
 		 */
 		if (err != -ENOTSUPP)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 				       MTK_OUTPUT);
@@ -232,7 +218,7 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		/* regard all non-zero value as enable */
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES, !!arg);
 		if (err)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 				       MTK_INPUT);
@@ -245,7 +231,7 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DO,
 				       arg);
 		if (err)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
 				       MTK_OUTPUT);
@@ -257,15 +243,14 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		 */
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR, !arg);
 		if (err)
-			goto err;
+			break;
 
 		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, !!arg);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		if (hw->soc->drive_set)
-			err = hw->soc->drive_set(hw, desc, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->drive_set)
+			break;
+		err = hw->soc->drive_set(hw, desc, arg);
 		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
@@ -275,26 +260,19 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		break;
 	case MTK_PIN_CONFIG_PU_ADV:
 	case MTK_PIN_CONFIG_PD_ADV:
-		if (hw->soc->adv_pull_set) {
-			bool pullup;
-
-			pullup = param == MTK_PIN_CONFIG_PU_ADV;
-			err = hw->soc->adv_pull_set(hw, desc, pullup,
-						    arg);
-		} else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_pull_set)
+			break;
+		err = hw->soc->adv_pull_set(hw, desc,
+					    (param == MTK_PIN_CONFIG_PU_ADV),
+					    arg);
 		break;
 	case MTK_PIN_CONFIG_DRV_ADV:
-		if (hw->soc->adv_drive_set)
-			err = hw->soc->adv_drive_set(hw, desc, arg);
-		else
-			err = -ENOTSUPP;
+		if (!hw->soc->adv_drive_set)
+			break;
+		err = hw->soc->adv_drive_set(hw, desc, arg);
 		break;
-	default:
-		err = -ENOTSUPP;
 	}
 
-err:
 	return err;
 }
 
-- 
2.43.0




