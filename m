Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5206FDE41
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjEJNLc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEJNLb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 09:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B53AA5
        for <stable@vger.kernel.org>; Wed, 10 May 2023 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683724244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UHxAFQIDmQk24+hfydTl2nNLMKHgY1PL6AIvHQifj7M=;
        b=ifLUK5g+dRsg9VznWrELx5rJ7wBdWwlTdFSxIJUgAJqTI6WaS5U3/YollXw0rOqgTDlNoi
        7d2jkAcJEkKzhvhNRFOzWiihwKEjwJ22GZKUCuYUg3sYHC1AX6G9sDzkothUWuVgdS+TIA
        neLuc/cGSBGXYlq9lL9XijFmx+dD1Xc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-loDSBWmZNY2vPPgOs5uyfg-1; Wed, 10 May 2023 09:10:40 -0400
X-MC-Unique: loDSBWmZNY2vPPgOs5uyfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26BC080C8CE;
        Wed, 10 May 2023 13:10:40 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAA7C2026DFD;
        Wed, 10 May 2023 13:10:38 +0000 (UTC)
From:   Jocelyn Falempe <jfalempe@redhat.com>
To:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        airlied@redhat.com, javierm@redhat.com, lyude@redhat.com
Cc:     stable@vger.kernel.org, Jocelyn Falempe <jfalempe@redhat.com>,
        Phil Oester <kernel@linuxace.com>
Subject: [PATCH v2] drm/mgag200: Fix gamma lut not initialized.
Date:   Wed, 10 May 2023 15:10:34 +0200
Message-Id: <20230510131034.284078-1-jfalempe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

v2: rebase on top of drm-misc-fixes, and add Cc stable tag.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2171155
Fixes: 1baf9127c482 ("drm/mgag200: Replace simple-KMS with regular atomic helpers")
Cc: <stable@vger.kernel.org>
Tested-by: Phil Oester <kernel@linuxace.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 0a5aaf78172a..576c4c838a33 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -640,6 +640,11 @@ void mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_
 	if (funcs->pixpllc_atomic_update)
 		funcs->pixpllc_atomic_update(crtc, old_state);
 
+	if (crtc_state->gamma_lut)
+		mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut->data);
+	else
+		mgag200_crtc_set_gamma_linear(mdev, format);
+
 	mgag200_enable_display(mdev);
 
 	if (funcs->enable_vidrst)

base-commit: a26cc2934331b57b5a7164bff344f0a2ec245fc0
-- 
2.39.2

