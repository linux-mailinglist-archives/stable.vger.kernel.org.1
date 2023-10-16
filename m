Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECAB7CAC6C
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjJPOya (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjJPOy3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:54:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E52B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:54:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3086C433C8;
        Mon, 16 Oct 2023 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468066;
        bh=gY6GKDxiT2vh/3SpIxeen0gnMRKoi0NRJDE249KNotM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gK+euWgif0nTpA/nG6oJgPYvOtoEtxSeMcbPB1WI4+2KyKLjW50JQnaT8C3+3Xoyl
         VJhisZAW0hIFqiVlEdDl+rsjIpM2D0LC9xR1BR/KM3NnoE30sycICyuVUWXHym4+bN
         TG0RB8gaTC3DBCzdEX/ykZrTnW6SAVvte51tDIEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dennis Bonke <admin@dennisbonke.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.5 119/191] media: subdev: Dont report V4L2_SUBDEV_CAP_STREAMS when the streams API is disabled
Date:   Mon, 16 Oct 2023 10:41:44 +0200
Message-ID: <20231016084018.157397850@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 4800021c630210ea0b19434a1fb56ab16385f2b3 upstream.

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
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-subdev.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -517,6 +517,13 @@ static long subdev_do_ioctl(struct file
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


