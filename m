Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F997615AB
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjGYLby (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjGYLbx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:31:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ECE1BF8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B24961648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B6CC433C8;
        Tue, 25 Jul 2023 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284701;
        bh=HA+TQA2cEr1s+l1vq12SXAI1JBKaUUibcFMqZA6W9h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYOdrzn1cXAox+kUF6dCTUfUl+iczt3scYd46xYxWiXJI9M5QBFX3zK2fnWgwP2UN
         Jg8nhWFJY6hOoEn0DQZeOTuWcSenPyYjszLRFZRJyx4UwWX10TM4tz7qylCaQ9zLJw
         Run+U+PRd9yUcaB8wpzUqcvIjI0/f2pHW0byIqOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Yi <yizhan@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5.10 451/509] drm/client: Fix memory leak in drm_client_target_cloned
Date:   Tue, 25 Jul 2023 12:46:30 +0200
Message-ID: <20230725104614.388889529@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jocelyn Falempe <jfalempe@redhat.com>

commit c2a88e8bdf5f6239948d75283d0ae7e0c7945b03 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_client_modeset.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -308,6 +308,9 @@ static bool drm_client_target_cloned(str
 	can_clone = true;
 	dmt_mode = drm_mode_find_dmt(dev, 1024, 768, 60, false);
 
+	if (!dmt_mode)
+		goto fail;
+
 	for (i = 0; i < connector_count; i++) {
 		if (!enabled[i])
 			continue;
@@ -323,11 +326,13 @@ static bool drm_client_target_cloned(str
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


