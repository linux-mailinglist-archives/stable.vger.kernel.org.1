Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A500F79B526
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbjIKU52 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbjIKOQx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:16:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56316DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:16:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCC0C433C7;
        Mon, 11 Sep 2023 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441808;
        bh=1zhRHRt17jGjr7rhKQkiRAHj9EaQU9HwC10wAYTK8Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=te6UamnV0xyDPtD7oqL8yrC5qTixrbQQ+SxvuL2Zj13PplfGJ48b0pM0smF0Ozbp2
         8jTFKlQwzCqNsalQ+2mibLW02K/lATNZcjeT/xNnbuBkgKRXTgTBJm7ljbbqEBvFtI
         nvUkp3jfkU5xCcZKYY4PiBVThPmVF77eT8rDcLHA=
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
Subject: [PATCH 6.5 543/739] media: ov2680: Fix vflip / hflip set functions
Date:   Mon, 11 Sep 2023 15:45:42 +0200
Message-ID: <20230911134706.262732319@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit d5d08ad330c9ccebc5e066fda815423a290f48b0 ]

ov2680_vflip_disable() / ov2680_hflip_disable() pass BIT(0) instead of
0 as value to ov2680_mod_reg().

While fixing this also:

1. Stop having separate enable/disable functions for hflip / vflip
2. Move the is_streaming check, which is unique to hflip / vflip
   into the ov2680_set_?flip() functions.

for a nice code cleanup.

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2680.c | 50 +++++++++-----------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 38c8b95f36523..c93810f84ed75 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -328,23 +328,15 @@ static void ov2680_set_bayer_order(struct ov2680_dev *sensor)
 	sensor->fmt.code = ov2680_hv_flip_bayer_order[hv_flip];
 }
 
-static int ov2680_vflip_enable(struct ov2680_dev *sensor)
+static int ov2680_set_vflip(struct ov2680_dev *sensor, s32 val)
 {
 	int ret;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1, BIT(2), BIT(2));
-	if (ret < 0)
-		return ret;
-
-	ov2680_set_bayer_order(sensor);
-	return 0;
-}
-
-static int ov2680_vflip_disable(struct ov2680_dev *sensor)
-{
-	int ret;
+	if (sensor->is_streaming)
+		return -EBUSY;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1, BIT(2), BIT(0));
+	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1,
+			     BIT(2), val ? BIT(2) : 0);
 	if (ret < 0)
 		return ret;
 
@@ -352,23 +344,15 @@ static int ov2680_vflip_disable(struct ov2680_dev *sensor)
 	return 0;
 }
 
-static int ov2680_hflip_enable(struct ov2680_dev *sensor)
+static int ov2680_set_hflip(struct ov2680_dev *sensor, s32 val)
 {
 	int ret;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2, BIT(2), BIT(2));
-	if (ret < 0)
-		return ret;
-
-	ov2680_set_bayer_order(sensor);
-	return 0;
-}
-
-static int ov2680_hflip_disable(struct ov2680_dev *sensor)
-{
-	int ret;
+	if (sensor->is_streaming)
+		return -EBUSY;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2, BIT(2), BIT(0));
+	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2,
+			     BIT(2), val ? BIT(2) : 0);
 	if (ret < 0)
 		return ret;
 
@@ -722,19 +706,9 @@ static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_EXPOSURE:
 		return ov2680_exposure_set(sensor, ctrl->val);
 	case V4L2_CID_VFLIP:
-		if (sensor->is_streaming)
-			return -EBUSY;
-		if (ctrl->val)
-			return ov2680_vflip_enable(sensor);
-		else
-			return ov2680_vflip_disable(sensor);
+		return ov2680_set_vflip(sensor, ctrl->val);
 	case V4L2_CID_HFLIP:
-		if (sensor->is_streaming)
-			return -EBUSY;
-		if (ctrl->val)
-			return ov2680_hflip_enable(sensor);
-		else
-			return ov2680_hflip_disable(sensor);
+		return ov2680_set_hflip(sensor, ctrl->val);
 	case V4L2_CID_TEST_PATTERN:
 		return ov2680_test_pattern_set(sensor, ctrl->val);
 	default:
-- 
2.40.1



