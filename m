Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC81713C22
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjE1TFP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjE1TFP (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:05:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9452C7
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 866AD618C1
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C5EC433D2;
        Sun, 28 May 2023 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300713;
        bh=pZKJ4UFCVMZGErZwQ0NVyO645xGAyZFh3epCpurpfmA=;
        h=Subject:To:From:Date:From;
        b=sYDg9ZY2CdTzEg/Z+4/JwWlYo9sdOlw0+02naNA5zanZ4CqQ0ndWxNpjU92kbIc5L
         Z/Hsrxccpg/y6onh5ZJGNKRyIO/ZCEvIryxFFqGK5ge//kKrrEe+K9C0lfWBQsdnv3
         FRuB+9P2sTMIlmzgSvl05SbG2D4eszRRI01GtI3A=
Subject: patch "iio: addac: ad74413: fix resistance input processing" added to char-misc-linus
To:     linux@rasmusvillemoes.dk, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, nuno.sa@analog.com
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:40 +0100
Message-ID: <2023052840-shortness-judge-3ab6@gregkh>
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

    iio: addac: ad74413: fix resistance input processing

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 24febc99ca725dcf42d57168a2f4e8a75a5ade92 Mon Sep 17 00:00:00 2001
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Wed, 3 May 2023 11:58:17 +0200
Subject: iio: addac: ad74413: fix resistance input processing

On success, ad74413r_get_single_adc_result() returns IIO_VAL_INT aka
1. So currently, the IIO_CHAN_INFO_PROCESSED case is effectively
equivalent to the IIO_CHAN_INFO_RAW case, and we never call
ad74413r_adc_to_resistance_result() to convert the adc measurement to
ohms.

Check ret for being negative rather than non-zero.

Fixes: fea251b6a5dbd (iio: addac: add AD74413R driver)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230503095817.452551-1-linux@rasmusvillemoes.dk
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 07e9f6ae16a8..e3366cf5eb31 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1007,7 +1007,7 @@ static int ad74413r_read_raw(struct iio_dev *indio_dev,
 
 		ret = ad74413r_get_single_adc_result(indio_dev, chan->channel,
 						     val);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ad74413r_adc_to_resistance_result(*val, val);
-- 
2.40.1


