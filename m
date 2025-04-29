Return-Path: <stable+bounces-137478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0266AA1391
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A3E4C3A09
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CC924C067;
	Tue, 29 Apr 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndBViScG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91900229B05;
	Tue, 29 Apr 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946185; cv=none; b=kzBoN7Ja/pitXbCEihNe8kn9R7AWTlQ/t3GPPXDNlavAURIJjKmdHyTKNmpA3On1enm8Efga8AD8HvU1+6BeLxVSEm1lsgxn+HmWl8mlQt4Wi2l3aUt2Pi3XwWU9GWUFONY78L9gC9Q6lT5NwzsgxxG+3O95GDuklr36euP4gzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946185; c=relaxed/simple;
	bh=WVT2/Rh3Ecj++8d/NjJU52xtnpaiPLdMR4yQ3utzeHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV8UmsXcvkui0X9P0l1Zsn+X3n9qxeMOMjpZqq0PnIW0Uc7LpzflsMrXPVEXPfh66PrygVModRyfVZTVevrkmy99boCXphmB1DgNjjr4c8XFluZDKU7m8k9gNW19UdF1luv9l4c0RgSSy63mCn3dI91MPOgM+7mnxZOM+x5o/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndBViScG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED193C4CEE3;
	Tue, 29 Apr 2025 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946185;
	bh=WVT2/Rh3Ecj++8d/NjJU52xtnpaiPLdMR4yQ3utzeHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndBViScGH1/Qv80lwvvDE3G08XeMYdZHd/PhmZaRAeRG6OmAct/y8MBXURctsrk+I
	 7kS6+G6MZ/oKg9hAWcClFXnyOg6yEOa3/anBE0ZV1PwZ2I6z7qHW+nFCi9rLNEypg8
	 lvfIwmIv4ikBKC3FaAsrG50cWlxPigeuSYFz2Lfw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 6.14 154/311] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Tue, 29 Apr 2025 18:39:51 +0200
Message-ID: <20250429161127.342995168@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -563,8 +563,11 @@ static void sifive_serial_break_ctl(stru
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -572,9 +575,12 @@ static int sifive_serial_startup(struct
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



