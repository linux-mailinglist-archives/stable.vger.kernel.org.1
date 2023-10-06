Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985EE7BBB18
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjJFPBn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjJFPBn (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 6 Oct 2023 11:01:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FCC6
        for <Stable@vger.kernel.org>; Fri,  6 Oct 2023 08:01:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D576FC433C7;
        Fri,  6 Oct 2023 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604501;
        bh=N5YMIrdd54alqzThSkZtBr1F5VVuLU68ZGeVJOqCXko=;
        h=Subject:To:From:Date:From;
        b=O9VcR3a1uCOM5t8wGtx4eWePmuvYxZQ98W8ZsnaABa0ki0UMSBID3axfZZEnOTidc
         vXbCUCTRMcArOm9zgJFj3BOphQDhNGHytGFEEeMwxKa26v41aokhLS2XL2ZAvHqOoL
         cm0pOAESLrePo//0YYtggL4FF22rnIaf+ttYir2Q=
Subject: patch "iio: pressure: ms5611: ms5611_prom_is_valid false negative bug" added to char-misc-linus
To:     az@breathe-safe.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 06 Oct 2023 17:01:11 +0200
Message-ID: <2023100611-trident-sister-2bf8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From fd39d9668f2ce9f4b05ad55e8c8d80c098073e0b Mon Sep 17 00:00:00 2001
From: Alexander Zangerl <az@breathe-safe.com>
Date: Wed, 20 Sep 2023 10:01:10 +1000
Subject: iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

The ms5611 driver falsely rejects lots of MS5607-02BA03-50 chips
with "PROM integrity check failed" because it doesn't accept a prom crc
value of zero as legitimate.

According to the datasheet for this chip (and the manufacturer's
application note about the PROM CRC), none of the possible values for the
CRC are excluded - but the current code in ms5611_prom_is_valid() ends with

return crc_orig != 0x0000 && crc == crc_orig

Discussed with the driver author (Tomasz Duszynski) and he indicated that
at that time (2015) he was dealing with some faulty chip samples which
returned blank data under some circumstances and/or followed example code
which indicated CRC zero being bad.

As far as I can tell this exception should not be applied anymore; We've
got a few hundred custom boards here with this chip where large numbers
of the prom have a legitimate CRC value 0, and do work fine, but which the
current driver code wrongly rejects.

Signed-off-by: Alexander Zangerl <az@breathe-safe.com>
Fixes: c0644160a8b5 ("iio: pressure: add support for MS5611 pressure and temperature sensor")
Link: https://lore.kernel.org/r/2535-1695168070.831792@Ze3y.dhYT.s3fx
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/ms5611_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 627497e61a63..2fc706f9d8ae 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -76,7 +76,7 @@ static bool ms5611_prom_is_valid(u16 *prom, size_t len)
 
 	crc = (crc >> 12) & 0x000F;
 
-	return crc_orig != 0x0000 && crc == crc_orig;
+	return crc == crc_orig;
 }
 
 static int ms5611_read_prom(struct iio_dev *indio_dev)
-- 
2.42.0


