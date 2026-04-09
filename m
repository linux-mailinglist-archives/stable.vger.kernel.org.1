Return-Path: <stable+bounces-235303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d0YHBJE512kgLwgAu9opvQ
	(envelope-from <stable+bounces-235303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 07:30:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE23C64D0
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 07:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBB1A300D857
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 05:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC6221F39;
	Thu,  9 Apr 2026 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="E3vqWAxq"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E7F9D9
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775712651; cv=none; b=J7RVu5TsODEIV/DJz5weCu2FXwoWLgGBq3NkRSt/etgUWvZZfwZuE42SPtS7NsfPt+68BUEBal6DuTN32MdpNSYmMAdgAkE0yBM9ynwmfe3R8StHymUSNj2CTtInOgIt7nrV5Xt5sryJAehv/htn5DXkjZ8uHni0cSfAOjs7qh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775712651; c=relaxed/simple;
	bh=hPSDNS2pmKnvE3EWyqx8L6sy8nlq54q5JSgI2/fJNQ0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=j0KfXJjkvtuiHLuwbKmSA0C7V4np5e/6yISr5gqxzfIdVr4RPzAbliz61lgXTKtoL116Pvh0x8vtzooQxvLNxvmLNpQO6lQ70lAjdwC558iVASRa8mcCIOBYzH2NRidPdcVK9J6miP3YhbsBzF6kFL0AI/1ejWgoHkKNG6tIODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=E3vqWAxq; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775712645; bh=saUzSOSLabVSqyIgKKzKGgKBGMnBOmvykPoGRA3J8Bw=;
	h=From:To:Cc:Subject:Date;
	b=E3vqWAxqfJ6ri6lcfKSecfc8ZmKzrwuKhz4CFO+gAz90DsEX9BXQhWd4s80ZZMkzd
	 rj9S/5IFP/R+XYmjxoJIDVuuwBF7TrWSmJ0Il7Eb0lFp0cjcH+6uNXjwxMR1oc3vOi
	 hRmIdDYBe8vjXVj9TzNlI/W2z8MAUtNbM9pLySuE=
Received: from qq.com ([123.121.145.161])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 7602AE14; Thu, 09 Apr 2026 13:29:32 +0800
X-QQ-mid: xmsmtpt1775712572tom67pmwh
Message-ID: <tencent_FD97D60AEC5F14EDB5C0FE8DB7D694CD6F07@qq.com>
X-QQ-XMAILINFO: MckYHXcfgHdfCF6wrEmmDceampf+9s+0OvcH1BvEsA4N5EdE1NWPHp8R3uWPCw
	 lXnpJpnDRh523TH3pgChWDYLJPE4G39rzdFOvQrkf3qZN+kFwF4ghE72ZaoZMPxV254dPVEgTE8P
	 ZO0ijI6Xler8vL//tQgicUCet56RreM7o0yy/JKwY0j6jYXQ9q7hzVCtd7AJpn85IeX5DGykZTzl
	 BZM2fqoZI/kOrW2Z7Dud60SU0bvLJ0i1WkLSyv5DpeXbcFQ42gXN3bOoZ5pxaGwqS0lBHpNz5Tiu
	 2xVVtwSL8aQLuXdU7RTMS+1V1Jbq0r9cm82g2X+HxpKW+44pm+AkdU7AvaBJ45ZXkDIfdQ7xTCeF
	 cgA5hojj/gjXQfjMZVObOQu2BSdY+m12LCOBPykREQPTGvkDeL+kZh52FP9XKogvTzIfC4wdma/E
	 /fIoJvaY+gb5U9kReDqA0VXIhiLeXtSetKs1JUyrJeuhpHMrWV2VRUKdRwqH+yZ4MDyhCeiQRbmM
	 /M21odEMY/eRPuzBfeKBhFuZp1XaajyimWgk1J2riYLkKvJqRBupqZBZki53qAsEmRexoOM96dK0
	 GZSZccnRdREEaVOx9VZjeEH/6//Bu/P8nFeysSu1mwVuYzgsUCRFFq5CJeqNRiHYPXRWqK3xauJX
	 p6660NvTwyADzAIzwxx6JbAE7rpIpfbb1ac7STntWNwNi2vtFnXXeRahEJEcjoYh5i4LmhF8mf78
	 FPgKfTd/ek4Cz4i5ABR/qrXgX2ON0vV89VpivM4/SngX6DohrUvfvRHEOkli1TKqrP4cqHOAG0m2
	 dqL9dwfL1h7b5+ocKOTAeeIrrUs0eaSvhKsNJ/fPPljmdBCPx/UlDxsaAaVrbovYxbFQTB+Yvgeb
	 NXS6CXfvDI+M3s/6nSkKlxEQRLuTO62yKSDeOdhsvLX3yF7snDkwL9jB2lEKqt8RU4U+CgWXXhD9
	 EowaRdJbtaTq48+HiGLKfB8gr5znCwJNChPinq4eC9B4s8+ZhZcz2EG1I6Hkm9d6K6UikweV081+
	 EWvkHptTVNAnoEC4NV9Pyyj+vVQrfSR94o4b7Ep2419lg+Icd3Xnf9czI/+oVkLXe9TdHrXg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Zhaoyang Yu <2426767509@qq.com>
To: 23120469@bjtu.edu.cn
Cc: Zhaoyang Yu <2426767509@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] tty: serial: pch_uart: add check for dma_alloc_coherent()
Date: Thu,  9 Apr 2026 13:29:30 +0800
X-OQ-MSGID: <20260409052930.6851-1-2426767509@qq.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235303-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2426767509@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: 16CE23C64D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a check for dma_alloc_coherent() failure to prevent a potential
NULL pointer dereference in dma_handle_rx(). Properly release DMA
channels and the PCI device reference using a goto ladder if the
allocation fails.

Fixes: 3c6a483275f4 ("Serial: EG20T: add PCH_UART driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zhaoyang Yu <2426767509@qq.com>
---
Changes in v2:
- Added the Fixes tag for the initial PCH_UART driver commit, per Andy's review.

 drivers/tty/serial/pch_uart.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6729d8e83c3c..ba1fcd663fe2 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -689,8 +689,7 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
 			__func__);
-		pci_dev_put(dma_dev);
-		return;
+		goto err_pci_get;
 	}
 	priv->chan_tx = chan;
 
@@ -704,18 +703,26 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Rx)\n",
 			__func__);
-		dma_release_channel(priv->chan_tx);
-		priv->chan_tx = NULL;
-		pci_dev_put(dma_dev);
-		return;
+		goto err_req_tx;
 	}
 
 	/* Get Consistent memory for DMA */
 	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
 				    &priv->rx_buf_dma, GFP_KERNEL);
+	if (!priv->rx_buf_virt)
+		goto err_req_rx;
 	priv->chan_rx = chan;
 
 	pci_dev_put(dma_dev);
+	return;
+
+err_req_rx:
+	dma_release_channel(chan);
+err_req_tx:
+	dma_release_channel(priv->chan_tx);
+	priv->chan_tx = NULL;
+err_pci_get:
+	pci_dev_put(dma_dev);
 }
 
 static void pch_dma_rx_complete(void *arg)
-- 
2.50.1


