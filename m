Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C553775BA8
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjHILTl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjHILTl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71267FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 098F4631C8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188F6C433C7;
        Wed,  9 Aug 2023 11:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579979;
        bh=nJOjsIaWQNSLUBI//4GF7vEBGQWqYszLFbqD/6J6too=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l77HRU0C03+jKcBdZOWNe35mhDckBPoSFaVRlcaTT97Lji0eid7k5fyeg1DIMeQ8t
         s6UHrk+aTlaFbLW0TrUeiyNtO6ENJLON+zMJSiEBgDJg7qcrUnV37kFDmXHVpkdu6c
         DMCQKYDOcz14ZKNoqaVlNbMrVLK4F5pEqh5D5tp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, shanzhulig <shanzhulig@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, stable@kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 185/323] drm/atomic: Fix potential use-after-free in nonblocking commits
Date:   Wed,  9 Aug 2023 12:40:23 +0200
Message-ID: <20230809103706.636719097@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit 4e076c73e4f6e90816b30fcd4a0d7ab365087255 upstream.

This requires a bit of background.  Properly done a modeset driver's
unload/remove sequence should be

	drm_dev_unplug();
	drm_atomic_helper_shutdown();
	drm_dev_put();

The trouble is that the drm_dev_unplugged() checks are by design racy,
they do not synchronize against all outstanding ioctl.  This is because
those ioctl could block forever (both for modeset and for driver
specific ioctls), leading to deadlocks in hotunplug.  Instead the code
sections that touch the hardware need to be annotated with
drm_dev_enter/exit, to avoid accessing hardware resources after the
unload/remove has finished.

To avoid use-after-free issues all the involved userspace visible
objects are supposed to hold a reference on the underlying drm_device,
like drm_file does.

The issue now is that we missed one, the atomic modeset ioctl can be run
in a nonblocking fashion, and in that case it cannot rely on the implied
drm_device reference provided by the ioctl calling context.  This can
result in a use-after-free if an nonblocking atomic commit is carefully
raced against a driver unload.

Fix this by unconditionally grabbing a drm_device reference for any
drm_atomic_state structures.  Strictly speaking this isn't required for
blocking commits and TEST_ONLY calls, but it's the simpler approach.

Thanks to shanzhulig for the initial idea of grabbing an unconditional
reference, I just added comments, a condensed commit message and fixed a
minor potential issue in where exactly we drop the final reference.

Reported-by: shanzhulig <shanzhulig@gmail.com>
Suggested-by: shanzhulig <shanzhulig@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: stable@kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_atomic.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -91,6 +91,12 @@ drm_atomic_state_init(struct drm_device
 	if (!state->planes)
 		goto fail;
 
+	/*
+	 * Because drm_atomic_state can be committed asynchronously we need our
+	 * own reference and cannot rely on the on implied by drm_file in the
+	 * ioctl call.
+	 */
+	drm_dev_get(dev);
 	state->dev = dev;
 
 	DRM_DEBUG_ATOMIC("Allocated atomic state %p\n", state);
@@ -250,7 +256,8 @@ EXPORT_SYMBOL(drm_atomic_state_clear);
 void __drm_atomic_state_free(struct kref *ref)
 {
 	struct drm_atomic_state *state = container_of(ref, typeof(*state), ref);
-	struct drm_mode_config *config = &state->dev->mode_config;
+	struct drm_device *dev = state->dev;
+	struct drm_mode_config *config = &dev->mode_config;
 
 	drm_atomic_state_clear(state);
 
@@ -262,6 +269,8 @@ void __drm_atomic_state_free(struct kref
 		drm_atomic_state_default_release(state);
 		kfree(state);
 	}
+
+	drm_dev_put(dev);
 }
 EXPORT_SYMBOL(__drm_atomic_state_free);
 


