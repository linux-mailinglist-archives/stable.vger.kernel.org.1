Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBFA761169
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjGYKuy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjGYKuj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75F1992
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DAA261648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C56AC433C8;
        Tue, 25 Jul 2023 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282221;
        bh=A2NsDGJhvYncPlkfy1iqCzm3eIJM9V36LjMQHQEGnaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0H6p3YU857wl/beZuWJ/UBuyNSWMqhRa01BfGTXLqSvjUCdUCF7gghWTkhqA2rNN
         0vSGX5DvLul3kKBih3H1X+GmhL2jdnIY58DNOFvkHsddzsbZxmRDGDFrKzwIqedORG
         S1oYmQZ83CFSNvBsrPLr2yGbGI50APxQlA7xSA9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Yi <yizhan@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6.4 051/227] drm/client: Fix memory leak in drm_client_modeset_probe
Date:   Tue, 25 Jul 2023 12:43:38 +0200
Message-ID: <20230725104516.903675915@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jocelyn Falempe <jfalempe@redhat.com>

commit 2329cc7a101af1a844fbf706c0724c0baea38365 upstream.

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
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230711092203.68157-3-jfalempe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_client_modeset.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -867,6 +867,7 @@ int drm_client_modeset_probe(struct drm_
 				break;
 			}
 
+			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;


