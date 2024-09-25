Return-Path: <stable+bounces-77290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E8985B7A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B37B1F24ECD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63091BF7E0;
	Wed, 25 Sep 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJedkawH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610601993AF;
	Wed, 25 Sep 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265003; cv=none; b=aCcsR5mUns+s3md0r6IfAYM/JbjyRwy/68DSI99CfJMgZbKYAAJkkkjyi7pwYWb3gArtL8xX8rqVTSDYCPZYY1G1jN61cFiBY7X4Y785tcERCTao8lAnvxCHMuUtsyNnQf66WD54Erbi6jstFutldnSc+hIOMuql5vIcrVDDA+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265003; c=relaxed/simple;
	bh=M3glKs3i2GpNKEzkN+E8d5VLfMis/iG9FnNW7OOCblI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj0lsfJBwCSxHli4vGO+ojJs8/QUVQQb+X6kgjSV4V5PAuAwOW5mdWx0pdS+81i/aVJMhUQ0ivJcsea6tlcnH22KrFgz0ws+XyvrLzgNscmfYFJONGtUKIx31p8dIPa7cwLahsfSI8lQ/r8asre3rDk4zdLdcJDbSPl5qYWEdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJedkawH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E173FC4CEC7;
	Wed, 25 Sep 2024 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265003;
	bh=M3glKs3i2GpNKEzkN+E8d5VLfMis/iG9FnNW7OOCblI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJedkawHgWAFB3M3NyRk+rBx9iavhOa5uu9NH+SNjFRQr6yy0uzQ2GRY1ag2dHMY6
	 EehMhsKtX9/DLE5tt29hhVZS89jFlrtiDjk/iew8wVKRyyxp6YJO3yzgl2H1C69zwH
	 r6saoq9ujLpTxOaHlmfqnV+4bbqpV3gK5HY7gvTA9jyXk8nKV8k79gqbmC46KWjsSj
	 S+HiU3l6SPqLB56ajiTxfOFffSGQvukGo+ZGi6sf8gHbBg+xHkXUjTVbPPQda61wz7
	 /XncPFNs4mcAO7Zp7kBoiAiRYS5y20NlJcykbMz5SzI4uye3+/p+DfqQmatgTr3YAe
	 ozrQPFC1kPxQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	dillon.varone@amd.com,
	moadhuri@amd.com,
	relja.vojvodic@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 192/244] drm/amd/display: Fix possible overflow in integer multiplication
Date: Wed, 25 Sep 2024 07:26:53 -0400
Message-ID: <20240925113641.1297102-192-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 3f96f545f877ac59d0c967f52d760b4b2b3b9a47 ]

[WHAT & HOW]
Integer multiplies integer may overflow in context that expects an
expression of unsigned long long (64 bits). This can be fixed by casting
integer to unsigned long long to force 64 bits results.

This fixes 2 OVERFLOW_BEFORE_WIDEN issues reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/resource/dcn32/dcn32_resource_helpers.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index 47c8a9fbe7546..f5a4e97c40ced 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -663,7 +663,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 
 				subvp_disallow |= disallow_subvp_in_active_plus_blank(pipe);
 				refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
-					pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+					pipe->stream->timing.v_total * (unsigned long long)pipe->stream->timing.h_total - (uint64_t)1);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
 			}
@@ -724,7 +724,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 
 				subvp_disallow |= disallow_subvp_in_active_plus_blank(pipe);
 				refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
-					pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+					pipe->stream->timing.v_total * (unsigned long long)pipe->stream->timing.h_total - (uint64_t)1);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
 				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
 			}
-- 
2.43.0


