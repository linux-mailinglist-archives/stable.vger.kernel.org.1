Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC875E243
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjGWOEl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWOEk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6112B
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE3F60D33
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49545C433C8;
        Sun, 23 Jul 2023 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690121078;
        bh=d2RBSXdpPuDQ7V4wXDYBVmKqcYYUMlP3tC739x4LTb4=;
        h=Subject:To:Cc:From:Date:From;
        b=wMh1a+PAZdnasUzrh5CERsFp9cpmEVSvV7oqOgvFXeQbCcyQcqqv3cX8WqzCyh9oo
         UYlZEtfMj8a6tOFN6bQV8w5exAPKnlb4X0nJD0S/mknCI18LjVfzlKyK28/SVUGk5/
         yE3X3I5BRv0KtbDdJh4jooEJ8mijdQbZp4E+gU7c=
Subject: FAILED: patch "[PATCH] drm/client: Fix memory leak in drm_client_target_cloned" failed to apply to 4.14-stable tree
To:     jfalempe@redhat.com, javierm@redhat.com, stable@vger.kernel.org,
        tzimmermann@suse.de, yizhan@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:04:27 +0200
Message-ID: <2023072327-repost-magma-4171@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x c2a88e8bdf5f6239948d75283d0ae7e0c7945b03
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072327-repost-magma-4171@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

c2a88e8bdf5f ("drm/client: Fix memory leak in drm_client_target_cloned")
cf13909aee05 ("drm/fb-helper: Move out modeset config code")
aafa9e066872 ("drm/fb-helper: Prepare to move out modeset config code")
e5852bee90d6 ("drm/fb-helper: Remove drm_fb_helper_connector")
aec3925f093d ("drm/fb-helper: Move out commit code")
eade2a17ddc5 ("drm/fb-helper: Prepare to move out commit code")
d81294afeecd ("drm/fb-helper: Remove drm_fb_helper_crtc")
4672b1d65fc9 ("Merge remote-tracking branch 'drm/drm-next' into drm-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2a88e8bdf5f6239948d75283d0ae7e0c7945b03 Mon Sep 17 00:00:00 2001
From: Jocelyn Falempe <jfalempe@redhat.com>
Date: Tue, 11 Jul 2023 11:20:43 +0200
Subject: [PATCH] drm/client: Fix memory leak in drm_client_target_cloned

dmt_mode is allocated and never freed in this function.
It was found with the ast driver, but most drivers using generic fbdev
setup are probably affected.

This fixes the following kmemleak report:
  backtrace:
    [<00000000b391296d>] drm_mode_duplicate+0x45/0x220 [drm]
    [<00000000e45bb5b3>] drm_client_target_cloned.constprop.0+0x27b/0x480 [drm]
    [<00000000ed2d3a37>] drm_client_modeset_probe+0x6bd/0xf50 [drm]
    [<0000000010e5cc9d>] __drm_fb_helper_initial_config_and_unlock+0xb4/0x2c0 [drm_kms_helper]
    [<00000000909f82ca>] drm_fbdev_client_hotplug+0x2bc/0x4d0 [drm_kms_helper]
    [<00000000063a69aa>] drm_client_register+0x169/0x240 [drm]
    [<00000000a8c61525>] ast_pci_probe+0x142/0x190 [ast]
    [<00000000987f19bb>] local_pci_probe+0xdc/0x180
    [<000000004fca231b>] work_for_cpu_fn+0x4e/0xa0
    [<0000000000b85301>] process_one_work+0x8b7/0x1540
    [<000000003375b17c>] worker_thread+0x70a/0xed0
    [<00000000b0d43cd9>] kthread+0x29f/0x340
    [<000000008d770833>] ret_from_fork+0x1f/0x30
unreferenced object 0xff11000333089a00 (size 128):

cc: <stable@vger.kernel.org>
Fixes: 1d42bbc8f7f9 ("drm/fbdev: fix cloning on fbcon")
Reported-by: Zhang Yi <yizhan@redhat.com>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230711092203.68157-2-jfalempe@redhat.com

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 1b12a3c201a3..a4a62aa99984 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -311,6 +311,9 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 	can_clone = true;
 	dmt_mode = drm_mode_find_dmt(dev, 1024, 768, 60, false);
 
+	if (!dmt_mode)
+		goto fail;
+
 	for (i = 0; i < connector_count; i++) {
 		if (!enabled[i])
 			continue;
@@ -326,11 +329,13 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 		if (!modes[i])
 			can_clone = false;
 	}
+	kfree(dmt_mode);
 
 	if (can_clone) {
 		DRM_DEBUG_KMS("can clone using 1024x768\n");
 		return true;
 	}
+fail:
 	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
 	return false;
 }

