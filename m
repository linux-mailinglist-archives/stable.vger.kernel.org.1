Return-Path: <stable+bounces-127965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B87A7ADB4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632BF3B691E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE925D91D;
	Thu,  3 Apr 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE7V9vO3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E237A253B59;
	Thu,  3 Apr 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707629; cv=none; b=FTSjuZsE7PZMVRMXwBWE2ihiXLjKF2wJiectYNed7jFQL3tl8A8uhX+gp2eSGVq2wbDSUyi516tSlhdj9q0hWkv2AwQIJsYnAw2wGiiDYQ7d4PDMczJni+QqRNX9V5LvBOcFJCWdsz480SjOMDZDwvGVjCABFZti3qv+hw+dZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707629; c=relaxed/simple;
	bh=XULMHhhPml6Us68TzzJZLuujw7t3oyVQmd7FPGYOLik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxKY2vesuU+tuSJDfxxfDDpe9qpxxL2POUY9EInaMmfrYJhQ7uXiwzliiz41Aat7KMM+9+RfOB+1n/HM9nSVIBlhiahNRLvxA6VGluorxFJGJgjVOC4NcQFvf/ofZbMDkw/KtG4QukB+M7YCcQcm2cOKERkCFfxaqAE0In7KhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE7V9vO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059C4C4CEE9;
	Thu,  3 Apr 2025 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707628;
	bh=XULMHhhPml6Us68TzzJZLuujw7t3oyVQmd7FPGYOLik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE7V9vO3IITpgjZes/7MHu7QNU4LQ61btN7LvsHirmMgfl/p/j1sUrq/66IzlSIFq
	 dpwOs+DvoA3/bPQdaeBg82GCYj71iMVa5+pFnpWtd0XYlV5zceZ7QpXTbvLF2Hyxzw
	 eERcDbA6z301Js3XkfnV7T8jiMKpH0SE+Fybsoi/gHBfHQixMp6K5QAPMzTCejnmH3
	 wQRtHXMtBoTKNnT1ZA9qY6b5HmBTVmmy3sLc0mWqOWJSg7jrvol5Rsj0frvtEO1kl6
	 c938ZZE3KsQeEC0xI6Waf9iYmw4yfeWPA8vRd9mXwLBJ0U1a2uLNWLJeLOr6yXMQv5
	 nUOsgnImNzc8g==
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
	Samson.Tam@amd.com,
	Syed.Hassan@amd.com,
	george.shen@amd.com,
	Cruise.Hung@amd.com,
	joshua.aberback@amd.com,
	PeiChen.Huang@amd.com,
	jerry.zuo@amd.com,
	michael.strauss@amd.com,
	ivlipski@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 10/44] drm/amd/display: add workaround flag to link to force FFE preset
Date: Thu,  3 Apr 2025 15:12:39 -0400
Message-Id: <20250403191313.2679091-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 053481ab69efb..ab77dcbc10584 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1788,7 +1788,9 @@ struct dc_link {
 		bool dongle_mode_timing_override;
 		bool blank_stream_on_ocs_change;
 		bool read_dpcd204h_on_irq_hpd;
+		bool force_dp_ffe_preset;
 	} wa_flags;
+	union dc_dp_ffe_preset forced_dp_ffe_preset;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
 	struct dc_link_status link_status;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 88d4288cde0f5..751c18e592ea5 100644
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


