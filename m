Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3F79BA78
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbjIKVja (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242060AbjIKPVT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:21:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BCFBE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF520C433C8;
        Mon, 11 Sep 2023 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445674;
        bh=PNNCmRNsS5rM1fKdAOOEuTpCfTahaBZ55MTjGKE1jT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVXmC7rfNCT9RFMhqSpMgX6Toq7Ss0dZtRWZmV8HL9Tku3A+R7HJSxmXjs6NAvKOl
         k5R6hNRvRybyRt4ei2NiVMt/oBfr/aIcRiddTuF0Ot1wh5pmPQaR+0et2CmjkpFSL6
         QmIbWCbNAB0v76Nbox+8/8gL7EKoJDDn7LI1W2Nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 424/600] iio: accel: adxl313: Fix adxl313_i2c_id[] table
Date:   Mon, 11 Sep 2023 15:47:37 +0200
Message-ID: <20230911134646.178328149@linuxfoundation.org>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit f636554c4cd1c644109cc525900a056495b86cc9 ]

The .driver_data in adxl313_i2c_id[] for adxl312 and adxl314 is
wrong. Fix this issue by adding corresponding adxl31x_chip_info
data.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/all/20230722172832.04ad7738@jic23-huawei
Fixes: a7a1c60bc4c9 ("drivers: iio: accel: adxl312 and adxl314 support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230725171624.331283-2-biju.das.jz@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/adxl313_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index 99cc7fc294882..68785bd3ef2f0 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -40,8 +40,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
 
 static const struct i2c_device_id adxl313_i2c_id[] = {
 	{ .name = "adxl312", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
-	{ .name = "adxl313", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
-	{ .name = "adxl314", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
+	{ .name = "adxl313", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL313] },
+	{ .name = "adxl314", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL314] },
 	{ }
 };
 
-- 
2.40.1



