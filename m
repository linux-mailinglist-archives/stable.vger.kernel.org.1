Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2774EA75
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGKJ1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjGKJ13 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 05:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04AA173D
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689067356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/u4T1zwnXS+bjfa4i0LilWpC/Ws3/1Pt2HUfiUuVACM=;
        b=L7ghQzBNwqhsXrTl6o4M1Tx6IfDoGolyIkSesvTfFtWqjnzXElEMFL1vphpGH3ttgFlYrf
        UDijLOSPmT8QHvSMbQWMj+sToJ57dwRZ0mGN8JWb5NeStmEpiqX7R8d7ed0uNwiXKZ92U2
        A6W6wUhT/9vv6Ktqy6ZK/LddnpiD+ls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-KqtcJWnyMSGuIYg-B_pMZQ-1; Tue, 11 Jul 2023 05:22:35 -0400
X-MC-Unique: KqtcJWnyMSGuIYg-B_pMZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF2798037BA;
        Tue, 11 Jul 2023 09:22:34 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.192.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7A1EC09A09;
        Tue, 11 Jul 2023 09:22:33 +0000 (UTC)
From:   Jocelyn Falempe <jfalempe@redhat.com>
To:     tzimmermann@suse.de, airlied@redhat.com, javierm@redhat.com,
        yizhan@redhat.com
Cc:     dri-devel@lists.freedesktop.org,
        Jocelyn Falempe <jfalempe@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] drm/client: Fix memory leak in drm_client_modeset_probe
Date:   Tue, 11 Jul 2023 11:20:44 +0200
Message-ID: <20230711092203.68157-3-jfalempe@redhat.com>
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

When a new mode is set to modeset->mode, the previous mode should be freed.
This fixes the following kmemleak report:

drm_mode_duplicate+0x45/0x220 [drm]
drm_client_modeset_probe+0x944/0xf50 [drm]
__drm_fb_helper_initial_config_and_unlock+0xb4/0x2c0 [drm_kms_helper]
drm_fbdev_client_hotplug+0x2bc/0x4d0 [drm_kms_helper]
drm_client_register+0x169/0x240 [drm]
ast_pci_probe+0x142/0x190 [ast]
local_pci_probe+0xdc/0x180
work_for_cpu_fn+0x4e/0xa0
process_one_work+0x8b7/0x1540
worker_thread+0x70a/0xed0
kthread+0x29f/0x340
ret_from_fork+0x1f/0x30

cc: <stable@vger.kernel.org>
Reported-by: Zhang Yi <yizhan@redhat.com>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_client_modeset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index a4a62aa99984..5d4703b4648a 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -867,6 +867,9 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 				break;
 			}
 
+			if (modeset->mode)
+				kfree(modeset->mode);
+				
 			modeset->mode = drm_mode_duplicate(dev, mode);
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
-- 
2.41.0

