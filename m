Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C295672F65D
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjFNHcK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 03:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjFNHcJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 03:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428AC2
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 00:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 599C86365E
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62732C433C8;
        Wed, 14 Jun 2023 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686727927;
        bh=0hidlaFa8fm8tS2qsLzKVRTgLSM2Ey7d0fM+S3bwEsY=;
        h=Subject:To:From:Date:In-Reply-To:From;
        b=DzSdrssSqJlpy5v5IWgSYuymOCz0Qux/bSjRAT4iX0AFpzx6EY4y8HzI6YG8gRv7E
         P7tMOATL4faMs0Jl5lghjQlSkKVDoD3GraHYW+75uOjQ5U25QZxmWYQIf4QH9Or0Rl
         VroPaBEmDddV6GmlMWXCruf4NPq5Z6/ONlBi6/vU=
Subject: patch "tty: serial: samsung_tty: Fix a memory leak in" added to tty-next
To:     christophe.jaillet@wanadoo.fr, andi.shyti@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski@linaro.org, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 14 Jun 2023 09:31:48 +0200
In-Reply-To: <cf3e0053d2fc7391b2d906a86cd01a5ef15fb9dc.1686412569.git.christophe.jaillet@wanadoo.fr>
Message-ID: <2023061448-handsaw-villain-a59b@gregkh>
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
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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


