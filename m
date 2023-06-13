Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7372DFA3
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjFMKfP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbjFMKet (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 06:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8A1FE8
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 03:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF82620EE
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 10:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCC7C433D2;
        Tue, 13 Jun 2023 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686652424;
        bh=r2UtEncxkPez4GCAMn4jkIteEUNTN5FruWDxrh3UhbU=;
        h=Subject:To:From:Date:In-Reply-To:From;
        b=pyjcVdE5VSrMLS6B2QB92gZ/0Iu3hCOU6ISZyvl0T++FZg5JxWh3WFiGoudx/PtKd
         78nTq8MaCzsoHpIkA2kfIeqaTAMmnKXN3H8ng5wA4/Jq0VMJFzGvQRrLni3qF1/XwK
         nDjly8bcYmDA9VgP0ZxvdDjNVTc/MfXAI4SV0aRk=
Subject: patch "tty: serial: samsung_tty: Fix a memory leak in" added to tty-testing
To:     christophe.jaillet@wanadoo.fr, andi.shyti@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski@linaro.org, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 13 Jun 2023 12:33:31 +0200
In-Reply-To: <cf3e0053d2fc7391b2d906a86cd01a5ef15fb9dc.1686412569.git.christophe.jaillet@wanadoo.fr>
Message-ID: <2023061330-stench-observant-e076@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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


From 832e231cff476102e8204a9e7bddfe5c6154a375 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 10 Jun 2023 17:59:26 +0200
Subject: tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk

When the best clk is searched, we iterate over all possible clk.

If we find a better match, the previous one, if any, needs to be freed.
If a better match has already been found, we still need to free the new
one, otherwise it leaks.

Cc: <stable@vger.kernel.org> # v3.3+
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Message-ID: <cf3e0053d2fc7391b2d906a86cd01a5ef15fb9dc.1686412569.git.christophe.jaillet@wanadoo.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index a92a23e1964e..0b37019820b4 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1490,10 +1490,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			calc_deviation = -calc_deviation;
 
 		if (calc_deviation < deviation) {
+			/*
+			 * If we find a better clk, release the previous one, if
+			 * any.
+			 */
+			if (!IS_ERR(*best_clk))
+				clk_put(*best_clk);
 			*best_clk = clk;
 			best_quot = quot;
 			*clk_num = cnt;
 			deviation = calc_deviation;
+		} else {
+			clk_put(clk);
 		}
 	}
 
-- 
2.41.0


