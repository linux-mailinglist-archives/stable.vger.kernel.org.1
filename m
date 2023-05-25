Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41460710C6E
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjEYMxV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjEYMxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 08:53:19 -0400
X-Greylist: delayed 2362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 05:53:17 PDT
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC32183
        for <stable@vger.kernel.org>; Thu, 25 May 2023 05:53:17 -0700 (PDT)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <hverkuil@linuxtv.org>)
        id 1q29qr-009ZxV-S3; Thu, 25 May 2023 12:13:53 +0000
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Thu, 25 May 2023 12:13:05 +0000
Subject: [git:media_stage/master] media: uapi: Fix [GS]_ROUTING ACTIVE flag value
To:     linuxtv-commits@linuxtv.org
Cc:     stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1q29qr-009ZxV-S3@www.linuxtv.org>
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

Subject: media: uapi: Fix [GS]_ROUTING ACTIVE flag value
Author:  Sakari Ailus <sakari.ailus@linux.intel.com>
Date:    Mon Apr 24 15:22:37 2023 +0300

The value of the V4L2_SUBDEV_ROUTE_FL_ACTIVE is 1, not 0. Use hexadecimal
numbers as is done elsewhere in the documentation.

Cc: stable@vger.kernel.org # for >= v6.3
Fixes: ea73eda50813 ("media: Documentation: Add GS_ROUTING documentation")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
index 68ca343c3b44..2d6e3bbdd040 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
@@ -122,7 +122,7 @@ for all the route entries and call ``VIDIOC_SUBDEV_G_ROUTING`` again.
     :widths:       3 1 4
 
     * - V4L2_SUBDEV_ROUTE_FL_ACTIVE
-      - 0
+      - 0x0001
       - The route is enabled. Set by applications.
 
 Return Value
