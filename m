Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1DA7CA327
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjJPJB4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjJPJBg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:01:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132DE12B
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:01:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03213C433B9;
        Mon, 16 Oct 2023 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446886;
        bh=9VuxhNIvitKS1iZ0b+01fjaesg+EQzoix2WntiX6MLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7eTBsgXlsNo4VDYNF79jboWyk17zlaKNQWdXrWIVI2j6jM71CNH2xvo7r57Tg5OF
         btJ4YJyjH3wJ4ghdAWTzzHepOD2UsL0MyOC8zGC+A2zv47S3296jsbtLUJt/vLoB9m
         2VrrslL6UL3FUHL1EnkgaM9qqZCarDeKBOcBUgqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 087/131] iio: addac: Kconfig: update ad74413r selections
Date:   Mon, 16 Oct 2023 10:41:10 +0200
Message-ID: <20231016084002.221307207@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit b120dd3a15582fb7a959cecb05e4d9814fcba386 upstream.

Building ad74413r without selecting IIO_BUFFER and
IIO_TRIGGERED_BUFFER generates error with respect to the iio trigger
functions that are used within the driver.
Update the Kconfig accordingly.

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Link: https://lore.kernel.org/r/20230912085421.51102-1-antoniu.miclaus@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/addac/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -10,6 +10,8 @@ config AD74413R
 	depends on GPIOLIB && SPI
 	select REGMAP_SPI
 	select CRC8
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD74412R/AD74413R
 	  quad-channel software configurable input/output solution.


