Return-Path: <stable+bounces-64965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CD943D0F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0801C21F92
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAE2155C91;
	Thu,  1 Aug 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz1wdy5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D9155A52;
	Thu,  1 Aug 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471769; cv=none; b=JrFySv2AK7La8mR3nSDyGBVS3r/J8OEsZb2YlY/rlIybbgxE/rhfw6vPGJj24tLVL3MpRuMg3ruVOTe8+FbMKybTklI1jy3cdvqX35hVM3Jp//IBS0ci+xVjsWpTVlYJgUqMVoNSMo+w/gs1vTZgredr5ht7Dg68qq5HcD+zU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471769; c=relaxed/simple;
	bh=wbpWnqBLV2lkBryAi5aIhbY2qvOMtO65SUHSHUkllIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGus+OAMoPLvGwuzblxwR/+Xo942J3RKvJa8Aj/B2VoClCoK1Cfz6msWggHOBwSSce22lJnYCZR5gR81xhuNndcs/B6DZU6QB9C2X7QTzjHd2p8h2AtxJrhsozmRS1lMG+xsSr3pZQhBhzY6igzKolbag+gz4O+49fpO9Tmu+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz1wdy5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503D9C4AF0C;
	Thu,  1 Aug 2024 00:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471769;
	bh=wbpWnqBLV2lkBryAi5aIhbY2qvOMtO65SUHSHUkllIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bz1wdy5Rv+I9IKxGvxEvWMezKxlmsg8ppKQ7BnBX3TTnmg+14IKb1wt0U05iEJme8
	 1lTfwiHBmyO75zMaUef4Sx3Q6wzbB00Bx0kNazE4eu1zXFIwbGBHbzV7xxx3aIJ28G
	 lJL+UvlplYVDtqds9cTRnyl3Yw6xtDR87NpI7JF7ZyMvdbSpuHzJdFl8/feqj0sk0L
	 9PQKAarTlwGtDN/COsMZEcOiRzpJzS/WWXY31q/K35xgP4yNQUnFhaGjhr+h4fk2QZ
	 m07sAycnPqo0evKeYaRa9y7Avro61ieFvjqcTt0QF048f3feNQ9QTCsbgMLTQXy/qb
	 D+jZJHxKRY5Eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
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
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 19/83] drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
Date: Wed, 31 Jul 2024 20:17:34 -0400
Message-ID: <20240801002107.3934037-19-sashal@kernel.org>
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

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit a54f7e866cc73a4cb71b8b24bb568ba35c8969df ]

[Why]
Coverity reports Memory - illegal accesses.

[How]
Skip inactive planes.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 9a3ded3111952..85453bbb4f9b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -1099,8 +1099,13 @@ void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 
 	// Total Available Pipes Support Check
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-		total_pipes += mode_lib->vba.DPPPerPlane[k];
 		pipe_idx = get_pipe_idx(mode_lib, k);
+		if (pipe_idx == -1) {
+			ASSERT(0);
+			continue; // skip inactive planes
+		}
+		total_pipes += mode_lib->vba.DPPPerPlane[k];
+
 		if (mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz > 0.0)
 			mode_lib->vba.DPPCLK[k] = mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz;
 		else
-- 
2.43.0


