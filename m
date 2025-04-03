Return-Path: <stable+bounces-127630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2BAA7A6BD
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63283BB2C0
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5905D25178B;
	Thu,  3 Apr 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z/D1SUqU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15625251781;
	Thu,  3 Apr 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693912; cv=none; b=GbPS8HGWLCjBDVKXRudGNqV6KzA5fogMhUlkrrO/JYeFLLQOX7P8q/zSOQIGkfG9MEd4PNe+q+WUgCeFRVg/LU5W6VCrd5uXdUezLc3cgAtUIsO0z3QM/lskZfgNwBC1GkTyot2h4dPRWwY3Mr5WR67CPiGwZa3m7c0w+PuM0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693912; c=relaxed/simple;
	bh=gmMRPGrvVjRkwNNWOc1Canu0QHQzeqvYW2UgbmuhvQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuBlAB99rB3yFV5wJuovnsyF4oEKCF2xtRczSpmTkTRJbJUlXNhJK1kMQoKqcWRjFFODm8OIM4m1GvZm2unSGmuPpkbgXGJx4GahQvytNZtPIJ+7lKOW2VLOEeVuc3QTeYYXo2wpZ4NJNZchYnCESxhgEQe3EeHb2rStMAmxuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/D1SUqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C84C4CEE7;
	Thu,  3 Apr 2025 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743693911;
	bh=gmMRPGrvVjRkwNNWOc1Canu0QHQzeqvYW2UgbmuhvQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/D1SUqUCxLgN9HO1TbzVqLD+42zNrJD8XkqcTL6nfcNU57Aavv1UPpcsEudXTDkP
	 cfMldLyeMdrFBUDR/B8HmWVTSsIPaQdcbDk7i26jFqQaFPCcUzhWnIuNz8B9dWI56j
	 06ulP4GqJTHmY47r6WmZ3FxcxJVAa3pnaJChFP70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Cheick Traore <cheick.traore@foss.st.com>
Subject: [PATCH 6.12 20/22] serial: stm32: do not deassert RS485 RTS GPIO prematurely
Date: Thu,  3 Apr 2025 16:20:30 +0100
Message-ID: <20250403151622.621701042@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403151622.055059925@linuxfoundation.org>
References: <20250403151622.055059925@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cheick Traore <cheick.traore@foss.st.com>

commit 2790ce23951f0c497810c44ad60a126a59c8d84c upstream.

If stm32_usart_start_tx is called with an empty xmit buffer, RTS GPIO
could be deasserted prematurely, as bytes in TX FIFO are still
transmitting.
So this patch remove rts disable when xmit buffer is empty.

Fixes: d7c76716169d ("serial: stm32: Use TC interrupt to deassert GPIO RTS in RS485 mode")
Cc: stable <stable@kernel.org>
Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
Link: https://lore.kernel.org/r/20250320152540.709091-1-cheick.traore@foss.st.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/stm32-usart.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -965,10 +965,8 @@ static void stm32_usart_start_tx(struct
 {
 	struct tty_port *tport = &port->state->port;
 
-	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char) {
-		stm32_usart_rs485_rts_disable(port);
+	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char)
 		return;
-	}
 
 	stm32_usart_rs485_rts_enable(port);
 



