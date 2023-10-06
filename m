Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2117BBB11
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjJFPBX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJFPBW (ORCPT
        <rfc822;Stable@vger.kernel.org>); Fri, 6 Oct 2023 11:01:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9EDB
        for <Stable@vger.kernel.org>; Fri,  6 Oct 2023 08:01:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B08C433C7;
        Fri,  6 Oct 2023 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604480;
        bh=DcvEZkPtb70Mq+ZeTnyWYe67Uq+zELZDzmsxl1vVnDI=;
        h=Subject:To:From:Date:From;
        b=xDloBRozlsvfLPhyDnK5dEPzvXKa6HGjn7pcr/GRfqf+/KJXOVTc2OvRVxodNzkpL
         PtZBnOLU5+tv17kzImuMilbeO1B6sG8DoNs8n3Aezej6PZyZjZzhQnVa45wnIJY3F3
         AVNCVY0EycwZ8RIZCykh/6GjOCdj2DQaiLuUvGrg=
Subject: patch "iio: adc: imx8qxp: Fix address for command buffer registers" added to char-misc-linus
To:     embed3d@gmail.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, haibo.chen@nxp.com
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 06 Oct 2023 17:01:04 +0200
Message-ID: <2023100604-lyrics-mutilated-22bf@gregkh>
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

    iio: adc: imx8qxp: Fix address for command buffer registers

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 850101b3598277794f92a9e363a60a66e0d42890 Mon Sep 17 00:00:00 2001
From: Philipp Rossak <embed3d@gmail.com>
Date: Tue, 5 Sep 2023 00:02:04 +0200
Subject: iio: adc: imx8qxp: Fix address for command buffer registers

The ADC Command Buffer Register high and low are currently pointing to
the wrong address and makes it impossible to perform correct
ADC measurements over all channels.

According to the datasheet of the imx8qxp the ADC_CMDL register starts
at address 0x100 and the ADC_CMDH register starts at address 0x104.

This bug seems to be in the kernel since the introduction of this
driver.

This can be observed by checking all raw voltages of the adc and they
are all nearly identical:

cat /sys/bus/iio/devices/iio\:device0/in_voltage*_raw
3498
3494
3491
3491
3489
3490
3490
3490

Fixes: 1e23dcaa1a9fa ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://lore.kernel.org/r/20230904220204.23841-1-embed3d@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/imx8qxp-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index f5a0fc9e64c5..fff6e5a2d956 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -38,8 +38,8 @@
 #define IMX8QXP_ADR_ADC_FCTRL		0x30
 #define IMX8QXP_ADR_ADC_SWTRIG		0x34
 #define IMX8QXP_ADR_ADC_TCTRL(tid)	(0xc0 + (tid) * 4)
-#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x100 + (cid) * 8)
-#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x104 + (cid) * 8)
+#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x100 + (cid) * 8)
+#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x104 + (cid) * 8)
 #define IMX8QXP_ADR_ADC_RESFIFO		0x300
 #define IMX8QXP_ADR_ADC_TST		0xffc
 
-- 
2.42.0


