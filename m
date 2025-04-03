Return-Path: <stable+bounces-127964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECADA7ADB3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552033AFE05
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD4B25D8FF;
	Thu,  3 Apr 2025 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/AKLBv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702B253B56;
	Thu,  3 Apr 2025 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707622; cv=none; b=o4OgZDulKYsCiI7kGLo0h/phiYcsPjvOr1S6CKBr6310jIWIlSk2i90ohuh+hWcl0NVwgwddHIDqSLkeziRAqPnJiryPsLbWVR9TERZvwnmrVGCOcY492FgFggVW1G6a7lXcVktryFm6nFD6i/A9fPMddkVhXg5kTJyAWzAHlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707622; c=relaxed/simple;
	bh=eWgw06fRSvqjEvBo5bsP/T6Y4MFBKn6dv3hWxJrlJ1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5TifwpB7YVaq7wNZ4tjQ++TOsiKfAR05f1zQf3EZFTGQR1nUKDfqOsP7Z9EwZNgClOUBrRn0K8yAh05/qabzw89dxdRsDpotdq35fV0nFR7B6ejUqMk4YejVvfJMfaI4X03Gn0cUaiwJyZnbaF56lBnKGGv8DlkdCdIdOeIr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/AKLBv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5A3C4CEE3;
	Thu,  3 Apr 2025 19:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707622;
	bh=eWgw06fRSvqjEvBo5bsP/T6Y4MFBKn6dv3hWxJrlJ1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/AKLBv0gsxasLR1JAdK5poTbGXD0W3wW3laj7gwOzSEXh0Ts5ZLuDZiygtKEStEw
	 u+ip4yGFqFOU+44KRE7hTs6cWUTT/ANyC8pJHpJubaxJP5ycyp/9sVDY08cq2r6Xg4
	 g2rW4mxT/DgMkFl70Jr74ljy3qd8B6aOEuvgEsj+JFPCoZ3f78ALPTIH2iAwKouc+d
	 X6ra8J8xq+Z0FEgzQfjB3Z84P9v3hqk6srNXpxyo76y8xo6MKprNhxRq4+f57LWTG1
	 JWpbQDt7V3W90BUn9z878PS7BRoTQC8JU2C7h/DvDTTHyNObxGDQRaO1IBUIa+l3At
	 tq1vaPeQWhEAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sung Lee <Sung.Lee@amd.com>,
	Joshua Aberback <joshua.aberback@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	alvin.lee2@amd.com,
	alex.hung@amd.com,
	Wayne.Lin@amd.com,
	Austin.Zheng@amd.com,
	Ilya.Bakoulin@amd.com,
	aurabindo.pillai@amd.com,
	mario.limonciello@amd.com,
	Josip.Pavic@amd.com,
	dillon.varone@amd.com,
	wenjing.liu@amd.com,
	linux@treblig.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 09/44] drm/amd/display: Guard Possible Null Pointer Dereference
Date: Thu,  3 Apr 2025 15:12:38 -0400
Message-Id: <20250403191313.2679091-9-sashal@kernel.org>
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

From: Sung Lee <Sung.Lee@amd.com>

[ Upstream commit c87d202692de34ee71d1fd4679a549a29095658a ]

[WHY]
In some situations, dc->res_pool may be null.

[HOW]
Check if pointer is null before dereference.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Sung Lee <Sung.Lee@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f84e795e35f58..4683c7ef4507f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5549,9 +5549,11 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->get_hard_min_memclk)
 		idle_dramclk_khz = dc->clk_mgr->funcs->get_hard_min_memclk(dc->clk_mgr);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &context->res_ctx.pipe_ctx[i];
-		subvp_pipe_type[i] = dc_state_get_pipe_subvp_type(context, pipe);
+	if (dc->res_pool && context) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &context->res_ctx.pipe_ctx[i];
+			subvp_pipe_type[i] = dc_state_get_pipe_subvp_type(context, pipe);
+		}
 	}
 
 	DC_LOG_DC("%s: allow_idle=%d\n HardMinUClk_Khz=%d HardMinDramclk_Khz=%d\n Pipe_0=%d Pipe_1=%d Pipe_2=%d Pipe_3=%d Pipe_4=%d Pipe_5=%d (caller=%s)\n",
-- 
2.39.5


