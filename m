Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963A73462D
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjFRMuC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFRMuA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 08:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B3DE4D
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 05:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A244060ACE
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 12:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EEAC433C0;
        Sun, 18 Jun 2023 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687092599;
        bh=kXRvJtNRP1k67oHtgGifA8q1go/Dlr48dQKAYdJhfh4=;
        h=Subject:To:Cc:From:Date:From;
        b=0HsqYVy4Hj8Li9HiSYlLqtet/Ccf1GvnvViNqssUNFtTe+d1/N6TLg6KgIr0WFxgk
         deDkdmfBqise5z6c4SSYI/1pfO8UCL4kE459Vnd15BOiSe9AYDLG37ha2Ovh+WO+GF
         4GD61h+muffuQInW7x6cOVJBr/y/EZYdQAzZzE9E=
Subject: FAILED: patch "[PATCH] tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A" failed to apply to 5.15-stable tree
To:     robert.hodaszi@digi.com, gregkh@linuxfoundation.org,
        stable@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 18 Jun 2023 14:49:48 +0200
Message-ID: <2023061848-unpleased-sizing-050f@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a82c3df955f8c1c726e4976527aa6ae924a67dd9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061848-unpleased-sizing-050f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a82c3df955f8c1c726e4976527aa6ae924a67dd9 Mon Sep 17 00:00:00 2001
From: Robert Hodaszi <robert.hodaszi@digi.com>
Date: Fri, 9 Jun 2023 14:13:34 +0200
Subject: [PATCH] tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

LS1028A is using DMA with LPUART. Having RX watermark set to 1, means
DMA transactions are started only after receiving the second character.

On other platforms with newer LPUART IP, Receiver Idle Empty function
initiates the DMA request after the receiver is idling for 4 characters.
But this feature is missing on LS1028A, which is causing a 1-character
delay in the RX direction on this platform.

Set RX watermark to 0 to initiate RX DMA after each character.

Link: https://lore.kernel.org/linux-serial/20230607103459.1222426-1-robert.hodaszi@digi.com/
Fixes: 9ad9df844754 ("tty: serial: fsl_lpuart: Fix the wrong RXWATER setting for rx dma case")
Cc: stable <stable@kernel.org>
Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
Message-ID: <20230609121334.1878626-1-robert.hodaszi@digi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7486a2b8556c..7fd30fcc10c6 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -310,7 +310,7 @@ static const struct lpuart_soc_data ls1021a_data = {
 static const struct lpuart_soc_data ls1028a_data = {
 	.devtype = LS1028A_LPUART,
 	.iotype = UPIO_MEM32,
-	.rx_watermark = 1,
+	.rx_watermark = 0,
 };
 
 static struct lpuart_soc_data imx7ulp_data = {

