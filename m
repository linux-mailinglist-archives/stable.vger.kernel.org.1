Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35BE7ED297
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjKOUmo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjKOTZv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79774A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE480C433C8;
        Wed, 15 Nov 2023 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076348;
        bh=lpRVATMmhFJzsBNY09ymxEVciDUHGfLBGUhHIuFCAdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xoaxG5Oxl5HMTG4q0OF8Qj3siYxNLJPlEHovofChTfh46yVtSEiUZsHsY3JT5ZlbW
         /STiCDOFo2BFkLpA4oVZzO9nuA4qaW5BJZsBogGG+qWH+2TeH5AaopCECLhGP8askn
         y/nOPMO/skCGe3mg7XVJUKxnOMLq/OjhVm6nh45s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 235/550] drm/amd/display: Check all enabled planes in dm_check_crtc_cursor
Date:   Wed, 15 Nov 2023 14:13:39 -0500
Message-ID: <20231115191616.998559280@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <mdaenzer@redhat.com>

[ Upstream commit 003048ddf44b1a6cfa57afa5a0cf40673e13f1ba ]

It was only checking planes which had any state changes in the same
commit. However, it also needs to check other enabled planes.

Not doing this meant that a commit might spuriously "succeed", resulting
in the cursor plane displaying with incorrect scaling. See
https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3177#note_1824263
for an example.

Fixes: d1bfbe8a3202 ("amd/display: check cursor plane matches underlying plane")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 83d670f0d199b..ee9eb7350b7fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9874,14 +9874,24 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	 * blending properties match the underlying planes'.
 	 */
 
-	new_cursor_state = drm_atomic_get_new_plane_state(state, cursor);
-	if (!new_cursor_state || !new_cursor_state->fb)
+	new_cursor_state = drm_atomic_get_plane_state(state, cursor);
+	if (IS_ERR(new_cursor_state))
+		return PTR_ERR(new_cursor_state);
+
+	if (!new_cursor_state->fb)
 		return 0;
 
 	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
 	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
 	cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
 
+	/* Need to check all enabled planes, even if this commit doesn't change
+	 * their state
+	 */
+	i = drm_atomic_add_affected_planes(state, crtc);
+	if (i)
+		return i;
+
 	for_each_new_plane_in_state_reverse(state, underlying, new_underlying_state, i) {
 		/* Narrow down to non-cursor planes on the same CRTC as the cursor */
 		if (new_underlying_state->crtc != crtc || underlying == crtc->cursor)
-- 
2.42.0



