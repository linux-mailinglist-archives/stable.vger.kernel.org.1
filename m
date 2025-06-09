Return-Path: <stable+bounces-151992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E9FAD1933
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383E71887C55
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB028137F;
	Mon,  9 Jun 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bK/ExMvO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC628137D
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455057; cv=none; b=DVnu9qTAkbK5IBCEzXcZTLbkGFRDhWU/z1m2bx9TrnV0Wr56KnBSXW0Y0f/ULh+/KNhZXiO1j6LdwDPCJvBji9C3b8pkEry72sC4+pm4cpHI5ZbfVZKhKVabRSCS3wVLvUBeYEvro1bW8Kl0MuEmgInJ3+ZzlASC10h/JcMqQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455057; c=relaxed/simple;
	bh=qGjOULSQfrhZNYJbcbq9J/bx7G4cga14Ksr4xHqMKco=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gaOhu6hiEIcvM7Te266oZzpFQIDto8f/v4We8YrB8p3R/+twKXu4rvARcy/BJxVJHXfcIvpqCKrTjjueE4Tb0Vk49AjDR0uFpoQyvBMbkAfp0+iJIVdOrB2urA2M30de1RuuNXkcNoAYiy521IkAXat+kIkMqI2urdJmAYN2KQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bK/ExMvO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234c5b57557so35915185ad.3
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749455054; x=1750059854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MgSetHRD9od3OJ7iz2rDkPKMWGhLjKM4sQsvvkn2HM=;
        b=bK/ExMvOYEHrzxPVkf7YubFWv90BGP5KCfyqE0uIsWuBIBHYHoMr6JYcJYRpTcX/33
         jFtp6eiFQKWizVGYr0wmcfyzXYw9JLB2RKZnsDKIAauDjlJI2yidl5xTxD/4lnmYFsAc
         /ppUCLLl8PVdu3AUOFLkNDeX5cDCI1By2CzAXzZ/h+JFb8O6EhlXyG+q2pa3UhTf+ToZ
         lICK1volWOxsm1rR8aLYGZWeHWZcN1h/POo5BbkXkDz3J6qCIIexgLngATA0wQsYX9dV
         uBk7Z6yDKcQO+mJEA8ulXjsQ0ebHVaONDvOzTqT1RDd7n5JaiNxxTPT+ooO8ZJJWj23r
         QmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455054; x=1750059854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MgSetHRD9od3OJ7iz2rDkPKMWGhLjKM4sQsvvkn2HM=;
        b=sPkE+FomBg7QzU73H7RBcu+poSi8QgaUHvB+Q6HE4e0Dkb71/C3hOLeo83nfUeQA27
         PNwitcwBAz5nh1vCHSxS5QkkfOQhyefEN6ivY9gdkLDlXlRc/1OTIVBQ/cEMETEhoVem
         2kDg1tMWND5jV6oyD2j/1tsmqxgUGezSgsjWKAAMsBj3YoiMay6rHR3vv7SHLBy8Jss8
         AEpXstKVezhk98eQfngXnraj/3zXS/ncCVfM5wYwJwp4jvCTG0va5deu9ZyHzdm0WVWM
         Vr6D5QldtSLxhijqlMlD2USGKFl72w8aUcz1Rn1QVNNOVUBEKg6HjHa2VkgcPaA1k7sF
         Gx0g==
X-Forwarded-Encrypted: i=1; AJvYcCX6NA5kzpIxjgI0msV10Ftdmid5xYVjXmKDbl69NcAWAFpwCOdT/8muM/qHjIqStiSr8/HY9To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6//ITd9UEiPh+JEz3FOmlhh/VNT48Ud2RMvaLlxAeSGtwpJfH
	O709TcGDtPltjWKt4XcGfDiQvtr+/6SoddaB7R7+6X5HFitsYaooJAz4R+ZFMEK3WpA=
X-Gm-Gg: ASbGncs3KpcSfil+TDsLzypU6LDXgCkdY+TxP1BgfPhOgHDmi/vVnbAvIn7DY62hKaX
	cpi02csXrnk9ZjnfujKyomGd4+c+cPT8IZnwRLksuumeU/IvrY6QPAjEOt1TJaFZ1/DeHdd1qfe
	DYB6vZs3HEkAYf712en/mV4KwDVm9AjGdPzzmzhFaxNk/hn21pnKJ2Aj48yKRWOimppuhqaB8VR
	fSQzdsZNBnda23xkS6bbG2kR6IFIdgVYH3nVNMaWZ/KBkMNUW0G6Bvsp6K4nDTUYcncCEE4//wH
	7U8rqmVktp8VsCk48+d2JbUOFN7AepivhIWZXI6cWnbmd8TK3fI5aoXMBWr26sH+/8FwKXb3lex
	7wSZkrULMzazjOOJGhL5qX1iLt41MXgeBBNpCiHFgac9M2y7oSk3J
