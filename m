Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101879BC29
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379536AbjIKWol (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240767AbjIKOxP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE0118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC94C433C8;
        Mon, 11 Sep 2023 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443990;
        bh=nuKnp3XMouWCOLXG/1fm5e0L62d02s8Rqgj1VlMKj18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q10kklsT17ouDaRRED5slPE/PGSA8BrJW6ab1Ijz326ozKQ/J2Sq3xkESJZYS2FM5
         QJoVVg/URSScwGYFDaKn4ukHDtBXeQVP4L4qTs1HAQZ/Wu/42NSErwU9L7xQe9+ky9
         oLbPP1KPBidcbWD0WP7qMc7iPeqv3hbPlQzVeUzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rui Miguel Silva <rmfrfs@gmail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 571/737] media: ov2680: Fix ov2680_set_fmt() which == V4L2_SUBDEV_FORMAT_TRY not working
Date:   Mon, 11 Sep 2023 15:47:10 +0200
Message-ID: <20230911134706.490396575@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit c0e97a4b4f20639f74cd5809b42ba6cbf9736a7d ]

ov2680_set_fmt() which == V4L2_SUBDEV_FORMAT_TRY was getting
the try_fmt v4l2_mbus_framefmt struct from the passed in sd_state
and then storing the contents of that into the return by reference
format->format struct.

While the right thing to do would be filling format->format based on
the just looked up mode and then store the results of that in
sd_state->pads[0].try_fmt .

Before the previous change introducing ov2680_fill_format() this
resulted in ov2680_set_fmt() which == V4L2_SUBDEV_FORMAT_TRY always
returning the zero-ed out sd_state->pads[0].try_fmt in format->format
breaking callers using this.

After the introduction of ov2680_fill_format() which at least
initializes sd_state->pads[0].try_fmt properly, format->format
is now always being filled with the default 800x600 mode set by
ov2680_init_cfg() independent of the actual requested mode.

Move the filling of format->format with ov2680_fill_format() to
before the if (which == V4L2_SUBDEV_FORMAT_TRY) and then store
the filled in format->format in sd_state->pads[0].try_fmt to
fix this.

Note this removes the fmt local variable because IMHO having a local
variable which points to a sub-struct of one of the function arguments
just leads to confusion when reading the code.

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2680.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 6e0e8d21d189f..a24344ef9852c 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -603,7 +603,6 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_format *format)
 {
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
-	struct v4l2_mbus_framefmt *fmt = &format->format;
 	struct v4l2_mbus_framefmt *try_fmt;
 	const struct ov2680_mode_info *mode;
 	int ret = 0;
@@ -612,14 +611,18 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 		return -EINVAL;
 
 	mode = v4l2_find_nearest_size(ov2680_mode_data,
-				      ARRAY_SIZE(ov2680_mode_data), width,
-				      height, fmt->width, fmt->height);
+				      ARRAY_SIZE(ov2680_mode_data),
+				      width, height,
+				      format->format.width,
+				      format->format.height);
 	if (!mode)
 		return -EINVAL;
 
+	ov2680_fill_format(sensor, &format->format, mode->width, mode->height);
+
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
 		try_fmt = v4l2_subdev_get_try_format(sd, sd_state, 0);
-		format->format = *try_fmt;
+		*try_fmt = format->format;
 		return 0;
 	}
 
@@ -630,8 +633,6 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 		goto unlock;
 	}
 
-	ov2680_fill_format(sensor, fmt, mode->width, mode->height);
-
 	sensor->current_mode = mode;
 	sensor->fmt = format->format;
 	sensor->mode_pending_changes = true;
-- 
2.40.1



