Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACEE713C1E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjE1TFD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE1TFC (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C2090
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6FAC618A9
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2614C433EF;
        Sun, 28 May 2023 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300700;
        bh=ZI+Nt3n2/gucH4/mUdfCHFVmPfOJeIFgzBbBylh2VQQ=;
        h=Subject:To:From:Date:From;
        b=PnLsvX1sUehFrNUmknrxkLgxfH7ErQYqxCAnae51lTPX6+MX+Q9T6MU444U5m+yvx
         DjpKWIAcqhXzZUYDSlcjFwhswoUJ75C/9sMp4Mwb1FUfAKEWPr6edLMpo6CggiB6Xy
         aK5KimzaMiVrFw7MZDMKEjChCOyi624CZY9GaACc=
Subject: patch "iio: adc: ad7192: Change "shorted" channels to differential" added to char-misc-linus
To:     paul@crapouillou.net, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, alisa.roman@analog.com, nuno.sa@analog.com
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:37 +0100
Message-ID: <2023052837-facial-unnerve-0a15@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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

    iio: adc: ad7192: Change "shorted" channels to differential

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From e55245d115bb9054cb72cdd5dda5660f4484873a Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 30 Mar 2023 12:21:00 +0200
Subject: iio: adc: ad7192: Change "shorted" channels to differential

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
---
 drivers/iio/adc/ad7192.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 55a6ab591016..99bb604b78c8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -897,10 +897,6 @@ static const struct iio_info ad7195_info = {
 	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
 		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
 
-#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
-	__AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
-
 #define AD719x_TEMP_CHANNEL(_si, _address) \
 	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
 
@@ -908,7 +904,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
 	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
 	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
 	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
 	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
 	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
@@ -922,7 +918,7 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
 	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
 	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
 	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
 	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),
-- 
2.40.1


