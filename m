Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B477315FC
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjFOLBt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFOLBq (ORCPT
        <rfc822;Stable@vger.kernel.org>); Thu, 15 Jun 2023 07:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA1199D
        for <Stable@vger.kernel.org>; Thu, 15 Jun 2023 04:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B537C62A93
        for <Stable@vger.kernel.org>; Thu, 15 Jun 2023 11:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C1FC433C0;
        Thu, 15 Jun 2023 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686826904;
        bh=u5lR7eK6cdOglUFb0gEWsEABPVTdnOvqQ2QIa6klsts=;
        h=Subject:To:From:Date:From;
        b=l0skRhE+R7BjYPKiO+qJCZa3z71ScW2zZvA+DO7INMLp8PbDWldzh5KzhwifQX1Md
         3Oif7itNMIrl6l5u3dn66XqfC5ANvJZeszKQEWpk8gZvOdZaQkZhhAO1WAX6ojoqsN
         klMhTvskjbISP+h0RQrS8T6YnRj+a2Gj4ZDF1glo=
Subject: patch "iio: adc: ad7192: Fix null ad7192_state pointer access" added to char-misc-testing
To:     fl.scratchpad@gmail.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, nuno.sa@analog.com
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 15 Jun 2023 13:01:25 +0200
Message-ID: <2023061525-outsource-output-a460@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7192: Fix null ad7192_state pointer access

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 9e58e3a6f8e1c483c86a04903b7b7aa0923e4426 Mon Sep 17 00:00:00 2001
From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date: Tue, 30 May 2023 09:53:07 +0200
Subject: iio: adc: ad7192: Fix null ad7192_state pointer access

Pointer to indio_dev structure is obtained via spi_get_drvdata() at
the beginning of function ad7192_setup(), but the spi->dev->driver_data
member is not initialized, hence a NULL pointer is returned.

Fix by changing ad7192_setup() signature to take pointer to struct
iio_dev, and get ad7192_state pointer via st = iio_priv(indio_dev);

Fixes: bd5dcdeb3fd0 ("iio: adc: ad7192: convert to device-managed functions")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230530075311.400686-2-fl.scratchpad@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7192.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 99bb604b78c8..55a26dbd6108 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -380,9 +380,9 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
+	struct ad7192_state *st = iio_priv(indio_dev);
 	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
@@ -1069,7 +1069,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(st, spi->dev.of_node);
+	ret = ad7192_setup(indio_dev, spi->dev.of_node);
 	if (ret)
 		return ret;
 
-- 
2.41.0


