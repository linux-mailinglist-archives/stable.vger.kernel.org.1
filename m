Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0357038CB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbjEORfL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbjEORef (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:34:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7593C113
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5408462D66
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EDDC433D2;
        Mon, 15 May 2023 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171962;
        bh=DQTFi7TedA6iTe6JJbJbgFoeyjFPNHvsE9lED+6tYX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mr1Kj0NJ3TbIssznmbxMGHMXUNM19pr9v2K85mortQJgd688mSVL5AcXsERlVfAkP
         4rFzmiT839kmzvRvjGyY3CubKweUgZJjPXNVbzfDnb818aWs20v/fjj9CgYBYVLfl1
         ye9NP5YVjJrUEy0c/LaZO9gb3sKcT6V2AhTSkgRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 134/134] drm/amd/display: Fix hang when skipping modeset
Date:   Mon, 15 May 2023 18:30:11 +0200
Message-Id: <20230515161707.640968423@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

commit da5e14909776edea4462672fb4a3007802d262e7 upstream.

[Why&How]

When skipping full modeset since the only state change was a front porch
change, the DC commit sequence requires extra checks to handle non
existant plane states being asked to be removed from context.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    5 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |    3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9020,6 +9020,8 @@ static void amdgpu_dm_commit_planes(stru
 			continue;
 
 		dc_plane = dm_new_plane_state->dc_state;
+		if (!dc_plane)
+			continue;
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -10550,8 +10552,9 @@ static int dm_update_plane_state(struct
 			return -EINVAL;
 		}
 
+		if (dm_old_plane_state->dc_state)
+			dc_plane_state_release(dm_old_plane_state->dc_state);
 
-		dc_plane_state_release(dm_old_plane_state->dc_state);
 		dm_new_plane_state->dc_state = NULL;
 
 		*lock_and_validation_needed = true;
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1434,6 +1434,9 @@ bool dc_remove_plane_from_context(
 	struct dc_stream_status *stream_status = NULL;
 	struct resource_pool *pool = dc->res_pool;
 
+	if (!plane_state)
+		return true;
+
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			stream_status = &context->stream_status[i];


