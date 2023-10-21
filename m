Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC637D1DED
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJUPgo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJUPgn (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sat, 21 Oct 2023 11:36:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDED114
        for <Stable@vger.kernel.org>; Sat, 21 Oct 2023 08:36:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427E2C433C8;
        Sat, 21 Oct 2023 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697902597;
        bh=ANb5j77exVQMNUgDnVTh8T3FuSre9QaO79+e6KFyfUg=;
        h=Subject:To:From:Date:From;
        b=J5QRfJ1zbpL6Vbf6ziKmk3JfC2oweIPWh5UpoXE3VwbHwwAfD6DOLxzPUO1EHEv+r
         Zw1rgO0b93FtH0ZWCVvw261BKN2DRpLQxdXfIkm/bbdbmPpXVb6wtVaDwVVTyO1QUk
         NcXAYRaTO2u0vR0gYse8ZLqxfcVoicQ680tv8mnk=
Subject: patch "iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature" added to char-misc-linus
To:     robert.hancock@calian.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, conall.ogriofa@amd.com
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 17:36:32 +0200
Message-ID: <2023102132-define-composed-dd21@gregkh>
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

    iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8d6b3ea4d9eaca80982442b68a292ce50ce0a135 Mon Sep 17 00:00:00 2001
From: Robert Hancock <robert.hancock@calian.com>
Date: Thu, 14 Sep 2023 18:10:18 -0600
Subject: iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature
 thresholds

In the probe function, the driver was reading out the thresholds already
set in the core, which can be configured by the user in the Vivado tools
when the FPGA image is built. However, it later clobbered those values
with zero or maximum values. In particular, the overtemperature shutdown
threshold register was overwritten with the max value, which effectively
prevents the FPGA from shutting down when the desired threshold was
eached, potentially risking hardware damage in that case.

Remove this code to leave the preconfigured default threshold values
intact.

The code was also disabling all alarms regardless of what enable state
they were left in by the FPGA image, including the overtemperature
shutdown feature. Leave these bits in their original state so they are
not unconditionally disabled.

Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Acked-by: O'Griofa, Conall <conall.ogriofa@amd.com>
Tested-by: O'Griofa, Conall <conall.ogriofa@amd.com>
Link: https://lore.kernel.org/r/20230915001019.2862964-2-robert.hancock@calian.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index dba73300f894..d4d0d184a172 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1423,28 +1423,6 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Disable all alarms */
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
-				  XADC_CONF1_ALARM_MASK);
-	if (ret)
-		return ret;
-
-	/* Set thresholds to min/max */
-	for (i = 0; i < 16; i++) {
-		/*
-		 * Set max voltage threshold and both temperature thresholds to
-		 * 0xffff, min voltage threshold to 0.
-		 */
-		if (i % 8 < 4 || i == 7)
-			xadc->threshold[i] = 0xffff;
-		else
-			xadc->threshold[i] = 0;
-		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
-			xadc->threshold[i]);
-		if (ret)
-			return ret;
-	}
-
 	/* Go to non-buffered mode */
 	xadc_postdisable(indio_dev);
 
-- 
2.42.0


