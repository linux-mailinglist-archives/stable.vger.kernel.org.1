Return-Path: <stable+bounces-71906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B0967849
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3081C21054
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2897183CA7;
	Sun,  1 Sep 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnoQ+Y6R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1D17CA1F;
	Sun,  1 Sep 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208208; cv=none; b=G0GkcghsmiWwR5WWge1qdvK9cFzRvrOLpyjQufFQUtqUSfbDp2+EYYGwHw288oM6QkMPL8qU/9OEMu9O/jH/VEFAmGn6KHXbX6MBAuyGCbxQf9dZfUdFUY2NWp9tNithJtYv+EMBDsM0QjDrsQRQPYbM62edCVsxcy9jgSJAT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208208; c=relaxed/simple;
	bh=M1r+5pmOXv4N898G0RGzlThYp73xqlpnOQu0U30hc/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5zM8a/gYUTZ3xXUdj1dIhDNcN4p1ThZlsxetCdNBlo0JTSr4ZLEd2wehYD2q8kVOGiWMm+OixE7ZHe06jPBuvtO8kwyyujoQbnzs3Pui/dQy5FNNz/+SOkXFk0VkVZI2Ac4v8Fju0mkRA5euJdeQrXJZeNvpCHXe+EHLk/dBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnoQ+Y6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6312C4CEC3;
	Sun,  1 Sep 2024 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208208;
	bh=M1r+5pmOXv4N898G0RGzlThYp73xqlpnOQu0U30hc/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnoQ+Y6RNF96gBbb6FLU4r5m/EcgGv+Hv77M76lW0w/y/OzI12z7hArDxfAE0K6Sq
	 Ck6xdHpG62jrE6V6CtSUytYCbqDbuwROziYf4iI05lTN/5krgR/BiGlkR0MUZDgvA3
	 ye4owpKWkHB1NPwZinGV2arosVJYAy8voRHdSU+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Kojedzinszky <richard@kojedz.in>,
	Huang-Huang Bao <i@eh5.me>,
	Heiko Stuebner <heiko@sntech.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Trevor Woerner <twoerner@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.10 012/149] pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins
Date: Sun,  1 Sep 2024 18:15:23 +0200
Message-ID: <20240901160817.929907613@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang-Huang Bao <i@eh5.me>

commit 128f71fe014fc91efa1407ce549f94a9a9f1072c upstream.

The base iomux offsets for each GPIO pin line are accumulatively
calculated based off iomux width flag in rockchip_pinctrl_get_soc_data.
If the iomux width flag is one of IOMUX_WIDTH_4BIT, IOMUX_WIDTH_3BIT or
IOMUX_WIDTH_2BIT, the base offset for next pin line would increase by 8
bytes, otherwise it would increase by 4 bytes.

Despite most of GPIO2-B iomux have 2-bit data width, which can be fit
into 4 bytes space with write mask, it actually take 8 bytes width for
whole GPIO2-B line.

Commit e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328
GPIO2-B pins") wrongly set iomux width flag to 0, causing all base
iomux offset for line after GPIO2-B to be calculated wrong. Fix the
iomux width flag to IOMUX_WIDTH_2BIT so the offset after GPIO2-B is
correctly increased by 8, matching the actual width of GPIO2-B iomux.

Fixes: e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins")
Cc: stable@vger.kernel.org
Reported-by: Richard Kojedzinszky <richard@kojedz.in>
Closes: https://lore.kernel.org/linux-rockchip/4f29b743202397d60edfb3c725537415@kojedz.in/
Tested-by: Richard Kojedzinszky <richard@kojedz.in>
Signed-off-by: Huang-Huang Bao <i@eh5.me>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Trevor Woerner <twoerner@gmail.com>
Link: https://lore.kernel.org/20240709105428.1176375-1-i@eh5.me
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-rockchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3800,7 +3800,7 @@ static struct rockchip_pin_bank rk3328_p
 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
-			     0,
+			     IOMUX_WIDTH_2BIT,
 			     IOMUX_WIDTH_3BIT,
 			     0),
 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",



