Return-Path: <stable+bounces-3842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93150802EC8
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40C91C209DD
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C730C1A726;
	Mon,  4 Dec 2023 09:38:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F05B2
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 01:38:19 -0800 (PST)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rA5P7-00AJUd-EU; Mon, 04 Dec 2023 09:38:17 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 04 Dec 2023 09:37:47 +0000
Subject: [git:media_stage/master] media: i2c: st-mipid02: correct format propagation
To: linuxtv-commits@linuxtv.org
Cc: Benjamin Mugnier <benjamin.mugnier@foss.st.com>, Daniel Scally <dan.scally@ideasonboard.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Alain Volmat <alain.volmat@foss.st.com>, stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rA5P7-00AJUd-EU@www.linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: i2c: st-mipid02: correct format propagation
Author:  Alain Volmat <alain.volmat@foss.st.com>
Date:    Mon Nov 13 15:57:30 2023 +0100

Use a copy of the struct v4l2_subdev_format when propagating
format from the sink to source pad in order to avoid impacting the
sink format returned to the application.

Thanks to Jacopo Mondi for pointing the issue.

Fixes: 6c01e6f3f27b ("media: st-mipid02: Propagate format from sink to source pad")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/st-mipid02.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

---

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index b08a249b5fdd..914f915749a8 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -769,6 +769,7 @@ static void mipid02_set_fmt_sink(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_format *format)
 {
 	struct mipid02_dev *bridge = to_mipid02_dev(sd);
+	struct v4l2_subdev_format source_fmt;
 	struct v4l2_mbus_framefmt *fmt;
 
 	format->format.code = get_fmt_code(format->format.code);
@@ -780,8 +781,12 @@ static void mipid02_set_fmt_sink(struct v4l2_subdev *sd,
 
 	*fmt = format->format;
 
-	/* Propagate the format change to the source pad */
-	mipid02_set_fmt_source(sd, sd_state, format);
+	/*
+	 * Propagate the format change to the source pad, taking
+	 * care not to update the format pointer given back to user
+	 */
+	source_fmt = *format;
+	mipid02_set_fmt_source(sd, sd_state, &source_fmt);
 }
 
 static int mipid02_set_fmt(struct v4l2_subdev *sd,

