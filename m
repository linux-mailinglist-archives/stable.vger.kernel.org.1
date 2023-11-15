Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF147ED29A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjKOUmp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjKOTZx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D11AD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE05C433C8;
        Wed, 15 Nov 2023 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076349;
        bh=2XaxAVuEpcYFy8k8igQ6sFgVEekwLHVtlvTOoAcdXhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Elqb9UIbZbeMN+rO65VO73sHdflRKH0zMzkM4j6PO2Ztz2e5M6O5DyjJ+ETtH2+KS
         5mxya9G8Nd2I8JENafiMhNBV2aZjcNU+Fp7VbfYjs+i/y1Llzl+KCvh+BSg1pl4Zbh
         A7VVdCg5VYsPY950tO41sI5/CeXq2wPmbvMx0c7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 236/550] drm/amd/display: Refactor dm_get_plane_scale helper
Date:   Wed, 15 Nov 2023 14:13:40 -0500
Message-ID: <20231115191617.063838191@linuxfoundation.org>
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

[ Upstream commit ec4d770bbb155674c2497f255f4199bdc42287a9 ]

Cleanup, no functional change intended.

Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: bc0b79ce2050 ("drm/amd/display: Bail from dm_check_crtc_cursor if no relevant change")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ee9eb7350b7fb..e465e9e56e672 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9857,6 +9857,17 @@ static void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 	}
 }
 
+static void
+dm_get_plane_scale(struct drm_plane_state *plane_state,
+		   int *out_plane_scale_w, int *out_plane_scale_h)
+{
+	int plane_src_w, plane_src_h;
+
+	dm_get_oriented_plane_size(plane_state, &plane_src_w, &plane_src_h);
+	*out_plane_scale_w = plane_state->crtc_w * 1000 / plane_src_w;
+	*out_plane_scale_h = plane_state->crtc_h * 1000 / plane_src_h;
+}
+
 static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 				struct drm_crtc *crtc,
 				struct drm_crtc_state *new_crtc_state)
@@ -9865,8 +9876,6 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	struct drm_plane_state *new_cursor_state, *new_underlying_state;
 	int i;
 	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
-	int cursor_src_w, cursor_src_h;
-	int underlying_src_w, underlying_src_h;
 
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
@@ -9881,9 +9890,7 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	if (!new_cursor_state->fb)
 		return 0;
 
-	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
-	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
-	cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
+	dm_get_plane_scale(new_cursor_state, &cursor_scale_w, &cursor_scale_h);
 
 	/* Need to check all enabled planes, even if this commit doesn't change
 	 * their state
@@ -9901,10 +9908,8 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 		if (!new_underlying_state->fb)
 			continue;
 
-		dm_get_oriented_plane_size(new_underlying_state,
-					   &underlying_src_w, &underlying_src_h);
-		underlying_scale_w = new_underlying_state->crtc_w * 1000 / underlying_src_w;
-		underlying_scale_h = new_underlying_state->crtc_h * 1000 / underlying_src_h;
+		dm_get_plane_scale(new_underlying_state,
+				   &underlying_scale_w, &underlying_scale_h);
 
 		if (cursor_scale_w != underlying_scale_w ||
 		    cursor_scale_h != underlying_scale_h) {
-- 
2.42.0



