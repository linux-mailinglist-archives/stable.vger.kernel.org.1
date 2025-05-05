Return-Path: <stable+bounces-140760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E187AAAB2A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AEC1A86B62
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C362F4034;
	Mon,  5 May 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btRdZ39R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF42E6865;
	Mon,  5 May 2025 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486163; cv=none; b=aYLGQMjYO81fj/PxpUxdsCAuflrySC7fNngnKV2Oqlyrg0YmxQiYu6oB2eQ/Zuazh5PMw0FbC5PNrtDJQfeaxTtRE1OwUd7lvtqx7gbQ3kNWflHjK1FVFGnzJQIOYAIRKpQWd97Lh439ff2bNIJz/KHNQOLzYtTzmK5heXiz5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486163; c=relaxed/simple;
	bh=wU0dJgQrN6llgCDacv/lF1XNbrIqJWn+Wj7cXZyNsmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qcS8fqpj9Xjmxs8/LOwy7tU2AxYrY4pA1uj7JVzoIP4WhNuNrzJNLBqrqHG6Px25iNfdOXhwCAy5Tdj0+4okgUwcBtf7VqzgeCgo6RsPQaMM3r+VfQSjw4aznjuygZt7VlP0zgDQQgtRbo7X5WVBioRll5DIL6kK+6TGsbiiA28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btRdZ39R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514D2C4CEEE;
	Mon,  5 May 2025 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486162;
	bh=wU0dJgQrN6llgCDacv/lF1XNbrIqJWn+Wj7cXZyNsmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btRdZ39RowItPcG1IjdkuG3ViimP0mqo30qhK3Ix0SKcJw/i/EB2JzBMhNQEH/Hve
	 w2clRGsEQvlcUNpQyZr016nJudQ8ovn17izfxUeAg93d2WY1svkcqohCuI9xtk1LMe
	 NjSQwLpt/2jHM61iXOlmZW2hixt34aL5pmSaPW1jzytAsnVpSIueKHaFvoaPmhJJ3n
	 TWmPqEhpUvU4dbRDIFNvYBJri0TqaaheeTQpeLy1ByMF0paACjFjJ68U5cKTPKdkLp
	 ebhudl3LyAKoeMiom9RdpsJ0mbXw6WcxNAC+J/UpKiGsANZxnwO336UxKMDrg7diPl
	 +QO05lR08xtwg==
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
Subject: [PATCH AUTOSEL 6.6 185/294] drm/amd/display: Add support for disconnected eDP streams
Date: Mon,  5 May 2025 18:54:45 -0400
Message-Id: <20250505225634.2688578-185-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 1e621eae9b7da..adf0ef8b70e4b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -920,6 +920,9 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		 * TODO: add MST specific link training routine
 		 */
 		decide_mst_link_settings(link, link_setting);
+	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
+		link_setting->lane_count = LANE_COUNT_FOUR;
+		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/* enable edp link optimization for DSC eDP case */
 		if (stream->timing.flags.DSC) {
-- 
2.39.5


