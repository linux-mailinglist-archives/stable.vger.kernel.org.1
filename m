Return-Path: <stable+bounces-129136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5AA7FE52
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946663BD378
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04622690D5;
	Tue,  8 Apr 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ovsSBkPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFD268C72;
	Tue,  8 Apr 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110212; cv=none; b=QgcPW9gdQaDVdsaTXHbBGYQxjBCUz9KbnFkd/dpGUQZnAzirj3pFHspv7xs7hGAXcRUSafdLR2sapSZsmNyLva7NAfgea5rxh37auNcjOxdv5nl6fddTPoj7ETcvMZi5aDW+0DKadq4tsgOc/sYm9K/VYaF0J6A/UOx4QQG/kGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110212; c=relaxed/simple;
	bh=eEfLdzG+5LDA3GvoCmQcnL8GEBuFJ2lYa+UrKFwOBrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blkrABEvvl6YQSMF6zrtWf56FhtEHh7vZBUj964jeXuwR7GPimd4k4M5WDwvKK8ZV3SLPMiqgeQCpMCkYfjuNPEIcGAeBJuNlnQ3MpXCAcyLGjHyPYXifocK4PG58CZAQKBAhfH7u3Fzab4TYUCraB7Y3iew5YqBCor94S8qNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ovsSBkPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEDCC4CEE5;
	Tue,  8 Apr 2025 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110212;
	bh=eEfLdzG+5LDA3GvoCmQcnL8GEBuFJ2lYa+UrKFwOBrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovsSBkPHutdx4pyyHp8JVyEiT0YXjPGbZNWEjJcKHiEkj9ZXcnvmcouioY8G2HAox
	 G2E5ZQpBogLmcEqKda3Z/Azg/FvI1/vCkgm9EUvbDaOU3WA1g4IlwyKOWg77nSPuIy
	 ZlMEdRwzTfscUqrlxERn/YLufQwDHiX38MaDzcOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 207/227] tty: serial: fsl_lpuart: use UARTMODIR register bits for lpuart32 platform
Date: Tue,  8 Apr 2025 12:49:45 +0200
Message-ID: <20250408104826.523472417@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sherry Sun <sherry.sun@nxp.com>

[ Upstream commit d57d56e4dddfb5c92cd81abf8922055bf0fb85a4 ]

For lpuart32 platforms, UARTMODIR register is used instead of UARTMODEM.
So here should configure the corresponding UARTMODIR register bits to
avoid confusion.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Link: https://lore.kernel.org/r/20230414022111.20896-1-sherry.sun@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f5cb528d6441 ("tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b16ad6db1ef8e..5135cdc0b6644 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1351,7 +1351,7 @@ static int lpuart32_config_rs485(struct uart_port *port,
 			struct lpuart_port, port);
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
-				& ~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
+				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	/* clear unsupported configurations */
@@ -1361,7 +1361,7 @@ static int lpuart32_config_rs485(struct uart_port *port,
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
-		modem |= UARTMODEM_TXRTSE;
+		modem |= UARTMODIR_TXRTSE;
 
 		/*
 		 * RTS needs to be logic HIGH either during transfer _or_ after
@@ -1383,9 +1383,9 @@ static int lpuart32_config_rs485(struct uart_port *port,
 		 * Note: UART is assumed to be active high.
 		 */
 		if (rs485->flags & SER_RS485_RTS_ON_SEND)
-			modem |= UARTMODEM_TXRTSPOL;
+			modem |= UARTMODIR_TXRTSPOL;
 		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
-			modem &= ~UARTMODEM_TXRTSPOL;
+			modem &= ~UARTMODIR_TXRTSPOL;
 	}
 
 	/* Store the new configuration */
-- 
2.39.5




