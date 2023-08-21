Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0667D783294
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjHUUIb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHUUIb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2CCDF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB1164A28
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675BBC433C7;
        Mon, 21 Aug 2023 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648508;
        bh=y1dRbUDI8YwEXTR7tC2httjr7xXGPh3SKF/bYDcTrMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMI1PjllOtBAunfGuPidIEg9Sgkwxiu6N3rQZOcrUYuisqdoLJ5HSwuafMr8NLub3
         ZwraIRzqhAMPxnY4AJHYzAODio7Nlv1Nvqi3VN1SaJI5JPsPYZWf13rl8ngSIBnERz
         J7kviABFnfHHwnoz8xE6m9w/6a330qxnmYiBjeuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 201/234] serial: 8250: Fix oops for port->pm on uart_change_pm()
Date:   Mon, 21 Aug 2023 21:42:44 +0200
Message-ID: <20230821194137.732779317@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit dfe2aeb226fd5e19b0ee795f4f6ed8bc494c1534 ]

Unloading a hardware specific 8250 driver can produce error "Unable to
handle kernel paging request at virtual address" about ten seconds after
unloading the driver. This happens on uart_hangup() calling
uart_change_pm().

Turns out commit 04e82793f068 ("serial: 8250: Reinit port->pm on port
specific driver unbind") was only a partial fix. If the hardware specific
driver has initialized port->pm function, we need to clear port->pm too.
Just reinitializing port->ops does not do this. Otherwise serial8250_pm()
will call port->pm() instead of serial8250_do_pm().

Fixes: 04e82793f068 ("serial: 8250: Reinit port->pm on port specific driver unbind")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20230804131553.52927-1-tony@atomide.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 053d44412e42f..0a67dff575f78 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3288,6 +3288,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 
 	spin_lock_init(&port->lock);
+	port->pm = NULL;
 	port->ops = &serial8250_pops;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-- 
2.40.1



