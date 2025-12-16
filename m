Return-Path: <stable+bounces-202092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43C2CC442F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13265305D1CF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCC341AAF;
	Tue, 16 Dec 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yhfBfgwd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A535CBB7;
	Tue, 16 Dec 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886788; cv=none; b=HLBKR7/257qZ48N1bxtBUmyTVUVASOXOYlROIG8EVqmcPBrkOLXzK1bZ55muColw+ikg7ciVnTw/ONsEWJFgaGs4aPFRvU2xJYKpYKI+yX6ThxRvMUq/1cXm00VOmbr5RcYbzQRBzVvok2EZhHxTKQsfEF7CVlT78YFxUXM5bcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886788; c=relaxed/simple;
	bh=SkBRQCB/Qhf9OBw/d9zzle+SbFRlhMtm01xBEEom5nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqdajqTgqQWgHaVTsaTCijyxnEv+EJeYMkUDu+aR+FMu+TML0CMRT9op0fqdCjEZupp9JXh0D5sc6lTUgtTCLR30CfodXlskKjdYYfxw3Z4JQ430M0pMDWCNdbBr2jZLKKqLBXj6zxVF7KgFUTgGDYnv3yT4hG8++iQKPeKC5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yhfBfgwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF332C4CEF1;
	Tue, 16 Dec 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886788;
	bh=SkBRQCB/Qhf9OBw/d9zzle+SbFRlhMtm01xBEEom5nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yhfBfgwdrZwg4dcoyU6zAhssYI5/uvZNXKYFCXp6/b95GKeOFLNTtEKTLrAWfOReC
	 Dxr/euzGBoBe6AHVKVJXcZJc/tyFfoR37t7HtITS1rY0tV+EZL3KCdaVDCQnFwZOKg
	 wDDswmtvDuEToSIah1k8bv4i9Dm/xoMfLeCn9pj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abel Vesa <abel.vesa@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 025/614] pinctrl: qcom: glymur: Fix the gpio and egpio pin functions
Date: Tue, 16 Dec 2025 12:06:32 +0100
Message-ID: <20251216111402.218065527@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit e73fda2dcb0bad6650e654556c5242b773707257 ]

Mark the gpio/egpio as GPIO specific pin functions, othewise
the pin muxing generic framework will complain about the gpio
being already requested by a different owner.

Fixes: 87ebcd8baebf ("pinctrl: qcom: Add glymur pinctrl driver")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-glymur.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-glymur.c b/drivers/pinctrl/qcom/pinctrl-glymur.c
index 9781e7fcb3a11..335005084b6bc 100644
--- a/drivers/pinctrl/qcom/pinctrl-glymur.c
+++ b/drivers/pinctrl/qcom/pinctrl-glymur.c
@@ -1316,7 +1316,7 @@ static const char *const wcn_sw_ctrl_groups[] = {
 };
 
 static const struct pinfunction glymur_functions[] = {
-	MSM_PIN_FUNCTION(gpio),
+	MSM_GPIO_PIN_FUNCTION(gpio),
 	MSM_PIN_FUNCTION(resout_gpio_n),
 	MSM_PIN_FUNCTION(aoss_cti),
 	MSM_PIN_FUNCTION(asc_cci),
@@ -1342,7 +1342,7 @@ static const struct pinfunction glymur_functions[] = {
 	MSM_PIN_FUNCTION(edp0_hot),
 	MSM_PIN_FUNCTION(edp0_lcd),
 	MSM_PIN_FUNCTION(edp1_lcd),
-	MSM_PIN_FUNCTION(egpio),
+	MSM_GPIO_PIN_FUNCTION(egpio),
 	MSM_PIN_FUNCTION(eusb_ac_en),
 	MSM_PIN_FUNCTION(gcc_gp1),
 	MSM_PIN_FUNCTION(gcc_gp2),
-- 
2.51.0




