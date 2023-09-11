Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839FD79B186
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353782AbjIKVuK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242137AbjIKPXP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:23:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C6D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:23:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E49C433C7;
        Mon, 11 Sep 2023 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445790;
        bh=zSrzXrN30KyLIpDXCmJGsr4QZXGDL/8WRS5JDnJ7DJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQ4CvFHHTsZeBlyUi5yO2zC0fUA6xfwPB7PjNO8BFMqAmyzV1mMRb98/Qa8UqS2fs
         bHAvj9f6hyjFJllDRcWLvZjd+EuWkHWFCsCKWOd8D1bd3lf/YWPb/S6noMIF49jdRy
         twK+tTIejcv1cdqiPC1QgpFiox6dsyBVuZKp/2D8=
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
Subject: [PATCH 6.1 472/600] media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors
Date:   Mon, 11 Sep 2023 15:48:25 +0200
Message-ID: <20230911134647.578612870@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 84b4bd7e0d98166aa32fd470e672721190492eae ]

When the ov2680_power_on() "sensor soft reset failed" path is hit during
probe() the WARN() about putting an enabled regulator at
drivers/regulator/core.c:2398 triggers 3 times (once for each regulator),
filling dmesg with backtraces.

Fix this by properly disabling the regulators on ov2680_power_on() errors.

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2680.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index a24344ef9852c..8943e4e78a0df 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -475,7 +475,7 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 		ret = ov2680_write_reg(sensor, OV2680_REG_SOFT_RESET, 0x01);
 		if (ret != 0) {
 			dev_err(dev, "sensor soft reset failed\n");
-			return ret;
+			goto err_disable_regulators;
 		}
 		usleep_range(1000, 2000);
 	} else {
@@ -485,7 +485,7 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 
 	ret = clk_prepare_enable(sensor->xvclk);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 
 	sensor->is_enabled = true;
 
@@ -495,6 +495,10 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 	ov2680_stream_disable(sensor);
 
 	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(OV2680_NUM_SUPPLIES, sensor->supplies);
+	return ret;
 }
 
 static int ov2680_s_power(struct v4l2_subdev *sd, int on)
-- 
2.40.1



