Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675972DFA4
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbjFMKfP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241605AbjFMKen (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 06:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC3B10E4
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 03:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4951563492
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 10:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38465C4339B;
        Tue, 13 Jun 2023 10:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686652412;
        bh=+30TxSPw8bIYEmvxMx3HJRi0UP/ZknvcxI1X2goZi/8=;
        h=Subject:To:From:Date:In-Reply-To:From;
        b=JE9gDksxRbRmchOFPxCskN0XI5jdehlHQBmXudrqoIawnLT9FLVuRSeFPy6jIBAWI
         ouIPMKs2Ja4KhhXpnCZuFR9wz+fsT9qQPcTek3wSad64HidsfogvIWlnzj3pAJWg0W
         JFnWS/ontuGoMRTFoPepQY/3YoqNFa1CU3QcgFq4=
Subject: patch "tty: serial: samsung_tty: Fix a memory leak in" added to tty-testing
To:     christophe.jaillet@wanadoo.fr, andi.shyti@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski@linaro.org, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 13 Jun 2023 12:33:30 +0200
In-Reply-To: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
Message-ID: <2023061330-debug-bronco-f8af@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


This is a note to let you know that I've just added the patch titled

    tty: serial: samsung_tty: Fix a memory leak in

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From a9c09546e903f1068acfa38e1ee18bded7114b37 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 10 Jun 2023 17:59:25 +0200
Subject: tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error

If clk_get_rate() fails, the clk that has just been allocated needs to be
freed.

Cc: <stable@vger.kernel.org> # v3.3+
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 2a7520ad3abd..a92a23e1964e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1459,8 +1459,12 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			continue;
 
 		rate = clk_get_rate(clk);
-		if (!rate)
+		if (!rate) {
+			dev_err(ourport->port.dev,
+				"Failed to get clock rate for %s.\n", clkname);
+			clk_put(clk);
 			continue;
+		}
 
 		if (ourport->info->has_divslot) {
 			unsigned long div = rate / req_baud;
-- 
2.41.0


