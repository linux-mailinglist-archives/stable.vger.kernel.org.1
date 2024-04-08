Return-Path: <stable+bounces-37657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7E389C5E1
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B7A1F21946
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235507CF39;
	Mon,  8 Apr 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z39U/yxA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC97C0A9;
	Mon,  8 Apr 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584876; cv=none; b=PBMMgVJ/isNeUjn2WUZRqURqwzYha7zsvXbgCFaqbGvgjzoPjBmtsc5U3O4JZ9UpCHt17px9zJIFyPBtDF6yh3aWtZi7krI9x0JqAoiqmvkEq71cquBMRS/p2vzq1a4H7laBEW2uvKYNQKfcm9Uhta91ILSUK0EDfSzzA6BrlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584876; c=relaxed/simple;
	bh=ONy8Fga3sfCZ80k26kR2N22cyeRpfPHMOrrIcgK4a0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ti9IimSbO29OJscSym0rYI1n67DJum///sCTXwGhYSLfAThZ3i0ypCLsWKYp9n5fb+k+Z5snm60EJl7yIw+snbCJPd/2DIaDmQxkNPF4by3uXCV2xaQ8KciblfzKpGPlgRlKCI+zzvHWu/Vi1KhNgVr5TpmvjYg/Lzkzo11CzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z39U/yxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E982C43390;
	Mon,  8 Apr 2024 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584876;
	bh=ONy8Fga3sfCZ80k26kR2N22cyeRpfPHMOrrIcgK4a0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z39U/yxA025exXW1Vuz/v3UBUszmOv8NT7yxqj6G7Jawt6u5ZuGd40zdzE16w1U4r
	 YFue9QSyBhZtWCrupA99gZx46iUptGV2QjpACB5scpjchblK5ngSI5L8z8ceV5PSFT
	 RpHLnzMZ74n1OH3+n0EUycBWQLLN2ttDfYADaFWk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 580/690] drm/amd/display: Preserve original aspect ratio in create stream
Date: Mon,  8 Apr 2024 14:57:26 +0200
Message-ID: <20240408125420.610252290@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit 79f3e38f60e5b2416ba99804d83d22e69ae592a3 ]

[Why]
The original picture aspect ratio in mode struct may have chance be
overwritten with wrong aspect ratio data in create_stream_for_sink().
It will create a different VIC output and cause HDMI compliance test
failed.

[How]
Preserve the original picture aspect ratio data during create the
stream.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9356decd14513..b7b8a2d77da67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6334,7 +6334,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
 			drm_mode_copy(&saved_mode, &mode);
+			saved_mode.picture_aspect_ratio = mode.picture_aspect_ratio;
 			drm_mode_copy(&mode, freesync_mode);
+			mode.picture_aspect_ratio = saved_mode.picture_aspect_ratio;
 		} else {
 			decide_crtc_timing_for_drm_display_mode(
 				&mode, preferred_mode, scale);
-- 
2.43.0




