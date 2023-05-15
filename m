Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3800470388B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbjEORdF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbjEORcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7328120B1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73EF062D26
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DD6C433D2;
        Mon, 15 May 2023 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171818;
        bh=6bctev+LNjdgklSrPVNVRyazqJmMW3HyfO4Z3Gg8d1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0myDoD3fTRFE4mRyR9LftS/ZC29O3yMNskW2LSI+4yc8Yi3fSyL5fEMIwqJJ0PNp
         Tmn5Vv4V975P/jOsB818Iopa0oEgB9AL5nOMUC2CvujrHrsOXdH0BUCT/mwcREZ8gY
         MtVkIMDLCBNhAH0lmx9hhLZaON4xTLk8qhQ1cJqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roman Li <Roman.Li@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 089/134] drm/amd/display: fix flickering caused by S/G mode
Date:   Mon, 15 May 2023 18:29:26 +0200
Message-Id: <20230515161706.120897336@linuxfoundation.org>
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

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

commit 08da182175db4c7f80850354849d95f2670e8cd9 upstream.

Currently, on a handful of ASICs. We allow the framebuffer for a given
plane to exist in either VRAM or GTT. However, if the plane's new
framebuffer is in a different memory domain than it's previous
framebuffer, flipping between them can cause the screen to flicker. So,
to fix this, don't perform an immediate flip in the aforementioned case.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
Reviewed-by: Roman Li <Roman.Li@amd.com>
Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8944,6 +8944,13 @@ static void amdgpu_dm_commit_cursors(str
 			handle_cursor_update(plane, old_plane_state);
 }
 
+static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
+{
+	struct amdgpu_bo *abo = gem_to_amdgpu_bo(fb->obj[0]);
+
+	return abo->tbo.resource ? abo->tbo.resource->mem_type : 0;
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct dc_state *dc_state,
 				    struct drm_device *dev,
@@ -9064,11 +9071,13 @@ static void amdgpu_dm_commit_planes(stru
 
 		/*
 		 * Only allow immediate flips for fast updates that don't
-		 * change FB pitch, DCC state, rotation or mirroing.
+		 * change memory domain, FB pitch, DCC state, rotation or
+		 * mirroring.
 		 */
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
-			acrtc_state->update_type == UPDATE_TYPE_FAST;
+			acrtc_state->update_type == UPDATE_TYPE_FAST &&
+			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
 		timestamp_ns = ktime_get_ns();
 		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);


