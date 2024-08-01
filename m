Return-Path: <stable+bounces-64929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6998943CAB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2318288DDD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8141C8FD2;
	Thu,  1 Aug 2024 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfiTpY9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F713958F;
	Thu,  1 Aug 2024 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471481; cv=none; b=J+Glw5SwMfylhwDaFau6WFTjN7uXrhLODBicx+TRH2jfz14EvkY8F4xTuXVOvEGBX9v+QzY+yJlLp5ZY8ddS5sW6FoJBb6/iVi45bWv4rV9AflQKoAloD/USy6KNq4uw7BOYwN4oyDucdar1lqtSFX4RWazC+M62hEWZCRiPow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471481; c=relaxed/simple;
	bh=rRurU/cEeHGGfJgDwaPWQDdbDLaaxDSR7ZDaKgU3Otc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GECzvFZJlPDW2JbYGpVpM1RdDn3YX5FlspGapbuUZJu1xdMrPhAjNtFmCG0YG3je9COjqOVBAPJXJIeuZJOG6vdo/GRtqWp5qNq/NCn2ipPpGh+lS/SPCPs1UT8WsaIrnbW63ahnotBeSK6xForxqWzfHZNJBX57RdjOCHvuD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfiTpY9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5953DC116B1;
	Thu,  1 Aug 2024 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471480;
	bh=rRurU/cEeHGGfJgDwaPWQDdbDLaaxDSR7ZDaKgU3Otc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfiTpY9IUReqkgCfk95JepRsn8WJe6pWU5OWZQri1md2nGf9hzzut3IZvnoAcXn0q
	 ZqSNqh19pucjIeEwL+UdPm1HDRYdAfj6ueMxlWI44h9FsfVWH6f8wzyIPNeUPKxori
	 XvqAsQT/Wg+GBGQOjmpaD2kZhXM5geEWf9dJx18pFbhWmmFxjBoGezL7g3h+toVa0v
	 SQzFSl5ZzMYlxk8UPaVTHg9NG3dZpjuAkBLt00MJyJufDwIu9DLXYO+jNKC2Y/jIyh
	 nYVNaErI+MSfo950vhDveZ95send8imX4ewL3buS8+3UMA2JxbjXaeGcMj6dPzdoeM
	 cFouqZzJOuXww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	chiahsuan.chung@amd.com,
	wayne.lin@amd.com,
	wenjing.liu@amd.com,
	moadhuri@amd.com,
	dmytro.laktyushkin@amd.com,
	joan.lee@amd.com,
	Bhawanpreet.Lakha@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 104/121] drm/amd/display: Check denominator crb_pipes before used
Date: Wed, 31 Jul 2024 20:00:42 -0400
Message-ID: <20240801000834.3930818-104-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit ea79068d4073bf303f8203f2625af7d9185a1bc6 ]

[WHAT & HOW]
A denominator cannot be 0, and is checked before used.

This fixes 2 DIVIDE_BY_ZERO issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 4ce0f4bf1d9bb..3329eaecfb15b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1756,7 +1756,7 @@ static int dcn315_populate_dml_pipes_from_context(
 				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
 						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
 
-				if (remaining_det_segs > MIN_RESERVED_DET_SEGS)
+				if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
 					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
 							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
 				if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
-- 
2.43.0


