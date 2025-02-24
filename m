Return-Path: <stable+bounces-118728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED66CA41ABF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66377161059
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48823F439;
	Mon, 24 Feb 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ef7ZH6j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04ED38DFC
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392451; cv=none; b=US02Y26XtwGPs2VfFZiA76d7aJHZZpvtWAlVdiIarhNfHx3pEXAQujl+wziR63SJB8xWzGK90V3R/qR5UgQelZ3ItCmt1uilLVIM+O8DWoUpE8ScU6LXjelj5ciCLbte95m7kPgyJfXfpzvFyL5VY2cWqtkCjGSEO43iunXv7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392451; c=relaxed/simple;
	bh=PYP0uIASOvy2ywGlbB3Znh8nT+DY/aCUWwXwwbA61cE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XDxdv0vTp2fhSaQYXlF9FL9HmoATPySDkci0CQVwgor2f7ITMOkvAOrlXivzQdsaxWVAt7q3YTM52y6CqrEYUoQMssdM5oi8qvTD+geSDiDbCRP24JIkFbxVnfk5WXmG+fQ5m+7YJIjRAZwCXoeNydn6GYzFLAnyKtYwgCwMoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ef7ZH6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF705C4CED6;
	Mon, 24 Feb 2025 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392450;
	bh=PYP0uIASOvy2ywGlbB3Znh8nT+DY/aCUWwXwwbA61cE=;
	h=Subject:To:Cc:From:Date:From;
	b=1ef7ZH6j9V3MxyGxkRGnSsTjqg0qBa+Z3ab7/TlNX/ckrgqL31HWFdfdZttbSNJny
	 Q8o4+CoAImVr8xFHfB2dd941bqqUl8F57KXpNyNnUChn4SRGs+ZYJ67hp5kNcD9N2R
	 e+L3zW/i/t8W+Qt1S/8sf9m966RMkTjG/3uOT13A=
Subject: FAILED: patch "[PATCH] drm: panel: jd9365da-h3: fix reset signal polarity" failed to apply to 6.6-stable tree
To: hvilleneuve@dimonoff.com,linus.walleij@linaro.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:20:41 +0100
Message-ID: <2025022441-stallion-given-47fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a8972d5a49b408248294b5ecbdd0a085e4726349
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022441-stallion-given-47fc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8972d5a49b408248294b5ecbdd0a085e4726349 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Fri, 27 Sep 2024 09:53:05 -0400
Subject: [PATCH] drm: panel: jd9365da-h3: fix reset signal polarity

In jadard_prepare() a reset pulse is generated with the following
statements (delays ommited for clarity):

    gpiod_set_value(jadard->reset, 1); --> Deassert reset
    gpiod_set_value(jadard->reset, 0); --> Assert reset for 10ms
    gpiod_set_value(jadard->reset, 1); --> Deassert reset

However, specifying second argument of "0" to gpiod_set_value() means to
deassert the GPIO, and "1" means to assert it. If the reset signal is
defined as GPIO_ACTIVE_LOW in the DTS, the above statements will
incorrectly generate the reset pulse (inverted) and leave it asserted
(LOW) at the end of jadard_prepare().

Fix reset behavior by inverting gpiod_set_value() second argument
in jadard_prepare(). Also modify second argument to devm_gpiod_get()
in jadard_dsi_probe() to assert the reset when probing.

Do not modify it in jadard_unprepare() as it is already properly
asserted with "1", which seems to be the intended behavior.

Fixes: 6b818c533dd8 ("drm: panel: Add Jadard JD9365DA-H3 DSI panel")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20240927135306.857617-1-hugo@hugovil.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240927135306.857617-1-hugo@hugovil.com

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 45d09e6fa667..7d68a8acfe2e 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -109,13 +109,13 @@ static int jadard_prepare(struct drm_panel *panel)
 	if (jadard->desc->lp11_to_reset_delay_ms)
 		msleep(jadard->desc->lp11_to_reset_delay_ms);
 
-	gpiod_set_value(jadard->reset, 1);
+	gpiod_set_value(jadard->reset, 0);
 	msleep(5);
 
-	gpiod_set_value(jadard->reset, 0);
+	gpiod_set_value(jadard->reset, 1);
 	msleep(10);
 
-	gpiod_set_value(jadard->reset, 1);
+	gpiod_set_value(jadard->reset, 0);
 	msleep(130);
 
 	ret = jadard->desc->init(jadard);
@@ -1130,7 +1130,7 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
 
-	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(jadard->reset)) {
 		DRM_DEV_ERROR(&dsi->dev, "failed to get our reset GPIO\n");
 		return PTR_ERR(jadard->reset);


