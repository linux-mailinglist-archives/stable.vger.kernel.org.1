Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C6726E7A
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjFGUut (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjFGUuW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF226B3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A729C646CA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E1AC433EF;
        Wed,  7 Jun 2023 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171013;
        bh=TioVpWTIMZ3lovXqix+AuORzxm9tsqxRhU0kzNkH7KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WA9KAke1QGu1kWzWLGxX5TCW2QZ/9GcHHOiuvODPd07TUb28X2NC3THuw7IGACu4z
         E7cSBvBe/81sE9nbB7qr9ymK7PB3RNVjXFzOe1bRIZMrITCTdorMP44FOWDsXcFdNq
         604dCqLiFUKi9JBgpYMRThoSjAOlEvASTr1kk4DE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 078/120] iio: dac: mcp4725: Fix i2c_master_send() return value handling
Date:   Wed,  7 Jun 2023 22:16:34 +0200
Message-ID: <20230607200903.358624096@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marex@denx.de>

commit 09d3bec7009186bdba77039df01e5834788b3f95 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/mcp4725.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -47,12 +47,18 @@ static int __maybe_unused mcp4725_suspen
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
 
 static int __maybe_unused mcp4725_resume(struct device *dev)
@@ -60,13 +66,19 @@ static int __maybe_unused mcp4725_resume
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
 static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
 


