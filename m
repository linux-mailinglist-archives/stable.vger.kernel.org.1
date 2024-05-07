Return-Path: <stable+bounces-43321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516D8BF1B8
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58386B258B4
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCEC136658;
	Tue,  7 May 2024 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvygdZcl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50E135A44;
	Tue,  7 May 2024 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123384; cv=none; b=K2KkdrvYNUUHhwTPNlktm+cRV2y637Tp6OmecqCO29cazFOyv//JytIGptA7ISVyxTb3F8pCP+4NRS6qjEZaQlZIywTvfbk+wbzyna+gi/z/+MuQ4ueQuzcBWFKig1waPoUYtiAEPMeH/UOoBkjzJq3X3koCW7SP8+EWxQmnquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123384; c=relaxed/simple;
	bh=Z1MO1ZagCXquTyQi4RXjNlyeIi8Vavtv2regL3YQls4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKfatxou494+8l6KDgS4RkPeHHT4fcfvE2HJTB0T80fyOfSpUmYxWV/717aTNiD7+xbiD1c0ZkHjE1uL4PDiwEZRG5PjEBb8VbdvbENpQx/t3xU0YXT9xOAmdlQMS6SJKh6uE68JwJ33D6FV1KG+JAoUtTRf4N7brxBdJ9DUuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvygdZcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE38C4AF68;
	Tue,  7 May 2024 23:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123384;
	bh=Z1MO1ZagCXquTyQi4RXjNlyeIi8Vavtv2regL3YQls4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvygdZclTQBMnefzCqISuxqBnwZCrjcvAcWsDyk0zKpFLpTuCsW4CylY/i68rZs8m
	 sNePKhY+F/ae2ZfHkm6FBglfY+h4cM/tZp6O3u/oipJHGZZkw2vpqjgBxOLXcR0eGg
	 E7xavrZBUCWLCHxRmIRlufUX2ph/GjT7jhNQ9oq2VrhYryHDb0St2P7ysX9rTZGW4S
	 f1hadcNqGiLCyRHMcpXe0g80jYPsqM3hty2PFv545Dp2gktqU+cde+CiIwvxr0m0ev
	 MUYYxlRViNGbqZy9BKQKMdy1fxUpJXEt8+FiL7+ZkfIxuswONdGsHAOfrbCvTRe9Gs
	 d2m5LGMc3nMcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sung Joon Kim <sungjoon.kim@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
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
	jun.lei@amd.com,
	wenjing.liu@amd.com,
	aric.cyr@amd.com,
	dillon.varone@amd.com,
	chiawen.huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 42/52] drm/amd/display: Disable seamless boot on 128b/132b encoding
Date: Tue,  7 May 2024 19:07:08 -0400
Message-ID: <20240507230800.392128-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Sung Joon Kim <sungjoon.kim@amd.com>

[ Upstream commit 6f0c228ed9184287031a66b46a79e5a3d2e73a86 ]

[why]
preOS will not support display mode programming and link training
for UHBR rates.

[how]
If we detect a sink that's UHBR capable, disable seamless boot

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3c3d613c5f00e..040b5c2a57586 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1804,6 +1804,9 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
+	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)
+		return false;
+
 	if (dc->link_srv->edp_is_ilr_optimization_required(link, crtc_timing)) {
 		DC_LOG_EVENT_LINK_TRAINING("Seamless boot disabled to optimize eDP link rate\n");
 		return false;
-- 
2.43.0


