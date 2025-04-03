Return-Path: <stable+bounces-128005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D4DA7AE21
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2172189AD47
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3508E1F3BAB;
	Thu,  3 Apr 2025 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2eLJw/o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45AB1F30DD;
	Thu,  3 Apr 2025 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707738; cv=none; b=K6UuRzYsMMsZcEK6q12z7JvkNCEZDhFhAjLASjSU3gQRuBKjG3Uv23nfMvnYGYdZqfxH4eSRWGpneLxUQ0kRi7z0n49JJsbZk+jW9MYzx+38D0EO7dS5nGu+RFMvyLkunFEO42op2UxLS1EwIoDSKuGkYgaHn1p8mn5NO52OoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707738; c=relaxed/simple;
	bh=cLm07MrN/+5WSG9GGHQ14GgM3R5yCRpHmRteCKQ4QZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyQ8iEsvS876MtGNNMRAscH8azVKgVdis6Kh/k1q1qym/uNpUB3LA2aNps90irs8C6vxV5/PvyiWeWzVQfMxz4Bf23M7HNsifMUZz9njz6ltZ45QLfN5NU0lLbx9/6iOFeCVunxfW3k/4hTIrJi7snLGeQz+dYPFzL20PeAnj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2eLJw/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02F9C4CEE3;
	Thu,  3 Apr 2025 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707737;
	bh=cLm07MrN/+5WSG9GGHQ14GgM3R5yCRpHmRteCKQ4QZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2eLJw/oEqhJTEqvey9bhXQ30DyOieH7j0lwP96YYgh4Ch8hBqAaDTZUuuA6DKCaz
	 o3V67B/YnVL/3J0wN3zrRxHrAg6I9MVCOQdXAny+YM3E5I8QRrywPsMiDVLHo6BliL
	 NYSWpk5+dnbvE8Kb7CNvto3ZP+TCnQRg5SeWcJUMWhA9kaLCRKWymbT6QYBr0il5iy
	 YgKWqjLCBeM7YyXeutaFo6+TNUMi9PpE4pcTWoh+uucN8f8NFIWpCGaCCxExZLWvpX
	 A8l5Sa0hnyLm9Nya6MxxpviuF21EAB7luDwiXY6d6iQDzlVpoxUOXmCl9AuN31XUEr
	 WOT4FruPrEIDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brendan Tam <Brendan.Tam@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	aric.cyr@amd.com,
	siqueira@igalia.com,
	alex.hung@amd.com,
	roman.li@amd.com,
	dillon.varone@amd.com,
	Syed.Hassan@amd.com,
	Samson.Tam@amd.com,
	george.shen@amd.com,
	Cruise.Hung@amd.com,
	joshua.aberback@amd.com,
	PeiChen.Huang@amd.com,
	jerry.zuo@amd.com,
	michael.strauss@amd.com,
	ivlipski@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 06/37] drm/amd/display: add workaround flag to link to force FFE preset
Date: Thu,  3 Apr 2025 15:14:42 -0400
Message-Id: <20250403191513.2680235-6-sashal@kernel.org>
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

From: Brendan Tam <Brendan.Tam@amd.com>

[ Upstream commit 51d1b338541dea83fec8e6f95d3e46fa469a73a8 ]

[Why]
There have been instances of some monitors being unable to link train on
their reported link speed using their selected FFE preset. If a different
FFE preset is found that has a higher rate of success during link training
this workaround can be used to force its FFE preset.

[How]
A new link workaround flag is made called force_dp_ffe_preset. The flag is
checked in override_training_settings and will set lt_settings->ffe_preset
which is null if the flag is not set. The flag is then set in
override_lane_settings.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Brendan Tam <Brendan.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h                             | 2 ++
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 08c5a315b3a67..1e1633b7771c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1780,7 +1780,9 @@ struct dc_link {
 		bool dongle_mode_timing_override;
 		bool blank_stream_on_ocs_change;
 		bool read_dpcd204h_on_irq_hpd;
+		bool force_dp_ffe_preset;
 	} wa_flags;
+	union dc_dp_ffe_preset forced_dp_ffe_preset;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
 	struct dc_link_status link_status;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 754c895e1bfbd..09024a8bac128 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -736,6 +736,8 @@ void override_training_settings(
 		lt_settings->pre_emphasis = overrides->pre_emphasis;
 	if (overrides->post_cursor2 != NULL)
 		lt_settings->post_cursor2 = overrides->post_cursor2;
+	if (link->wa_flags.force_dp_ffe_preset && !dp_is_lttpr_present(link))
+		lt_settings->ffe_preset = &link->forced_dp_ffe_preset;
 	if (overrides->ffe_preset != NULL)
 		lt_settings->ffe_preset = overrides->ffe_preset;
 	/* Override HW lane settings with BIOS forced values if present */
-- 
2.39.5


