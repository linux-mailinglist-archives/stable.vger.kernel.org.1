Return-Path: <stable+bounces-141454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEDAAAB38D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549201B648E5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D724DFF6;
	Tue,  6 May 2025 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXT1vTq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B4239E84;
	Mon,  5 May 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486355; cv=none; b=Mgjd2+W1ZxHDJbziB/lRlgj2IeXxFVRyd1EKN+Kc92+HxBMCXLDWLZ3Eez/wI36qqjTDtZOYk1UKHdz1qFVZhca7lMG8Mh+4Y+ZvKrM4k+gLyfQOmPgMo7HUwF0DPBOvQwmj9EO6ZigTgv1kvmKX6y1n8tWRuElYMlA1vjlSN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486355; c=relaxed/simple;
	bh=dNhTQdQsmVJdOJI8hk4/K23ZH1cUxcHoeRd+WsN65vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZW9dd5WjvEmBGnMWqiF28sO2nNnhi6Fpvvijb/DM/Fi0BX9kInidjxj7LnsCYQBeGn/n3pGTeZqozhNJMVxrMnMbpe7nox4z3Z1fjQA5OPEJChigfzEQD7WbiujO6ZfsFoRmOr6LgYIBkd4LHqZLKV9WwfBNK+Cw6V9NUhQtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXT1vTq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFA5C4CEE4;
	Mon,  5 May 2025 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486353;
	bh=dNhTQdQsmVJdOJI8hk4/K23ZH1cUxcHoeRd+WsN65vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXT1vTq88aqsZzKOl2Ux1J5PVLJFf6rIMVcbkq0T5Zf8ztp6gDoVU/8qd20xv5BEQ
	 ZXF0ZD3mo96xdCIQYqbWF1z/wDmy1/qN4bi2+9o+/XtgZuLx8KaQcPqEz1g2BLekML
	 I9S5/jAP/1JAvrSiOtwlWRZSofe78j4vCNWmBLqlhtOonyoBMl1hMnOIduPNs/OTVN
	 TdIDQ2QUkw1SFmi79mMNV5S0IxCafGjSiEbq1iRSjRG0UoaJxPjMTFuBac/N4xEWlP
	 74tbYU3RTV3WwK77OKJWGe2E16eYmd63WBLq22iPSgAckdNfMGcy0m0uOYF0D+VcL2
	 omdF6F90Es4Zg==
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
Subject: [PATCH AUTOSEL 6.6 276/294] drm/ast: Find VBIOS mode from regular display size
Date: Mon,  5 May 2025 18:56:16 -0400
Message-Id: <20250505225634.2688578-276-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 3de0f457fff6a..5f58da6ebaadb 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -132,7 +132,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		return false;
 	}
 
-	switch (mode->crtc_hdisplay) {
+	switch (mode->hdisplay) {
 	case 640:
 		vbios_mode->enh_table = &res_640x480[refresh_rate_index];
 		break;
@@ -146,7 +146,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1152x864[refresh_rate_index];
 		break;
 	case 1280:
-		if (mode->crtc_vdisplay == 800)
+		if (mode->vdisplay == 800)
 			vbios_mode->enh_table = &res_1280x800[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1280x1024[refresh_rate_index];
@@ -158,7 +158,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1440x900[refresh_rate_index];
 		break;
 	case 1600:
-		if (mode->crtc_vdisplay == 900)
+		if (mode->vdisplay == 900)
 			vbios_mode->enh_table = &res_1600x900[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1600x1200[refresh_rate_index];
@@ -167,7 +167,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1680x1050[refresh_rate_index];
 		break;
 	case 1920:
-		if (mode->crtc_vdisplay == 1080)
+		if (mode->vdisplay == 1080)
 			vbios_mode->enh_table = &res_1920x1080[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1920x1200[refresh_rate_index];
@@ -211,6 +211,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 	hborder = (vbios_mode->enh_table->flags & HBorder) ? 8 : 0;
 	vborder = (vbios_mode->enh_table->flags & VBorder) ? 8 : 0;
 
+	adjusted_mode->crtc_hdisplay = vbios_mode->enh_table->hde;
 	adjusted_mode->crtc_htotal = vbios_mode->enh_table->ht;
 	adjusted_mode->crtc_hblank_start = vbios_mode->enh_table->hde + hborder;
 	adjusted_mode->crtc_hblank_end = vbios_mode->enh_table->ht - hborder;
@@ -220,6 +221,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 					 vbios_mode->enh_table->hfp +
 					 vbios_mode->enh_table->hsync);
 
+	adjusted_mode->crtc_vdisplay = vbios_mode->enh_table->vde;
 	adjusted_mode->crtc_vtotal = vbios_mode->enh_table->vt;
 	adjusted_mode->crtc_vblank_start = vbios_mode->enh_table->vde + vborder;
 	adjusted_mode->crtc_vblank_end = vbios_mode->enh_table->vt - vborder;
-- 
2.39.5


