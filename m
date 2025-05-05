Return-Path: <stable+bounces-139997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0EAAA392
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9573AA9CB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC45C2F4955;
	Mon,  5 May 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfCa3XRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941562F4952;
	Mon,  5 May 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483858; cv=none; b=qVj859IAh6/FtVgVjQ00n+1zr3w5iPb1Z0qO48RghuC+QGJ79+lrrqCtzQ60U2G5aMVcRT4SmgMKEPmLlCztWKwfCEJwLaFggih6kbTZM9j1RH6jnjZPV8XdToxRWpWzFjR3PpL7jm7RrdCvRuQghVp5ayUh0Yk1EEyWBDuL5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483858; c=relaxed/simple;
	bh=hmCYWfcrgzVNUsnwiwvvhVBdNzXqDpzOhmLwKL6TJ0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8+4T7B8f7A8zwtSxDtodrfIeEqf/0WsJuZlcGuqeUHfOrtcmijDs6W4HY/NDLSs0ZvUF0t6GEGNHjIfgj8akzuXGqVWjcQ/rV35tUAPYb1H8FCQBjEkhKfk2hTJyV/ja2UL/RsXdMfjGgpLbp7u3VlJqBp04tjcYr1zOAS8gtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfCa3XRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009F2C4CEE4;
	Mon,  5 May 2025 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483857;
	bh=hmCYWfcrgzVNUsnwiwvvhVBdNzXqDpzOhmLwKL6TJ0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfCa3XRbfhSyO8EtvP2/A3gVuMQLs+PTdSK5I6WrBvOVsD9yAijfTEmS4kSyTyFya
	 kyvmiKevmxMg5dUkMG3oiokrarX/cMGX8ZG0ArgrWwXe1OPOBOI0NcOdJoB48bDbU+
	 yc13HIeR2D3yxP+HSDKe8RXkoAH/51lI+d3r9G4fqpqhs/2NdbuY3S01VoAS4do2qh
	 DX4neP+q/npN7wbO+dnIKyqMKTh5syiz05/vnGVmqpRi216ha/w/uOARaEqX03jiSo
	 YvTBPLJvXAnW6l5Fe30ZIQ0iHUhz/TDjz5EDU5UItSTG/MIXmwx6s90uzadX9GnXgD
	 aGIywpe4GFD8g==
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
Subject: [PATCH AUTOSEL 6.14 250/642] drm/amd/display: Skip checking FRL_MODE bit for PCON BW determination
Date: Mon,  5 May 2025 18:07:46 -0400
Message-Id: <20250505221419.2672473-250-sashal@kernel.org>
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
index 44f33e3bc1c59..6d7131369f00b 100644
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


