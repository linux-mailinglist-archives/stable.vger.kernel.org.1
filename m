Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958B37C5457
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjJKMxS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjJKMxS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 08:53:18 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1A798
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 05:53:16 -0700 (PDT)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <hverkuil@linuxtv.org>)
        id 1qqYi4-00CUav-H9; Wed, 11 Oct 2023 12:53:08 +0000
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Wed, 11 Oct 2023 12:52:57 +0000
Subject: [git:media_stage/fixes] media: subdev: Don't report V4L2_SUBDEV_CAP_STREAMS when the streams API is disabled
To:     linuxtv-commits@linuxtv.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qqYi4-00CUav-H9@www.linuxtv.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: subdev: Don't report V4L2_SUBDEV_CAP_STREAMS when the streams API is disabled
Author:  Hans de Goede <hdegoede@redhat.com>
Date:    Tue Oct 10 12:24:58 2023 +0200

Since the stream API is still experimental it is currently locked away
behind the internal, default disabled, v4l2_subdev_enable_streams_api flag.

Advertising V4L2_SUBDEV_CAP_STREAMS when the streams API is disabled
confuses userspace. E.g. it causes the following libcamera error:

ERROR SimplePipeline simple.cpp:1497 Failed to reset routes for
  /dev/v4l-subdev1: Inappropriate ioctl for device

Don't report V4L2_SUBDEV_CAP_STREAMS when the streams API is disabled
to avoid problems like this.

Reported-by: Dennis Bonke <admin@dennisbonke.com>
Fixes: 9a6b5bf4c1bb ("media: add V4L2_SUBDEV_CAP_STREAMS")
Cc: stable@vger.kernel.org # for >= 6.3
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/v4l2-core/v4l2-subdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

---

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index b92348ad61f6..31752c06d1f0 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -502,6 +502,13 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 				       V4L2_SUBDEV_CLIENT_CAP_STREAMS;
 	int rval;
 
+	/*
+	 * If the streams API is not enabled, remove V4L2_SUBDEV_CAP_STREAMS.
+	 * Remove this when the API is no longer experimental.
+	 */
+	if (!v4l2_subdev_enable_streams_api)
+		streams_subdev = false;
+
 	switch (cmd) {
 	case VIDIOC_SUBDEV_QUERYCAP: {
 		struct v4l2_subdev_capability *cap = arg;
