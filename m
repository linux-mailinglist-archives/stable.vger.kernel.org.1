Return-Path: <stable+bounces-64843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F02943AB9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372B41F2155D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77EE14F9E4;
	Thu,  1 Aug 2024 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjYyM5so"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AA614F9DA;
	Thu,  1 Aug 2024 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471014; cv=none; b=slQdrf/AtzYCodxE+DqelGWHHCOOnr2O6CzstWOv7g8wsfQ22IUm2SvELpvESUWDVbhm8nTKGoo+yna8d/F++QY0EJrWsKFIlj81bo1INGodqM5NpMKPoieDFCCXF4YgMaumAnXDe1OvltnfGFFhrkZhhRSP7LjoSfyxxutP9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471014; c=relaxed/simple;
	bh=W3oUaL901wpWKL883MvvjPg/OCyqaTMhpUbRlCxZ0QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZYw1lnKSGvYHprzVsKPUoj25ti77SqYX5y0eUyGXSW+BgIaZxDNYym89TZb2xFjXFWNJHcdntKEZt7QrvtzkladCLfblKxg2nOVJBzN6JahzoY5JCHLopPmYDbM1z7GR7z1KJb47CFbCwqcuGWAxRB5uH7COwVRuRowmzbHC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjYyM5so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8D7C32786;
	Thu,  1 Aug 2024 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471014;
	bh=W3oUaL901wpWKL883MvvjPg/OCyqaTMhpUbRlCxZ0QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjYyM5soyJOVBBNmVJvLX2C4I6OV/HvrdAw6IQTnMl+L0JFediCbTJY4AhHRgr/GR
	 OB/bwTda4Qx7S4Auno9IHNBU/JpAFwBkH44a/5Wysr8uNUlAtkpwlfEbsQLTMF6f7M
	 MIFRMmuizv70/dF4f25Zbb+CEL0pZ1Rpu+N6wlKzPLV2m035KQxvRKyHVLa0e654xZ
	 Qm8T7V6oYdLGVzB1kahUDAJ2hQRqqqLjciBmvRIJ9Vxw0Aot3X1AAiOosdCLU1TfEJ
	 cr9iyAhvEfkPvdAKvRfE+PD1AMo8+3y9zGg+dNQQCSyMjsOojXpZg59SDa7bloCXus
	 OCeTxUIXyqOMQ==
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
Subject: [PATCH AUTOSEL 6.10 018/121] drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]
Date: Wed, 31 Jul 2024 19:59:16 -0400
Message-ID: <20240801000834.3930818-18-sashal@kernel.org>
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
index 5ef0879f6ad9c..aea4bb46856ef 100644
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


