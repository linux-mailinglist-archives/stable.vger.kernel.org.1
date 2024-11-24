Return-Path: <stable+bounces-95022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C799D724E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30170163AC3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9052A1F8919;
	Sun, 24 Nov 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCKGQvtm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2781CEAD6;
	Sun, 24 Nov 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455707; cv=none; b=r5ebCbLiuFyMJDrF+bYigh4mIZfVU5AO7gbDv+Ya0zpGAqUw15Z9yjO6hfig5YlkMuexo9QoZV3Yyj1cQ5IAOUMAVMmLt+js3TzgZ0b5OXl/5XSLc57kD18qfCHmEEkFkGLQDeg1pu8/2zpSYqYa4bjfn/CTSBsIwwmfK6TYQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455707; c=relaxed/simple;
	bh=Raevhs8OqHABL6IjidcI3z0i6g+y/svILLeLE2hOOqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOVuuD94PDhNwqEeTyvg5WddDnMPqCbovCmOO5UPZCQz/kAPMgCShBqCwaBZjLSuUi5UZKRcnW5DPEMDiTY2NlPvu+mkO7MHshOjLxQ+VPca3ITryfMiVHRYcp6JrG4GSScZaF9J+IQbNFvYx17iNLwiC09Bgja5IAHa+JoBkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCKGQvtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6ACC4CED9;
	Sun, 24 Nov 2024 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455707;
	bh=Raevhs8OqHABL6IjidcI3z0i6g+y/svILLeLE2hOOqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCKGQvtmCIJp57oaJtc/+f25XwqLrJsklGbWa7JYOHSspHoewCHEg6ljG1ds4eEBO
	 +gLzbazrQwtnpW+dcXi6ejEu6yv0TTrdS/iMJo5lNUB16ql4BFgV/h58TDIhmf8Pbk
	 r8TumI8iMW1uHO6InVPGVdXxj8LFZFs446Bb6LsoBdbPylUVHYN5DmJWIf/kUGRuwP
	 CRh4IZDPLBY8lISbBxsIFBPRsQI4UHi1Tm5RBVxn1okZdY5pxxk5Ce05JR56VW/oc/
	 QWI0hdqWGBWM2jTqbPydx+NXsB1P02Hr+BO5mQ4sxLxZGEetE4Cz1AMISp0YL9fEpS
	 X/7BFxIppnNYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fudongwang <Fudong.Wang@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
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
	simona@ffwll.ch,
	wenjing.liu@amd.com,
	yi-lchen@amd.com,
	george.shen@amd.com,
	alvin.lee2@amd.com,
	alex.hung@amd.com,
	Zhongwei.Zhang@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 19/87] drm/amd/display: skip disable CRTC in seemless bootup case
Date: Sun, 24 Nov 2024 08:37:57 -0500
Message-ID: <20241124134102.3344326-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Fudongwang <Fudong.Wang@amd.com>

[ Upstream commit 0e37e4b9afbd08df1f00a70bbb4d1ec273d18c9e ]

Resync FIFO is a workaround to write the same value to
DENTIST_DISPCLK_CNTL register after programming OTG_PIXEL_RATE_DIV
register, in case seemless boot, there is no OTG_PIXEL_RATE_DIV register
update, so skip CRTC disable when resync FIFO to avoid random FIFO error
and garbage.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Fudongwang <Fudong.Wang@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 388404cdeeaae..336a0c18360c6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -367,7 +367,9 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal)) &&
+			!pipe->stream->apply_seamless_boot_optimization &&
+			!pipe->stream->apply_edp_fast_boot_optimization) {
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
 			reset_sync_context_for_pipe(dc, context, i);
 			otg_disabled[i] = true;
-- 
2.43.0


