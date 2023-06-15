Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15215731637
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbjFOLOD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbjFOLN7 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Thu, 15 Jun 2023 07:13:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258CE2707
        for <Stable@vger.kernel.org>; Thu, 15 Jun 2023 04:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B574F62264
        for <Stable@vger.kernel.org>; Thu, 15 Jun 2023 11:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB847C433C8;
        Thu, 15 Jun 2023 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686827637;
        bh=80cR4Xn3rxRyuzZWAInDUXTT8ol5eTdLaU5dDuOXTCg=;
        h=Subject:To:From:Date:From;
        b=G7ejocBKRhQ4wj2cmd+04n1wdm2GyiysK69fVkfBizbXiS/HngOV5LYzR9PjqYUuw
         Lx4n46pjp4/+JwdkJYw4u1OoiYUQi44glph/7S0JKLxM4jhd5z/jq/b70V3AJNsXqZ
         mV1PLf8yNYZJXr4xO0l7Ie6DRQw27oYr6SyLAF7c=
Subject: patch "iio: adc: ad7192: Fix internal/external clock selection" added to char-misc-next
To:     fl.scratchpad@gmail.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, nuno.sa@analog.com
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 15 Jun 2023 13:11:41 +0200
Message-ID: <2023061541-polio-encircle-2861@gregkh>
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

    iio: adc: ad7192: Fix internal/external clock selection

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From f7d9e21dd274b97dc0a8dbc136a2ea8506063a96 Mon Sep 17 00:00:00 2001
From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date: Tue, 30 May 2023 09:53:08 +0200
Subject: iio: adc: ad7192: Fix internal/external clock selection

Fix wrong selection of internal clock when mclk is defined.

Resolve a logical inversion introduced in c9ec2cb328e3.

Fixes: c9ec2cb328e3 ("iio: adc: ad7192: use devm_clk_get_optional() for mclk")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230530075311.400686-3-fl.scratchpad@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 55a26dbd6108..8685e0b58a83 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -367,7 +367,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
-	if (st->mclk) {
+	if (!st->mclk) {
 		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
-- 
2.41.0


