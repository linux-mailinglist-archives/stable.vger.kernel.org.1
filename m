Return-Path: <stable+bounces-94917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030FB9D7495
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE07EB21062
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267301B6CEA;
	Sun, 24 Nov 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3sifbi6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9018188737;
	Sun, 24 Nov 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455231; cv=none; b=WnXZjReThr7e4K33vMw/yrFxU34CgvoHabtD/CG4IGipV701+m+OUqBlhjc37lGujHcsnZ3MEIQn8sXUjPKLdbv/M0dus0Eh/H40ifhLMKEjdAcfIpb7BSJlUwNK0cC8aZcNVDiHto4Si4wr/XZWc2SbRY8MjtKww40oixy07Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455231; c=relaxed/simple;
	bh=X/174+9QZj5SHgLJYYgYDwPo+NQCes8A7vKNxrCJwXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hebZmVKTKK/VE/Yxd9gxcENv7p5ZFtQWvEhucWPAUyhZtytjevgBnZzv2qdwMxcWfM1VFiGWaQCOJGk+0SBzg1VF9B4r2V14ZqWuMaiROlCvgtqMCo7dOtB9kx/Au/DAdc031wHBlzDBqcHTlilAYqgIw5V+cGsjYqW3MNXIy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3sifbi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DB4C4CECC;
	Sun, 24 Nov 2024 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455231;
	bh=X/174+9QZj5SHgLJYYgYDwPo+NQCes8A7vKNxrCJwXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3sifbi6MgqYXmxBqJKgPFFqwhRn0/9CySSzERWUlrXE4McS0tRI572vuLdyAsrrE
	 DTCIJB4ix+fmcIpTbqIUzx/x8IgGc5mnTf1vwZcNCKXxMqZDRWRuK88fh8EhAgOvhg
	 vn2DzJjkX3rTYJkB2pGk+cggFdpaJ774v/48j77PcVcu+QJYtl5AcfDaNYzRXM7bqP
	 dfgvjRUkqJ8jJ/TZs9vh5W3gKb1o7BC4mFEnd9WCU1kGcmmcjZThxO4PCGAgWT41Li
	 gB9POzeolV7nZdEW/IShTh6Wn01LzsjN4XRoT2nzwTlJ7zQzYeXCM8BCbH4wOTJwUI
	 CWlg8o7iMkJ3g==
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
	wayne.lin@amd.com,
	yi-lchen@amd.com,
	alvin.lee2@amd.com,
	george.shen@amd.com,
	Zhongwei.Zhang@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 021/107] drm/amd/display: skip disable CRTC in seemless bootup case
Date: Sun, 24 Nov 2024 08:28:41 -0500
Message-ID: <20241124133301.3341829-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 4e93eeedfc1bb..a8e04a39a19e5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -371,7 +371,9 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
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


