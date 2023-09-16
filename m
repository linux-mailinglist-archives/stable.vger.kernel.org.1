Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19DA7A3004
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjIPMYw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbjIPMYb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:24:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5341B194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:24:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949D2C433CA;
        Sat, 16 Sep 2023 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867066;
        bh=hgYJ6RumKYcy/LlSXor7/JSvvXeivr9fPZlUUQIWhXI=;
        h=Subject:To:Cc:From:Date:From;
        b=KGA5PTr6lzOYHfNxu5dHcrFkix0uXQffsXpmZwIHfzdWSKnuvQzSNv9aaDtZoVdeW
         u49v7LxcZlW5wa2fU7hbcm0aoNynbFrCmvmmWpQe6wYNTsGYiedJ9yfKIP6AG4g3A/
         PlWN0l6HuuquRmK0oE5Pwh1hA3yUoz74OuDbWwr8=
Subject: FAILED: patch "[PATCH] drm/amd/display: enable cursor degamma for DCN3+ DRM legacy" failed to apply to 5.10-stable tree
To:     mwen@igalia.com, alexander.deucher@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:24:22 +0200
Message-ID: <2023091622-outpost-audio-2222@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 57a943ebfcdb4a97fbb409640234bdb44bfa1953
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091622-outpost-audio-2222@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

57a943ebfcdb ("drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma")
5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes")
60693e3a3890 ("Merge tag 'amd-drm-next-5.20-2022-07-14' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57a943ebfcdb4a97fbb409640234bdb44bfa1953 Mon Sep 17 00:00:00 2001
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
index 2198df96ed6f..cc74dd69acf2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1269,6 +1269,13 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
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

