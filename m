Return-Path: <stable+bounces-65179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4553A943F77
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01528282896
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE46F1C6881;
	Thu,  1 Aug 2024 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKNG3Wvl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695491C233E;
	Thu,  1 Aug 2024 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472776; cv=none; b=cGn25L7xBqmnnureVYJp5BE0UYql4kQWNYcYAp1r2Jb6O/yrE2hG6w1PjX8jwyufWnJaVzisem6YmM1qMBDEHjZqUJ3+fhj2/ezQcyR5252Qbhh3kjZ5RSxtswX/rx6i4DHoksCvJHDhXgLx2BRr1WBOUx95JlzjSC8bLoM5NPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472776; c=relaxed/simple;
	bh=Hue/ES6WQ/o+QiMw1DP2CFp7w6vrWU9PdSaBj4Z4Uvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClunDr8ADhY709PkytIx8+PzWQhvYwkV++MgzdGJUN0jiXprMVfS8HZb2pKVF5Foz2KopKsgZan1bAGYcgRw7y4lNVuizaxYd8YZiDyg28sU89xzm1Q1lUX/cTrJNKaM2mHmYhwyYJ632xQaQdjb2WDeu88mTRPW7ZgAu9i0nw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKNG3Wvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E25C32786;
	Thu,  1 Aug 2024 00:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472776;
	bh=Hue/ES6WQ/o+QiMw1DP2CFp7w6vrWU9PdSaBj4Z4Uvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKNG3WvlVLCwAjWi/TBxTRjaaS3zssmZlyHF1XT4694JjDWVB/lhme8d3oX9D0DGH
	 23ov4kzSfUle6sJys++v6VNF0tpwpXUEb0DzunRpPJVYvPkzDGVSsGECN4xnsH4NX/
	 tMp9NWXYvRXje+Mpq01MLWLcEJUpN3OUfCsUco9/NC0ARXxazSBVUVCwklEm/TRrJE
	 rKSH1qPa/AGbHfELAOaX/aMnZpYzUAiBYkSS0hZO0G6khWKX0lf/BBKPxQ3ZL3jhvj
	 rHMt8W2t1cAHSxvbZ0huBFyDOUPcUaT2GYJTBvGghY3EMnhl1W3JnMLzg11BkbzknP
	 wsTdZUsJIzTDA==
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
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	aric.cyr@amd.com,
	joshua.aberback@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 04/22] drm/amd/display: Check num_valid_sets before accessing reader_wm_sets[]
Date: Wed, 31 Jul 2024 20:38:33 -0400
Message-ID: <20240801003918.3939431-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 9f301f8575a54..fec3ca955b264 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -453,7 +453,8 @@ void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_smu_wm_ra
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


