Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D787352B4
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjFSKh3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjFSKhS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D47E60
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D2060B6D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E487C433C0;
        Mon, 19 Jun 2023 10:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171035;
        bh=b4c1v+rZ9P9t7NSY+l6rjJiBvjWbpq2N2ybsmiBhO34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ip11h7jUSoLh1zRV9Njfi9o42Jy7wXoSA43uymcp5AyVx07X+FuOEGWHhG/dDnLD6
         mfDYQIURYhoIpEm8a5wptcFN/AoSCmau0pRvxsK/jZCUmBhgh5NC9Pi1kchYl4UqFX
         T/foSNIpdry9XqgBdpxcvGMvCNu+Ns3wPHVaxYfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.3 098/187] serial: lantiq: add missing interrupt ack
Date:   Mon, 19 Jun 2023 12:28:36 +0200
Message-ID: <20230619102202.332219143@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bernhard Seibold <mail@bernhard-seibold.de>

commit 306320034e8fbe7ee1cc4f5269c55658b4612048 upstream.

Currently, the error interrupt is never acknowledged, so once active it
will stay active indefinitely, causing the handler to be called in an
infinite loop.

Fixes: 2f0fc4159a6a ("SERIAL: Lantiq: Add driver for MIPS Lantiq SOCs.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Message-ID: <20230602133029.546-1-mail@bernhard-seibold.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/lantiq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -250,6 +250,7 @@ lqasc_err_int(int irq, void *_port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
+	__raw_writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);


