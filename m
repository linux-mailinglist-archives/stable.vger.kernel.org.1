Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927D37BBB13
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjJFPBa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjJFPB2 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 6 Oct 2023 11:01:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA204DE
        for <Stable@vger.kernel.org>; Fri,  6 Oct 2023 08:01:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36461C433CA;
        Fri,  6 Oct 2023 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604486;
        bh=tKQYQ8w/IpSY1fKcDW2yqzDJmEmV8/m0t/LpPjxLFTI=;
        h=Subject:To:From:Date:From;
        b=p72Zz/5FMDh6vmYItEu5/a+G5o265dC+rdK+mExraDaZXfy3XBty+t6G80wWpPkYW
         VfIMZ7NLoxqCQYWtUXWeaf1eYfdvghXRpNB7bZMeTKFNrfKSVxEGBfENO45PDcwoTH
         TFKaPJw6uG/3g0uHGuy529u8UeQiTINOwoplHfrw=
Subject: patch "iio: pressure: dps310: Adjust Timeout Settings" added to char-misc-linus
To:     lakshmiy@us.ibm.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 06 Oct 2023 17:01:06 +0200
Message-ID: <2023100606-stellar-outlook-d30d@gregkh>
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

    iio: pressure: dps310: Adjust Timeout Settings

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 901a293fd96fb9bab843ba4cc7be3094a5aa7c94 Mon Sep 17 00:00:00 2001
From: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Date: Tue, 29 Aug 2023 13:02:22 -0500
Subject: iio: pressure: dps310: Adjust Timeout Settings

The DPS310 sensor chip has been encountering intermittent errors while
reading the sensor device across various system designs. This issue causes
the chip to become "stuck," preventing the indication of "ready" status
for pressure and temperature measurements in the MEAS_CFG register.

To address this issue, this commit fixes the timeout settings to improve
sensor stability:
- After sending a reset command to the chip, the timeout has been extended
  from 2.5 ms to 15 ms, aligning with the DPS310 specification.
- The read timeout value of the MEAS_CFG register has been adjusted from
  20ms to 30ms to match the specification.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Fixes: 7b4ab4abcea4 ("iio: pressure: dps310: Reset chip after timeout")
Link: https://lore.kernel.org/r/20230829180222.3431926-2-lakshmiy@us.ibm.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/dps310.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index b10dbf5cf494..1ff091b2f764 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -57,8 +57,8 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 
-/* Make sure sleep time is <= 20ms for usleep_range */
-#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
+/* Make sure sleep time is <= 30ms for usleep_range */
+#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
 /* Silently handle error in rate value here */
 #define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
 
@@ -402,8 +402,8 @@ static int dps310_reset_wait(struct dps310_data *data)
 	if (rc)
 		return rc;
 
-	/* Wait for device chip access: 2.5ms in specification */
-	usleep_range(2500, 12000);
+	/* Wait for device chip access: 15ms in specification */
+	usleep_range(15000, 55000);
 	return 0;
 }
 
-- 
2.42.0


