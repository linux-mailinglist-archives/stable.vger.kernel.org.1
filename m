Return-Path: <stable+bounces-282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD457F762B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA9A1C20E71
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71012C842;
	Fri, 24 Nov 2023 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hS4beowp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99928E25
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DD8C43391;
	Fri, 24 Nov 2023 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835484;
	bh=P7ah2SEcB69VqvAbg6J5YuwoPvjVwWhstmcu+bnSQSw=;
	h=Subject:To:Cc:From:Date:From;
	b=hS4beowpWbPSUrUC2K52QsYwyRgrEIwQFAGy7ACiTFyRnEPVJaVDq4Ev4Ajeytaw+
	 Fj1aotJGXjBtJvM7K2anXCEw/fH6lQhJqqoVZOav4uI/hcx4MRQRPdyCAlUHMYOQC2
	 KUbubW1bQWbuY5rpy+hGSLwQPDn2RdMIPXVitf8s=
Subject: FAILED: patch "[PATCH] drm/amd/display: enable cursor degamma for DCN3+ DRM legacy" failed to apply to 5.15-stable tree
To: mwen@igalia.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:17:57 +0000
Message-ID: <2023112457-suspend-washday-4688@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fabd2165d11649ecca5012d786a62ac149e9d83f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112457-suspend-washday-4688@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

fabd2165d116 ("drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma")
5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
60693e3a3890 ("Merge tag 'amd-drm-next-5.20-2022-07-14' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")

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


