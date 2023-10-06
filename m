Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D457BBB12
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjJFPB2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjJFPB1 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 6 Oct 2023 11:01:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0117FC6
        for <Stable@vger.kernel.org>; Fri,  6 Oct 2023 08:01:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473EFC433C7;
        Fri,  6 Oct 2023 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604483;
        bh=iErOLn5QTnd3rIPfLnXteA2eTSDr39JgSW8/tfnqaDw=;
        h=Subject:To:From:Date:From;
        b=CRV04xz8nIcVTmFpxV2JRyodKBr6aHFk9+lCIFeYau0gMRL3Zel4RMMtRVBT9zO+f
         yYAq/ajVA+2peWzz9o2fn3LWMSPoiJcp7OVSZzC6Lrp8CRyQWukdAE3SDcjmpUqZhU
         YxFsBMgc/128O3oLrzI6t68WtWkICIFDpD7ZHLAY=
Subject: patch "iio: imu: bno055: Fix missing Kconfig dependencies" added to char-misc-linus
To:     Jonathan.Cameron@huawei.com, Stable@vger.kernel.org,
        andrea.merello@iit.it, rdunlap@infradead.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 06 Oct 2023 17:01:05 +0200
Message-ID: <2023100605-snowcap-showoff-ce91@gregkh>
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

    iio: imu: bno055: Fix missing Kconfig dependencies

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From c9b9cfe7d342683f624a89c3b617be18aff879e8 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sun, 3 Sep 2023 12:30:52 +0100
Subject: iio: imu: bno055: Fix missing Kconfig dependencies

This driver uses IIO triggered buffers so it needs to select them in
Kconfig.

on riscv-32bit:

/opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: drivers/iio/imu/bno055/bno055.o: in function `.L367':
bno055.c:(.text+0x2c96): undefined reference to `devm_iio_triggered_buffer_setup_ext'

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-next/40566b4b-3950-81fe-ff14-871d8c447627@infradead.org/
Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
Cc: Andrea Merello <andrea.merello@iit.it>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20230903113052.846298-1-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/bno055/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index fa79b1ac4f85..83e53acfbe88 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -2,6 +2,8 @@
 
 config BOSCH_BNO055
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config BOSCH_BNO055_SERIAL
 	tristate "Bosch BNO055 attached via UART"
-- 
2.42.0


