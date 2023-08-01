Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B344476AEDB
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjHAJmg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjHAJmX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABDE5B8B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B4861525
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BF4C433C9;
        Tue,  1 Aug 2023 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882796;
        bh=dJwhxcZD/MAAxzrG1zgBMGMBqDn9vvMG+m3IWTMk2HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u46dggobJNnUu47JTvw9brAAs8piTeM+9jtH/J4OJzfTTbz5fV/yggo6mVzIiPOO7
         V0K3QceTJ0k05uxzgwMgPPX+N5dRfAi4yh3diW/QWSw8y0E1SbyBOeLkjtDQcsqj0r
         17G6PVLHj5eF2yMkwMF6l1rv0WdWZSNd7jCA0z1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Fei Yang <fei.yang@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 6.1 212/228] drm/i915/dpt: Use shmem for dpt objects
Date:   Tue,  1 Aug 2023 11:21:10 +0200
Message-ID: <20230801091930.522886608@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Radhakrishna Sripada <radhakrishna.sripada@intel.com>

commit 3844ed5e78823eebb5f0f1edefc403310693d402 upstream.

Dpt objects that are created from internal get evicted when there is
memory pressure and do not get restored when pinned during scanout. The
pinned page table entries look corrupted and programming the display
engine with the incorrect pte's result in DE throwing pipe faults.

Create DPT objects from shmem and mark the object as dirty when pinning so
that the object is restored when shrinker evicts an unpinned buffer object.

v2: Unconditionally mark the dpt objects dirty during pinning(Chris).

Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation for dpt")
Cc: <stable@vger.kernel.org> # v6.0+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Suggested-by: Chris Wilson <chris.p.wilson@intel.com>
Signed-off-by: Fei Yang <fei.yang@intel.com>
Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230718225118.2562132-1-radhakrishna.sripada@intel.com
(cherry picked from commit e91a777a6e602ba0e3366e053e4e094a334a1244)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_dpt.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/intel_dpt.c
+++ b/drivers/gpu/drm/i915/display/intel_dpt.c
@@ -163,6 +163,8 @@ struct i915_vma *intel_dpt_pin(struct i9
 		i915_vma_get(vma);
 	}
 
+	dpt->obj->mm.dirty = true;
+
 	atomic_dec(&i915->gpu_error.pending_fb_pin);
 	intel_runtime_pm_put(&i915->runtime_pm, wakeref);
 
@@ -258,7 +260,7 @@ intel_dpt_create(struct intel_framebuffe
 		dpt_obj = i915_gem_object_create_stolen(i915, size);
 	if (IS_ERR(dpt_obj) && !HAS_LMEM(i915)) {
 		drm_dbg_kms(&i915->drm, "Allocating dpt from smem\n");
-		dpt_obj = i915_gem_object_create_internal(i915, size);
+		dpt_obj = i915_gem_object_create_shmem(i915, size);
 	}
 	if (IS_ERR(dpt_obj))
 		return ERR_CAST(dpt_obj);


