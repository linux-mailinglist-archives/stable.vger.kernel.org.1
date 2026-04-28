Return-Path: <stable+bounces-241712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE90GX3g8GmoagEAu9opvQ
	(envelope-from <stable+bounces-241712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:29:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2677D488E86
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47065309AD07
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672A646AF04;
	Tue, 28 Apr 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr5uUgjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2C3C1406;
	Tue, 28 Apr 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392760; cv=none; b=EZrr+E7odIBGkp5A+sKsvEgpYnchsGtD0QFS1D4zIBnCK/eRzaVQ2fLQvoTq0VFdHWckNMEQvtbuPHq3Y6bRCB8pYvdA09F6F+ZTqsGBkz9stePwBvPh/hW/eAnlTQtdhAgYrITK6pIuAwrF9GOF6EIS9ZXGB64ePhPo70l4nB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392760; c=relaxed/simple;
	bh=kxxeRh+fiRBAkPPQ6Ege8TcSd/UDjWuIziK+9tp8mck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLamg0aOnJcp1g/UNDIJnP7Vl0xejyPoc7lakC2VsbL/Y1fPXd2+ISinjOR3ThADNE6JGF1ln8JbB7xo5cXlSbCO0x39JMwOI/MOM5eMV3LdLH/ud+RXxIrAOnwvSAQALdddXh8fUzoa3NKM/PWnTF273v4uIy0+O006m6Y/GaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr5uUgjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC618C2BCB5;
	Tue, 28 Apr 2026 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392759;
	bh=kxxeRh+fiRBAkPPQ6Ege8TcSd/UDjWuIziK+9tp8mck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zr5uUgjAiwDDNiO5RdBkwMQqczxPCPHO8vmjveAqjkFhvjgL1qKFOsnf5BCTmdp40
	 NDbbhIkbfGDlnpZdrhDwfo/y8Zx/jyTsaFJyLQDoFQ3/uCPKbzZGzo/enWsgT30JrB
	 ct6s6Wrvolvm9BIPAj46bK72BjJjSwMPSdlh8rvlOTzC8w8D+fZuDWvccC72Oq7BTN
	 IYWnqc+F/b+Yo9UvHvbAfvoMD19uheFZRamYFKg9fqCw5oSyriK1rIR09NCRY9IFmX
	 ccphEexyQpOF5vv945jVUOBmm5he616hUzVKUsIPzJgHlM3HYKy5ItwlOje2JDSNLR
	 yks4T5YWJ2UEw==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
Date: Tue, 28 Apr 2026 17:12:06 +0100
Message-ID: <20260428-directly-stroller-f6551c3dca16@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428-plexiglas-smith-6ae4e9ba8abd@spud>
References: <20260428-plexiglas-smith-6ae4e9ba8abd@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=659GQtxfjWiZygrLJrj8jZ6QG6PovzBK+5ouTwOvfAE=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkf7iQ6T/rAp1WhaGNTK3tC7EQiG0NR0nqvOU+V+S23R R9VsdnQUcrCIMbFICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgInUtzMytEzQPZtxoU/LazHD MsWEjsMT2xd26bJ6++71mrWifdcvA4Y/fAlv9jUe6PYNeRd4/F7svnWOna5ru96m3KsxnO//hms iHwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2677D488E86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241712-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Conor Dooley <conor.dooley@microchip.com>

The core will deal with reads by creating clock cycles itself, there's
no need to generate clock cycles by transmitting garbage data at the
driver level. Further, transmitting garbage data just bricks the transfer
since QSPI doesn't have a dedicated master-out line like MOSI in regular
SPI. I'm not entirely sure if the transfer is bricked because of the
garbage data being transmitted on the bus or because the core loses
track of whether it is supposed to be sending or receiving data.

Fixes: 8f9cf02c88528 ("spi: microchip-core-qspi: Add regular transfers")
CC: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 7bd2c9dcd4771..dd3644ee80c6f 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -693,18 +693,28 @@ static int mchp_coreqspi_transfer_one(struct spi_controller *ctlr, struct spi_de
 				      struct spi_transfer *t)
 {
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+	bool dual_quad = false;
 
 	qspi->tx_len = t->len;
 
+	if (t->tx_nbits == SPI_NBITS_QUAD || t->rx_nbits == SPI_NBITS_QUAD ||
+			t->tx_nbits == SPI_NBITS_DUAL ||
+			t->rx_nbits == SPI_NBITS_DUAL)
+		dual_quad = true;
+
 	if (t->tx_buf)
 		qspi->txbuf = (u8 *)t->tx_buf;
 
 	if (!t->rx_buf) {
 		mchp_coreqspi_write_op(qspi);
-	} else {
+	} else if (!dual_quad) {
 		qspi->rxbuf = (u8 *)t->rx_buf;
 		qspi->rx_len = t->len;
 		mchp_coreqspi_write_read_op(qspi);
+	} else {
+		qspi->rxbuf = (u8 *)t->rx_buf;
+		qspi->rx_len = t->len;
+		mchp_coreqspi_read_op(qspi);
 	}
 
 	return 0;
-- 
2.53.0


