Return-Path: <stable+bounces-152890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71504ADD152
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F3F1895056
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491222EB5A8;
	Tue, 17 Jun 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmVyKtLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A572EF655;
	Tue, 17 Jun 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174112; cv=none; b=l+LpdXGu/xD9Oczj4yDHTYCnkI+e6KDVZ34dLSdqdYggWONkw9jmVgLr1tOHdVAxRteFAME7dJFIsvS4FFQZxElI/A1J7WYoy7WzZCCoFcPTnENuT1me1mcFMMYWryq+Fa768//9op1w9Pf5ATicNaPW9FoeZDL4bWQ9H7v3M0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174112; c=relaxed/simple;
	bh=8RL81aAWBWTJLtYKL9QhgLuzOTXph2rIScZK3VA/xg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HghpyMKTDaccQSHY0i5Z5npgcjIODo+AD6xz4HAiAusMwuRut9WJevI7gyeTfUbrH+Lxk0hsHD2KNjjxC2acclMUqNxkhyZEqExnclJnKbTUwO3h9i+eALPD84/xEgWt+Dwhvfv3XgcAb773WNc9GsgaUJ8oDER+bN3bDU5qrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vmVyKtLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5A8C4CEE3;
	Tue, 17 Jun 2025 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174110;
	bh=8RL81aAWBWTJLtYKL9QhgLuzOTXph2rIScZK3VA/xg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vmVyKtLMXbDMikny0NmnMI7sSuCjui00XiG72HNT3VhWunBhWTiP7uFruFWYa4JbQ
	 t/0BmpUP2PH1aVdTkU/XlHfxDdoAyXejMYttzHG0P+he7Rzffgds19+Yi4bggzrk7z
	 KzChoHICYit1lLjfPHuYNvRDih3HEvlzvkM9/ClA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Imre Kaloz <kaloz@openwrt.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gabor Juhos <j4g8y7@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.6 002/356] pinctrl: armada-37xx: use correct OUTPUT_VAL register for GPIOs > 31
Date: Tue, 17 Jun 2025 17:21:57 +0200
Message-ID: <20250617152338.319188324@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

commit 947c93eb29c2a581c0b0b6d5f21af3c2b7ff6d25 upstream.

The controller has two consecutive OUTPUT_VAL registers and both
holds output value for 32 GPIOs. Due to a missing adjustment, the
current code always uses the first register while setting the
output value whereas it should use the second one for GPIOs > 31.

Add the missing armada_37xx_update_reg() call to adjust the register
according to the 'offset' parameter of the function to fix the issue.

Cc: stable@vger.kernel.org
Fixes: 6702abb3bf23 ("pinctrl: armada-37xx: Fix direction_output() callback behavior")
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Link: https://lore.kernel.org/20250514-pinctrl-a37xx-fixes-v2-1-07e9ac1ab737@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -417,6 +417,7 @@ static int armada_37xx_gpio_direction_ou
 					     unsigned int offset, int value)
 {
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int val_offset = offset;
 	unsigned int reg = OUTPUT_EN;
 	unsigned int mask, val, ret;
 
@@ -429,6 +430,8 @@ static int armada_37xx_gpio_direction_ou
 		return ret;
 
 	reg = OUTPUT_VAL;
+	armada_37xx_update_reg(&reg, &val_offset);
+
 	val = value ? mask : 0;
 	regmap_update_bits(info->regmap, reg, mask, val);
 



