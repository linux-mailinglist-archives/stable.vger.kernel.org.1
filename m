Return-Path: <stable+bounces-77477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15491985D9F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43DB1F25806
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA11B3B1B;
	Wed, 25 Sep 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwWfmWHw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0017AE05;
	Wed, 25 Sep 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265960; cv=none; b=fcjW15Vmjdq8fsaWdsG5LqNKyz/1mLOj7f+ivTP5YoQ/krHxQyM6dSb0dNwqOr41MVaoU2gy6h7p9WzkI9M2BqaRfB2U6ku5sMJU6aRbtd45JoxgE6FhsQ0JAiETppWFoW+b5TpOPygZZGrTGclnofOV1u38YMnbdCTgh6RKo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265960; c=relaxed/simple;
	bh=eRuln8e9VHwpZLNjSbN8jXsnIosW8yfjYZ0mOiU/ZO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEaFB9L76RqlJJrgU2FpCU3A3eIeHediDgUNcDuUtEasYpXz0CeovxfDaTRdDi4SgXvC6PJnpxS8vDypPg4GE62TH8UzMapVyF2+VBXG6YRkWQT7QHksHzQ3De3MKoZAgf4K90nSNxlXwICIwKI/NBLJcw9tOw92ANUBE/sP2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwWfmWHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492E2C4CEC3;
	Wed, 25 Sep 2024 12:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265960;
	bh=eRuln8e9VHwpZLNjSbN8jXsnIosW8yfjYZ0mOiU/ZO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwWfmWHwFICNvcz/l8Kf2fDQsOcVDmD3GMeZRcUU1Um+0IHlHZwRXoHWCoPCMS38G
	 tN9rgJpm77INQ+eEjRv+YcxpdqyMso49FR3sA4bbvQWU+354m3RBHYsG6l7GiUAgkW
	 OBM+V5xMWKOpHvuk/S6r5Evx8X9QrOBs7lsypcAaC3JJGNZvpYo+b9diqpWvZ5nTig
	 2vUfzxP0MDMgXCxakUQts6q7xhqwt09cDF6a2YpQj75aAR9lUUq20UpYzhg0d8WMfR
	 sbVgPVB51jIURMX15CMyi5ctq5Mk/FQS9wzw7JIXq0wYC3gFcNPr6bdiwLWwy0NecZ
	 g4MpqyjCzV++A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mwen@igalia.com,
	joshua@froggi.es,
	marek.olsak@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 132/197] drm/amd/display: Add null check for 'afb' in amdgpu_dm_plane_handle_cursor_update (v2)
Date: Wed, 25 Sep 2024 07:52:31 -0400
Message-ID: <20240925115823.1303019-132-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit cd9e9e0852d501f169aa3bb34e4b413d2eb48c37 ]

This commit adds a null check for the 'afb' variable in the
amdgpu_dm_plane_handle_cursor_update function. Previously, 'afb' was
assumed to be null, but was used later in the code without a null check.
This could potentially lead to a null pointer dereference.

Changes since v1:
- Moved the null check for 'afb' to the line where 'afb' is used. (Alex)

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1298 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1252)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Co-developed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 7d47acdd11d55..fe7a99aee47dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1285,7 +1285,8 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 	    adev->dm.dc->caps.color.dpp.gamma_corr)
 		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
 
-	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
+	if (afb)
+		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {
 		mutex_lock(&adev->dm.dc_lock);
-- 
2.43.0


