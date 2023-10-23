Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5557D32D8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjJWLYc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjJWLYa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:24:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445D1711
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:24:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF0EC433CA;
        Mon, 23 Oct 2023 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060252;
        bh=VnQbWLmW2QGqerW6B4J2e/G8eoOViJ7scpHat0/rsFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etos3+UMgPbmSWcQPsKEikU+PCmEHpoGXoZWmqNT62g1JTOYqhvQVKDh2EjT4rxal
         51nJWQA8b1Q3PgPXoWvvC3DImGV8JzjZUf4T9+x/HmyjgPlVqLuEDRct66TUhVWB9H
         rH7YKdOGmliTb2qSIkIsb9/AW1Zqf/LksmN+Vlu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 083/196] serial: Rename uart_change_speed() to uart_change_line_settings()
Date:   Mon, 23 Oct 2023 12:55:48 +0200
Message-ID: <20231023104830.891868738@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 826736a6c7c8c3185bfb10e03c10d03d53d6cf94 ]

uart_change_speed() changes more than just speed so rename it to more
generic uart_change_line_settings().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230309080923.11778-6-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8679328eb859 ("serial: Reduce spinlocked portion of uart_rs485_config()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 07e694c4f4827..25972767129a3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -176,8 +176,8 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
 }
 
 /* Caller holds port mutex */
-static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
-			      const struct ktermios *old_termios)
+static void uart_change_line_settings(struct tty_struct *tty, struct uart_state *state,
+				      const struct ktermios *old_termios)
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct ktermios *termios;
@@ -276,7 +276,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		/*
 		 * Initialise the hardware port settings.
 		 */
-		uart_change_speed(tty, state, NULL);
+		uart_change_line_settings(tty, state, NULL);
 
 		/*
 		 * Setup the RTS and DTR signals once the
@@ -992,7 +992,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 				      current->comm,
 				      tty_name(port->tty));
 			}
-			uart_change_speed(tty, state, NULL);
+			uart_change_line_settings(tty, state, NULL);
 		}
 	} else {
 		retval = uart_startup(tty, state, 1);
@@ -1654,7 +1654,7 @@ static void uart_set_termios(struct tty_struct *tty,
 		goto out;
 	}
 
-	uart_change_speed(tty, state, old_termios);
+	uart_change_line_settings(tty, state, old_termios);
 	/* reload cflag from termios; port driver may have overridden flags */
 	cflag = tty->termios.c_cflag;
 
@@ -2454,7 +2454,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			ret = ops->startup(uport);
 			if (ret == 0) {
 				if (tty)
-					uart_change_speed(tty, state, NULL);
+					uart_change_line_settings(tty, state, NULL);
 				spin_lock_irq(&uport->lock);
 				if (!(uport->rs485.flags & SER_RS485_ENABLED))
 					ops->set_mctrl(uport, uport->mctrl);
-- 
2.40.1



