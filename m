Return-Path: <stable+bounces-155569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E75AE42D0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7083178A40
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E9E25392C;
	Mon, 23 Jun 2025 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtwKet+t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820924DFF3;
	Mon, 23 Jun 2025 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684766; cv=none; b=Ysx2ZbapSVL4tpQ9vkorR0lKAbbnnJNuUa1tje0iEhE7c1RIA4Hm1fduV0ahm4CPfIS8S2prQzaa0R3tBczvaTcz0QuFm6+//LEfaQ7zA083wdGepUKl2TkCZTJ175QcZaO57TE70SE76/NRZ36r5FuGZRdOtYerZmMLzPllg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684766; c=relaxed/simple;
	bh=42jeMrsOn2iCAOM8vpwG4HzNs6YusSM0eTFIPqFozGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm0uCoNWGeh5Jd4dADM+T3NEJhBL7llqUwE9y0U7mSbXNa275MIznuFUFGMzno6lYx/uOcPFeBOH8yaxm/E9muExZzEJ+qkk/R65JrBfuauBSRNTkA8dcPdRYVJWx5Rz9xulYukVP9azpiziEQ5G5fnjbyopDtwpMOegeQQ+/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtwKet+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B385C4CEEA;
	Mon, 23 Jun 2025 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684766;
	bh=42jeMrsOn2iCAOM8vpwG4HzNs6YusSM0eTFIPqFozGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtwKet+txPMO0s32JsLOjMnRUFV1kgKvzDb9b0s52t3qhK/yhuH06gBnKIX4V+Woz
	 eHmVlJC0VocUX+PBsikWfB4y7FdXlOWIC1faYxHaXSqX7ke6BdOBtOYDMtDJSzRBn3
	 x0CY/2ircrLPMxDvY218qmrNNh41+Cj3GLFgGt1Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Imre Kaloz <kaloz@openwrt.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gabor Juhos <j4g8y7@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.15 003/411] pinctrl: armada-37xx: set GPIO output value before setting direction
Date: Mon, 23 Jun 2025 15:02:27 +0200
Message-ID: <20250623130633.095665130@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

commit e6ebd4942981f8ad37189bbb36a3c8495e21ef4c upstream.

Changing the direction before updating the output value in the
OUTPUT_VAL register may result in a glitch on the output line
if the previous value in the OUTPUT_VAL register is different
from the one we want to set.

In order to avoid that, update the output value before changing
the direction.

Cc: stable@vger.kernel.org
Fixes: 6702abb3bf23 ("pinctrl: armada-37xx: Fix direction_output() callback behavior")
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Link: https://lore.kernel.org/20250514-pinctrl-a37xx-fixes-v2-2-07e9ac1ab737@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -413,23 +413,22 @@ static int armada_37xx_gpio_direction_ou
 					     unsigned int offset, int value)
 {
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
-	unsigned int val_offset = offset;
-	unsigned int reg = OUTPUT_EN;
+	unsigned int en_offset = offset;
+	unsigned int reg = OUTPUT_VAL;
 	unsigned int mask, val, ret;
 
 	armada_37xx_update_reg(&reg, &offset);
 	mask = BIT(offset);
+	val = value ? mask : 0;
 
-	ret = regmap_update_bits(info->regmap, reg, mask, mask);
-
+	ret = regmap_update_bits(info->regmap, reg, mask, val);
 	if (ret)
 		return ret;
 
-	reg = OUTPUT_VAL;
-	armada_37xx_update_reg(&reg, &val_offset);
+	reg = OUTPUT_EN;
+	armada_37xx_update_reg(&reg, &en_offset);
 
-	val = value ? mask : 0;
-	regmap_update_bits(info->regmap, reg, mask, val);
+	regmap_update_bits(info->regmap, reg, mask, mask);
 
 	return 0;
 }



