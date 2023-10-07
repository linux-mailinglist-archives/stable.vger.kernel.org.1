Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C199E7BC656
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 11:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343641AbjJGJJw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 05:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343601AbjJGJJv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 05:09:51 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41F1B9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 02:09:49 -0700 (PDT)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <hverkuil@linuxtv.org>)
        id 1qp3Jk-008cxh-18; Sat, 07 Oct 2023 09:09:48 +0000
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Sat, 07 Oct 2023 08:55:47 +0000
Subject: [git:media_stage/master] media: ccs: Correctly initialise try compose rectangle
To:     linuxtv-commits@linuxtv.org
Cc:     stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qp3Jk-008cxh-18@www.linuxtv.org>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ccs: Correctly initialise try compose rectangle
Author:  Sakari Ailus <sakari.ailus@linux.intel.com>
Date:    Mon Sep 4 15:57:37 2023 +0300

Initialise the try sink compose rectangle size to the sink compose
rectangle for binner and scaler sub-devices. This was missed due to the
faulty condition that lead to the compose rectangles to be initialised for
the pixel array sub-device where it is not relevant.

Fixes: ccfc97bdb5ae ("[media] smiapp: Add driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/ccs/ccs-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 6a8116454f87..022e8712d48e 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3097,7 +3097,7 @@ static int ccs_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 		try_fmt->code = sensor->internal_csi_format->code;
 		try_fmt->field = V4L2_FIELD_NONE;
 
-		if (ssd != sensor->pixel_array)
+		if (ssd == sensor->pixel_array)
 			continue;
 
 		try_comp = v4l2_subdev_get_try_compose(sd, fh->state, i);
