Return-Path: <stable+bounces-151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07547F73F4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30434B212A9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691415AEB;
	Fri, 24 Nov 2023 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YU8N+1UQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40C250F6
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B3C433C9;
	Fri, 24 Nov 2023 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700829653;
	bh=NAPdcFYiIPyxbc3akI6KPu8ytZM2lUWsg/NhUiT13d8=;
	h=Subject:To:Cc:From:Date:From;
	b=YU8N+1UQmzU8vpgDi84y4brac2as48muhJx7nJnwj0KtoeGkS5IInhOJIQTtYcY8e
	 ye1xHkMAEkDe6975Ba6X9kH69raHcvBt2ipnecY4aqdb//1vVKyCfjaik8TeoflBCs
	 VoSXq6PL56J7r9jXfJa7/krTBjOFRHRrxbL29gYw=
Subject: FAILED: patch "[PATCH] media: ccs: Correctly initialise try compose rectangle" failed to apply to 4.19-stable tree
To: sakari.ailus@linux.intel.com,hverkuil-cisco@xs4all.nl,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 12:40:33 +0000
Message-ID: <2023112433-prolonged-crank-6bc0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 724ff68e968b19d786870d333f9952bdd6b119cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112433-prolonged-crank-6bc0@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

724ff68e968b ("media: ccs: Correctly initialise try compose rectangle")
b24cc2a18c50 ("media: smiapp: Rename as "ccs"")
161cc847370a ("media: smiapp: Internal rename to CCS")
47ff2ff267ee ("media: smiapp: Rename register access functions")
235ac9a4b36c ("media: smiapp: Remove quirk function for writing a single 8-bit register")
42aab58f456a ("media: smiapp: Use CCS registers")
3e158e1f1ec2 ("media: smiapp: Switch to CCS limits")
ca296a11156a ("media: smiapp: Read CCS limit values")
503a88422fb0 ("media: smiapp: Use MIPI CCS version and manufacturer ID information")
e66a7c849086 ("media: smiapp: Add macros for accessing CCS registers")
cb50351be662 ("media: smiapp: Remove macros for defining registers, merge definitions")
ab47d5cd8253 ("media: smiapp: Calculate CCS limit offsets and limit buffer size")
82731a194fc1 ("media: smiapp: Use CCS register flags")
6493c4b777c2 ("media: smiapp: Import CCS definitions")
1ec0b899c2b7 ("media: ccs: Add the generator for CCS register definitions and limits")
b5783c4d1fbe ("media: i2c: smiapp: simplify getting state container")
1771e9fb67e2 ("media: Use fallthrough pseudo-keyword")
a98f670e41a9 ("Merge tag 'media/v5.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 724ff68e968b19d786870d333f9952bdd6b119cb Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Mon, 4 Sep 2023 15:57:37 +0300
Subject: [PATCH] media: ccs: Correctly initialise try compose rectangle

Initialise the try sink compose rectangle size to the sink compose
rectangle for binner and scaler sub-devices. This was missed due to the
faulty condition that lead to the compose rectangles to be initialised for
the pixel array sub-device where it is not relevant.

Fixes: ccfc97bdb5ae ("[media] smiapp: Add driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

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


