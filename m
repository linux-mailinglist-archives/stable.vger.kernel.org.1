Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3151773E747
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFZSNu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFZSNd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00D268C
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B62F60F4E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562DFC433B9;
        Mon, 26 Jun 2023 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803203;
        bh=ADwynfRqCWEeAvlqG2MNCmJG/P7BjQ4DCLgOAbsrDKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhC4QDtksv7hxo5iPz+bAEuTuhA8DwPTHW0Uc/ecRIKIkCkjdgWJjlSyn/e/LdRGb
         313fYTO4GCPD9gU01fLjlJsjbZItb+MIfhF5rhjkYThlgmN3V+EHcLNVECyipH++VC
         H0yTumGtU88IN1Wc8H/cinL3KU/1Wxf99Tku2vM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4.14 01/26] serial: lantiq: add missing interrupt ack
Date:   Mon, 26 Jun 2023 20:11:03 +0200
Message-ID: <20230626180733.757828250@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
References: <20230626180733.699092073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -263,6 +263,7 @@ lqasc_err_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
+	ltq_w32(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);


