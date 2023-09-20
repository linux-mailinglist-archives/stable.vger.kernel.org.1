Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499DF7A800F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjITMcg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjITMcf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:32:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27E683
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:32:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61A7C433C7;
        Wed, 20 Sep 2023 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213149;
        bh=poBfh8ows3/w05oTbwPrTtm5YixnDXbP9bks+NafMvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGKM2QTgEXV1VPQsGaXprWjb3Bc67Ezv0hghk98suoUPn5dyJtJzT88YSWsHkyPCr
         IuzUGJnLIifH0vNfkue1CV6zpKUynsdBBZ7Oo6oMVvBk8irPlmQYTw4Y66MAaV7VWk
         z6GgwVto35cUpJUqhF9NgFYHmrx2+rc2JANvP5TQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Marek Vasut <marex@denx.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 5.4 178/367] media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()
Date:   Wed, 20 Sep 2023 13:29:15 +0200
Message-ID: <20230920112903.244111665@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 76a9fa6d6d5c0..2e5a49e87a74c 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1927,9 +1927,9 @@ static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
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



