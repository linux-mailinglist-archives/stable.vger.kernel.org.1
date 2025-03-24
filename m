Return-Path: <stable+bounces-125939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECB3A6DF1E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E643916CE78
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3B261368;
	Mon, 24 Mar 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/yu0oPa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256A13A41F
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831802; cv=none; b=hRfD9DjbSlF0WpjOfPOkANTprAtlTue2GgV+vcGbF37gPFim4R0idjwyxG1JOykL9fcAwUt+OjI7R3thHC0wN1sVcZDl7Yg4iQBVj5ZlagVJDhEFHoNvK0F+xzpOAEQDOcairu1+s52HjytFZyzZovsRqTnDKhI4KiSOXJuHjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831802; c=relaxed/simple;
	bh=b5G4gUYkefDj1Kj13rmx2oelbGa8eBZejAZQiOxzTE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVtkqBZfxoxbpSTo0U0irlxVtjIY+PwOhblW2d1REBC+sSJ+5tlyHttOOjpQv9H622IZAkaHqs4GjeDmgjiUSqZFQc5sW34QUL8W40xYOAIQWdxyItyivj3OOnGYvadfICP/Hnda9saijV2pLEx4RIcvIYeLNkxLHR2ZuIJqpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/yu0oPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9B7C4CEDD;
	Mon, 24 Mar 2025 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742831800;
	bh=b5G4gUYkefDj1Kj13rmx2oelbGa8eBZejAZQiOxzTE4=;
	h=From:To:Cc:Subject:Date:From;
	b=Y/yu0oPamfmY5xYEso36aHa1iL96CaYWEl0IUCnkosxfxZ8kYUVFDcNd+SCwp5ZSM
	 2BAWcL3NyuxQEnathDM1eThAoelX/TedmgZJjmGrG2V2pthmfiodNlK92AQMUm5Pfd
	 0/TLOewNJTe/VjqLReDrxJBn+V9CL0hLyCutOWviEp6w7QY4/1kOjA/Xd3wfMVEXgK
	 2idEKEzVy2Q/ksYlpSGo/xKjAF7glsmI3aJ/ZaSBZTdlsvxN2ehCsQYjroRSgcNvq0
	 jTK2BtxYXu1drmW2pO9gCtDUah7JT+h7A2tEiTNGUyliyp6pwYLGKVdUjKdnMyrVL0
	 vrWf8TF0UptYA==
From: Mario Limonciello <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander.Deucher@amd.com,
	harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	ChiaHsuan Chung <chiahsuan.chung@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y] drm/amd/display: Use HW lock mgr for PSR1 when only one eDP
Date: Mon, 24 Mar 2025 10:56:29 -0500
Message-ID: <20250324155629.2588451-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[WHY]
DMUB locking is important to make sure that registers aren't accessed
while in PSR.  Previously it was enabled but caused a deadlock in
situations with multiple eDP panels.

[HOW]
Detect if multiple eDP panels are in use to decide whether to use
lock. Refactor the function so that the first check is for PSR-SU
and then replay is in use to prevent having to look up number
of eDP panels for those configurations.

Fixes: f245b400a223 ("Revert "drm/amd/display: Use HW lock mgr for PSR1"")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3965
Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
(cherry picked from commit acbf16a6ae775b4db86f537448cc466288aa307e)
[superm1: Adjust for missing replay support bfeefe6ea5f1,
          Adjust for dc_get_edp_links not being renamed from get_edp_links()]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 3f32e9c3fbaf..13995b6fb865 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -67,5 +67,17 @@ bool should_use_dmub_lock(struct dc_link *link)
 {
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
+
+	/* only use HW lock for PSR1 on single eDP */
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
+		struct dc_link *edp_links[MAX_NUM_EDP];
+		int edp_num;
+
+		get_edp_links(link->dc, edp_links, &edp_num);
+
+		if (edp_num == 1)
+			return true;
+	}
+
 	return false;
 }
-- 
2.43.0


