Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2F9761748
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjGYLqq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjGYLqn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC91FD7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 484C16169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582A5C433C8;
        Tue, 25 Jul 2023 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285595;
        bh=2Boqgdv+d+CAbaPylFU5D9+yQB76GtZgHvvqAMNFois=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEkAc/Cl2pLedhJjBbcXxVWlv5/HBDwaxleWBGn3/+djGZGw2uRMlofp8R/Higu98
         8n8hQ7GMU819X36j9U1H+NRkGCSRxyI6zlGcg9CVTJ5/I85/3IJElw+7jgviPAXLZD
         i66ocFsp/6TgDxaUvnRIUua17sDuJ1h/rg4wM0QU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 5.4 262/313] tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
Date:   Tue, 25 Jul 2023 12:46:55 +0200
Message-ID: <20230725104532.390623539@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit a9c09546e903f1068acfa38e1ee18bded7114b37 upstream.

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
 drivers/tty/serial/samsung.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1199,8 +1199,12 @@ static unsigned int s3c24xx_serial_getcl
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


