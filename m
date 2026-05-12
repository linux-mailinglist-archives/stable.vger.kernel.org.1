Return-Path: <stable+bounces-246476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PTLHg9vA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247F527484
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDE7630AF027
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2593134405B;
	Tue, 12 May 2026 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tkWuGl3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92662DE6E3;
	Tue, 12 May 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609323; cv=none; b=CiFConIwtNv2hiHRW0NuNWBB+dpYdQ87kyu7c9QzdiFACwYNIRpMwvvvZhiz00Q5kCZgDo1sFLjlp/AzbmJgZlBx9gFMpvDp1Ie+7yp/RbWGQA9U5HCkXjS5lGYsMSv/+GaS/lDR2pU5Did67eHQhZSSk5zAG5GLIkNjOEtXFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609323; c=relaxed/simple;
	bh=lvpaXdLD3xUkwDK/Dwa27LVj4CnuWqrG/F5g7QPtBEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyxaEpm3lsPjPsz9Ek/ay5upesnbI3j5/zbSWS8m3ry/B93lU2dS5kkv7/yaJIRvwABgNmpHxQc1Ncfoo+gzVwgktv5F7QRgVwgzrB5wyaYFw75N+um9i3J7zseDTmN0ON32PQrqkvnivsb877Q6merFNBspU/Wz/ngSZQY2Ge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tkWuGl3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E15AC2BCB0;
	Tue, 12 May 2026 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609323;
	bh=lvpaXdLD3xUkwDK/Dwa27LVj4CnuWqrG/F5g7QPtBEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkWuGl3iA2AHq6QLRHKKa79rAvnsveEPTrcJTMPIERm08XcdvZZU7jIL981DcK4Ny
	 7NIhOjUTqYHTbxIe/OaRgsaeIfzMIFL9GF+DmOFCT5zZDAhDtxaHrOi6QnJ9m/RuYh
	 Tts0B4Oz2Pnbkl85C83s9vL1kJnqKXhzM+Sellgg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 150/307] spi: microchip-core-qspi: dont attempt to transmit during emulated read-only dual/quad operations
Date: Tue, 12 May 2026 19:39:05 +0200
Message-ID: <20260512173943.294114625@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3247F527484
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246476-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conor Dooley <conor.dooley@microchip.com>

commit eb56deaabf127e8985fc91fa6c97bf8a3b062844 upstream.

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
Link: https://patch.msgid.link/20260430-freezing-saloon-95b1f3d9dad0@spud
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-microchip-core-qspi.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -662,18 +662,28 @@ static int mchp_coreqspi_transfer_one(st
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



