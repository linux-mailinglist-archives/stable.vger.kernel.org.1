Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979137D1BDE
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJUJDT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 05:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUJDT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 05:03:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3670BDD
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 02:03:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8BBC433C8;
        Sat, 21 Oct 2023 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697878996;
        bh=bDF09wLM4YeSwAKyHFKz8F5DQYSdMCI1ufwXPL33c8c=;
        h=Subject:To:Cc:From:Date:From;
        b=yn526mZnQ40eC9WNMrSxb/FEfMDh6EO9hcdZczNh8gbxT+HJcBNj5P9ubEQtr7US4
         N5pCwQi7Gkx5hsRqTX2Si0Dal8yYs9BziZVhnzLmjy4dKZmAZv7/u0yHTYidcDnagZ
         fOwRRfqzlLgaay6CHYqIWl7hlAxW+B13OP4mqIW0=
Subject: FAILED: patch "[PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode" failed to apply to 4.14-stable tree
To:     haibo.chen@nxp.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 21 Oct 2023 11:03:06 +0200
Message-ID: <2023102105-washbasin-crimp-78d1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 32a9cdb8869dc111a0c96cf8e1762be9684af15b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102105-washbasin-crimp-78d1@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32a9cdb8869dc111a0c96cf8e1762be9684af15b Mon Sep 17 00:00:00 2001
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 30 Aug 2023 17:39:22 +0800
Subject: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode

tuning only support in 4-bit mode or 8 bit mode, so in 1-bit mode,
need to hold retuning.

Find this issue when use manual tuning method on imx93. When system
resume back, SDIO WIFI try to switch back to 4 bit mode, first will
trigger retuning, and all tuning command failed.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230830093922.3095850-1-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f64b9ac76a5c..5914516df2f7 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1089,8 +1089,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		}
 		err = mmc_sdio_reinit_card(host);
 	} else if (mmc_card_wake_sdio_irq(host)) {
-		/* We may have switched to 1-bit mode during suspend */
+		/*
+		 * We may have switched to 1-bit mode during suspend,
+		 * need to hold retuning, because tuning only supprt
+		 * 4-bit mode or 8 bit mode.
+		 */
+		mmc_retune_hold_now(host);
 		err = sdio_enable_4bit_bus(host->card);
+		mmc_retune_release(host);
 	}
 
 	if (err)

