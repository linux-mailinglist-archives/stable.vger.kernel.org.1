Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1637B88F9
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbjJDSVX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbjJDSVX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:21:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA21C4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:21:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF0C433C8;
        Wed,  4 Oct 2023 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443678;
        bh=mkyNFu7ZsepOPCL7oQYhRefa4Ncj9xKvHRz+5iI08A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ah1rAmabMAdfsGzJ8N+E4ejRJDTZE28vjofQQtGs49SsN+cyKKOeMIp3YdEIxIlKU
         qD+R1KEk7ADKXu6aHFZRRYtKfrFCjAHGqIq95mufNZlPqPIX+njiQihS6i3LIr3Blt
         2keBxIPZS6GDNX2W+JqvWsgHIPKv0kCzu9wUZFpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Zubin Mithra <zsm@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.1 241/259] media: uvcvideo: Fix OOB read
Date:   Wed,  4 Oct 2023 19:56:54 +0200
Message-ID: <20231004175228.446707038@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

commit 41ebaa5e0eebea4c3bac96b72f9f8ae0d77c0bdb upstream.

If the index provided by the user is bigger than the mask size, we might do
an out of bound read.

CC: stable@kernel.org
Fixes: 40140eda661e ("media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU")
Reported-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1347,6 +1347,9 @@ int uvc_query_v4l2_menu(struct uvc_video
 	query_menu->id = id;
 	query_menu->index = index;
 
+	if (index >= BITS_PER_TYPE(mapping->menu_mask))
+		return -EINVAL;
+
 	ret = mutex_lock_interruptible(&chain->ctrl_mutex);
 	if (ret < 0)
 		return -ERESTARTSYS;


