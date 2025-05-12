Return-Path: <stable+bounces-143542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA6EAB404A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747E93A92BF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611DC254879;
	Mon, 12 May 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NqTCiFTA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4E245022;
	Mon, 12 May 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072294; cv=none; b=jGZZZ76e5RxwqAl/aXM/ckIsmMIp6KJsYJ7AAQX2vSbPXB+MvskdKjrIzr3Or0BZ2q8N3w7zFm6gNaTqJnxb/BdNIiVW5HsG0ACJfuqW3IeHlDvx0B1msBq0NH2gqvHZiG1Js7PwALKgS5X25HOnnn9+Dqv2UZ22536OR2nlavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072294; c=relaxed/simple;
	bh=AMFmhNu9oN5w7aaiG1GjcK4W+K7K5zI+NGMlqiNtK6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgl8AwbPM1SAx51OGR6ucvZqLmBJJICLJ9NJbnd9Tp1nCAr+zkU++nunZFTlG9yMP9zhv7UJrlD/0qAEX3nrTHRJ4uj9gaC4yCd5RSrqp0nVV0GrpGn4I1uQKIhnyYNUonGFCfOkIZjefp3ubuSOyiKFOhICh5S/iS3k+NTz5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NqTCiFTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38EFC4CEE7;
	Mon, 12 May 2025 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072294;
	bh=AMFmhNu9oN5w7aaiG1GjcK4W+K7K5zI+NGMlqiNtK6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqTCiFTAEmfcP2G6AvrzGqAFUtnqQpZnmiwD1KSmzJLfIt86mDRp9/AO2BzmINEMA
	 CRXDyoj6kWJVI0pN8LFGiQiblPxpWmoOAqYQWrG7DV7LnmZts71ttvdiAppRk3swNA
	 6Z+V/3eIb/kuSVLh7cY1106kaHZw6o3ONB2sqycQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Baker <kevinb@ventureresearch.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 163/197] drm/panel: simple: Update timings for AUO G101EVN010
Date: Mon, 12 May 2025 19:40:13 +0200
Message-ID: <20250512172051.020851220@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Baker <kevinb@ventureresearch.com>

[ Upstream commit 7c6fa1797a725732981f2d77711c867166737719 ]

Switch to panel timings based on datasheet for the AUO G101EVN01.0
LVDS panel. Default timings were tested on the panel.

Previous mode-based timings resulted in horizontal display shift.

Signed-off-by: Kevin Baker <kevinb@ventureresearch.com>
Fixes: 4fb86404a977 ("drm/panel: simple: Add AUO G101EVN010 panel support")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250505170256.1385113-1-kevinb@ventureresearch.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250505170256.1385113-1-kevinb@ventureresearch.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9b2f128fd3094..cf9ab2d1f1d2a 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1027,27 +1027,28 @@ static const struct panel_desc auo_g070vvn01 = {
 	},
 };
 
-static const struct drm_display_mode auo_g101evn010_mode = {
-	.clock = 68930,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 82,
-	.hsync_end = 1280 + 82 + 2,
-	.htotal = 1280 + 82 + 2 + 84,
-	.vdisplay = 800,
-	.vsync_start = 800 + 8,
-	.vsync_end = 800 + 8 + 2,
-	.vtotal = 800 + 8 + 2 + 6,
+static const struct display_timing auo_g101evn010_timing = {
+	.pixelclock = { 64000000, 68930000, 85000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 8, 64, 256 },
+	.hback_porch = { 8, 64, 256 },
+	.hsync_len = { 40, 168, 767 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 4, 8, 100 },
+	.vback_porch = { 4, 8, 100 },
+	.vsync_len = { 8, 16, 223 },
 };
 
 static const struct panel_desc auo_g101evn010 = {
-	.modes = &auo_g101evn010_mode,
-	.num_modes = 1,
+	.timings = &auo_g101evn010_timing,
+	.num_timings = 1,
 	.bpc = 6,
 	.size = {
 		.width = 216,
 		.height = 135,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
-- 
2.39.5




