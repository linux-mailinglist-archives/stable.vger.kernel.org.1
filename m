Return-Path: <stable+bounces-140711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA58AAAAD3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D0E189650F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE92EDB3B;
	Mon,  5 May 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/8AmMjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442902D0284;
	Mon,  5 May 2025 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486032; cv=none; b=UvOBRIrCmnwBoZOwaL0WPBUAhjgVW9eiYEWvLSesXCXW0Cwlhp5Re+PrRIIIJ0CM8bveroCEZIN3dLsDvm/ktdLx8obcp2nC1LigfMazEasZf/d7at25vFAeKtY7o644rqHKesoWYVcPzYM5BSCdd6sW2DVEC4gyt2vt//s2+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486032; c=relaxed/simple;
	bh=0oolSqsZ1MAxsLhdbgfd9396bqGOYrEmyGV7kZGgazM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbGkEIBV0M9yBfxXp+Jv3+OVbtizK+HCGxttHZN5ECvKc/NxrbycRBlJB0rUc05rexYWC4wo2vzONeBMCjd6LDSwr3IWnn+yRYn8hbfSHxifF0lRilHsrnuMAwCi6cgvlbUKR4Ur5heqC0iuJC4VAQXigJGso0teHD1ru259tnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/8AmMjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085A1C4CEE4;
	Mon,  5 May 2025 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486031;
	bh=0oolSqsZ1MAxsLhdbgfd9396bqGOYrEmyGV7kZGgazM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/8AmMjXZJbbt33IFaYj72mIL5eZX2qVFW6SQKbuWFNU/m9kWKTMYy6gwo0/WikFT
	 +iq7x7AEza0lt6IOP4l1VTiq9aFhgokGDF3sXgqyTieiG++nDbqjcF0NR5+Lv/Op6M
	 dahyWObC+U5TPnjrk2X35vuBxB+rSoaX+A48zvbVOudo52Ki6r3PMGmKhQ8WELCkrb
	 EyNyM2RrSZUa//tEB5iaTvPzbzKpiuNX2bahzKKq5AnS0kUd+B5s8Mrut/m4iIpOZw
	 NiMfSwEiFHSUJ2uNp1AzmaTKzb/AKDhd4652susVJO4wuWUqwGZ0RIAlYKHLlfZCyh
	 9mV4P3GKLf6Fg==
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
	michael.strauss@amd.com,
	roman.li@amd.com,
	PeiChen.Huang@amd.com,
	Ausef.Yousof@amd.com,
	Cruise.Hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 119/294] drm/amd/display: Skip checking FRL_MODE bit for PCON BW determination
Date: Mon,  5 May 2025 18:53:39 -0400
Message-Id: <20250505225634.2688578-119-sashal@kernel.org>
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
index 3d589072fe307..1e621eae9b7da 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -239,21 +239,21 @@ static uint32_t intersect_frl_link_bw_support(
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


