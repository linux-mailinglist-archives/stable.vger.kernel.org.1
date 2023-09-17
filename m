Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506647A3C51
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbjIQU3Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbjIQU3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:29:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472D10B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:29:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC5AC433C8;
        Sun, 17 Sep 2023 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982554;
        bh=fzwa2o32IR/LGR0UkT1VVV5Ni2/By8KH6WVPpqiLIzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOmXVLK8pNQ8Xmy028y0o57T527oksu+456L4juyEZLSD2UH5JoOSmLbF5wIbscJG
         oE51WKSnfda+z/HWiCfqT1kXuCoancB7KF5iG6hiK1PSfenXXWaVChQ6XYQ0AjbzgS
         v+j0O7A47GXzG4co9NDRZTiL3ShROLB5q9GOGlNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rui Miguel Silva <rmfrfs@gmail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 285/511] media: ov2680: Dont take the lock for try_fmt calls
Date:   Sun, 17 Sep 2023 21:11:52 +0200
Message-ID: <20230917191120.728676832@linuxfoundation.org>
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

[ Upstream commit e521b9cc1a49de677f4fc65909ce4877fbf7b113 ]

On ov2680_set_fmt() calls with format->which == V4L2_SUBDEV_FORMAT_TRY,
ov2680_set_fmt() does not talk to the sensor.

So in this case there is no need to lock the sensor->lock mutex or
to check that the sensor is streaming.

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2680.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 2a89deacb6ab1..b594943d38862 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -595,24 +595,22 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 	if (format->pad != 0)
 		return -EINVAL;
 
-	mutex_lock(&sensor->lock);
-
-	if (sensor->is_streaming) {
-		ret = -EBUSY;
-		goto unlock;
-	}
-
 	mode = v4l2_find_nearest_size(ov2680_mode_data,
 				      ARRAY_SIZE(ov2680_mode_data), width,
 				      height, fmt->width, fmt->height);
-	if (!mode) {
-		ret = -EINVAL;
-		goto unlock;
-	}
+	if (!mode)
+		return -EINVAL;
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
 		try_fmt = v4l2_subdev_get_try_format(sd, sd_state, 0);
 		format->format = *try_fmt;
+		return 0;
+	}
+
+	mutex_lock(&sensor->lock);
+
+	if (sensor->is_streaming) {
+		ret = -EBUSY;
 		goto unlock;
 	}
 
-- 
2.40.1



