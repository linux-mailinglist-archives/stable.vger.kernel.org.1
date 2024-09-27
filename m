Return-Path: <stable+bounces-78118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74AB9886CD
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656F4284923
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E074BED;
	Fri, 27 Sep 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="WfN/0X3q"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51778493;
	Fri, 27 Sep 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446568; cv=none; b=uVlHW3lNHwNXZq/b1YrOoBXiPUwB+mAFRWTPjvbPO3vf7q+MEyakYFORy8vYZIEeSZccSukQD+zIG53E0pMLGmG+L2XC/lX1mYAOXO27Moxi6Eix43WXUt7CV8AStj6GUk10x0uL/wvVaUp2vUQ1jD6B670uRJ17iPgNq4QaqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446568; c=relaxed/simple;
	bh=Y+KbHIb4oHpeFuLUCsPn+9dosUtmgAlL5hFLy/c3O7c=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=o++qgoSEtNeCKMkp5V4+zEVtQj1Vo+DuV2Lnf5q0d1D90MAmAUThOkkjYEiAWORzkWt4qybmNUhTkwKoKnjPi3lZh1UDHzgJKJ8HOnJq7xD66aQmlwguKMN2Gp7tlG9y0A73i9hL+PFHZ6gLmQ17sA1pLrLcktCEZoCuMyV2tkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=WfN/0X3q; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=rFY2f6oSwge6XyupmQECSbR1vqc99i87yPhEVwH6LEY=; b=WfN/0X3qoT0Pfn4oZLPNzDrwHD
	kA1LEpVnfSTZ8ZvHRXwNiwuAkAcQDg25ID4lM82d1DJePJKy02SlN1JVQE8A0KgoSfNKDI2XunotA
	buyJcTLHjXWT4Zm3RGQEmnFGWmrTpcB24sQs9HXTIfCAhgBkJSZMZRou6wOrA5+K2h8M=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54798 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1suBQP-0007xB-Uu; Fri, 27 Sep 2024 09:54:26 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jagan Teki <jagan@edgeble.ai>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Date: Fri, 27 Sep 2024 09:53:05 -0400
Message-Id: <20240927135306.857617-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH] drm: panel: jd9365da-h3: fix reset signal polarity
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 44897e5218a69..6fec99cf4d935 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -110,13 +110,13 @@ static int jadard_prepare(struct drm_panel *panel)
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
@@ -1131,7 +1131,7 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
 
-	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(jadard->reset)) {
 		DRM_DEV_ERROR(&dsi->dev, "failed to get our reset GPIO\n");
 		return PTR_ERR(jadard->reset);

base-commit: 18ba6034468e7949a9e2c2cf28e2e123b4fe7a50
-- 
2.39.5


