Return-Path: <stable+bounces-163649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B11B0D0FE
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B387ACBBF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3D1581F8;
	Tue, 22 Jul 2025 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf+NjBfj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976C2E3716
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160157; cv=none; b=AFP23ffPzr4WvysseyY0UZgrYOU/o3ZyUDZjxugnxjA5tbtQVS8kj/VAvCx9qzkqC8tY9mp3Yv/gIoEqjI/xLTJzXr1ji8AxV3DRgcoutL4i4hFUloNaiE8QDZmShoT1IfOyi9iZ2fglMh1ekqvJgiaLOME/2y22vrnkORPW74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160157; c=relaxed/simple;
	bh=KRO18tywI9n9sHoIIxeeWA8EbiPvKKZk5KdGs5ixUnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7lMknEAWVZ+s40KN3KiVu6MvFZZCw/i+nhtuF5sd23jwl5JMSKcbjRgt/GSVrIMczQgCkqNQxcOO4pBI+/Z84UOIDvXdYKrH0Ja/63h3WiVkJV7lxmmwPzUue/oZE61Ftz+WJfoZTztmgzWpRzkUvhmjWvaeaZ4tN7vBVdUwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf+NjBfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84912C4CEF9;
	Tue, 22 Jul 2025 04:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160155;
	bh=KRO18tywI9n9sHoIIxeeWA8EbiPvKKZk5KdGs5ixUnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cf+NjBfjRPgCU7jtURHK1UbljdsdcKVwFh1DycK1MHCiRXsS7ShEQWvidVRFC82j7
	 H/ZtUFxgG61NjlFK2QNT6Crq+cBfZ0GBure1QXCHWKupQJA6f31+gG0q86Alt27x91
	 qj3I6N70cCIC+5Or7jzDIOHYKMZumynq6Z/22Qu0wwbTjwU1KZSAsLUUmCMBSssJnU
	 9DrC0lV3nOOV/CTrAE4Cd8msrQo5eAAwEawljT7eZfYwz/br2uUgo3dMZ3faUMYxD0
	 p9a+EmrajhZMNpsgmzbrIULRMHwReXEGdg7szA2Q65C62mhm8VwJ4YVhUliQt5QeRt
	 +ALzCXaoNM6fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()
Date: Tue, 22 Jul 2025 00:55:34 -0400
Message-Id: <20250722045534.894081-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722045534.894081-1-sashal@kernel.org>
References: <2025072119-stifling-dismount-033b@gregkh>
 <20250722045534.894081-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit a9503a2ecd95e23d7243bcde7138192de8c1c281 ]

omap_i2c_init() can fail. Handle this error in omap_i2c_probe().

Fixes: 010d442c4a29 ("i2c: New bus driver for TI OMAP boards")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v2.6.19+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/565311abf9bafd7291ca82bcecb48c1fac1e727b.1751701715.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-omap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 16c5d79143ff8..534ca652c3b29 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1475,7 +1475,9 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	/* reset ASAP, clearing any IRQs */
-	omap_i2c_init(omap);
+	r = omap_i2c_init(omap);
+	if (r)
+		goto err_mux_state_deselect;
 
 	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
 		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
@@ -1518,6 +1520,7 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+err_mux_state_deselect:
 	if (omap->mux_state)
 		mux_state_deselect(omap->mux_state);
 err_put_pm:
-- 
2.39.5


