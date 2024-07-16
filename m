Return-Path: <stable+bounces-59427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE59E932880
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0381C2283C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03B419DF58;
	Tue, 16 Jul 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmnxSbAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6FB19D8B0;
	Tue, 16 Jul 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139950; cv=none; b=KANLfjlls+VSLEatlYHvWkt599rmXIu51xNe9BIstjaYrzrJaS9PiF3uVD+IEpYYibE/WIqHoZr9/KWMYyrpO3zcMKciRsQPzLrOILsZvpGlXTaidZ+m5fMqSJ8AIRdqC8f7QgUBXy8MnclHw5pYxa2AFEkJ0GZiNdwlQye52jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139950; c=relaxed/simple;
	bh=Xn+6qUzEpTK6qfPzPjy3rGiaLoMBOtgvKgPsCnJsxrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnExe9NsbunHDFWhxelOQ5uJN8WhcV/ydE1WfT2mTIhiyfwuIQnHRGtIL1ijL5RpLIVkluewXvXcxErvMVHZYqR57ry4SbVVaDIfrJKgqkHQOTPKeuAh++baOCpfuUHy6iqx6GUXboNAogO9TzsIpQKQzdNmCD8QI/ZBduC2/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmnxSbAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2148BC116B1;
	Tue, 16 Jul 2024 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139950;
	bh=Xn+6qUzEpTK6qfPzPjy3rGiaLoMBOtgvKgPsCnJsxrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmnxSbAsnQkWj/lqjVx7qGHXsOObpICYIPisn2JHYdlvpGUbF++S/ahnSQiaXlkoe
	 1Ia6b77eiZA9SWz+kxSXNo2mra5JlKz0w6vpr1nznrsbyDLXxdUy3/JmkZTLghL/T4
	 JHziIraQIMIv8mXmBUQ/uUoOR+6QJq9/XpJfcnwx9Ap3pReFJTRqPGxuommu0Luqia
	 i7ZJADI5EpVuXUCbk9RpHUgK/B1saR8XtgnJuI+cbnycbMjEbESDJMrxhFjWhZcW1m
	 s0UiBlgoCs8iPsX/4mottu7ov1YADDXLLLiEgAuZITv7KpJznACVjJvvPCWmEp6WL0
	 8pqWmXlV+1GUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	roman.li@amd.com,
	mario.limonciello@amd.com,
	joshua@froggi.es,
	wayne.lin@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 11/22] drm/amd/display: Reset freesync config before update new state
Date: Tue, 16 Jul 2024 10:24:18 -0400
Message-ID: <20240716142519.2712487-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit 6b8487cdf9fc7bae707519ac5b5daeca18d1e85b ]

[Why]
Sometimes the new_crtc_state->vrr_infopacket did not sync up with the
current state.
It will affect the update_freesync_state_on_stream() does not update
the state correctly.

[How]
Reset the freesync config before get_freesync_config_for_crtc() to
make sure we have the correct new_crtc_state for VRR.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f866a02f4f489..53a55270998cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10028,6 +10028,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
+	reset_freesync_config_for_crtc(dm_new_crtc_state);
 	get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
-- 
2.43.0


