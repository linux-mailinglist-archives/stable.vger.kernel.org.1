Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF71B7667C6
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 10:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjG1Ix0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjG1Iwv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 04:52:51 -0400
X-Greylist: delayed 1204 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 01:51:12 PDT
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A10B26A0
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 01:51:12 -0700 (PDT)
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1qPIsM-006AbI-Hk; Fri, 28 Jul 2023 08:31:06 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Fri, 28 Jul 2023 08:20:10 +0000
Subject: [git:media_stage/fixes] media: uvcvideo: Fix menu count handling for userspace XU mappings
To:     linuxtv-commits@linuxtv.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qPIsM-006AbI-Hk@www.linuxtv.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: uvcvideo: Fix menu count handling for userspace XU mappings
Author:  Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:    Tue Jun 6 18:55:30 2023 +0200

When commit 716c330433e3 ("media: uvcvideo: Use standard names for
menus") reworked the handling of menu controls, it inadvertently
replaced a GENMASK(n - 1, 0) with a BIT_MASK(n). The latter isn't
equivalent to the former, which broke adding XU mappings from userspace.
Fix it.

Link: https://lore.kernel.org/linux-media/468a36ec-c3ac-cb47-e12f-5906239ae3cd@spahan.ch/

Cc: stable@vger.kernel.org
Reported-by: Poncho <poncho@spahan.ch>
Fixes: 716c330433e3 ("media: uvcvideo: Use standard names for menus")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

 drivers/media/usb/uvc/uvc_v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 5ac2a424b13d..f4988f03640a 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -45,7 +45,7 @@ static int uvc_control_add_xu_mapping(struct uvc_video_chain *chain,
 	map->menu_names = NULL;
 	map->menu_mapping = NULL;
 
-	map->menu_mask = BIT_MASK(xmap->menu_count);
+	map->menu_mask = GENMASK(xmap->menu_count - 1, 0);
 
 	size = xmap->menu_count * sizeof(*map->menu_mapping);
 	map->menu_mapping = kzalloc(size, GFP_KERNEL);
