Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF32703AC6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbjEORzY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbjEORzC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E842659B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE85C62F77
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9EC433D2;
        Mon, 15 May 2023 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173178;
        bh=EAhqY54xVuv/AzRcxMobKGeeZIMQy3G4RrmuBodxlYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVIZANZ2D1qkYqu58JNivi80O1W/hTGmwi8Vc8/wZgE+Y7pRkI/g5HKB5/dgOCRWA
         +R9QpbCBFPwYzzY/iBFDhdzpTi7nndqVO+zdlnbLHAvrxwoRhCaFEyR7PcSjZ8xK65
         0E7oCS7of4bq8ybm/KJ4udATFBFtbcOAJ83252d4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+20dcf81733d43ddff661@syzkaller.appspotmail.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 5.4 003/282] drm/fb-helper: set x/yres_virtual in drm_fb_helper_check_var
Date:   Mon, 15 May 2023 18:26:21 +0200
Message-Id: <20230515161722.263543624@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit 1935f0deb6116dd785ea64d8035eab0ff441255b upstream.

Drivers are supposed to fix this up if needed if they don't outright
reject it. Uncovered by 6c11df58fd1a ("fbmem: Check virtual screen
sizes in fb_set_var()").

Reported-by: syzbot+20dcf81733d43ddff661@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=c5faf983bfa4a607de530cd3bb008888bf06cefc
Cc: stable@vger.kernel.org # v5.4+
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230404194038.472803-1-daniel.vetter@ffwll.ch
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_fb_helper.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1340,6 +1340,9 @@ int drm_fb_helper_check_var(struct fb_va
 		return -EINVAL;
 	}
 
+	var->xres_virtual = fb->width;
+	var->yres_virtual = fb->height;
+
 	/*
 	 * Workaround for SDL 1.2, which is known to be setting all pixel format
 	 * fields values to zero in some cases. We treat this situation as a


