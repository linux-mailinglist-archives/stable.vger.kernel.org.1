Return-Path: <stable+bounces-279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8927F7628
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F8AB21345
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1CE2C866;
	Fri, 24 Nov 2023 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/74532Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF82C1AE
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D2EC433C7;
	Fri, 24 Nov 2023 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835476;
	bh=F7kB71zpQ45Rk0KcIMp84S35d+S25A4d76HqZlrKNJI=;
	h=Subject:To:Cc:From:Date:From;
	b=B/74532QHblQ/L2nqOsP+l+2xwk34iJCwzrgGPMmnzSajxAUpTbiOGN9YFvGTvzCn
	 4ClkUh3FyjbfItquzVdx+lnximOSvZk2tFRf23bLEgf3hleCzuOBq0aWBS5v/RIjCd
	 u855MTGBDq9XfN36VrwTPY/9mnuoZCT4eAx5io/k=
Subject: FAILED: patch "[PATCH] drm/amd/display: enable cursor degamma for DCN3+ DRM legacy" failed to apply to 6.6-stable tree
To: mwen@igalia.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:17:54 +0000
Message-ID: <2023112453-implicate-dimly-d0a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fabd2165d11649ecca5012d786a62ac149e9d83f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112453-implicate-dimly-d0a5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

fabd2165d116 ("drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fabd2165d11649ecca5012d786a62ac149e9d83f Mon Sep 17 00:00:00 2001
From: Melissa Wen <mwen@igalia.com>
Date: Thu, 31 Aug 2023 15:12:28 -0100
Subject: [PATCH] drm/amd/display: enable cursor degamma for DCN3+ DRM legacy
 gamma

For DRM legacy gamma, AMD display manager applies implicit sRGB degamma
using a pre-defined sRGB transfer function. It works fine for DCN2
family where degamma ROM and custom curves go to the same color block.
But, on DCN3+, degamma is split into two blocks: degamma ROM for
pre-defined TFs and `gamma correction` for user/custom curves and
degamma ROM settings doesn't apply to cursor plane. To get DRM legacy
gamma working as expected, enable cursor degamma ROM for implict sRGB
degamma on HW with this configuration.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2803
Fixes: 96b020e2163f ("drm/amd/display: check attr flag before set cursor degamma on DCN3+")
Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index df568a7cd005..b97cbc4e5477 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1270,6 +1270,13 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 	attributes.rotation_angle    = 0;
 	attributes.attribute_flags.value = 0;
 
+	/* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
+	 * legacy gamma setup.
+	 */
+	if (crtc_state->cm_is_degamma_srgb &&
+	    adev->dm.dc->caps.color.dpp.gamma_corr)
+		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
+
 	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {


