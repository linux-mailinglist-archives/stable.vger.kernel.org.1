Return-Path: <stable+bounces-140214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E4AAA630
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9CB168AD0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536BD28F53F;
	Mon,  5 May 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIrYgpn7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D728F536;
	Mon,  5 May 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484370; cv=none; b=AL8MqflpGpufBOcp5fC9+voxHb5VpeUrhl5v6sfRX9Ht3D7idWiEWlXtkDJakEOe8sacl4m6ImP7dtuHYGd80aCxO3+lQNKSenacZil7MckrHf99O5/nhxWXAaqx35FFqAQrlk6FyCjAxbHdzNfJh+RMjYsaynjzjKFN2nCmTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484370; c=relaxed/simple;
	bh=WhObNx/UgZPNUHn7lDsfgoqh+dAqU8HeTGp0/MvtNw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TL+liJWkWW1vLQn5G/fo3m+ze4fvEnWYXAuRicIOFdR+bHIGKW+n1xQU7KDYa8xhBzQh/4wjBOYs5mgZfE4RI02Xa2xA7k921v4l377ioQX2Wf4TqpGySGhDuUP3dJkHqO6f3tAka/nLFfPOGu+PClywajFsGb3V4AHFQXnHc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIrYgpn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ED2C4CEEE;
	Mon,  5 May 2025 22:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484369;
	bh=WhObNx/UgZPNUHn7lDsfgoqh+dAqU8HeTGp0/MvtNw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIrYgpn7e2T/pwk5T3pzG4TB/h6Vdd3f/y1XmN38OmFal92vku3kuBjQGb0X8XBnK
	 cqmUsqCicouOcVQ0OZrYaWCcZejSNPM6y7HKIvHmWCV4ZRaBtdC2Ctx+TVSwqfcGSU
	 5zg4Lx/i36PRBP5UGN1pOxvSvR1R9NzFwPb8yF9usQed4Ash1YWJWA7YfwY1ghNYfh
	 4JDUdBEGW+PMn9uvAZZb7ozCyVuGSKI6Nafd+YDMwfl2tjOqgPVngcZ4jW2AGh8jA+
	 FH5CJRGOKXNE7YRXXf4XOJ9m+xtc0ZCCpNUMPVlNNqzbybL3VJVbLWL0hIaHIIkLHx
	 6Intd4HrAWxXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Tsai <Martin.Tsai@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	aurabindo.pillai@amd.com,
	dennis.chan@amd.com,
	mwen@igalia.com,
	Kaitlyn.Tse@amd.com,
	george.shen@amd.com,
	Wayne.Lin@amd.com,
	Gabe.Teeger@amd.com,
	Cruise.Hung@amd.com,
	jack.chang@amd.com,
	jerry.zuo@amd.com,
	zaeem.mohamed@amd.com,
	duncan.ma@amd.com,
	Zhongwei.Zhang@amd.com,
	chiahsuan.chung@amd.com,
	nicholas.kazlauskas@amd.com,
	Syed.Hassan@amd.com,
	dillon.varone@amd.com,
	aric.cyr@amd.com,
	Ovidiu.Bunea@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 466/642] drm/amd/display: Support multiple options during psr entry.
Date: Mon,  5 May 2025 18:11:22 -0400
Message-Id: <20250505221419.2672473-466-sashal@kernel.org>
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

From: Martin Tsai <Martin.Tsai@amd.com>

[ Upstream commit 3a5fa55455db6a11248a25f24570c365f9246144 ]

[WHY]
Some panels may not handle idle pattern properly during PSR entry.

[HOW]
Add a condition to allow multiple options on power down
sequence during PSR1 entry.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Martin Tsai <Martin.Tsai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h       | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c   | 4 ++++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0c2aa91f0a111..e60898c2df01a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1033,6 +1033,13 @@ struct psr_settings {
 	unsigned int psr_sdp_transmit_line_num_deadline;
 	uint8_t force_ffu_mode;
 	unsigned int psr_power_opt;
+
+	/**
+	 * Some panels cannot handle idle pattern during PSR entry.
+	 * To power down phy before disable stream to avoid sending
+	 * idle pattern.
+	 */
+	uint8_t power_down_phy_before_disable_stream;
 };
 
 enum replay_coasting_vtotal_type {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 88c75c243bf8a..ff3b8244ba3d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -418,6 +418,10 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->relock_delay_frame_cnt = 0;
 	if (link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8)
 		copy_settings_data->relock_delay_frame_cnt = 2;
+
+	copy_settings_data->power_down_phy_before_disable_stream =
+		link->psr_settings.power_down_phy_before_disable_stream;
+
 	copy_settings_data->dsc_slice_height = psr_context->dsc_slice_height;
 
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d0fe324cb5371..8cf89aed024b7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3118,6 +3118,12 @@ struct dmub_cmd_psr_copy_settings_data {
 	 * Some panels request main link off before xth vertical line
 	 */
 	uint16_t poweroff_before_vertical_line;
+	/**
+	 * Some panels cannot handle idle pattern during PSR entry.
+	 * To power down phy before disable stream to avoid sending
+	 * idle pattern.
+	 */
+	uint8_t power_down_phy_before_disable_stream;
 };
 
 /**
-- 
2.39.5


