Return-Path: <stable+bounces-81057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489BC990E5F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C111F2667C
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A10224CAD;
	Fri,  4 Oct 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhzI47eo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA9224CA2;
	Fri,  4 Oct 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066589; cv=none; b=oOm7zP7IY2f4DlBB0ys7GrcFIH3/te0/SJIZob3Cu6womPGAFZ5V4zt027lyKO6353K6Prt8Bup0+hOp8AbABHmyfpRKdUGl1/rtZHm9tc7RhSKK8RVX7uSw07qY12FtKHKheSagNHtb9zBgbgqBld8egiZVXI4s2doA87rhEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066589; c=relaxed/simple;
	bh=BSd8d6oLezafcvk6TobPvsi6Prt04X99T1Jr4pC/q+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJFs3u0budB0P6Fbw4dqNHWopVA6jgmkOfqyWcpL5+e7gdANmjDu3kRjIleW4xbQPPOKzNIqDUe9xJApW/mMgc6wvmEf79pkhmiIlGFyVCE9AVTNrO/aMRJBz/g5mHRQ4XGVZBVb+Xlf/m7L3lauDuIzYamW9jH0cHpGno7wtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhzI47eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00314C4CED0;
	Fri,  4 Oct 2024 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066589;
	bh=BSd8d6oLezafcvk6TobPvsi6Prt04X99T1Jr4pC/q+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhzI47eo7oQaGto7/zorEzS2k/GgluLxcOgcWnlnl65F5bEjzBGl4KDN/qOG6wbma
	 oaSWrHWY3h24j0i/utDmpg9JManqiMGYUQ/RR9OVkj817yTb1c7Jnlo6j23qo69Wir
	 XTJJhaZlpyqZu6uO4TfhXL1vlX1UvU7ot4X2FDbL2ARlonOw0cfQsH7AynET5aATZV
	 9mSYSSDx0/8OtAiWb8aT/C6Vk4AAzsop9CIhHRicmwGBBxrYF4AX40aDIMl/s1dca1
	 RlMafYX1Bbinf9kySV9cmK2c1Q2VJwGMfqWmcLeZF37N94czSwfP82QvAWkttBf5Gn
	 F+P2iq1AI7PeA==
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
	wenjing.liu@amd.com,
	sungjoon.kim@amd.com,
	nicholas.kazlauskas@amd.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	chiawen.huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 30/31] drm/amd/display: Check null pointer before dereferencing se
Date: Fri,  4 Oct 2024 14:28:38 -0400
Message-ID: <20241004182854.3674661-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit ff599ef6970ee000fa5bc38d02fa5ff5f3fc7575 ]

[WHAT & HOW]
se is null checked previously in the same function, indicating
it might be null; therefore, it must be checked when used again.

This fixes 1 FORWARD_NULL issue reported by Coverity.

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 12e4beca5e840..72b8065ae082b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1464,7 +1464,7 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
 			return false;
 
-		if (!se->funcs->dp_get_pixel_format)
+		if (!se || !se->funcs->dp_get_pixel_format)
 			return false;
 
 		if (!se->funcs->dp_get_pixel_format(
-- 
2.43.0


