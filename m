Return-Path: <stable+bounces-81083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A1E990EB8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88791F24B92
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7422A466;
	Fri,  4 Oct 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzWCYsUi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68322A465;
	Fri,  4 Oct 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066653; cv=none; b=HXHnhrK9A3m+5Lmkfen4XjpEehWTvM6geM8qQs8c3Xavp60Me2dueNBKoqCEfLBPr2BR4/GrO4p7kkT5r6meYKa5c0C6/SBIEw8OzjbAt1pgAgLo8twiOMQhFGZCAlNrsPJbiCK9xweJeP6ReOf0FOVG1dhJrN/0ZR8hGyqU07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066653; c=relaxed/simple;
	bh=HBFB2J9husfamI56aIOzlQW3cTfOVYFFyPE+ho21oiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iF9TmiAGsF4wBS2w7i7Y63WW7A7jAdPM2QteXDQ2Lsp0+mxpuswNfnwJl7J1FxuFylGP+25Ro+WRU97mq0hmN/9PeI/eRzcG0x9LWydKSX6sztY72ubpMvOV7CnXHLpsIooSh1nLp5oGwf/D86e0JZeVtMJB9hk6cOF8Rb3TmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzWCYsUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4408C4CECC;
	Fri,  4 Oct 2024 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066653;
	bh=HBFB2J9husfamI56aIOzlQW3cTfOVYFFyPE+ho21oiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzWCYsUi3diGKXhaxzls9TrctsI/qeyWiAt/ch2zbnBYPHKwem7P+CnvDCLxsF6Ri
	 K+nhLsI/7LFm778phLL8jLWilEYfk1mFRo/XKddtKiaKEu04ZSIPvViNc/Bg3iLKEW
	 XgfATNnz39GKCE/tRWSa7M48O8iaYBaCUcBoOX3oh2oFVRUr96fvQW0WeBzQeppELW
	 Q43kfcUIB/IZ1tWGdTn/+8C4jb9X2HwApgIyqNLSrPcU6YXlLBB8Ha7WpS2jiAxVYW
	 KM/mkhdZR5elzFMLgDyfv4q18SkoNrQ79duKsTdMgzPkBxC1GTW8wT3MfheC0V7ZCU
	 mRPfgd7cpl1hg==
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
	aurabindo.pillai@amd.com,
	dillon.varone@amd.com,
	chiawen.huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 25/26] drm/amd/display: Check null pointer before dereferencing se
Date: Fri,  4 Oct 2024 14:29:51 -0400
Message-ID: <20241004183005.3675332-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 272252cd05001..f3fc9b44b4601 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1258,7 +1258,7 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
 			return false;
 
-		if (!se->funcs->dp_get_pixel_format)
+		if (!se || !se->funcs->dp_get_pixel_format)
 			return false;
 
 		if (!se->funcs->dp_get_pixel_format(
-- 
2.43.0


