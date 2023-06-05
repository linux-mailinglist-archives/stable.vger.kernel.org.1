Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456837228F5
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjFEOhu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 10:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFEOhu (ORCPT
        <rfc822;Stable@vger.kernel.org>); Mon, 5 Jun 2023 10:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46AED
        for <Stable@vger.kernel.org>; Mon,  5 Jun 2023 07:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C21F625B5
        for <Stable@vger.kernel.org>; Mon,  5 Jun 2023 14:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768A3C433EF;
        Mon,  5 Jun 2023 14:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685975866;
        bh=TtgSbtsY7uWspwK0xKFbpFDKOh6pHaZj075EijyFPKI=;
        h=Subject:To:Cc:From:Date:From;
        b=J55QD9Ug/uMUC9pMC8hiS9IGZriZ4M0lVr7fvm+cm+vgk5hnYGj5pk9zpsK55bwT3
         wy/mvxWLTFJjCh8JL3v5jTU4qe73leGi7X0010lAvQSliGVf3HxJf4jA6Z3h7j3frt
         dRJcyycV4/oRBGvO63w6SK7uWNr+69U5QvRGWXK4=
Subject: FAILED: patch "[PATCH] iio: adc: ad_sigma_delta: Fix IRQ issue by setting" failed to apply to 5.10-stable tree
To:     honda@mechatrax.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 05 Jun 2023 16:37:43 +0200
Message-ID: <2023060543-disdain-plaza-27e7@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 626d312028bec44209d0ecd5beaa9b1aa8945f7d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060543-disdain-plaza-27e7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 626d312028bec44209d0ecd5beaa9b1aa8945f7d Mon Sep 17 00:00:00 2001
From: Masahiro Honda <honda@mechatrax.com>
Date: Thu, 18 May 2023 20:08:16 +0900
Subject: [PATCH] iio: adc: ad_sigma_delta: Fix IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag

The Sigma-Delta ADCs supported by this driver can use SDO as an interrupt
line to indicate the completion of a conversion. However, some devices
cannot properly detect the completion of a conversion by an interrupt.
This is for the reason mentioned in the following commit.

commit e9849777d0e2 ("genirq: Add flag to force mask in
                      disable_irq[_nosync]()")

A read operation is performed by an extra interrupt before the completion
of a conversion. At this time, the value read from the ADC data register
is the same as the previous conversion result. This patch fixes the issue
by setting IRQ_DISABLE_UNLAZY flag.

Fixes: 0c6ef985a1fd ("iio: adc: ad7791: fix IRQ flags")
Fixes: 1a913270e57a ("iio: adc: ad7793: Fix IRQ flag")
Fixes: e081102f3077 ("iio: adc: ad7780: Fix IRQ flag")
Fixes: 89a86da5cb8e ("iio: adc: ad7192: Add IRQ flag")
Fixes: 79ef91493f54 ("iio: adc: ad7124: Set IRQ type to falling")
Signed-off-by: Masahiro Honda <honda@mechatrax.com>
Link: https://lore.kernel.org/r/20230518110816.248-1-honda@mechatrax.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8570f620785..7e2192870743 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
+
+	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
+	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+
 	ret = devm_request_irq(dev, sigma_delta->spi->irq,
 			       ad_sd_data_rdy_trig_poll,
 			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,

