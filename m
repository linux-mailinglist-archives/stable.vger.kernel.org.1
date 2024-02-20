Return-Path: <stable+bounces-21680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C8A85C9E2
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869DB1C224B9
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F00151CF1;
	Tue, 20 Feb 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G6zsUZ6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D28151CEA;
	Tue, 20 Feb 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465174; cv=none; b=GirFuSnVHJOGb+XwYbiF3GXQgbisdABqt54EgjttzHguVX9Bh+HjPcbXuNxayIOKVnCA8rSlT/iNns2AMe+HFKhMPDCTzGYDMyQ4bL5BVInIqNvD8Dw/hsbKt1M1sxKvHllg1B2imUnXPt+JfhavFcSiOiGRPTRmyufo5KJqIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465174; c=relaxed/simple;
	bh=d6Q2MWrIIRohgQawY/gjQA0mQ/vo5F3m3fRun4tOHiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQcuYnorwnyybyFr2Cbvpo4FNEjBm2zivtEHnQqAD7gTnzZl3FVXfPShgGmSyJcOnig0NGHiC3qYR4BYIttmgW2d4UJwGZjjj8yPzMgWyHEfU5gOmOpij1/GfXE+kw0j5uKKbzwyYb9QXSBswPa6k431zkNkJjJIUwO0jQ/iSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G6zsUZ6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820FFC433C7;
	Tue, 20 Feb 2024 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708465174;
	bh=d6Q2MWrIIRohgQawY/gjQA0mQ/vo5F3m3fRun4tOHiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6zsUZ6IhWEl5ZtfMfBLr7I15j1V+BCLBglxvQHrc2XQ6ZYRI6frkgtqmOb9OYFMh
	 vHRPUlBE1CB9uyT3Z3QmOcztBu6HP2e/znuw8t5HppOegsUzz26lP9GL4wyefwXfAi
	 RB4pVeS47emDcVivGrZihX761pXIijQywUOk/oko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Emil Kronborg <emil.kronborg@protonmail.com>,
	stable <stable@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 6.7 230/309] serial: mxs-auart: fix tx
Date: Tue, 20 Feb 2024 21:56:29 +0100
Message-ID: <20240220205640.347305016@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

commit 7be50f2e8f20fc2299069b28dea59a28e3abe20a upstream.

Emil reports:
  After updating Linux on an i.MX28 board, serial communication over
  AUART broke. When I TX from the board and measure on the TX pin, it
  seems like the HW fifo is not emptied before the transmission is
  stopped.

MXS performs weird things with stop_tx(). The driver makes it
conditional on uart_tx_stopped().

So the driver needs special handling. Pass the brand new UART_TX_NOSTOP
to uart_port_tx_flags() and handle the stop on its own.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Reported-by: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: stable <stable@kernel.org>
Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
Closes: https://lore.kernel.org/all/miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw/
Tested-by: Stefan Wahren <wahrenst@gmx.net>
Tested-by: Emil Kronborg <emil.kronborg@protonmail.com>
Link: https://lore.kernel.org/r/20240201105557.28043-2-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/mxs-auart.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -605,13 +605,16 @@ static void mxs_auart_tx_chars(struct mx
 		return;
 	}
 
-	pending = uart_port_tx(&s->port, ch,
+	pending = uart_port_tx_flags(&s->port, ch, UART_TX_NOSTOP,
 		!(mxs_read(s, REG_STAT) & AUART_STAT_TXFF),
 		mxs_write(ch, s, REG_DATA));
 	if (pending)
 		mxs_set(AUART_INTR_TXIEN, s, REG_INTR);
 	else
 		mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
+
+	if (uart_tx_stopped(&s->port))
+               mxs_auart_stop_tx(&s->port);
 }
 
 static void mxs_auart_rx_char(struct mxs_auart_port *s)



