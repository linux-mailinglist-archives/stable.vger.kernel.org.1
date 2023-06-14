Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F4726BFE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjFGU3u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjFGU3m (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A7F2695
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E98B6644B1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A2FC433EF;
        Wed,  7 Jun 2023 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169763;
        bh=23DUmPYIkKNST7knuRTUhd6sQBqqZMiGD891iBDqaZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9lhzLbq9uRkycaEr19s+xD3VHGLtYuw6FBTGYgHNiUB7Ko/A/3IJ86QRiGayU26j
         eeG12Y9zm6NuYpW4vniLGKoCh5HB+nG+HPwnM7utSnzEBSRUiiQT6RMjG1YSQIeT6F
         BUpsPyQdGTZvdGu1zsHf7FdpD6p4PAMvyIn5uLJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Cercueil <paul@crapouillou.net>,
        Alisa Roman <alisa.roman@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.3 205/286] iio: adc: ad7192: Change "shorted" channels to differential
Date:   Wed,  7 Jun 2023 22:15:04 +0200
Message-ID: <20230607200929.952465058@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit e55245d115bb9054cb72cdd5dda5660f4484873a upstream.

The AD7192 provides a specific channel configuration where both negative
and positive inputs are connected to AIN2. This was represented in the
ad7192 driver as a IIO channel with .channel = 2 and .extended_name set
to "shorted".

The problem with this approach, is that the driver provided two IIO
channels with the identifier .channel = 2; one "shorted" and the other
not. This goes against the IIO ABI, as a channel identifier should be
unique.

Address this issue by changing "shorted" channels to being differential
instead, with channel 2 vs. itself, as we're actually measuring AIN2 vs.
itself.

Note that the fix tag is for the commit that moved the driver out of
staging. The bug existed before that, but backporting would become very
complex further down and unlikely to happen.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Co-developed-by: Alisa Roman <alisa.roman@analog.com>
Signed-off-by: Alisa Roman <alisa.roman@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230330102100.17590-1-paul@crapouillou.net
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7192.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -897,10 +897,6 @@ static const struct iio_info ad7195_info
 	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
 		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
 
-#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
-	__AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
-
 #define AD719x_TEMP_CHANNEL(_si, _address) \
 	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
 
@@ -908,7 +904,7 @@ static const struct iio_chan_spec ad7192
 	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
 	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
 	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
 	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
 	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
@@ -922,7 +918,7 @@ static const struct iio_chan_spec ad7193
 	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
 	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
 	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
 	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
 	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),


