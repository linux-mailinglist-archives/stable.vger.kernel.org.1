Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F418C7ED29B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjKOUmq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjKOTZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C76D5E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B852C433C7;
        Wed, 15 Nov 2023 19:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076351;
        bh=ynVQlHbNvcK0HM5M3fM+dzeiMSEZCtHkuvXQh821lns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKFsnnukYGL7vkvYVWwITNEfwYCTiGQLK6mRdT86ZXqeBegHasgOra2YZb+GIFWio
         gwoBuoP608ecEl/pOknCDNbzWV5/DbOckmPsJT78hg2Pe0pOkMDSvpqeuIyKVHoa/A
         z+mCBlKiNd9xIKbbjiEqBHw2hyOZawRZ0ta80XG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 237/550] drm/amd/display: Bail from dm_check_crtc_cursor if no relevant change
Date:   Wed, 15 Nov 2023 14:13:41 -0500
Message-ID: <20231115191617.137403688@linuxfoundation.org>
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

[ Upstream commit bc0b79ce2050aa523c38c96b6d26340a96bfbdca ]

If no plane was newly enabled or changed scaling, there can be no new
scaling mismatch with the cursor plane.

By not pulling non-cursor plane states into all atomic commits while
the cursor plane is enabled, this avoids synchronizing all cursor plane
changes to vertical blank, which caused the following IGT tests to fail:

kms_cursor_legacy@cursor-vs-flip.*
kms_cursor_legacy@flip-vs-cursor.*

Fixes: 003048ddf44b ("drm/amd/display: Check all enabled planes in dm_check_crtc_cursor")
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e465e9e56e672..573e27399c790 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9872,10 +9872,12 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 				struct drm_crtc *crtc,
 				struct drm_crtc_state *new_crtc_state)
 {
-	struct drm_plane *cursor = crtc->cursor, *underlying;
+	struct drm_plane *cursor = crtc->cursor, *plane, *underlying;
+	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct drm_plane_state *new_cursor_state, *new_underlying_state;
 	int i;
 	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
+	bool any_relevant_change = false;
 
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
@@ -9883,6 +9885,35 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	 * blending properties match the underlying planes'.
 	 */
 
+	/* If no plane was enabled or changed scaling, no need to check again */
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
+		int new_scale_w, new_scale_h, old_scale_w, old_scale_h;
+
+		if (!new_plane_state || !new_plane_state->fb || new_plane_state->crtc != crtc)
+			continue;
+
+		if (!old_plane_state || !old_plane_state->fb || old_plane_state->crtc != crtc) {
+			any_relevant_change = true;
+			break;
+		}
+
+		if (new_plane_state->fb == old_plane_state->fb &&
+		    new_plane_state->crtc_w == old_plane_state->crtc_w &&
+		    new_plane_state->crtc_h == old_plane_state->crtc_h)
+			continue;
+
+		dm_get_plane_scale(new_plane_state, &new_scale_w, &new_scale_h);
+		dm_get_plane_scale(old_plane_state, &old_scale_w, &old_scale_h);
+
+		if (new_scale_w != old_scale_w || new_scale_h != old_scale_h) {
+			any_relevant_change = true;
+			break;
+		}
+	}
+
+	if (!any_relevant_change)
+		return 0;
+
 	new_cursor_state = drm_atomic_get_plane_state(state, cursor);
 	if (IS_ERR(new_cursor_state))
 		return PTR_ERR(new_cursor_state);
-- 
2.42.0



