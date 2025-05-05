Return-Path: <stable+bounces-140573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C1AAAE47
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C1F3B4A83
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59F2D4B42;
	Mon,  5 May 2025 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfSZi23A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734543679D9;
	Mon,  5 May 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485176; cv=none; b=thRqNZ9Q7/e5nbH30oTlog3foWuIZHQL/t+BVcSlf32QI5iPSWYtlSj+kBSr/jbIHvHRx3eyDrrH+UANYdtqyuU5oJewKDdfXvxcTp97upMBxrI8qb1mKUK+ebOoJ0+FhBfyCdBqGuqvTGYnJIK/3qrU/jjJIeWT+dWQXnfzYYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485176; c=relaxed/simple;
	bh=IM+quJAHAyIiqqydPfve0lj9WWv+tWG5QphYLrWXjIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKUQ6xtY6PcVCkOBE+OsXwif9EROQpOVqHNlplqigtLO3RxhopKKz31l6YLHFpsajrGfNSYVavVWnQgDxD0R3NxFpxdh9lfqkNBnKQhKCdxHHseRQuuLPN1hQlhyXiwz5WfoBxrK7pAnGJVT/XgIk0Typ83gZlrfjoWmUxMtfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfSZi23A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70548C4CEE4;
	Mon,  5 May 2025 22:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485174;
	bh=IM+quJAHAyIiqqydPfve0lj9WWv+tWG5QphYLrWXjIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfSZi23Akh1MtCPOeXv3yPUueE3YnRlJvvaYk7VHyzFTQoKW9tzqgAtQKSXG19Yoa
	 YzaFTv/deVheEltH9b61rXJoTsTvHTPOSeVY1jj9Qfh8lD2QNj6Oa20EMePoS0MhMm
	 0ar0IN+R47geJsIPLNsePhNJur2kjItvgMrb/5kAcTMyN9v/NxWngrVMIDEHgyg4qr
	 rcFbOdudzorSGtAOzQm13R48vO1TLFk3/2wcZHShM+NmjptHcAh+BxBGCYQ5yWwh3r
	 4KSUAQ0GIgQWKolJz6KFqMrBpz08Iculw0KJU9oKG8JV1BjCPPD8j6pQbIupt/CUJJ
	 5HaChF5lwWNbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Shen <george.shen@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	roman.li@amd.com,
	michael.strauss@amd.com,
	PeiChen.Huang@amd.com,
	Ausef.Yousof@amd.com,
	Cruise.Hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 198/486] drm/amd/display: Skip checking FRL_MODE bit for PCON BW determination
Date: Mon,  5 May 2025 18:34:34 -0400
Message-Id: <20250505223922.2682012-198-sashal@kernel.org>
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

From: George Shen <george.shen@amd.com>

[ Upstream commit 0584bbcf0c53c133081100e4f4c9fe41e598d045 ]

[Why/How]
Certain PCON will clear the FRL_MODE bit despite supporting the link BW
indicated in the other bits.

Thus, skip checking the FRL_MODE bit when interpreting the
hdmi_encoded_link_bw struct.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/link/protocols/link_dp_capability.c    | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 885e749cdc6e9..23e650e39910e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -250,21 +250,21 @@ static uint32_t intersect_frl_link_bw_support(
 {
 	uint32_t supported_bw_in_kbps = max_supported_frl_bw_in_kbps;
 
-	// HDMI_ENCODED_LINK_BW bits are only valid if HDMI Link Configuration bit is 1 (FRL mode)
-	if (hdmi_encoded_link_bw.bits.FRL_MODE) {
-		if (hdmi_encoded_link_bw.bits.BW_48Gbps)
-			supported_bw_in_kbps = 48000000;
-		else if (hdmi_encoded_link_bw.bits.BW_40Gbps)
-			supported_bw_in_kbps = 40000000;
-		else if (hdmi_encoded_link_bw.bits.BW_32Gbps)
-			supported_bw_in_kbps = 32000000;
-		else if (hdmi_encoded_link_bw.bits.BW_24Gbps)
-			supported_bw_in_kbps = 24000000;
-		else if (hdmi_encoded_link_bw.bits.BW_18Gbps)
-			supported_bw_in_kbps = 18000000;
-		else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
-			supported_bw_in_kbps = 9000000;
-	}
+	/* Skip checking FRL_MODE bit, as certain PCON will clear
+	 * it despite supporting the link BW indicated in the other bits.
+	 */
+	if (hdmi_encoded_link_bw.bits.BW_48Gbps)
+		supported_bw_in_kbps = 48000000;
+	else if (hdmi_encoded_link_bw.bits.BW_40Gbps)
+		supported_bw_in_kbps = 40000000;
+	else if (hdmi_encoded_link_bw.bits.BW_32Gbps)
+		supported_bw_in_kbps = 32000000;
+	else if (hdmi_encoded_link_bw.bits.BW_24Gbps)
+		supported_bw_in_kbps = 24000000;
+	else if (hdmi_encoded_link_bw.bits.BW_18Gbps)
+		supported_bw_in_kbps = 18000000;
+	else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
+		supported_bw_in_kbps = 9000000;
 
 	return supported_bw_in_kbps;
 }
-- 
2.39.5


