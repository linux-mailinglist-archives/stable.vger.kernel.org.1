Return-Path: <stable+bounces-163963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B768B0DC85
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F43B16A101
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAF288C01;
	Tue, 22 Jul 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vym7pX7j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3628B7C2;
	Tue, 22 Jul 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192792; cv=none; b=aaIWUN7eOf+vkOsCu5PEPpS57uZ09ewnjYtp8qkx5atMn1VXn9Yj6s4awSafv7+6wsZhJCgIPyfOAu8iSrYnaVkuwU2E3A8IwT2fBo5ZZuW6ftwrC6xhBhg8dFQHNH0di1LrGT2pXv8W6FagFBTawygC8uKiL/jI3CelwRX8Bl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192792; c=relaxed/simple;
	bh=aJXp+5bl6uMJnK5+5twbt7dSRtpr4LyIC5QO3g4Gs90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnFOn8lKGbD1v32Mje9FrDBJtrHDtw3C3aHUvdhqAdUqRcFSEb6eLI+MF4Mz3qAaPxZ5iNLFLY123+SNA4C6DodDhR+2txUgVGMdmFRcrJYhmEuwWhvj6DS41s+MNQQdD++LKvNMGKrtMDwdCnaJnPJS20Rd1YV+ISUnDdJqHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vym7pX7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762DEC4CEEB;
	Tue, 22 Jul 2025 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192791;
	bh=aJXp+5bl6uMJnK5+5twbt7dSRtpr4LyIC5QO3g4Gs90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vym7pX7jKqaoe84hN7rk2P+GoD5og6M8FJk3foGBocnK0NLvXG6mascQnuKvzMuJ7
	 llH9zPyrsWYv+digAkOjqJ/3CZ3GNYJfH6qqH0Z8Rm7oYWQq5d2CxrOhihbQk64uq2
	 p9wlmHG/7PT4nkGwMdLLqsxex3WPFUV1UojSj8AU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harry Wentland <harry.wentland@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 031/158] drm/amd/display: Disable CRTC degamma LUT for DCN401
Date: Tue, 22 Jul 2025 15:43:35 +0200
Message-ID: <20250722134341.906841900@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Melissa Wen <mwen@igalia.com>

commit 97a0f2b5f4d4afcec34376e4428e157ce95efa71 upstream.

In DCN401 pre-blending degamma LUT isn't affecting cursor as in previous
DCN version. As this is not the behavior close to what is expected for
CRTC degamma LUT, disable CRTC degamma LUT property in this HW.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4176
---

When enabling HDR on KDE, it takes the first CRTC 1D LUT available and
apply a color transformation (Gamma 2.2 -> PQ). AMD driver usually
advertises a CRTC degamma LUT as the first CRTC 1D LUT, but it's
actually applied pre-blending. In previous HW version, it seems to work
fine because the 1D LUT was applied to cursor too, but DCN401 presents a
different behavior and the 1D LUT isn't affecting the hardware cursor.

To address the wrong gamma on cursor with HDR (see the link), I came up
with this patch that disables CRTC degamma LUT in this hw, since it
presents a different behavior than others. With this KDE sees CRTC
regamma LUT as the first post-blending 1D LUT available. This is
actually more consistent with AMD color pipeline. It was tested by the
reporter, since I don't have the HW available for local testing and
debugging.

Melissa
---

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 340231cdceec2c45995d773a358ca3c341f151aa)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -731,7 +731,16 @@ int amdgpu_dm_crtc_init(struct amdgpu_di
 	 * support programmable degamma anywhere.
 	 */
 	is_dcn = dm->adev->dm.dc->caps.color.dpp.dcn_arch;
-	drm_crtc_enable_color_mgmt(&acrtc->base, is_dcn ? MAX_COLOR_LUT_ENTRIES : 0,
+	/* Dont't enable DRM CRTC degamma property for DCN401 since the
+	 * pre-blending degamma LUT doesn't apply to cursor, and therefore
+	 * can't work similar to a post-blending degamma LUT as in other hw
+	 * versions.
+	 * TODO: revisit it once KMS plane color API is merged.
+	 */
+	drm_crtc_enable_color_mgmt(&acrtc->base,
+				   (is_dcn &&
+				    dm->adev->dm.dc->ctx->dce_version != DCN_VERSION_4_01) ?
+				     MAX_COLOR_LUT_ENTRIES : 0,
 				   true, MAX_COLOR_LUT_ENTRIES);
 
 	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);



