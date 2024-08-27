Return-Path: <stable+bounces-70995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE1961110
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09962280D13
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A81C68A6;
	Tue, 27 Aug 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtF3Xv7d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56217C96;
	Tue, 27 Aug 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771748; cv=none; b=L76gn1tky+B/nXtplIm0FOHNq+Ksz3JEb49WbWfzbQ7qZkQGCIuuFzAfnu4lgf+hZixRcTMcBnrTn+dOzDIgCKA51zP5zDh8uwwsKStSpy5AZYdTCfyPWJWfEtbWQJ8a5V/Y4D6Mz5t1t61l6269mdRcf6hphrWKo45mFGSY+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771748; c=relaxed/simple;
	bh=zc1KL3F3E/GjN+ofvNoLMsqvV3sOwVZOd/D0VYhe1Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7/DJWVYvFB81qNGcXR+zk/m/7fHf9rfQIvUxwmEQMp9DXgs5g6yV8CnUPO2aaOivgwmEDcx6HxtHx/fjf58SaD4ioP+xrQ3dz7/81HnRUIkW9sL8832FMNiMSI4cNUCY4YGsPMIbeULRukicvy+LGj/OQSxntzbP/ejFf0gyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtF3Xv7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC18C4AF50;
	Tue, 27 Aug 2024 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771748;
	bh=zc1KL3F3E/GjN+ofvNoLMsqvV3sOwVZOd/D0VYhe1Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtF3Xv7dIgWMKm/tQJHou9LP1MlR/zfF3wjGofFznwAj37u1DS3ArBFjieKv0ZSAH
	 hT0agzqNWQhW+QSKzyDXB2tUaaF/TqX2dYertmKMSOpGyAwWwKCkblxB3xAMW6UiVr
	 JEv8rG2AKboxYBYf9w1nUeQ/PKXL3FljZwqJpRIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Othacehe <othacehe@gnu.org>,
	stable <stable@kernel.org>,
	Alexander Dahl <ada@thorsis.com>
Subject: [PATCH 6.1 001/321] tty: atmel_serial: use the correct RTS flag.
Date: Tue, 27 Aug 2024 16:35:09 +0200
Message-ID: <20240827143838.251444197@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Othacehe <othacehe@gnu.org>

commit c9f6613b16123989f2c3bd04b1d9b2365d6914e7 upstream.

In RS485 mode, the RTS pin is driven high by hardware when the transmitter
is operating. This behaviour cannot be changed. This means that the driver
should claim that it supports SER_RS485_RTS_ON_SEND and not
SER_RS485_RTS_AFTER_SEND.

Otherwise, when configuring the port with the SER_RS485_RTS_ON_SEND, one
get the following warning:

kern.warning kernel: atmel_usart_serial atmel_usart_serial.2.auto:
ttyS1 (1): invalid RTS setting, using RTS_AFTER_SEND instead

which is contradictory with what's really happening.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
Cc: stable <stable@kernel.org>
Tested-by: Alexander Dahl <ada@thorsis.com>
Fixes: af47c491e3c7 ("serial: atmel: Fill in rs485_supported")
Link: https://lore.kernel.org/r/20240808060637.19886-1-othacehe@gnu.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/atmel_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2539,7 +2539,7 @@ static const struct uart_ops atmel_pops
 };
 
 static const struct serial_rs485 atmel_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };



