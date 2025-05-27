Return-Path: <stable+bounces-146730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CCAC5452
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480B74A285A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4C627FD5D;
	Tue, 27 May 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jbknD5XE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599227FD53;
	Tue, 27 May 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365131; cv=none; b=MuKHYjj2imvO0lFZNMQHrZic3Kj1PUxZBMZwIoEYG9UUGVTxzOInsVPTIqhlX417Vp9Iqyp/x1SVk26W3HDAbcK8iP+e3LDkYFW+et3BH2tvfJTa+TGHbotCy+0NIT2peFkfncE3wZ06z4re+oBYWz7wDGeXceiIeUwW31Zsyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365131; c=relaxed/simple;
	bh=XDwnpYLTLqQATHcJNwXuIweciSw+xXcAsvLrA6T0VvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPemQT75DGVMh6UkQ1O6xqzFcVmClz7k/yEDBOWwlJRCP8YP/52SxbGEMuQjE7SUzF7rgLul9x8CoMc7PxIGGzHo6DTabKoE9sUsxpBOYS6naYfkiw0mlGc0rFCKUuduofQQUyIVvw8VlJVuY264NipUoEz4QWOMgKazpgEfcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jbknD5XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6731AC4CEE9;
	Tue, 27 May 2025 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365130;
	bh=XDwnpYLTLqQATHcJNwXuIweciSw+xXcAsvLrA6T0VvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbknD5XE+hVwvUjvNSzdgI9mqUtOICoK7ROWJXtRL/2izwMqchaM2DPRBVe/3gXHU
	 XQ6kUz2Xa3EuMldzjwIiZHS6HtLEU9bN29A6OFLbc6jEtyQ48GeGXPUhJkMQK3hqx1
	 I8SpciVBB/CuVud25WkoTGHj0ONPPz28tDvXo3qI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 275/626] pinctrl: sophgo: avoid to modify untouched bit when setting cv1800 pinconf
Date: Tue, 27 May 2025 18:22:48 +0200
Message-ID: <20250527162456.199052417@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit ef1a5121ae3da02372fcb66d9632ed3d47ad5637 ]

When setting pinconf configuration for cv1800 SoC, the driver just writes
the value. It may zero some bits of the pinconf register and cause some
unexpected error. Add a mask to avoid this.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Link: https://lore.kernel.org/20250211051801.470800-2-inochiama@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sophgo/pinctrl-cv18xx.c | 33 +++++++++++++++++--------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sophgo/pinctrl-cv18xx.c b/drivers/pinctrl/sophgo/pinctrl-cv18xx.c
index 57f2674e75d68..84b4850771ce2 100644
--- a/drivers/pinctrl/sophgo/pinctrl-cv18xx.c
+++ b/drivers/pinctrl/sophgo/pinctrl-cv18xx.c
@@ -574,10 +574,10 @@ static int cv1800_pinconf_compute_config(struct cv1800_pinctrl *pctrl,
 					 struct cv1800_pin *pin,
 					 unsigned long *configs,
 					 unsigned int num_configs,
-					 u32 *value)
+					 u32 *value, u32 *mask)
 {
 	int i;
-	u32 v = 0;
+	u32 v = 0, m = 0;
 	enum cv1800_pin_io_type type;
 	int ret;
 
@@ -596,10 +596,12 @@ static int cv1800_pinconf_compute_config(struct cv1800_pinctrl *pctrl,
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 			v &= ~PIN_IO_PULLDOWN;
 			v |= FIELD_PREP(PIN_IO_PULLDOWN, arg);
+			m |= PIN_IO_PULLDOWN;
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
 			v &= ~PIN_IO_PULLUP;
 			v |= FIELD_PREP(PIN_IO_PULLUP, arg);
+			m |= PIN_IO_PULLUP;
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH_UA:
 			ret = cv1800_pinctrl_oc2reg(pctrl, pin, arg);
@@ -607,6 +609,7 @@ static int cv1800_pinconf_compute_config(struct cv1800_pinctrl *pctrl,
 				return ret;
 			v &= ~PIN_IO_DRIVE;
 			v |= FIELD_PREP(PIN_IO_DRIVE, ret);
+			m |= PIN_IO_DRIVE;
 			break;
 		case PIN_CONFIG_INPUT_SCHMITT_UV:
 			ret = cv1800_pinctrl_schmitt2reg(pctrl, pin, arg);
@@ -614,6 +617,7 @@ static int cv1800_pinconf_compute_config(struct cv1800_pinctrl *pctrl,
 				return ret;
 			v &= ~PIN_IO_SCHMITT;
 			v |= FIELD_PREP(PIN_IO_SCHMITT, ret);
+			m |= PIN_IO_SCHMITT;
 			break;
 		case PIN_CONFIG_POWER_SOURCE:
 			/* Ignore power source as it is always fixed */
@@ -621,10 +625,12 @@ static int cv1800_pinconf_compute_config(struct cv1800_pinctrl *pctrl,
 		case PIN_CONFIG_SLEW_RATE:
 			v &= ~PIN_IO_OUT_FAST_SLEW;
 			v |= FIELD_PREP(PIN_IO_OUT_FAST_SLEW, arg);
+			m |= PIN_IO_OUT_FAST_SLEW;
 			break;
 		case PIN_CONFIG_BIAS_BUS_HOLD:
 			v &= ~PIN_IO_BUS_HOLD;
 			v |= FIELD_PREP(PIN_IO_BUS_HOLD, arg);
+			m |= PIN_IO_BUS_HOLD;
 			break;
 		default:
 			return -ENOTSUPP;
@@ -632,17 +638,19 @@ static int cv1800_pinconf_compute_config(struct cv1800_pinctrl *pctrl,
 	}
 
 	*value = v;
+	*mask = m;
 
 	return 0;
 }
 
 static int cv1800_pin_set_config(struct cv1800_pinctrl *pctrl,
 				 unsigned int pin_id,
-				 u32 value)
+				 u32 value, u32 mask)
 {
 	struct cv1800_pin *pin = cv1800_get_pin(pctrl, pin_id);
 	unsigned long flags;
 	void __iomem *addr;
+	u32 reg;
 
 	if (!pin)
 		return -EINVAL;
@@ -650,7 +658,10 @@ static int cv1800_pin_set_config(struct cv1800_pinctrl *pctrl,
 	addr = cv1800_pinctrl_get_component_addr(pctrl, &pin->conf);
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
-	writel(value, addr);
+	reg = readl(addr);
+	reg &= ~mask;
+	reg |= value;
+	writel(reg, addr);
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
@@ -662,16 +673,17 @@ static int cv1800_pconf_set(struct pinctrl_dev *pctldev,
 {
 	struct cv1800_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	struct cv1800_pin *pin = cv1800_get_pin(pctrl, pin_id);
-	u32 value;
+	u32 value, mask;
 
 	if (!pin)
 		return -ENODEV;
 
 	if (cv1800_pinconf_compute_config(pctrl, pin,
-					  configs, num_configs, &value))
+					  configs, num_configs,
+					  &value, &mask))
 		return -ENOTSUPP;
 
-	return cv1800_pin_set_config(pctrl, pin_id, value);
+	return cv1800_pin_set_config(pctrl, pin_id, value, mask);
 }
 
 static int cv1800_pconf_group_set(struct pinctrl_dev *pctldev,
@@ -682,7 +694,7 @@ static int cv1800_pconf_group_set(struct pinctrl_dev *pctldev,
 	struct cv1800_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct group_desc *group;
 	const struct cv1800_pin_mux_config *pinmuxs;
-	u32 value;
+	u32 value, mask;
 	int i;
 
 	group = pinctrl_generic_get_group(pctldev, gsel);
@@ -692,11 +704,12 @@ static int cv1800_pconf_group_set(struct pinctrl_dev *pctldev,
 	pinmuxs = group->data;
 
 	if (cv1800_pinconf_compute_config(pctrl, pinmuxs[0].pin,
-					  configs, num_configs, &value))
+					  configs, num_configs,
+					  &value, &mask))
 		return -ENOTSUPP;
 
 	for (i = 0; i < group->grp.npins; i++)
-		cv1800_pin_set_config(pctrl, group->grp.pins[i], value);
+		cv1800_pin_set_config(pctrl, group->grp.pins[i], value, mask);
 
 	return 0;
 }
-- 
2.39.5




