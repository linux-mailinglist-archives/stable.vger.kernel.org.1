Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698F726BCC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFGU2Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjFGU2Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:28:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329451706
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F310764488
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1084EC4339B;
        Wed,  7 Jun 2023 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169682;
        bh=g+cLRP6mr9VygFT6r+Pyge0IkNSzrys++cPM57EkTJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ka8g46InpyplvMsIHMzBHXqWA/KQ3Sjpkmfs8Mb0Mgtl7zePxv2UxodWYkqGqCeNs
         nKCtZpkQ/Sp86wa92fa85IqXyMGqWT0AnXeO1BZqBckwcvO0mae6jLVGuYuYBbfuLZ
         qGSqcQWTQ23mC6Cmi3tE0pNTj36XGBg50ZPE6StM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 174/286] iio: adc: imx93: fix a signedness bug in imx93_adc_read_raw()
Date:   Wed,  7 Jun 2023 22:14:33 +0200
Message-ID: <20230607200928.806658241@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit 20f291b88ecf23f674ee2ed980a4d93b7f16a06f ]

The problem is these lines:

	ret = vref_uv = regulator_get_voltage(adc->vref);
	if (ret < 0)

The "ret" variable is type long and "vref_uv" is u32 so that means
the condition can never be true on a 64bit system.  A negative error
code from regulator_get_voltage() would be cast to a high positive
u32 value and then remain a high positive value when cast to a long.

The "ret" variable only ever stores ints so it should be declared as
an int.  We can delete the "vref_uv" variable and use "ret" directly.

Fixes: 7d02296ac8b8 ("iio: adc: add imx93 adc support")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/r/Y+utEvjfjQRQo2QB@kili
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/imx93_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index a775d2e405671..dce9ec91e4a77 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -236,8 +236,7 @@ static int imx93_adc_read_raw(struct iio_dev *indio_dev,
 {
 	struct imx93_adc *adc = iio_priv(indio_dev);
 	struct device *dev = adc->dev;
-	long ret;
-	u32 vref_uv;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -253,10 +252,10 @@ static int imx93_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = vref_uv = regulator_get_voltage(adc->vref);
+		ret = regulator_get_voltage(adc->vref);
 		if (ret < 0)
 			return ret;
-		*val = vref_uv / 1000;
+		*val = ret / 1000;
 		*val2 = 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
-- 
2.39.2



