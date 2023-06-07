Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E7726C1F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjFGUa5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjFGUal (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3E2702
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56AC644D5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E6CC433D2;
        Wed,  7 Jun 2023 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169834;
        bh=+/uUPiNKP6XTa6nO7f2KMIkLt3h0LH2qbjEpl6gAL2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isIBMn2Aq/fcNHq15NxpAT3pNAfoLARX166sMbABlIX03egXma+QpOGrUW6s678Mo
         fh1DiYbKJdFclzubcdkvjKVpoqtoTx5SU4THHzocaGNIoxFAigYLAbW1QiwRvIRdtX
         ksQV5wzeh0GAhH/km/y/HcySQPG8daxR2Y27Wtww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Honda <honda@mechatrax.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.3 202/286] iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Date:   Wed,  7 Jun 2023 22:15:01 +0200
Message-ID: <20230607200929.856647673@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masahiro Honda <honda@mechatrax.com>

commit 626d312028bec44209d0ecd5beaa9b1aa8945f7d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad_sigma_delta.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(stru
 	init_completion(&sigma_delta->completion);
 
 	sigma_delta->irq_dis = true;
+
+	/* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IRQ */
+	irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
+
 	ret = devm_request_irq(dev, sigma_delta->spi->irq,
 			       ad_sd_data_rdy_trig_poll,
 			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,


