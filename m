Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225AC713C26
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjE1TF1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjE1TF0 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEEE90
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC4E6160D
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC0FC433EF;
        Sun, 28 May 2023 19:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300724;
        bh=OCPdDMEqdLKGSQfExm0pq8gYLM9/wNAQgckLmfjacBM=;
        h=Subject:To:From:Date:From;
        b=TA7B8rLISk/DL5JZp1b57cJsPA8tRn0Vw26KbsZ+iBXcJZZQF4XEsZ+pYkqtlT7Ef
         vrSXCVe7eDNzVeHBr+x7EEfJksyuKqAQSziCZcrwKyuA1Y9YFvWwfzZrX+sOyhACB8
         9klX897Yuqn3/1qFAQMjj2nZjjLU4pufSbUwNtSA=
Subject: patch "iio: dac: mcp4725: Fix i2c_master_send() return value handling" added to char-misc-linus
To:     marex@denx.de, Jonathan.Cameron@huawei.com, Stable@vger.kernel.org,
        u.kleine-koenig@pengutronix.de
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:43 +0100
Message-ID: <2023052843-scope-resemble-8105@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: dac: mcp4725: Fix i2c_master_send() return value handling

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 09d3bec7009186bdba77039df01e5834788b3f95 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Thu, 11 May 2023 02:43:30 +0200
Subject: iio: dac: mcp4725: Fix i2c_master_send() return value handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The i2c_master_send() returns number of sent bytes on success,
or negative on error. The suspend/resume callbacks expect zero
on success and non-zero on error. Adapt the return value of the
i2c_master_send() to the expectation of the suspend and resume
callbacks, including proper validation of the return value.

Fixes: cf35ad61aca2 ("iio: add mcp4725 I2C DAC driver")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230511004330.206942-1-marex@denx.de
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/mcp4725.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 46bf758760f8..3f5661a3718f 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -47,12 +47,18 @@ static int mcp4725_suspend(struct device *dev)
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = (data->powerdown_mode + 1) << 4;
 	outbuf[1] = 0;
 	data->powerdown = true;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	return 0;
 }
 
 static int mcp4725_resume(struct device *dev)
@@ -60,13 +66,19 @@ static int mcp4725_resume(struct device *dev)
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	u8 outbuf[2];
+	int ret;
 
 	/* restore previous DAC value */
 	outbuf[0] = (data->dac_value >> 8) & 0xf;
 	outbuf[1] = data->dac_value & 0xff;
 	data->powerdown = false;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	return 0;
 }
 static DEFINE_SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend,
 				mcp4725_resume);
-- 
2.40.1


