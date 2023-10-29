Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCBC7DAC62
	for <lists+stable@lfdr.de>; Sun, 29 Oct 2023 13:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJ2MRH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 29 Oct 2023 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjJ2MRG (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 29 Oct 2023 08:17:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE0DBE
        for <Stable@vger.kernel.org>; Sun, 29 Oct 2023 05:17:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A711C433B9;
        Sun, 29 Oct 2023 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698581823;
        bh=r4+nd5GDXN4jY1sNixIKN6tjxXuLXWBB1qs0W/t9n+Y=;
        h=Subject:To:Cc:From:Date:From;
        b=OlgFvW59SzoOvca4q915XeyB39e3t6zqgV9UO/jFsQELth16uQJIRgFOMM+ZkSrdN
         NDAUlJGpv2+d2OuZTqjqvy3EL7OX9bGXpGaKbANL+zd4AiHNodympNO5h8FLNkChqJ
         mS54MMLvQIbg/wWEkyKY3N4zqKzwIQ3YmezBYAaA=
Subject: FAILED: patch "[PATCH] iio: adc: xilinx-xadc: Don't clobber preset" failed to apply to 4.19-stable tree
To:     robert.hancock@calian.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, conall.ogriofa@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 29 Oct 2023 13:16:53 +0100
Message-ID: <2023102953-ditto-overcook-adcf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8d6b3ea4d9eaca80982442b68a292ce50ce0a135
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102953-ditto-overcook-adcf@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d6b3ea4d9eaca80982442b68a292ce50ce0a135 Mon Sep 17 00:00:00 2001
From: Robert Hancock <robert.hancock@calian.com>
Date: Thu, 14 Sep 2023 18:10:18 -0600
Subject: [PATCH] iio: adc: xilinx-xadc: Don't clobber preset
 voltage/temperature thresholds

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
 

