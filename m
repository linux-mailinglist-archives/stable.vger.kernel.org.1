Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1BD7A3C6E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbjIQUbA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbjIQUao (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:30:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BC101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:30:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA15C433C8;
        Sun, 17 Sep 2023 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982639;
        bh=YvC0dr+zu7mAeDNp+ZQoXUQMr5NviGrxytYjW4hinmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4KfvU7MSFhny3QDOPzTY7P1CFqZWFjxX/zi3C0Y+BK4VziSwEWk+0AnnbHnJOxBk
         h0zoFNm3lgpm2y4aHR4POmUMRyBvzGalBug4xAmujmuIfTX1YQ2/GJRUZph78V9yr7
         jbQ0iQtl1I1NIW47h7A0LSdWD6ZqCdoe0NWE5ToU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Marek Vasut <marex@denx.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 5.15 279/511] media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()
Date:   Sun, 17 Sep 2023 21:11:46 +0200
Message-ID: <20230917191120.571367183@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 98cb72d3b9c5e03b10fa993752ecfcbd9c572d8c ]

Set OV5640_REG_IO_MIPI_CTRL00 bit 2 to 1 instead of 0, since 1 means
MIPI CSI2 interface, while 0 means CPI parallel interface.

In the ov5640_set_power_mipi() the interface should obviously be set
to MIPI CSI2 since this functions is used to power up the sensor when
operated in MIPI CSI2 mode. The sensor should not be in CPI mode in
that case.

This fixes a corner case where capturing the first frame on i.MX8MN
with CSI/ISI resulted in corrupted frame.

Fixes: aa4bb8b8838f ("media: ov5640: Re-work MIPI startup sequence")
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Tested-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com> # [Test on imx6q]
Signed-off-by: Marek Vasut <marex@denx.de>
Tested-by: Jai Luthra <j-luthra@ti.com> # [Test on bplay, sk-am62]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index a141552531f7e..13144e87f47a1 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1968,9 +1968,9 @@ static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
 	 *		  "ov5640_set_stream_mipi()")
 	 * [4] = 0	: Power up MIPI HS Tx
 	 * [3] = 0	: Power up MIPI LS Rx
-	 * [2] = 0	: MIPI interface disabled
+	 * [2] = 1	: MIPI interface enabled
 	 */
-	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00, 0x40);
+	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00, 0x44);
 	if (ret)
 		return ret;
 
-- 
2.40.1



