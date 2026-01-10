Return-Path: <stable+bounces-207969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642CD0D897
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADCB730319A2
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32933985B;
	Sat, 10 Jan 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="YBk+EmSv"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A132309B9;
	Sat, 10 Jan 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768058884; cv=none; b=UOG5x7Qf9dQunoBAwAWEL4oZp4/ShbEIUxsyDEYtfWR8Z1f71uu8DCVRCwAgsrbl9BsSAF5u8uhmAKCtbVGSxx/1csefB3i7JE50oAvWeJin0x73+g1U2MUs98P/wIrIdc9JAWeyqfj1B1HoVpaMy0CXbZIlrO7bwvZ88aNqA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768058884; c=relaxed/simple;
	bh=mRCPtIAF73wP1/o7ZVCX1RjRFvbR0B+HwEZ4LB7IADY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzAyK0OVAs8t8dldk/B/QkelC+RnB9mIrsbbi4Mkz8Fut86pNL+P7Jp/C8vZ1bdIuCcHBaN8vJ+8doKHkwv0Xjb25nErv+JxQf2VU4zj5IJAF7q0WG/2bgD8QSWKb+5nyyTMJUmkjtHDBh17j1gnbuVQ56g8dLd7qbiwzWImLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=YBk+EmSv; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 392B4103478;
	Sat, 10 Jan 2026 16:27:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768058874; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=jPuCYz9M+uS+LPyzVn6gpI54syQVbiK+1G5ZGXrjAeI=;
	b=YBk+EmSvl6cMfa/yJiRh8yDvKSH9+w+Y62/z7nF4Ji4Jm5jPW9LHQpMAC2Zefy9kFRXiut
	9MA3peqFkvGfvgcS/i4pcIbbCSx8jtaiYgk2T41TobuODZyU5YOPk+Xo1dpCP3DaWcIsEV
	7somRUZfuI5pdHqOegvl4kd3OjTxXFZx46Iw3NzYTwx4fRHVRTgz/3CB2KccBzmyjGDhEl
	94AaCSa0HSxDNU5WgJfRifK3i9RkJ688MlueWtBagcJDEApTUoa3zF1uUndplvAJuCWF0N
	fP871G7A8lvHq7VJv7uiBbBZjdIigf2yOsD2+xoFNreN+Wf6jJPfDxy9EsBU0w==
From: Marek Vasut <marex@nabladev.com>
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marex@nabladev.com>,
	stable@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-simple: fix connector type for DataImage SCF0700C48GGU18 panel
Date: Sat, 10 Jan 2026 16:27:28 +0100
Message-ID: <20260110152750.73848-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The connector type for the DataImage SCF0700C48GGU18 panel is missing and
devm_drm_panel_bridge_add() requires connector type to be set. This leads
to a warning and a backtrace in the kernel log and panel does not work:
"
WARNING: CPU: 3 PID: 38 at drivers/gpu/drm/bridge/panel.c:379 devm_drm_of_get_bridge+0xac/0xb8
"
The warning is triggered by a check for valid connector type in
devm_drm_panel_bridge_add(). If there is no valid connector type
set for a panel, the warning is printed and panel is not added.
Fill in the missing connector type to fix the warning and make
the panel operational once again.

Cc: stable@vger.kernel.org
Fixes: 97ceb1fb08b6 ("drm/panel: simple: Add support for DataImage SCF0700C48GGU18")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: David Airlie <airlied@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3acc9f3dac16a..e33ee2308e715 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1900,6 +1900,7 @@ static const struct panel_desc dataimage_scf0700c48ggu18 = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
 static const struct display_timing dlc_dlc0700yzg_1_timing = {
-- 
2.51.0


