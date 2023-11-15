Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E47ECE58
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjKOTmb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjKOTm3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853AD1A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FB5C433CB;
        Wed, 15 Nov 2023 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077346;
        bh=t+fNQsicTuzOWKLDMU14nGQZZsNmDvjFjfEYnu+4FDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLGUWhvbfkh969glB4T7JLCxoerCKHnz98zL2ibYfyQBS7jPjkNJont+LGGE/sCy8
         DhptToFW71Z/KF4JSNsG2+cvr0D8C1wJJB9aam5Oph6xW8UBN1xpRs3Yx+Pcul1b/z
         W1WAjIuQMotvkVQFuOfy4Ghiy0mxKp1NMch5dNvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 246/603] drm/amd/display: Check all enabled planes in dm_check_crtc_cursor
Date:   Wed, 15 Nov 2023 14:13:11 -0500
Message-ID: <20231115191630.263131637@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 4120ae9d10248..342988f52d960 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9908,14 +9908,24 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
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



