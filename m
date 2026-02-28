Return-Path: <stable+bounces-220468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCviETs4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60FF1C6414
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BABA30E3EFA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992403BF4F3;
	Sat, 28 Feb 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOas6iMT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95F3BF4EA;
	Sat, 28 Feb 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300355; cv=none; b=KjrTnNIZHY3cGdYmyZL/1PXn3Y/yO8dLYXCA914oK9AK5+W0hNXbTeBnydVI2m4sjV7a2E2bdXHXHbeyfuubsRcJOsixLXJGGFqQK8akee1novJeA3gyA2h0cCiz+Ozfty2jkEXa2jb2Z7f+/lp//PUE39QphpZ4NnQ0MXsFV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300355; c=relaxed/simple;
	bh=i8/3pj5C23rWp+g8HgYnKimhcpObrbmR5Xq/logB+3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8CRRkF3wNr79+TrvMw8IxuauAAhBwVUs6O3qBW6+WMxIM7IEv/3fDTRikaS52qhRFwb8eH2dVuk7onSMuAn58w07U63rawI/ycvOZwoNlqaDuD6GW592GzFRKlp5SrQv29HFAUQ/scQkaDz7tGKrYUipGsj4LyH6goCug5nbBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOas6iMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F67C116D0;
	Sat, 28 Feb 2026 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300355;
	bh=i8/3pj5C23rWp+g8HgYnKimhcpObrbmR5Xq/logB+3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOas6iMTZCSDZfvtFJ0Fj7OOoV8GS5MVQUSFLOXZzBDHa4XDH1njKFGDF8g/o5tMG
	 cd7o4gPlbg/tdKPs4+zMzw+ufxLao8WZjR+OOe6qUnscZ9Vcjep4loJKwdvq63XKJH
	 yFOxkMKrO1htIkrG1/cLTrtHhWk7xqBUr+s3bNkMaAlgRnMKJeOk6UEOAhzZnT6Sgu
	 usYYOC0wWWLuYbQHxFkbt9Ltiv06/qbRoyynZKnpLz21k+cm3ovnExSJb0puW9NivC
	 EoH5Ppx105fr4aEDZwAPa7GpSpdlZZUiGIDcSMVV2r1bdKC/aSw9VpOLz27NWOS0DL
	 C0oMipT61ecRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Moteen Shah <m-shah@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 389/844] serial: 8250: 8250_omap.c: Add support for handling UART error conditions
Date: Sat, 28 Feb 2026 12:25:02 -0500
Message-ID: <20260228173244.1509663-390-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220468-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C60FF1C6414
X-Rspamd-Action: no action

From: Moteen Shah <m-shah@ti.com>

[ Upstream commit 623b07b370e9963122d167e04fdc1dc713ebfbaf ]

The DMA IRQ handler does not accounts for the overrun(OE) or any other
errors being reported by the IP before triggering a DMA transaction which
leads to the interrupts not being handled resulting into an IRQ storm.

The way to handle OE is to:
1. Reset the RX FIFO.
2. Read the UART_RESUME register, which clears the internal flag

Earlier, the driver issued DMA transations even in case of OE which shouldn't
be done according to the OE handling mechanism mentioned above, as we are
resetting the FIFO's, refer section: "12.1.6.4.8.1.3.6 Overrun During
Receive" [0].

[0] https://www.ti.com/lit/pdf/spruiu1

Signed-off-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260112081829.63049-2-m-shah@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 9e49ef48b851b..e26bae0a6488f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -100,6 +100,9 @@
 #define OMAP_UART_REV_52 0x0502
 #define OMAP_UART_REV_63 0x0603
 
+/* Resume register */
+#define UART_OMAP_RESUME		0x0B
+
 /* Interrupt Enable Register 2 */
 #define UART_OMAP_IER2			0x1B
 #define UART_OMAP_IER2_RHR_IT_DIS	BIT(2)
@@ -119,7 +122,6 @@
 /* Timeout low and High */
 #define UART_OMAP_TO_L                 0x26
 #define UART_OMAP_TO_H                 0x27
-
 struct omap8250_priv {
 	void __iomem *membase;
 	int line;
@@ -1256,6 +1258,20 @@ static u16 omap_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir, u16 status
 	return status;
 }
 
+static void am654_8250_handle_uart_errors(struct uart_8250_port *up, u8 iir, u16 status)
+{
+	if (status & UART_LSR_OE) {
+		serial8250_clear_and_reinit_fifos(up);
+		serial_in(up, UART_LSR);
+		serial_in(up, UART_OMAP_RESUME);
+	} else {
+		if (status & (UART_LSR_FE | UART_LSR_PE | UART_LSR_BI))
+			serial_in(up, UART_RX);
+		if (iir & UART_IIR_XOFF)
+			serial_in(up, UART_IIR);
+	}
+}
+
 static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
 				     u16 status)
 {
@@ -1266,7 +1282,8 @@ static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
 	 * Queue a new transfer if FIFO has data.
 	 */
 	if ((status & (UART_LSR_DR | UART_LSR_BI)) &&
-	    (up->ier & UART_IER_RDI)) {
+	    (up->ier & UART_IER_RDI) && !(status & UART_LSR_OE)) {
+		am654_8250_handle_uart_errors(up, iir, status);
 		omap_8250_rx_dma(up);
 		serial_out(up, UART_OMAP_EFR2, UART_OMAP_EFR2_TIMEOUT_BEHAVE);
 	} else if ((iir & 0x3f) == UART_IIR_RX_TIMEOUT) {
@@ -1282,6 +1299,8 @@ static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
 		serial_out(up, UART_OMAP_EFR2, 0x0);
 		up->ier |= UART_IER_RLSI | UART_IER_RDI;
 		serial_out(up, UART_IER, up->ier);
+	} else {
+		am654_8250_handle_uart_errors(up, iir, status);
 	}
 }
 
-- 
2.51.0


