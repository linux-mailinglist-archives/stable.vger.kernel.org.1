Return-Path: <stable+bounces-141175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40345AAB63D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72B31C035A0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5E2C0854;
	Tue,  6 May 2025 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf95r6Km"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783A37778E;
	Mon,  5 May 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485383; cv=none; b=Z3Sn5uBvhGxL7BVnV81aY0F6sRb+3UkzD+0MW9MNpcGwBGjQmONp5gKluITeWT3F8keeU7aMBkD0OvTdQgBkHSwHWKlu8ZNkqCui/w+IgfkWy5ZluqfmsZC7B7EcAmHLQxSf4Cd+TKJxBLDRF0dVafXGqZK9q59ifjEpq2Mlgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485383; c=relaxed/simple;
	bh=nJtv7p0rucIQvy2LKomc4PsnCh5XM7YlZVAREd7jaEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJpsjJreBRYXE3B3NHbf4S7qBNG7U4MdvckqwlKGgmvlBayhRMErjsVfa05IyoaiEwwKPlzG+M7udF/yiFI5PxZ0/lp6K9ymoQogrHwlkju2yY7mFE14srd4TS9/MKSwkjGMlop4+r4dII7HyKwQw0jHubTQiKK2N8dksVlUZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf95r6Km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE3CC4CEE4;
	Mon,  5 May 2025 22:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485382;
	bh=nJtv7p0rucIQvy2LKomc4PsnCh5XM7YlZVAREd7jaEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jf95r6KmOEFysX6RevRfDKtSi8VCkEuEXe8kL/DolrJeG0j4r2v28bWl2dO00SQRT
	 8tnY+dkf3MN8EM6e26nH7bSCE+xQzQfmorLmiao22Qpw8MsCMkpy+tFr87/yXQVRsz
	 4xnHq2eLJi0VqFGYttZzW7rA/ku9vhJ7DnetSmHA/D6ouRnahRvxUyBwSxhJbHriJn
	 l2r/NKuZXv0+mj8ZXnEAihoHQNLyvZXWW0AyxbvbMRuJqyyMbxI3ShdNoeDDlVlUpO
	 WnQj9HoyErnKclKzIxVw5lvsfRRL7QzK19sl4P4ZsScSifbwLAPI3Vi8pdZaAFJ33D
	 oBK8OOdw0nMGg==
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
Subject: [PATCH AUTOSEL 6.12 300/486] drm/amd/display: Add support for disconnected eDP streams
Date: Mon,  5 May 2025 18:36:16 -0400
Message-Id: <20250505223922.2682012-300-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 23e650e39910e..d9a1e1a599674 100644
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


