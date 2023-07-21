Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206CB75D3CB
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjGUTOd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGUTOb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FF1FD7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CC6561D89
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8750CC433CA;
        Fri, 21 Jul 2023 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966869;
        bh=EQexQZUecC9KCq249OQUh9Qzb4gZ5l2iiRAgFOMoIyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r24K3Lz0txVi9aDb6Mc2PuRb6fUxJTlsKCDQwEMnwUAXxKWZFvD/aAaaxL4tLpxTh
         mj2/gx3GPZ20ZIzsh51EgPKtbo4EIne5lpTyFUo5d5wqfSISdQLwr9LHJro8GB30ss
         VRdlkpDzeDc1Pw6+vk2fWaI1d4+nIT4vjTEcB4CA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 5.15 496/532] tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
Date:   Fri, 21 Jul 2023 18:06:40 +0200
Message-ID: <20230721160641.465668079@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 832e231cff476102e8204a9e7bddfe5c6154a375 upstream.

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
 drivers/tty/serial/samsung_tty.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1509,10 +1509,18 @@ static unsigned int s3c24xx_serial_getcl
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
 


