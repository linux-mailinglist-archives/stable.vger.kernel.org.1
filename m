Return-Path: <stable+bounces-264068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8kvAUFuMWqUjAUAu9opvQ
	(envelope-from <stable+bounces-264068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:39:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E41691408
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:39:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=EXGwnzJM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264068-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264068-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2A7131467CC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C5E44B696;
	Tue, 16 Jun 2026 15:32:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169943DA2D;
	Tue, 16 Jun 2026 15:32:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623956; cv=none; b=G+oxsM5WSQvWodlCxBT23SRMOueFSUiimm63To0VjNY1f17Rs8iyKKkMtwSZA35R1NiEHWtnpfr4gUZOduwoNHkbFhSC5teibwcmG58LNRC7cevua448UD3WgzWy0XZOHaKlRJGmZ5eLw6lXj/54jxwl2HWlflRJZ2jo2euQXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623956; c=relaxed/simple;
	bh=PwoRco4fo2tiAPY/Yr78YUE7DEpZCzCw1+NTFB+5af4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xz7kBgkSrGRuvUl5kanccj9uNLtKg3hzmWOGHzbAOYEGOid/1xwKjLZ78rAF3cMPgrphRSevKqt5zyfi1BTIP0dglqAOiqgHqPYg5/rd+irYphc43asRAFBaXscRjpFFo2AFRZFEwImRKQDyBpr168ZzJCQyZaOgr1bRAPicSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EXGwnzJM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF961F00A3D;
	Tue, 16 Jun 2026 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623955;
	bh=27ON05D8ALg/h5bz3eUvjaMWMvnSUrYFlHF4EctGft4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EXGwnzJM9Fw+6rucCePLHDRqv7BKc1iWEx0RlyQ4f8E3gilKhfa4CNTBQwKw4/frI
	 9C6fL/TFsJpjsKIXU+pYHslpN4yhnZuh16x53tLYWnXhDEx9mrXkY6K+5Z1WmEu5jV
	 T5/p+lKL9IOmYn4jigJ1CxCJKbu3pzzdZaNMtnFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Marek <jonathan@marek.ca>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 246/378] spi: qcom-geni: Fix cs_change handling on the last transfer
Date: Tue, 16 Jun 2026 20:27:57 +0530
Message-ID: <20260616145123.136087253@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264068-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jonathan@marek.ca,m:viken.dadhaniya@oss.qualcomm.com,m:broonie@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56E41691408

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

commit 5ac5ec84734fd338867055d4d7b650f18a023cb0 upstream.

TPM TIS SPI probe fails with:

   tpm_tis_spi: probe of spi11.0 failed with error -110

TPM TIS SPI sets cs_change=1 on single-transfer messages to keep CS
asserted across the header, wait-state, and data phases of a transaction.
CS deassertion between these phases violates the TCG SPI flow control
specification.

This bug was introduced by commit b99181cdf9fa ("spi-geni-qcom: remove
manual CS control"), which replaced manual CS control with automatic CS
control via the FRAGMENTATION bit. The FRAGMENTATION bit controls CS
behavior after a transfer: when set to 1, CS remains asserted; when
cleared to 0, CS is deasserted.

The commit correctly sets FRAGMENTATION for non-last transfers with
cs_change=0 to keep CS asserted between chained transfers, but misses the
case where cs_change=1 is set on the last transfer. When cs_change=1 on
the last transfer, the client requests CS to remain asserted after the
message completes, so FRAGMENTATION must be set to 1 in this case as well.

Fix setup_se_xfer() to set FRAGMENTATION when cs_change=1 on the last
transfer.

Also fix the same missing case in setup_gsi_xfer() and correct it to
write 1 instead of the raw bitmask FRAGMENTATION (value 4) to
peripheral.fragmentation. This field is a 1-bit boolean consumed by
gpi_create_spi_tre() via u32_encode_bits(..., TRE_SPI_GO_FRAG). Writing 4
to a 1-bit field causes u32_encode_bits() to mask it to 0, silently
disabling the FRAGMENTATION bit in the GPI TRE regardless of the
cs_change logic.

Fixes: b99181cdf9fa ("spi-geni-qcom: remove manual CS control")
Cc: stable@vger.kernel.org
Reviewed-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Link: https://patch.msgid.link/20260609-fix-spi-fragmentation-bit-logic-v2-1-e18efc255563@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-geni-qcom.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d5fb0edc8e0c..23c6d3a37341 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -440,10 +440,15 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		return ret;
 	}
 
-	if (!xfer->cs_change) {
-		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
-			peripheral.fragmentation = FRAGMENTATION;
-	}
+	/*
+	 * Set fragmentation to keep CS asserted after this transfer when:
+	 *  - non-last transfer with cs_change=0: keep CS asserted between chained transfers
+	 *  - last transfer with cs_change=1: keep CS asserted after the message
+	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
+	 *     keep CS asserted across header, wait-state and data phases)
+	 */
+	peripheral.fragmentation = list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
+				   xfer->cs_change : !xfer->cs_change;
 
 	if (peripheral.cmd & SPI_RX) {
 		dmaengine_slave_config(mas->rx, &config);
@@ -849,10 +854,16 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 		mas->cur_xfer_mode = GENI_SE_DMA;
 	geni_se_select_mode(se, mas->cur_xfer_mode);
 
-	if (!xfer->cs_change) {
-		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
-			m_params = FRAGMENTATION;
-	}
+	/*
+	 * Set FRAGMENTATION to keep CS asserted after this transfer when:
+	 *  - non-last transfer with cs_change=0: keep CS asserted between chained transfers
+	 *  - last transfer with cs_change=1: keep CS asserted after the message
+	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
+	 *     keep CS asserted across header, wait-state and data phases)
+	 */
+	if (list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
+	    xfer->cs_change : !xfer->cs_change)
+		m_params = FRAGMENTATION;
 
 	/*
 	 * Lock around right before we start the transfer since our
-- 
2.54.0




