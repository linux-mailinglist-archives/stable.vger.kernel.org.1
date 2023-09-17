Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FFE7A3845
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbjIQTdu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbjIQTdU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:33:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C2DD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:33:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82E2C433C8;
        Sun, 17 Sep 2023 19:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979194;
        bh=7U6QlSPgJSNCpp/L1NJJB3NlLFXv0lKl42mAJp0FSUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzajB2cu54yCwj0M6N+D/oL+lSO6aHuTkPp/EC1hsmk4S3UimKWgHGpKpxilqGCnt
         iBfpRN3yL2pjkTQQRDNWMMLmc8Vv8E3PpUh713FADq2OkW2MA3DajpNKRUHAbgauqi
         X31ZA/O4MqJQYPiBBVR6a6SZRbPlVn1+n5o92R88=
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
Subject: [PATCH 5.10 241/406] media: ov2680: Fix ov2680_bayer_order()
Date:   Sun, 17 Sep 2023 21:11:35 +0200
Message-ID: <20230917191107.525980384@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 50a7bad4e0a37d7018ab6fe843dd84bc6b2ecf72 ]

The index into ov2680_hv_flip_bayer_order[] should be 0-3, but
ov2680_bayer_order() was using 0 + BIT(2) + (BIT(2) << 1) as
max index, while the intention was to use: 0 + 1 + 2 as max index.

Fix the index calculation in ov2680_bayer_order(), while at it
also just use the ctrl values rather then reading them back using
a slow i2c-read transaction.

This also allows making the function void, since there now are
no more i2c-reads to error check.

Note the check for the ctrls being NULL is there to allow
adding an ov2680_fill_format() helper later, which will call
ov2680_set_bayer_order() during probe() before the ctrls are created.

[Sakari Ailus: Change all users of ov2680_set_bayer_order() here]

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2680.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index f143e2af0b5fc..a4baf440b9505 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -315,26 +315,17 @@ static void ov2680_power_down(struct ov2680_dev *sensor)
 	usleep_range(5000, 10000);
 }
 
-static int ov2680_bayer_order(struct ov2680_dev *sensor)
+static void ov2680_set_bayer_order(struct ov2680_dev *sensor)
 {
-	u32 format1;
-	u32 format2;
-	u32 hv_flip;
-	int ret;
-
-	ret = ov2680_read_reg(sensor, OV2680_REG_FORMAT1, &format1);
-	if (ret < 0)
-		return ret;
+	int hv_flip = 0;
 
-	ret = ov2680_read_reg(sensor, OV2680_REG_FORMAT2, &format2);
-	if (ret < 0)
-		return ret;
+	if (sensor->ctrls.vflip && sensor->ctrls.vflip->val)
+		hv_flip += 1;
 
-	hv_flip = (format2 & BIT(2)  << 1) | (format1 & BIT(2));
+	if (sensor->ctrls.hflip && sensor->ctrls.hflip->val)
+		hv_flip += 2;
 
 	sensor->fmt.code = ov2680_hv_flip_bayer_order[hv_flip];
-
-	return 0;
 }
 
 static int ov2680_vflip_enable(struct ov2680_dev *sensor)
@@ -345,7 +336,8 @@ static int ov2680_vflip_enable(struct ov2680_dev *sensor)
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor);
+	return 0;
 }
 
 static int ov2680_vflip_disable(struct ov2680_dev *sensor)
@@ -356,7 +348,8 @@ static int ov2680_vflip_disable(struct ov2680_dev *sensor)
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor);
+	return 0;
 }
 
 static int ov2680_hflip_enable(struct ov2680_dev *sensor)
@@ -367,7 +360,8 @@ static int ov2680_hflip_enable(struct ov2680_dev *sensor)
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor);
+	return 0;
 }
 
 static int ov2680_hflip_disable(struct ov2680_dev *sensor)
@@ -378,7 +372,8 @@ static int ov2680_hflip_disable(struct ov2680_dev *sensor)
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor);
+	return 0;
 }
 
 static int ov2680_test_pattern_set(struct ov2680_dev *sensor, int value)
-- 
2.40.1



