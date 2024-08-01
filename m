Return-Path: <stable+bounces-64958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C5943CFE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4286286456
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA2F50F;
	Thu,  1 Aug 2024 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6O3R9C4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8F13D896;
	Thu,  1 Aug 2024 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471729; cv=none; b=J/CTC+GA72gNC8HJApSSnkddIN1a99xjIlEBOgBWzkZvFpliY9ucqFPg072XDMqAVbxwiUx3YVd4zLT7Mf74FayOKS3SdWxih2eBg4h0R2rh+6z9t+qO6x0Pctq4xJrK9VYOKOjbx1ait3BKpzNjs1Ljd9hrLR9Q9haSjPiQTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471729; c=relaxed/simple;
	bh=ggHN2SXa33xP26WtRM/dHXg7aHBJQSaCCypRbBwVG5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZZhoZeRfNDQTVUO2/s5MXGiWD62J6ofDUswOg1IFNbmdAk3pDZ5AkTT6jYXO13kmoQnm7AU8eVg4ATWT3ytUNy2HVeO7fSg3VnttVT5Ssw6NAPdN+1MIAvMbEwCjyrAfJ+a+t1CfaUdY2m70HakHHZyWUgNljTK7hULAO3CA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6O3R9C4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A510CC116B1;
	Thu,  1 Aug 2024 00:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471728;
	bh=ggHN2SXa33xP26WtRM/dHXg7aHBJQSaCCypRbBwVG5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6O3R9C4M/Af54Zz7JyCiSl5ZULcLwDIV5Ue+LPcZ5xVg+zY1NzQHg/zqhHyBvBY9
	 DfD5UDg2dv4NYyhlpjdkw1luDKZAiLbXKI7853/i+Vwz5ZlBTNAujma9TOg/afViP0
	 r4NBjGE4MhhSkunJPR34b1uLCEXv2FwKcKvgmOaxh3bdg9iRKcrFPQa3zSTkSnkEPY
	 tW/YkHyfn/2ueOdHyyrZa+sQnBEpFPe0MaNX/PB8Mzi2PmrUW2/vjO3Q/aLLrl+SID
	 2m/ILlasbuKgPBR/tLa7QJ9B7olrSBefUQJi7SqZZxyYdT9n97GGxSn4lyUAnoNfk5
	 5Z/h050m0Aqrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	roman.li@amd.com,
	hamza.mahfooz@amd.com,
	aric.cyr@amd.com,
	joshua.aberback@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 12/83] drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]
Date: Wed, 31 Jul 2024 20:17:27 -0400
Message-ID: <20240801002107.3934037-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit b38a4815f79b87efb196cd5121579fc51e29a7fb ]

[WHY & HOW]
num_valid_sets needs to be checked to avoid a negative index when
accessing reader_wm_sets[num_valid_sets - 1].

This fixes an OVERRUN issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 0c6a4ab72b1d2..97cdc24cef9a5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -484,7 +484,8 @@ static void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_sm
 			ranges->reader_wm_sets[num_valid_sets].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 
 			/* Modify previous watermark range to cover up to max */
-			ranges->reader_wm_sets[num_valid_sets - 1].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
+			if (num_valid_sets > 0)
+				ranges->reader_wm_sets[num_valid_sets - 1].max_fill_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 		}
 		num_valid_sets++;
 	}
-- 
2.43.0


