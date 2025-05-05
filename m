Return-Path: <stable+bounces-140135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6162FAAA57B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB1188E6AE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF827A46C;
	Mon,  5 May 2025 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3SGdnaz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D727A441;
	Mon,  5 May 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484195; cv=none; b=N69NI2D7ti1Fj84GNFRM6ijGLk9MHmx2HMKB/9IAusi8RAPAuw1sY1vk+D/q6Z3CHmhhkWZBARug9jeWZPPmvgBkPBnCZ/aJGpnxuKVgV6yRPy82VLuFAHFMRSK9Et6NXvBq/Ki+2ke7BNubNDh494u/8E0QP0pTXgOicTJ3n9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484195; c=relaxed/simple;
	bh=LrDTYJPPikt2CZU7xFsXv7FLYT+5gZ9WRCubtv94W7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYnGx9IbISaeV1RI+YpbFdKiqNsax7QQlanR5ARGz8x3eMps+EUag8BncxHAVdr0vLn/r+kcwPPTj5OpldS2fgEX+JNdivpNXOWhBtJQAXHQJgoPQu/XJDSXySnPRmACIaNoMyyd8InPSVMf9JCKG5yN2cfzJMCzsDnX0E2lhts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3SGdnaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB10C4CEE4;
	Mon,  5 May 2025 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484194;
	bh=LrDTYJPPikt2CZU7xFsXv7FLYT+5gZ9WRCubtv94W7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3SGdnazeFdYFTLQ1xCU8/54Z+Zi+Xx2hO//X/771+uisnPKqwRhlYxUmi6N32dQU
	 Fi8/6hJHpJ3y5VnSFurbunWJCwLjd79rcVUTA0y+sO+S8TC2QFjs6/RdQ+S+Ig0+FK
	 k1Sw5TErG2LavZUkczSiX1FB3aRA1Qs+kET0pH+0cMcmsgGNxb/gtfxEElWYMn/+1K
	 Ut2aumEhNjWZ/3Hz0UiJUWOG85R9ekf5xXB9+YYGCLqgEA5AKC2WkGIvk0D9zw29R9
	 HDLWef2FotQp2zUItyjSRgO5CD84LtJ+SYpxWZvzyL/zJEJ1nliWbVQ38wkCluPjzh
	 ViV5bVxZP+L5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Zeng <Leo.Zeng@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	Aric.Cyr@amd.com,
	alvin.lee2@amd.com,
	siqueira@igalia.com,
	wenjing.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 388/642] Revert "drm/amd/display: Request HW cursor on DCN3.2 with SubVP"
Date: Mon,  5 May 2025 18:10:04 -0400
Message-Id: <20250505221419.2672473-388-sashal@kernel.org>
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

From: Leo Zeng <Leo.Zeng@amd.com>

[ Upstream commit 8ae6dfc0b61b170cf13832d4cfe2a0c744e621a7 ]

This reverts commit 13437c91606c9232c747475e202fe3827cd53264.

Reason to revert: idle power regression found in testing.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Leo Zeng <Leo.Zeng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 56dda686e2992..6f490d8d7038c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -626,7 +626,6 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 * - Not TMZ surface
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe && !dcn32_is_center_timing(pipe) &&
-				!pipe->stream->hw_cursor_req &&
 				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
-- 
2.39.5


