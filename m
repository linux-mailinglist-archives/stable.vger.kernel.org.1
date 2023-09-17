Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1E7A3C4E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbjIQU3Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbjIQU3Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:29:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE12101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:29:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6B0C433C7;
        Sun, 17 Sep 2023 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982551;
        bh=lXK65o1UwZt/AIBUqIG1ajuBzH00GqFYYctCcPx3akM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hM6rEZsFnOaMjk61Ncav0WWJdMh+7QQyfLwTY91pvF/nU9Eorun7WOdjndY4lBxma
         OwHZqbVrUAPVUwmtTmwQz4/ii0tW63CryBQpuhPKn7r/87ABaHJ3oMtkWiYC8fbjx+
         L0N8xSAdio+5W1pWqCCiBwIKM5RdbdPe700Mf9P4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 284/511] media: ov2680: Remove VIDEO_V4L2_SUBDEV_API ifdef-s
Date:   Sun, 17 Sep 2023 21:11:51 +0200
Message-ID: <20230917191120.704962940@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 49c282d5a8c5f4d1d9088622bec792294c716010 ]

VIDEO_V4L2_SUBDEV_API is now automatically selected in Kconfig
for all sensor drivers. Remove the ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
checks.

This is a preparation patch for fixing ov2680_set_fmt()
which == V4L2_SUBDEV_FORMAT_TRY calls not properly filling in
the passed in v4l2_mbus_framefmt struct.

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2680.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index c78ac547ddbc1..2a89deacb6ab1 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -562,7 +562,6 @@ static int ov2680_get_fmt(struct v4l2_subdev *sd,
 {
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
 	struct v4l2_mbus_framefmt *fmt = NULL;
-	int ret = 0;
 
 	if (format->pad != 0)
 		return -EINVAL;
@@ -570,22 +569,17 @@ static int ov2680_get_fmt(struct v4l2_subdev *sd,
 	mutex_lock(&sensor->lock);
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		fmt = v4l2_subdev_get_try_format(&sensor->sd, sd_state,
 						 format->pad);
-#else
-		ret = -EINVAL;
-#endif
 	} else {
 		fmt = &sensor->fmt;
 	}
 
-	if (fmt)
-		format->format = *fmt;
+	format->format = *fmt;
 
 	mutex_unlock(&sensor->lock);
 
-	return ret;
+	return 0;
 }
 
 static int ov2680_set_fmt(struct v4l2_subdev *sd,
@@ -594,9 +588,7 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 {
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
 	struct v4l2_mbus_framefmt *fmt = &format->format;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *try_fmt;
-#endif
 	const struct ov2680_mode_info *mode;
 	int ret = 0;
 
@@ -619,10 +611,8 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 	}
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		try_fmt = v4l2_subdev_get_try_format(sd, sd_state, 0);
 		format->format = *try_fmt;
-#endif
 		goto unlock;
 	}
 
@@ -780,9 +770,7 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 	v4l2_i2c_subdev_init(&sensor->sd, sensor->i2c_client,
 			     &ov2680_subdev_ops);
 
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	sensor->sd.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
-#endif
 	sensor->pad.flags = MEDIA_PAD_FL_SOURCE;
 	sensor->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
 
-- 
2.40.1



