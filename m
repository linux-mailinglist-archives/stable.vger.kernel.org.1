Return-Path: <stable+bounces-64964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9137943D0C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCDF1C21268
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372B155730;
	Thu,  1 Aug 2024 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AltNdXEA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EC1552FD;
	Thu,  1 Aug 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471764; cv=none; b=KPHE3uOP3NT1nm3dIbvvprgFe3VGOJcBPrzooRQG1AYiRIMZ177GdlPCbxqnG45uXAfwFUMjMtJDfPdMssclnV1X1tZ8DWbE8YRLoFnk6uAn2FiamjaQNWwZjQcfE1TwUYqqE77d0lDQFaR/DM97MZVpfg4z0qZC7TReiuCsKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471764; c=relaxed/simple;
	bh=k1OzG/Ph8FLCQr2rJ2EcfbDg5sZPpBE/xjv0ztn/6f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSonatVbTtDgSgB33ikvfAEh6s4q/qrbOHc7dUeDxd5slfVnduiaPnK+Fda2VT3jZ0BWszHLxbtRCf3AI9X107JrtqJQC9m1Twts0AYfrDRTn77uSl/wPAZO4jg5Jyrx3fgVmIEPid9SwNbk3bajAAbbqqCKWHkw8Z5pSda4Z3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AltNdXEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69510C4AF0E;
	Thu,  1 Aug 2024 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471764;
	bh=k1OzG/Ph8FLCQr2rJ2EcfbDg5sZPpBE/xjv0ztn/6f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AltNdXEAuhbPdHZHOf3dBhkGScqQP1MEsl+Tvh4/k2iAgtIE4V3mWMrxnNHmH+YZp
	 7BrjsAXVr0uL3rkbOatTEWBie6/k/rYRF9acDf/OTNMjWbl6vSEbplJ9tq/JaoRlF5
	 +IXlnjWr6h8pvtgRpWVZwLu2OMymt24jHBpNsTgDzkciGh8qUfl0MmaNoz5JvbFFgL
	 IWnxnGII7xnC2QTQ+3gRsVBzMA59psrxxWzhvXmXb2K5w5S/hWC82xJJVWXaLDX4vr
	 ltL/Fi2L43HsKo9H6VpwKeRQNH5fzH4YzpGYudYki84obvtEUKPsUe5tdn1rn3Iu4F
	 UpjF0bYEnhVmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
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
	wenjing.liu@amd.com,
	george.shen@amd.com,
	zaeem.mohamed@amd.com,
	michael.strauss@amd.com,
	ran.shi@amd.com,
	daniel.sa@amd.com,
	Bhawanpreet.Lakha@amd.com,
	yao.wang1@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 18/83] drm/amd/display: Fix Coverity INTEGER_OVERFLOW within decide_fallback_link_setting_max_bw_policy
Date: Wed, 31 Jul 2024 20:17:33 -0400
Message-ID: <20240801002107.3934037-18-sashal@kernel.org>
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

[ Upstream commit 83c0c8361347cf43937348e8ca0a487679c003ae ]

[Why]
For addtion (uint8_t) variable + constant 1,
coverity generates message below:
Truncation due to cast operation on "cur_idx + 1" from
32 to 8 bits.

Then Coverity assume result is 32 bits value be saved into
8 bits variable. When result is used as index to access
array, Coverity suspects index invalid.

[How]
Change varaible type to uint32_t.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 9a0beaf601f87..16f4865e4246d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -528,7 +528,7 @@ static bool decide_fallback_link_setting_max_bw_policy(
 		struct dc_link_settings *cur,
 		enum link_training_result training_result)
 {
-	uint8_t cur_idx = 0, next_idx;
+	uint32_t cur_idx = 0, next_idx;
 	bool found = false;
 
 	if (training_result == LINK_TRAINING_ABORT)
-- 
2.43.0