X-Google-Smtp-Source: AGHT+IGF35bl6kHfVcpqficVcBv0i2lmdc98JjLaSkjXXef5nwbwLjsouU+PXGgR5AeX/b1tmHYsMw==
X-Received: by 2002:a17:902:db07:b0:234:a139:1203 with SMTP id d9443c01a7336-23601d82d1bmr193428465ad.32.1749455054477;
        Mon, 09 Jun 2025 00:44:14 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm48573715ad.72.2025.06.09.00.44.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Jun 2025 00:44:13 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu,
	cuiyunhui@bytedance.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	jkeeping@inmusicbrands.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	namcao@linutronix.de,
	paulmck@kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	sunilvl@ventanamicro.com,
	tim.kryger@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH v8 2/4] serial: 8250: avoid potential PSLVERR issue
Date: Mon,  9 Jun 2025 15:43:46 +0800
Message-Id: <20250609074348.54899-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250609074348.54899-1-cuiyunhui@bytedance.com>
References: <20250609074348.54899-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PSLVERR_RESP_EN parameter is set to 1, reading UART_RX while
the FIFO is enabled and UART_LSR_DR is not set will generate a PSLVERR
error.

Failure to check the UART_LSR_DR before reading UART_RX, or the non-
atomic nature of clearing the FIFO and reading UART_RX, poses
potential risks that could lead to PSLVERR.

PSLVERR is addressed through two methods. One is to introduce
serial8250_discard_data() to check whether UART_LSR_DR is set before
reading UART_RX, thus solving the PSLVERR issue when the FIFO is
enabled. The other is to place FIFO clearing and reading of UART_RX
under port->lock.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/tty/serial/8250/8250.h      | 13 +++++++++++++
 drivers/tty/serial/8250/8250_port.c | 26 +++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 18530c31a5981..b3fb8a550db35 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -162,6 +162,19 @@ static inline u16 serial_lsr_in(struct uart_8250_port *up)
 	return lsr;
 }
 
+/*
+ * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
+ * reading UART_RX.
+ */
+static inline void serial8250_discard_data(struct uart_8250_port *up)
+{
+	u16 lsr;
+
+	lsr = serial_in(up, UART_LSR);
+	if (lsr & UART_LSR_DR)
+		serial_in(up, UART_RX);
+}
+
 /*
  * For the 16C950
  */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 07fe818dffa34..0560df9b064f9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -764,8 +764,6 @@ static void disable_rsa(struct uart_8250_port *up)
 
 	if (up->port.type == PORT_RSA &&
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		uart_port_lock_irq(&up->port);
-
 		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
 
@@ -777,7 +775,6 @@ static void disable_rsa(struct uart_8250_port *up)
 
 		if (result)
 			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		uart_port_unlock_irq(&up->port);
 	}
 }
 #endif /* CONFIG_SERIAL_8250_RSA */
@@ -1353,9 +1350,8 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	/* Synchronize UART_IER access against the console. */
 	uart_port_lock_irq(port);
 	serial_out(up, UART_IER, UART_IER_ALL_INTR);
+	serial8250_discard_data(up);
 	uart_port_unlock_irq(port);
-	serial_in(up, UART_LSR);
-	serial_in(up, UART_RX);
 	serial_in(up, UART_IIR);
 	serial_in(up, UART_MSR);
 	serial_out(up, UART_TX, 0xFF);
@@ -2260,13 +2256,20 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
 	 */
+	uart_port_lock_irqsave(port, &flags);
 	serial8250_clear_fifos(up);
 
 	/*
-	 * Clear the interrupt registers.
+	 * Read UART_RX to clear interrupts (e.g., Character Timeout).
+	 * To prevent PSLVERR, we can either disable the FIFO before reading
+	 * UART_RX or read UART_RX only when UART_LSR_DR is set while the FIFO
+	 * remains enabled. If using the latter approach to avoid PSLVERR, it
+	 * creates a contradiction with the interrupt-clearing (see the
+	 * rx_timeout handling in dw8250_handle_irq()).
 	 */
 	serial_port_in(port, UART_LSR);
 	serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 
@@ -2423,15 +2426,13 @@ int serial8250_do_startup(struct uart_port *port)
 		}
 	}
 
-	uart_port_unlock_irqrestore(port, flags);
-
 	/*
 	 * Clear the interrupt registers again for luck, and clear the
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	serial8250_discard_data(up);
+	uart_port_unlock_irqrestore(port, flags);
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 	up->lsr_saved_flags = 0;
@@ -2513,7 +2514,6 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2532,8 +2532,12 @@ void serial8250_do_shutdown(struct uart_port *port)
 	/*
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
+	 *
+	 * Since reading UART_RX clears interrupts, doing so with
+	 * FIFO disabled won't trigger PSLVERR.
 	 */
 	serial_port_in(port, UART_RX);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 
 	up->ops->release_irq(up);
-- 
2.39.5


