Return-Path: <stable+bounces-137302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D1AA12B0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110E216E7A8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFF3253F21;
	Tue, 29 Apr 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BwHCdyte"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA6253F09;
	Tue, 29 Apr 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945663; cv=none; b=hIz3DvfnobHCmkt2y+yrFH8S2c7NGLMzra5kblt7rMJZLyr6c0KogiID7nuIqrysmlKbKtqYhLjooJCW329NGiq8Wo0UShzewCQYPrVn30v6wupnJj57NOxlqVVxpyCdmFBjFy9hgTT0B9M3lBSQxqrbMJZTkEuDXYkenJUn38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945663; c=relaxed/simple;
	bh=vCrM5pZq+aE8Nr3kuQxypblm1T7YPLJ/QUAmB0QnDG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdLp/geNagadhbIRXrssS6aUjV9XvBefWQe/byFbBQ4aqahL8D2Cqj6mWbJmb1TOAzZA0LFhqd/CHSWrU6I5Y8t8m3JxJLqejKFkemtlML0+AlwFsCckQUUb5TbHRQ+qiEWicylkuUJ/4TmKnizmMOWfTbLf8p4YLRF7wdCOuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BwHCdyte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07379C4CEEA;
	Tue, 29 Apr 2025 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945663;
	bh=vCrM5pZq+aE8Nr3kuQxypblm1T7YPLJ/QUAmB0QnDG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwHCdytetmw4VU5l2VUu8pPEIDlYEUZ+Hc7iTB9BeUemXXdumTrY8iDH704/Fo0+B
	 ynAyBKmQzwpw+zeL6PCHXPFBhAKM38XdxLjKsHMGpoa1uKvf0IAXrzQo8BYSkn+NxU
	 XHN4SPZH6kvtkAfBgZiL3WiorOIW4HzCRfo6Iqyk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 5.4 149/179] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Tue, 29 Apr 2025 18:41:30 +0200
Message-ID: <20250429161055.414786153@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -596,8 +596,11 @@ static void sifive_serial_break_ctl(stru
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -605,9 +608,12 @@ static int sifive_serial_startup(struct
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



