Return-Path: <stable+bounces-77464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C89985D84
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60231C24E95
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA0F1B29B1;
	Wed, 25 Sep 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg6VJB8J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEDE18BC35;
	Wed, 25 Sep 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265890; cv=none; b=PsRXlvt6a4I4RIbUMytvrCGy9kTQ2chnM2caJj/u+nkEANAibPdmiuLLChsy/i3zcyJHXRthIF4lSToQ8KcU+axdRAJnDoyLuUmsHgpEFZVI0TFkPrdaCWhL+YXJ7K9tC7qe0HQK8eDXOYUAXKWP/BXuNHaglwdIrR1voV6F3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265890; c=relaxed/simple;
	bh=0BJP31CFh9sabb3zMJFok1j++lOYUZlh7qRAywB2rJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvWKyUrmNKMDek4IM1SCG/j1RvgDH3Y+MXItuiNALL5D75DwMO4MV4kQIMoue3gy3n8GNGAPQ9kiNNXn+4KnNcRP1jtfhLtlHZ7vCHTJrgY/y/gT0MtJhXSVGB7B3yTAYrjXwcR0I8wjzudhLg1E5r6vBISQtx0b7jz4ar0p7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg6VJB8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB0DC4CEC3;
	Wed, 25 Sep 2024 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265889;
	bh=0BJP31CFh9sabb3zMJFok1j++lOYUZlh7qRAywB2rJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kg6VJB8JqTKxRSIRns+jy6jRgB3vCfcQVCay0svhPdbqZjwjD/8RmeNgOFVGEyzD9
	 mAIvLyvk6TWQNIrbxCI5m+Q4MTBb5aUdjrY5tQITLKQpxd9LpSJhTk9HljacVOvceR
	 RRVSb4t9WLiCDAkGOx80Ytskn2WvmUZ+QTsgjMO6p4VC8eMqwbKmlQNiZURiNKrkM/
	 1pBtwxhjWiUtPGEGoK602dVFy6p+e/V69u+pYwTJq8grMSGIUV//BfXbT4pKgUCHww
	 74Y3jbPckdOFOeBvXC1ytkN9HxGJCZ224eX0RCX1JnrMzXNt8X7gp8Mm8ltdYNPtKP
	 WBSD6NueOP4Zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mwen@igalia.com,
	hanghong.ma@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 119/197] drm/amd/display: Add NULL check for clk_mgr and clk_mgr->funcs in dcn30_init_hw
Date: Wed, 25 Sep 2024 07:52:18 -0400
Message-ID: <20240925115823.1303019-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit cba7fec864172dadd953daefdd26e01742b71a6a ]

This commit addresses a potential null pointer dereference issue in the
`dcn30_init_hw` function. The issue could occur when `dc->clk_mgr` or
`dc->clk_mgr->funcs` is null.

The fix adds a check to ensure `dc->clk_mgr` and `dc->clk_mgr->funcs` is
not null before accessing its functions. This prevents a potential null
pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:789 dcn30_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 628)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 4c47061533050..f3422a323b71a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -622,7 +622,7 @@ void dcn30_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	// Initialize the dccg
@@ -783,11 +783,12 @@ void dcn30_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
 	//if softmax is enabled then hardmax will be set by a different call
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.43.0


