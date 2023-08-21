Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1108178322B
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjHUT5K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjHUT5K (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE4810E
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A986464648
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6BAC433C8;
        Mon, 21 Aug 2023 19:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647825;
        bh=1LdRl6wyw/H9W9/zpnp0rGpLhX0AJuUJwlSYhBo37Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcH+zczB0J/6fTaEr2hlfgYBODVkErryp1ZXPYfEbyqy+iWZ7kwTRnOsvjs5TT2yf
         GF+xjnRnkL0AqS6IoBR6J/9gGf2bQxvwE5AW2vVOTMSzWZpamXcEn7JmZzbha3sQfi
         OTDtVwuyg+LO/YCjE0JNw6FfzkWpcoAedbIrB5UQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 151/194] serial: 8250: Fix oops for port->pm on uart_change_pm()
Date:   Mon, 21 Aug 2023 21:42:10 +0200
Message-ID: <20230821194129.362037323@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index acf578aa9930b..38760bd6e0c29 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3281,6 +3281,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 
 	spin_lock_init(&port->lock);
+	port->pm = NULL;
 	port->ops = &serial8250_pops;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-- 
2.40.1



