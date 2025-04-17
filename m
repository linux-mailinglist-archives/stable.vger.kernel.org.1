Return-Path: <stable+bounces-134496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5BA92BFA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 21:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE34A250C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCC20408A;
	Thu, 17 Apr 2025 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="j4Mr40UW"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA91EF38F;
	Thu, 17 Apr 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744919733; cv=none; b=dfUk1y9JuKruutNbY4YcQ+bYoPRboLikSmXTHNbP5P0vnwueFckhxvDe8oqfNV4yCNO+IzEtemcviD1OrH2E4gskXnuhYYYGvJocalmT8yhL0gCw9mgExSIOusgA/xnOGq8JvglDxITzyW9S2pNdFUYqee2tqXcSITBtxkrARkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744919733; c=relaxed/simple;
	bh=PavDeZO+/OtHq3jgGVCjzL68cJ1U/v1a0S+w3cI+a5A=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=mogDixzrougwAs2ODF42POAM65NNhEguzTkEnadZfdWVzqO34SiZ+pqX0q9EocLXZjmgwqp8DVIzaNQWDmrQd5ZMuKa3YMiAtlzjnBztbOxsuLXC+b9xSyKCNYasvMjitkBO0kFjG3dIV+O1zFSt4DqqIgHVlcnwsxUPvFclKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=j4Mr40UW; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=qT5lUbWkD7RDrtfHAg0hqc+izqmK/T9JNswM903OaGI=; b=j4Mr40UWBtWABqrkVj2d68iDHx
	oTPbm+2ReACRCF3rYSB2nAJiGnBVHP3sKP/m3McOMlkXcNkdzfvRT6sYzMf48SjEVHwuL15CffUD+
	115T0vl2Ahp0nRes+rrgB5SLl09T4zMvDfcCNn+khYxOxXzFawjf2SpDRrftFb6oecJg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:58954 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1u5VKG-0000g8-Mk; Thu, 17 Apr 2025 15:55:09 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jagan Teki <jagan@edgeble.ai>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Linus Walleij <linus.walleij@linaro.org>,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Date: Thu, 17 Apr 2025 15:55:06 -0400
Message-Id: <20250417195507.778731-1-hugo@hugovil.com>
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
Subject: [PATCH] drm: panel: jd9365da: fix reset signal polarity in unprepare
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit a8972d5a49b4 ("drm: panel: jd9365da-h3: fix reset signal polarity")
fixed reset signal polarity in jadard_dsi_probe() and jadard_prepare().

It was not done in jadard_unprepare() because of an incorrect assumption
about reset line handling in power off mode. After looking into the
datasheet, it now appears that before disabling regulators, the reset line
is deasserted first, and if reset_before_power_off_vcioo is true, then the
reset line is asserted.

Fix reset polarity by inverting gpiod_set_value() second argument in
in jadard_unprepare().

Fixes: 6b818c533dd8 ("drm: panel: Add Jadard JD9365DA-H3 DSI panel")
Fixes: 2b976ad760dc ("drm/panel: jd9365da: Support for kd101ne3-40ti MIPI-DSI panel")
Fixes: a8972d5a49b4 ("drm: panel: jd9365da-h3: fix reset signal polarity")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 7d68a8acfe2ea..eb0f8373258c3 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -129,11 +129,11 @@ static int jadard_unprepare(struct drm_panel *panel)
 {
 	struct jadard *jadard = panel_to_jadard(panel);
 
-	gpiod_set_value(jadard->reset, 1);
+	gpiod_set_value(jadard->reset, 0);
 	msleep(120);
 
 	if (jadard->desc->reset_before_power_off_vcioo) {
-		gpiod_set_value(jadard->reset, 0);
+		gpiod_set_value(jadard->reset, 1);
 
 		usleep_range(1000, 2000);
 	}

base-commit: 7adf8b1afc14832de099f9e178f08f91dc0dd6d0
-- 
2.39.5


