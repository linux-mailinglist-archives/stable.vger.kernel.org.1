Return-Path: <stable+bounces-140131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84988AAA568
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F1E188FCEB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E827A12F;
	Mon,  5 May 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xpncj2PL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8730FD12;
	Mon,  5 May 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484166; cv=none; b=c4b8eM6ZMlokNqukiV4S0jYeXkxngjARhG3E4Nqjh8MVvKC0tMrHSJHt/GH6LfxTKYHDpKdxnLUGOl/dDNaX1NrnLteK4Z7lKwrO6nyiBF/n4xEaaws3Sq61mUl9ERRh+SKyfSuqkbC5CsEJbFV35nU9l3q8bkKwehuqc75PcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484166; c=relaxed/simple;
	bh=CJqtGRIu7fkrant3moOP0oGqadAAgLUL0H9FjJ68rXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3FK2cOU2DIjOqrhoGqP3VeL9vU3w6U84gj7yLp7s+gOrhkiKF/rCTYH0erDkhm3ijEZtnljU1E7beeR628zmi6oZTNjgrT3GMY904MDHDQRsgOZjBd+VMhz9xcZHcQ/5FuJDjJsHyn89WuI3/0zpnvWNK1lB+TxYu//cT6iaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xpncj2PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E50C4CEEE;
	Mon,  5 May 2025 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484166;
	bh=CJqtGRIu7fkrant3moOP0oGqadAAgLUL0H9FjJ68rXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xpncj2PLd+m8OstQNJm3RPFR9zJ2zwlq9ivMzD6DOtBZUHDN8C6XJyotm5seeKWWv
	 bKfIv0FqqzMfMFvi6ga4ddBDxrNm65dQJMux8f2LKAJ59aWGZIX3cnm9Hg7uieaiha
	 fw1h0YG7aBM1hlCdQmsGMMc63cJf6HRTFrgRgPHr1xrjgDBxG2L8NZL+kNfjqiwz5I
	 XXnrZObTrz0/OIwOjD5ScqqN464t812X+VWbgOxv5i4GNx8h7DgaCWMRiUP5uSRuUj
	 5nttz0wEB3v60uDiMBu+slUSbedBXejmI9DZFpuK4ts554oZcHCrG8Uj385XnSVrJB
	 RTwqHXa9JNLEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry VanZyllDeJong <hvanzyll@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	michael.strauss@amd.com,
	george.shen@amd.com,
	PeiChen.Huang@amd.com,
	Ausef.Yousof@amd.com,
	Cruise.Hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 384/642] drm/amd/display: Add support for disconnected eDP streams
Date: Mon,  5 May 2025 18:10:00 -0400
Message-Id: <20250505221419.2672473-384-sashal@kernel.org>
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

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[ Upstream commit 6571bef25fe48c642f7a69ccf7c3198b317c136a ]

[Why]
eDP may not be connected to the GPU on driver start causing
fail enumeration.

[How]
Move the virtual signal type check before the eDP connector
signal check.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 6d7131369f00b..28843e9882d39 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -945,6 +945,9 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		 * TODO: add MST specific link training routine
 		 */
 		decide_mst_link_settings(link, link_setting);
+	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
+		link_setting->lane_count = LANE_COUNT_FOUR;
+		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/* enable edp link optimization for DSC eDP case */
 		if (stream->timing.flags.DSC) {
@@ -967,9 +970,6 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		} else {
 			edp_decide_link_settings(link, link_setting, req_bw);
 		}
-	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
-		link_setting->lane_count = LANE_COUNT_FOUR;
-		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else {
 		decide_dp_link_settings(link, link_setting, req_bw);
 	}
-- 
2.39.5


