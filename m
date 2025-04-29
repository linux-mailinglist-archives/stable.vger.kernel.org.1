Return-Path: <stable+bounces-138631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895CFAA18D6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B431BC6FC8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D8A24633C;
	Tue, 29 Apr 2025 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0fGAc18U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7B21ABC8;
	Tue, 29 Apr 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949860; cv=none; b=an3NJQx438VdibjBfcIX0M8Ci+v6UqIcupCKIqKEEYuOiwx+GkALyTmnqz069FNIuICmixiDGza5tx2zJ6AFXCbaPcWdrH+b6rsHjpkHmPvKw6iyGS5R8e5OZif+YH417ih5YxPrkMOAYfN4TRP5oX20Te6tfFD9C6fa/1D4ooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949860; c=relaxed/simple;
	bh=hBliCIitlFJxl+N+zvpYjZUUWkg8HkhTbtjGmHvcYYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2Ek8IJxKmRNjOQK9rRdR7ELO7jR3OkVMfEY4aToKFlyidYNSGX9Mc4JbNrfRuzxstNZv8mChcQZoAr3OQw/5fYhBHMOxoEjQbJ0lGJ98+RtmpFbwylxnh3zu6f3dPVMDLe6bEizx3feV2sT9FGBICZ3OxVZwVQ3lKuwSWvvB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0fGAc18U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9608C4CEE3;
	Tue, 29 Apr 2025 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949859;
	bh=hBliCIitlFJxl+N+zvpYjZUUWkg8HkhTbtjGmHvcYYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0fGAc18U7zIies0TrYe1r6RM9Q6odMnXe4tKU0Nb8/4NyKa96uwQHhPWVWaAFjLoI
	 mmjmCTRn44RjegaB5anPIu5z6o9Fqyojak6kxM1U2N1C2opJDzPdjc/uZOYpWTON16
	 jX8iv6XZkGHeY3UfaxBoNN/Zo0d7N/iueH38XQiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 6.1 079/167] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Tue, 29 Apr 2025 18:43:07 +0200
Message-ID: <20250429161054.959612899@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryo Takakura <ryotkkr98@gmail.com>

commit e1ca3ff28ab1e2c1e70713ef3fa7943c725742c3 upstream.

startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
The register is also accessed from write() callback.

If console were printing and startup()/shutdown() callback
gets called, its access to the register could be overwritten.

Add port->lock to startup()/shutdown() callbacks to make sure
their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
write() callback.

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: stable@vger.kernel.org
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Rule: add
Link: https://lore.kernel.org/stable/20250330003522.386632-1-ryotkkr98%40gmail.com
Link: https://lore.kernel.org/r/20250412001847.183221-1-ryotkkr98@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sifive.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -583,8 +583,11 @@ static void sifive_serial_break_ctl(stru
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -592,9 +595,12 @@ static int sifive_serial_startup(struct
 static void sifive_serial_shutdown(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_disable_rxwm(ssp);
 	__ssp_disable_txwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 /**



