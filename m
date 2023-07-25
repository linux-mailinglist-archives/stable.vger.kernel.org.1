Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D67617EE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 14:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjGYMEC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjGYMEB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 08:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309810D1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690286593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vG11tYddVStl9fWky+0e8mFH6mTq54FEmvzLA0/vBJA=;
        b=iimFI3ubIFjgFC7OYh9tGxNggJV1SLaiiNGKxaTZg11mlhj6thE6HKHGJE6KUIzuvQQvmj
        r+jJiqqZMSs2HwycNY0QB0sDoPq/XVRZegFGgJoDSd3WyeulzRG36Zph7l77wtsmZcwaMC
        OySLstLontftDw4ZS6AhtfbQho7C7z0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-dpCzUzPqOsuZbq345uwEVg-1; Tue, 25 Jul 2023 08:03:09 -0400
X-MC-Unique: dpCzUzPqOsuZbq345uwEVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BDA310504AC;
        Tue, 25 Jul 2023 12:03:09 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27A64200B66C;
        Tue, 25 Jul 2023 12:03:08 +0000 (UTC)
From:   Jocelyn Falempe <jfalempe@redhat.com>
To:     stable@vger.kernel.org
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        Zhang Yi <yizhan@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4.19.y] drm/client: Fix memory leak in drm_client_target_cloned
Date:   Tue, 25 Jul 2023 14:02:54 +0200
Message-ID: <20230725120302.89913-1-jfalempe@redhat.com>
In-Reply-To: <2023072326-snuff-obnoxious-af01@gregkh>
References: <2023072326-snuff-obnoxious-af01@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
(cherry picked from commit c2a88e8bdf5f6239948d75283d0ae7e0c7945b03)
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index fbe9156c9e7c..ee6801fa36ad 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2233,6 +2233,9 @@ static bool drm_target_cloned(struct drm_fb_helper *fb_helper,
 	can_clone = true;
 	dmt_mode = drm_mode_find_dmt(fb_helper->dev, 1024, 768, 60, false);
 
+	if (!dmt_mode)
+		goto fail;
+
 	drm_fb_helper_for_each_connector(fb_helper, i) {
 		if (!enabled[i])
 			continue;
@@ -2249,11 +2252,13 @@ static bool drm_target_cloned(struct drm_fb_helper *fb_helper,
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
-- 
2.41.0

