Return-Path: <stable+bounces-78292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F998AAA2
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00171C22666
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB3194096;
	Mon, 30 Sep 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GCdcUvOE"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD38126C03;
	Mon, 30 Sep 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715994; cv=none; b=nE6lKb89t1/3WHhIFpZ3jgIqU9mJD0sM2qcidFrgh3XgEqQRV02Ifl39rNTHDbOCQFRLZxVL9MvzNxjJf7SVO414ekwIDuGzlYNQASLtYZoaG9DA5moqxNTSnlOENlhgev1xCTcH+fuPAhfioKhhmNhMfmdKfiKxqid1LKH3zDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715994; c=relaxed/simple;
	bh=TrXuPMm9zcp4cEm95p012f2bgas90nMN/FrZWiy7Q7o=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=hqEM5NtmXf6O+spKaA3nFfxHgzmkHBv4qXYh1sxWiMME2reYLK0Mp7AktpnqZPIj1sxjMkPDccxb1NREo0kXryiq81VKh+qfrKyBGOskQqZyhSG18ojIeya34qp2npZB/YC/Q9z3MJViyx8rgv43Qkp2oiFWrcV19eJqkvnzc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GCdcUvOE; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=UMnrG8ZjcGLecpo1O8GBztCjlOrIx408++7rYA1x43w=; b=GCdcUvOEP3uZQTKQdx8T3txvIf
	MiZCxOMr/8tm/pnPXMG+VrVXIgZS/ABmJSfE3EW9Hdm64aTGn7okpP+WbAK2JS3VzCfoLYWU0L+4h
	4lVxut9nopH6Ak+DX9GPamfgAKXlxla6olsXhtm4ZX6RcS1h3Mor7dZj6bTw7ISHVI0Q=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40922 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1svJql-0000XQ-Vv; Mon, 30 Sep 2024 13:06:20 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Jagan Teki <jagan@edgeble.ai>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Date: Mon, 30 Sep 2024 13:05:03 -0400
Message-Id: <20240930170503.1324560-1-hugo@hugovil.com>
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
Subject: [PATCH] drm: panel: jd9365da-h3: Remove unused num_init_cmds structure member
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Now that the driver has been converted to use wrapped MIPI DCS functions,
the num_init_cmds structure member is no longer needed, so remove it.

Fixes: 35583e129995 ("drm/panel: panel-jadard-jd9365da-h3: use wrapped MIPI DCS functions")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 44897e5218a6..45d09e6fa667 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -26,7 +26,6 @@ struct jadard_panel_desc {
 	unsigned int lanes;
 	enum mipi_dsi_pixel_format format;
 	int (*init)(struct jadard *jadard);
-	u32 num_init_cmds;
 	bool lp11_before_reset;
 	bool reset_before_power_off_vcioo;
 	unsigned int vcioo_to_lp11_delay_ms;

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.39.5


