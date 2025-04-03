Return-Path: <stable+bounces-128008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E81A7AE1D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701AA3B796F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715CE1F584A;
	Thu,  3 Apr 2025 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVIvw4tz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BC1F583B;
	Thu,  3 Apr 2025 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707749; cv=none; b=CFBn8RuM6auecg8LZvhAl4kuAGX6Ln4kc2kgha8cU2rhajyMKjHQdWf7NtH9DN5/ANKrYdqrzB5t+zCB6U7RnZkAOrRuWFdOPgsKySqtmeY1/ejD9NHmYMZwo2D33epkUB22cVwpRBJc6HtHiOMXUHPV6ZQMzaBETAZCmJoLgq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707749; c=relaxed/simple;
	bh=XmkNPLT5Lhcti9jG+lBjspxrlWMRLk3OLBBVrU8VG0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uj49gBVDWK/Oq6tPRuaHabBPcqK+E7oFAP+UjvG4cEDVSgIogtuBl5w17aOx5NQkBBvcqVdEza3bWihFXCPJiLw4VtXVrcvmdjQWWsqS7vpE+bQQGVP2m1Xf54mc98bISHfwUp0e/nD2AFx5Ye7J/LjfRqR16SNwuvsIvQWXLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVIvw4tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E0EC4CEE3;
	Thu,  3 Apr 2025 19:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707749;
	bh=XmkNPLT5Lhcti9jG+lBjspxrlWMRLk3OLBBVrU8VG0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVIvw4tz9gNbXTDLJqLatUHwZLljvlrH4uCMWSYa2pB8bCvYtiHxvgUfFIURl0Bip
	 YxX5UYhOOhXVIUrM5nIMvlKiqC8eUjkCJ70KrdZw99XDeocJnxDU0uER1tRlBwcHy6
	 oH37Rc6s6FMlrhfNNWqpi6EruQwb59bLzzyGWrscZeb5np4jzN7guGAEQLLpCBby+1
	 qneYm4KFHwl7XbIFHlMguOf0bif9dF3uV/UnYs4O2yAjFCvTU9m81NMJULAe/Afsqp
	 ofmGvKU+m4IHhN6+2r71VMJdcRtyj4ywey4CvskXkUCNla000h5c0QqlWNEQqY0kqh
	 U7zjZS1yz3bGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Wyatt <fewtarius@steamfork.org>,
	John Edwards <uejji@uejji.net>,
	Paco Avelar <pacoavelar@hotmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 09/37] drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
Date: Thu,  3 Apr 2025 15:14:45 -0400
Message-Id: <20250403191513.2680235-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

[ Upstream commit 529741c331da1fbf54f86c6ec3a4558b9b0b16dc ]

The AYA NEO Flip DS and KB both use a 1080x1920 portrait LCD panel.  The
Flip DS additionally uses a 640x960 portrait LCD panel as a second display.

Add DMI matches to correctly rotate these panels.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Co-developed-by: John Edwards <uejji@uejji.net>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: Paco Avelar <pacoavelar@hotmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213222455.93533-3-uejji@uejji.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index f9c975338fc9e..b5f6ae0459459 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -93,6 +93,12 @@ static const struct drm_dmi_panel_orientation_data onegx1_pro = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd640x960_leftside_up = {
+	.width = 640,
+	.height = 960,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd720x1280_rightside_up = {
 	.width = 720,
 	.height = 1280,
@@ -202,6 +208,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {    /* AYA NEO Flip DS Bottom Screen */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FLIP DS"),
+		},
+		.driver_data = (void *)&lcd640x960_leftside_up,
+	}, {    /* AYA NEO Flip KB/DS Top Screen */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "FLIP"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYA NEO Founder */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),
-- 
2.39.5


