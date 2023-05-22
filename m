Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E65A70C6FB
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjEVTYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjEVTYf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041679C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BFDE62879
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A29C433D2;
        Mon, 22 May 2023 19:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783474;
        bh=kY9ROL/ajKrc6AW3nYuqoAAPqXA3n3Uo3N7sV13DZbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2pAq9uNjHqgfk6RCaXugO6yoPRobT5GV45Fj7w2TSvnwcP1H+HSXB0+QGfJ7ChqW
         F3orekX7OGK93VC0UA7Di8aHQtLZHP3c/lvIr13KZdZWzp9jIsmzgXGePD1OtxwbLk
         u4/uP8LAVAphtYQRLvCrqj40RP2wuTd5s+UyZezk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 027/292] drm/i915: Fix NULL ptr deref by checking new_crtc_state
Date:   Mon, 22 May 2023 20:06:24 +0100
Message-Id: <20230522190406.572404616@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>

[ Upstream commit a41d985902c153c31c616fe183cf2ee331e95ecb ]

intel_atomic_get_new_crtc_state can return NULL, unless crtc state wasn't
obtained previously with intel_atomic_get_crtc_state, so we must check it
for NULLness here, just as in many other places, where we can't guarantee
that intel_atomic_get_crtc_state was called.
We are currently getting NULL ptr deref because of that, so this fix was
confirmed to help.

Fixes: 74a75dc90869 ("drm/i915/display: move plane prepare/cleanup to intel_atomic_plane.c")
Signed-off-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230505082212.27089-1-stanislav.lisovskiy@intel.com
(cherry picked from commit 1d5b09f8daf859247a1ea65b0d732a24d88980d8)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_atomic_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index aaa6708256d58..82826454b5e83 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -988,7 +988,7 @@ intel_prepare_plane_fb(struct drm_plane *_plane,
 	int ret;
 
 	if (old_obj) {
-		const struct intel_crtc_state *crtc_state =
+		const struct intel_crtc_state *new_crtc_state =
 			intel_atomic_get_new_crtc_state(state,
 							to_intel_crtc(old_plane_state->hw.crtc));
 
@@ -1003,7 +1003,7 @@ intel_prepare_plane_fb(struct drm_plane *_plane,
 		 * This should only fail upon a hung GPU, in which case we
 		 * can safely continue.
 		 */
-		if (intel_crtc_needs_modeset(crtc_state)) {
+		if (new_crtc_state && intel_crtc_needs_modeset(new_crtc_state)) {
 			ret = i915_sw_fence_await_reservation(&state->commit_ready,
 							      old_obj->base.resv, NULL,
 							      false, 0,
-- 
2.39.2



