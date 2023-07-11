Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA4374EA74
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 11:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjGKJ1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGKJ11 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 05:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9E8173E
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689067355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGW+sT7a+152xgQrEwMP2d2kUtvMEF/I0+4Rn7iBJoA=;
        b=C6pOkFGyLWHSwIARM80Fr2XCiAFTHvPgSHsiMSYc6k7flW7wljdtUTsrUS/wp09yteOHRd
        ZE6BSk4hs5Q1zfrsdiuIxfUqzmtjZ/zximG5BUdvQ5ux5JlFhKp+cCOMr+4/8bM8LBVfjG
        hcI//+APCc1JYFi2UXUh2lPpxYA+lYw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-R_KIgloEPLS7nnR-hhbzUw-1; Tue, 11 Jul 2023 05:22:33 -0400
X-MC-Unique: R_KIgloEPLS7nnR-hhbzUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65558101A54E;
        Tue, 11 Jul 2023 09:22:33 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.192.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E5F0C09A09;
        Tue, 11 Jul 2023 09:22:31 +0000 (UTC)
From:   Jocelyn Falempe <jfalempe@redhat.com>
To:     tzimmermann@suse.de, airlied@redhat.com, javierm@redhat.com,
        yizhan@redhat.com
Cc:     dri-devel@lists.freedesktop.org,
        Jocelyn Falempe <jfalempe@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] drm/client: Fix memory leak in drm_client_target_cloned
Date:   Tue, 11 Jul 2023 11:20:43 +0200
Message-ID: <20230711092203.68157-2-jfalempe@redhat.com>
In-Reply-To: <20230711092203.68157-1-jfalempe@redhat.com>
References: <20230711092203.68157-1-jfalempe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/gpu/drm/drm_client_modeset.c | 5 +++++
 1 file changed, 5 insertions(+)

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
-- 
2.41.0

