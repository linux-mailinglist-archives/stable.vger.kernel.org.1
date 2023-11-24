Return-Path: <stable+bounces-1865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E47F7F81B8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A01C282FAB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29033418B;
	Fri, 24 Nov 2023 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qjqkKsAq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DB2C87B;
	Fri, 24 Nov 2023 19:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72299C433C8;
	Fri, 24 Nov 2023 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852463;
	bh=/XClqxgxt73ztuUqNGLsBVD+1VqrWaCR6MfFZ+rHqgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjqkKsAqxWaPhT2kOpW+NPaMveMP/M063wf45DUBVjfhVaj4VIUhVyClRL+3V0Tu6
	 uiaxALOfmyoCTaHPUY9dwu0I+Kab9tGSysYcCgbl26yXExe7ExW25ItVpQPt2WAaQF
	 4bOEaCVyRkjh6t/mUzv9oJZpAxePu+tciJ3SPVY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tianci Yin <tianci.yin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1 367/372] drm/amd/display: Enable fast plane updates on DCN3.2 and above
Date: Fri, 24 Nov 2023 17:52:34 +0000
Message-ID: <20231124172022.501169494@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tianci Yin <tianci.yin@amd.com>

commit 435f5b369657cffee4b04db1f5805b48599f4dbe upstream.

[WHY]
When cursor moves across screen boarder, lag cursor observed,
since subvp settings need to sync up with vblank that causes
cursor updates being delayed.

[HOW]
Enable fast plane updates on DCN3.2 to fix it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tianci Yin <tianci.yin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9285,14 +9285,14 @@ static bool should_reset_plane(struct dr
 	struct drm_plane *other;
 	struct drm_plane_state *old_other_state, *new_other_state;
 	struct drm_crtc_state *new_crtc_state;
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	int i;
 
 	/*
-	 * TODO: Remove this hack once the checks below are sufficient
-	 * enough to determine when we need to reset all the planes on
-	 * the stream.
+	 * TODO: Remove this hack for all asics once it proves that the
+	 * fast updates works fine on DCN3.2+.
 	 */
-	if (state->allow_modeset)
+	if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->allow_modeset)
 		return true;
 
 	/* Exit early if we know that we're adding or removing the plane. */



