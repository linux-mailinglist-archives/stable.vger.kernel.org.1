Return-Path: <stable+bounces-140328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D46AAA7B1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD05986EE4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684CB33BC41;
	Mon,  5 May 2025 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1hCKBEX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399733AAA0;
	Mon,  5 May 2025 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484643; cv=none; b=X7M5xBENhHL6dejYvkzNhKvjXtAr1tt7a+imU/oqT8S8e0y9d5K5snMOe3NSOnB+NFFYD1A7534r5/NVcvnVXnaVWhuL7zMA7OTyQPLJ8xjlcqv3Lly3cuUA2+mQtKCOrNdg0kfqe5RkyZXiMeG6qp6bzN6RwtTKCt0yQeUWAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484643; c=relaxed/simple;
	bh=UQ4fYYDOqGWhEE90z4YemxbN1I6T53FGwnmHFuiuFEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rb0NcWE+xjAbs/3GGpE1KCHqm+roFubf23axlUQKZ73VG0EBocMuALbGdxmktkNC/TeQl2MN3VdSjs18Bq6qB8TbpD6EJCfPKPujFRWQXDulcEHUWsJ/lphmVfzCl1U+PlTzcdSwu+YG60hNcoa2NlWOygLlvxEghFIdnEaHfSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1hCKBEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F61FC4CEED;
	Mon,  5 May 2025 22:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484642;
	bh=UQ4fYYDOqGWhEE90z4YemxbN1I6T53FGwnmHFuiuFEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1hCKBEX3AYj/SwldQIi+U4oJLSyUYy/qbZ4YZ+eTRbhu4BbGcfhWHKX80SgA+Dhv
	 N5h54ExjC6Tmxv6t63XVT8ZHr0OVB9FOCjE15mIiwViwhghXAVTgB6Dr69TD5gLz1Q
	 d57N7nC1Pz/K9Z6M3kCmTgvP1mq7/3Xx1wCHd3oa8zpJQcts/qSE606XrdimvZc/AE
	 yVq4qKzFUWfokJ5fzjZ2ML2tB88k37tddQ64pwMhG2lE93ikY4gUjR95u++8mesbW1
	 Io0u1qpSEFH3pXUiJW+GxceCjrquD1we+LsJzg1lib+8NMWpfcNMWS6NcRI9IS4xuK
	 EyZ7f0FFX31rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 579/642] drm/ast: Find VBIOS mode from regular display size
Date: Mon,  5 May 2025 18:13:15 -0400
Message-Id: <20250505221419.2672473-579-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit c81202906b5cd56db403e95db3d29c9dfc8c74c1 ]

The ast driver looks up supplied display modes from an internal list of
display modes supported by the VBIOS.

Do not use the crtc_-prefixed display values from struct drm_display_mode
for looking up the VBIOS mode. The fields contain raw values that the
driver programs to hardware. They are affected by display settings like
double-scan or interlace.

Instead use the regular vdisplay and hdisplay fields for lookup. As the
programmed values can now differ from the values used for lookup, set
struct drm_display_mode.crtc_vdisplay and .crtc_hdisplay from the VBIOS
mode.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250131092257.115596-9-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_mode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 9d5321c81e68d..a29fe1ae803f1 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -131,7 +131,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		return false;
 	}
 
-	switch (mode->crtc_hdisplay) {
+	switch (mode->hdisplay) {
 	case 640:
 		vbios_mode->enh_table = &res_640x480[refresh_rate_index];
 		break;
@@ -145,7 +145,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1152x864[refresh_rate_index];
 		break;
 	case 1280:
-		if (mode->crtc_vdisplay == 800)
+		if (mode->vdisplay == 800)
 			vbios_mode->enh_table = &res_1280x800[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1280x1024[refresh_rate_index];
@@ -157,7 +157,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1440x900[refresh_rate_index];
 		break;
 	case 1600:
-		if (mode->crtc_vdisplay == 900)
+		if (mode->vdisplay == 900)
 			vbios_mode->enh_table = &res_1600x900[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1600x1200[refresh_rate_index];
@@ -166,7 +166,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1680x1050[refresh_rate_index];
 		break;
 	case 1920:
-		if (mode->crtc_vdisplay == 1080)
+		if (mode->vdisplay == 1080)
 			vbios_mode->enh_table = &res_1920x1080[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1920x1200[refresh_rate_index];
@@ -210,6 +210,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 	hborder = (vbios_mode->enh_table->flags & HBorder) ? 8 : 0;
 	vborder = (vbios_mode->enh_table->flags & VBorder) ? 8 : 0;
 
+	adjusted_mode->crtc_hdisplay = vbios_mode->enh_table->hde;
 	adjusted_mode->crtc_htotal = vbios_mode->enh_table->ht;
 	adjusted_mode->crtc_hblank_start = vbios_mode->enh_table->hde + hborder;
 	adjusted_mode->crtc_hblank_end = vbios_mode->enh_table->ht - hborder;
@@ -219,6 +220,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 					 vbios_mode->enh_table->hfp +
 					 vbios_mode->enh_table->hsync);
 
+	adjusted_mode->crtc_vdisplay = vbios_mode->enh_table->vde;
 	adjusted_mode->crtc_vtotal = vbios_mode->enh_table->vt;
 	adjusted_mode->crtc_vblank_start = vbios_mode->enh_table->vde + vborder;
 	adjusted_mode->crtc_vblank_end = vbios_mode->enh_table->vt - vborder;
-- 
2.39.5


