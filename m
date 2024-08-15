Return-Path: <stable+bounces-68067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670AE953075
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155A0281F32
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA419E7EF;
	Thu, 15 Aug 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N52luds4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746E1714A8;
	Thu, 15 Aug 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729393; cv=none; b=PlZyxV0cfC0yEYnFzDX+U02bfBVDVg7gJxmxJ48kHp/t25TrM99MuiDIgbeB6kNzVdfS3A6ak8K3GsvKCffEq5/9rPfsOcF5fFPyFaj4ZuYsoM7AJCtaAazGNfMvJk6dQ9BVT70CmOlGwG0W9AadDgtXMp5QWLn8jYubfnWPWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729393; c=relaxed/simple;
	bh=TMCGIifXMvqhriBaLB5gC3OgfRUzWIzAOPPt1mgGQ8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQNQEZXJUkpwi775f7xIFsmtxQrtiL1khLB6jg64HlhEBWN6hoG7mgQuWLF1LuL4JHlPEp8rlT6l6kKfYgvlyJJJQ89hX9vu43pETGnBbya2qADswmJDt9CxMofIMchh+N5USBl6UEWaSQtmLHl5gFZKn9dOcufyE53U51/x2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N52luds4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05C3C32786;
	Thu, 15 Aug 2024 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729393;
	bh=TMCGIifXMvqhriBaLB5gC3OgfRUzWIzAOPPt1mgGQ8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N52luds45jwfrimGgOZEcVyWzu2PlPUanwWiackAGrhDlc67uI2MCPG6ub1JPiaWF
	 EwLeqj8Gizwn3tchaFOu1h/7L3jAYS4cjsY98xk4GNTMYBsTxRTv6ubllpHHmFBoCQ
	 MeimFDswUz1G24EP9WV9pQxy1zCwUWKCQWoB4EDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/484] drm/panel: boe-tv101wum-nl6: If prepare fails, disable GPIO before regulators
Date: Thu, 15 Aug 2024 15:19:01 +0200
Message-ID: <20240815131944.494573189@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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
index 9e518213a54ff..c448be3d01d16 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -574,13 +574,13 @@ static int boe_panel_prepare(struct drm_panel *panel)
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




