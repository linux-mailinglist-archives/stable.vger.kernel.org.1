Return-Path: <stable+bounces-63700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152A3941A35
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B5C281EB2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A678184535;
	Tue, 30 Jul 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xtE7CZfX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DA1A6192;
	Tue, 30 Jul 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357675; cv=none; b=GnWoNFMIhhr+beVzggOBWVTh1jYh5zf+GJWVeyRgdgimL1z3HOa7siretQ6xTFh7jcyfbLOKrqXZV5Tng+OaxuoDpWQwh8Av0K+7WYMskDpFUwetxn2BbOIoEYmSomC9DslV1ncD98UbEJSUKO/sEMPzynu0KB0U4hLCRrwqGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357675; c=relaxed/simple;
	bh=R7MXksLnXTZ90EKwJ6zvz6ezGDgSDNejt7cW8XVeXWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVeX2/PU43E/OWnL0LGxHgREl6AsWu6N8zNhc4OVTOZBzc86V1Dk8yrMPVt4tBjCj3z6tCTWQO5vyg+y0ji6w+3zORxMn8x2RPV41RA2h7iK3J1fGkX8m0jS9+GXMHTAzCfPABLgmLtkvwqX0wyzvSkOiBh5c9GD78Ws+UOUfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xtE7CZfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9837AC4AF0C;
	Tue, 30 Jul 2024 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357675;
	bh=R7MXksLnXTZ90EKwJ6zvz6ezGDgSDNejt7cW8XVeXWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xtE7CZfXwhw+8hyFu1/IHU04YdU4sfbZdXe7fb4P+zDHlkmE5uH2O+VrRFIKNyfpz
	 y3VZWsySF3ZrUL6Gcw0pygH8wfjI7aEG72Ouzc5vYDtIr0aP0XloBqtauaZuQB5JrB
	 eVw7qE5uJhkD/GPmynW7oA0UQEfq1fSrdJhacV3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 278/809] drm/panel: boe-tv101wum-nl6: If prepare fails, disable GPIO before regulators
Date: Tue, 30 Jul 2024 17:42:34 +0200
Message-ID: <20240730151735.573370746@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 587c48f622374e5d47b1d515c6006a4df4dee882 ]

The enable GPIO should clearly be set low before turning off
regulators. That matches both the inverse order that things were
enabled and also the order in unprepare().

Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20240517143643.2.Ieac346cd0f1606948ba39ceea06b55359fe972b6@changeid
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240517143643.2.Ieac346cd0f1606948ba39ceea06b55359fe972b6@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 0ffe8f8c01de8..ce7b4f5ce3fae 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1528,13 +1528,13 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
+	gpiod_set_value(boe->enable_gpio, 0);
 	regulator_disable(boe->avee);
 poweroffavdd:
 	regulator_disable(boe->avdd);
 poweroff1v8:
 	usleep_range(5000, 7000);
 	regulator_disable(boe->pp1800);
-	gpiod_set_value(boe->enable_gpio, 0);
 
 	return ret;
 }
-- 
2.43.0




