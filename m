Return-Path: <stable+bounces-148686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E086AACA5AC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724801797A6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DEA30C397;
	Sun,  1 Jun 2025 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfoKnVvM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675C30C382;
	Sun,  1 Jun 2025 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821105; cv=none; b=Ve826ro8pnFheqV9h1b0Vcl6Vo2TcTxt2j7whuhg16QzibUTLkqsLVSvxRRbf08AmdH5Aayyw7BX3fP9Kwb4SE7FKaPmpj1izJts1o3aK0v8N0aE9rNmooAqq/IxRNkmik6PNjAAOrc2g0pqXYHLnNwxa4QBskStohSiJN3e61Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821105; c=relaxed/simple;
	bh=L/l4GcpH4qDGzEZ5kTk1gPeHUa96W1cMjD2dwvtt5rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaNMUG95zdsEjMh0QewsmulFwX0XE6RB8Qg2hIMAT9HspEluCXY36rzhd83vaE1a+7zlYxeFveNk9CLHtSl90Sfc1b2oZKlMVI2jEfOpA4jSsK3Ln+Ll3gioUeMNHGkzGSlrCJ/hzSjkE4baKY6uiNF9nUb4StOGZhDn3UdG2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfoKnVvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069F5C4CEF1;
	Sun,  1 Jun 2025 23:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821105;
	bh=L/l4GcpH4qDGzEZ5kTk1gPeHUa96W1cMjD2dwvtt5rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfoKnVvMS7jXSrnrh3u5wMAFepkaGGcL2/eLaMg8vZsJvOVhHw/M1l310Vbrqj5y7
	 uH73UKUXkfQXyZBxlh+i2qhTA7C5DcFYIBh0Rfq4WuSyyy7zrX8+Gi96OUmy7yUG3B
	 kmLKelB1GIz+q45efMqNc2uKBR6kNMWl9h4nAaUt0YTRwF7fVqf+koolxocy85AuQK
	 p7sgPrPd9EV0DzxyG8JMwsBRAmBzJO7jlYiAGV/m9oQdDix/tcEiH0oZ3FPpFsxttL
	 fOWNgdlf17DXnBqCgATl432Ty1wvUcPwK+VsMcvkqDOhieD5QpFqXHxLTXxw/jcZsR
	 PTs05o5wuyD1Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	Wayne.Lin@amd.com,
	dominik.kaszewski@amd.com,
	mwen@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/66] drm/amd/display: Add NULL pointer checks in dm_force_atomic_commit()
Date: Sun,  1 Jun 2025 19:36:52 -0400
Message-Id: <20250601233744.3514795-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233744.3514795-1-sashal@kernel.org>
References: <20250601233744.3514795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 3f397cd203f247879c2f1a061e90d4c8d23655de ]

This commit updates the dm_force_atomic_commit function to replace the
usage of PTR_ERR_OR_ZERO with IS_ERR for checking error states after
retrieving the Connector (drm_atomic_get_connector_state), CRTC
(drm_atomic_get_crtc_state), and Plane (drm_atomic_get_plane_state)
states.

The function utilized PTR_ERR_OR_ZERO for error checking. However, this
approach is inappropriate in this context because the respective
functions do not return NULL; they return pointers that encode errors.

This change ensures that error pointers are properly checked using
IS_ERR before attempting to dereference.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis, here's my assessment: **YES** This commit should
be backported to stable kernel trees. Here's my detailed analysis: ##
Commit Analysis **1. Bug Fix Nature:** This commit fixes a clear
programming error where `PTR_ERR_OR_ZERO()` was incorrectly used to
check error pointers returned by `drm_atomic_get_connector_state()`,
`drm_atomic_get_crtc_state()`, and `drm_atomic_get_plane_state()`. The
commit message clearly states these functions "do not return NULL; they
return pointers that encode errors." **2. Specific Code Issues Fixed:**
- **Before:** Used `PTR_ERR_OR_ZERO(conn_state)` which is inappropriate
since these functions never return NULL - **After:** Uses
`IS_ERR(conn_state)` followed by `PTR_ERR(conn_state)` which is the
correct pattern for error pointer checking **3. Comparison with Similar
Commits:** Looking at the provided examples, this commit closely matches
**Similar Commit #4 (Status: YES)** which also: - Adds null pointer
checks for proper error handling - Fixes potential crashes from
dereferencing error pointers - Is a small, contained bug fix - Addresses
static analysis findings (Coverity-style issues) **4. Risk Assessment:**
- **Low Risk:** The change is minimal and only affects error handling
paths - **No Architectural Changes:** This is purely a bug fix with no
feature additions - **Contained Impact:** Only affects the
`dm_force_atomic_commit()` function in AMD display driver - **Improves
Stability:** Prevents potential kernel crashes from dereferencing error
pointers **5. Stable Tree Criteria Met:** - ✅ Fixes an important bug
(potential crash) - ✅ Small and contained change - ✅ No new features
introduced - ✅ Minimal regression risk - ✅ Clear fix for incorrect API
usage **6. Critical System Impact:** The DRM subsystem is critical for
display functionality, and improper error handling in atomic commits
could lead to: - Kernel oops/crashes during display mode changes -
System instability during hotplug events - Potential security
implications from dereferencing invalid pointers The fix ensures proper
error propagation in the display driver's atomic commit path, which is
essential for system stability.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bcf0dc05c7676..937a0d128eeb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9102,16 +9102,20 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 	 */
 	conn_state = drm_atomic_get_connector_state(state, connector);
 
-	ret = PTR_ERR_OR_ZERO(conn_state);
-	if (ret)
+	/* Check for error in getting connector state */
+	if (IS_ERR(conn_state)) {
+		ret = PTR_ERR(conn_state);
 		goto out;
+	}
 
 	/* Attach crtc to drm_atomic_state*/
 	crtc_state = drm_atomic_get_crtc_state(state, &disconnected_acrtc->base);
 
-	ret = PTR_ERR_OR_ZERO(crtc_state);
-	if (ret)
+	/* Check for error in getting crtc state */
+	if (IS_ERR(crtc_state)) {
+		ret = PTR_ERR(crtc_state);
 		goto out;
+	}
 
 	/* force a restore */
 	crtc_state->mode_changed = true;
@@ -9119,9 +9123,11 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 	/* Attach plane to drm_atomic_state */
 	plane_state = drm_atomic_get_plane_state(state, plane);
 
-	ret = PTR_ERR_OR_ZERO(plane_state);
-	if (ret)
+	/* Check for error in getting plane state */
+	if (IS_ERR(plane_state)) {
+		ret = PTR_ERR(plane_state);
 		goto out;
+	}
 
 	/* Call commit internally with the state we just constructed */
 	ret = drm_atomic_commit(state);
-- 
2.39.5


