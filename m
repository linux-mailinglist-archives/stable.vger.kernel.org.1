Return-Path: <stable+bounces-218930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNYdDBFYnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:01:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DD190689
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7955C30E8DB7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50672741C9;
	Wed, 25 Feb 2026 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YsCimz5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA0265CBE;
	Wed, 25 Feb 2026 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983827; cv=none; b=iK58xXt3Eoosxwf7jxWKK4kvqK/Wjv3KQ9drV7Gfm/wedKsVE2slggEHypJprrQl43Qr3TwDESfNZve8p1I79m27iGMSbRzqg9gSXEtCNVvcbiNwlw45VHENDAhrQJk8aietbvueImYpiZl91BPSJrUSg5YVA0pQdm0At3YTpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983827; c=relaxed/simple;
	bh=JZ9VF2VtHneFDhIw8Z5mNzJEIDN6t6FiGPexcNDJoHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApksCVf+HwzyftJYftoLe+4+Y0eMmtLyHtRfQU8ZJJy+pK9UIf+bPBvyg2K4y6X+Bz9aeKb7nfGH6LxPKuOAAow+9So53gTQjHJx91fTVu/PPTIwOZy7wzgwzVxebH1tgT7YW/NEK9Q1NjAFHJBmuTxsy4mCA54g2c/7wPkUhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YsCimz5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D25C116D0;
	Wed, 25 Feb 2026 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983827;
	bh=JZ9VF2VtHneFDhIw8Z5mNzJEIDN6t6FiGPexcNDJoHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsCimz5d3SXPkskEynWtdQZjf5qkruZFnu0hzq6FSUh9Saopv4VGhz/e+R/L1I4FI
	 ceKxj6Ti531AhNLoHIH/nSnjDR8rwWLZ5wRe17ucIodLttqPPMZ4DM4HcnLIHYggC3
	 dJDiGEArCPMxHIKXPngLEjuwNs9wk/Fa/SYQ3xCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 108/641] Bluetooth: btintel_pcie: Use IRQF_ONESHOT and default primary handler
Date: Tue, 24 Feb 2026 17:17:14 -0800
Message-ID: <20260225012351.736004555@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218930-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 5E0DD190689
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 28abed6569c87eab9071ab56c64433c2f0d9ce51 ]

There is no added value in btintel_pcie_msix_isr() compared to
irq_default_primary_handler().

Using a threaded interrupt without a dedicated primary handler mandates
the IRQF_ONESHOT flag to mask the interrupt source while the threaded
handler is active. Otherwise the interrupt can fire again before the
threaded handler had a chance to run.

Use the default primary interrupt handler by specifying NULL and set
IRQF_ONESHOT so the interrupt source is masked until the secondary
handler is done.

Fixes: c2b636b3f788d ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-7-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel_pcie.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index f280bcc61bbfb..c68a8de3025b0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1430,11 +1430,6 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 	}
 }
 
-static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
-{
-	return IRQ_WAKE_THREAD;
-}
-
 static inline bool btintel_pcie_is_rxq_empty(struct btintel_pcie_data *data)
 {
 	return data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM] == data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM];
@@ -1536,9 +1531,9 @@ static int btintel_pcie_setup_irq(struct btintel_pcie_data *data)
 
 		err = devm_request_threaded_irq(&data->pdev->dev,
 						msix_entry->vector,
-						btintel_pcie_msix_isr,
+						NULL,
 						btintel_pcie_irq_msix_handler,
-						IRQF_SHARED,
+						IRQF_ONESHOT | IRQF_SHARED,
 						KBUILD_MODNAME,
 						msix_entry);
 		if (err) {
-- 
2.51.0




