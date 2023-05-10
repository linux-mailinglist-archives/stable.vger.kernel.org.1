Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5986FDA22
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjEJI4D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbjEJIz7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 04:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AAA13D
        for <stable@vger.kernel.org>; Wed, 10 May 2023 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683708912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HCG1W7/c7Lgz8PoTuKyRX8o/yyWCNKZTf6kZON4C85I=;
        b=Qynk8JgvNRJluryEdSvtrHwD8xtqz78r91NPFfxrmivoZanYiuarmjlUdNWdDkzc2+cIId
        Lq69Enw7Jp+Dhn8v5P019XUpbXecO7y41Xe1cK/iGURLc9gw6QSOTRTIjNn+BYV1AcqXYm
        m3kzao/VM2v2qvb81MEcrWj/DoaVljM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-RPSucRMDPE-yIll5M7TzOw-1; Wed, 10 May 2023 04:55:09 -0400
X-MC-Unique: RPSucRMDPE-yIll5M7TzOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25595868C96;
        Wed, 10 May 2023 08:55:09 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1554C15BA0;
        Wed, 10 May 2023 08:55:07 +0000 (UTC)
From:   Jocelyn Falempe <jfalempe@redhat.com>
To:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        airlied@redhat.com, javierm@redhat.com, lyude@redhat.com
Cc:     stable@vger.kernel.org, Jocelyn Falempe <jfalempe@redhat.com>,
        Phil Oester <kernel@linuxace.com>
Subject: [PATCH] drm/mgag200: Fix gamma lut not initialized.
Date:   Wed, 10 May 2023 10:54:51 +0200
Message-Id: <20230510085451.226546-1-jfalempe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When mgag200 switched from simple KMS to regular atomic helpers,
the initialization of the gamma settings was lost.
This leads to a black screen, if the bios/uefi doesn't use the same
pixel color depth.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2171155
Fixes: 1baf9127c482 ("drm/mgag200: Replace simple-KMS with regular atomic helpers")
Tested-by: Phil Oester <kernel@linuxace.com>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 461da1409fdf..911d46741e40 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -819,6 +819,11 @@ static void mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 	else if (mdev->type == G200_EV)
 		mgag200_g200ev_set_hiprilvl(mdev);
 
+	if (crtc_state->gamma_lut)
+		mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut->data);
+	else
+		mgag200_crtc_set_gamma_linear(mdev, format);
+
 	mgag200_enable_display(mdev);
 
 	if (mdev->type == G200_WB || mdev->type == G200_EW3)

base-commit: 1baf9127c482a3a58aef81d92ae751798e2db202
-- 
2.39.2

