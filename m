Return-Path: <stable+bounces-235305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPNRNANA12npLwgAu9opvQ
	(envelope-from <stable+bounces-235305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 07:58:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57F3C667B
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 07:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89B79300B28C
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 05:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EF307AF4;
	Thu,  9 Apr 2026 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ux71kres"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8B199FAC;
	Thu,  9 Apr 2026 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775714299; cv=none; b=RvhmEB2BzwE36r7+DmhlMZ6YE5iulRUVT/TVTMwfhlGV+6mOqNctPNigZF2kF5JT/vsGt7t0w1dh1DjJaSnlWtZ2m0A+rIagy8/qZKS5hGk19HUN92u3QMb5xDH4GI4DN/yiMLGVtGC9ie05fvYCbKnR12gV0LFtGavZM5pzU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775714299; c=relaxed/simple;
	bh=hPSDNS2pmKnvE3EWyqx8L6sy8nlq54q5JSgI2/fJNQ0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pa74j4tSWVor39xAT5MGoHC+7HuQEZg3nZIJffQReS22c9d7s7+1J3RAahBS98JCgbmNiPFuNsOYcstIDfpHBc9YjG6mOwxQwhSMf8vb6giqWGRUy3s5Yvki9WTWXucP81kG9xrLRXRlx6zwstseoUZ2KtMN9ju//59e+QxKf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ux71kres; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775714286; bh=saUzSOSLabVSqyIgKKzKGgKBGMnBOmvykPoGRA3J8Bw=;
	h=From:To:Cc:Subject:Date;
	b=ux71kresDE60aZxj42Z2qIbRprN2W9El/ubf09ByxbAz3AJ5XjLa2K/+XSZ5efTNO
	 wEA58d0UHbFS0eFaiMXIf2RXnMhH2MwcaPkBcjyv9Mlh/ObwCE3gZZzwtthBt+qBgt
	 V76zW/B14D8eHCdjEiiC/JCqqK5Xzn2SUx9CD7fA=
Received: from qq.com ([123.121.145.161])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A88B52ED; Thu, 09 Apr 2026 13:42:08 +0800
X-QQ-mid: xmsmtpt1775713328tnu91yjf5
Message-ID: <tencent_E328416B7CFD436F6029F2DF02AD7ED89C08@qq.com>
X-QQ-XMAILINFO: MwOvDUWSFAlQxjprT6pL3qbMrvkpgun8Nr+ooi6FDCWXibDtA2kaLL2ABrp2/F
	 Hntz+3tBAl+xCp6q0Urb3nr7yzt3RwyBhj3HOUph8JkMMM92D1KBeKE5UPS7CdsrC8/YH1yX+OsL
	 ulseKiyV7vBFfvBpC3tVlf6Db3w7qpU2WFiTISoDMZn1WFMq1ZWoJcFm7SGv2IKrhLK3EybaoSYW
	 rBrYDJfn+3RtNTG8Mo3TxRya5TgtsxCd++ieI8drVP2eNAkOrr/00I24lAyYd3sC0Cx9jyMpJfI1
	 IBafI1E/8pNNIs9IxbbE1FXgqRW3j6FgYSsSELPBkf/KOOnJhSww+WO6yrZcakDPoufDI4nk7A/r
	 mVXdCESkQaG1IS8pod/xV3WzIcFa8wP1esu2QMAikuitBtlf77noyqY7dRNsEXSJT8cT6ban97vR
	 9nn/RJWl72gX6T8oPVKSYx7EZnIgo0+3p6yE5mfxJOmLVmwP312DxuBZcnYqQibIqtKV0A44pjFS
	 cJ8zhYRUq2wo31u9dJjTATFCEcge9hTT5p0DIPQcNMtwvWXMfbD2wHlomxlPYAhkZd1pc82JOJb6
	 ir3Xfp/cqQyL4iv7dw+ggHO+kXiVkAka1jMWmrr6m/k788bO9yDn/uJI+309pI/WzV6bohRlMid0
	 AJmT07phSC0CKE2TGn4F+sZjuG3d1pIGDkgbuU6KVnkUvgT9Vv8Qp+FwGwubLUFg3gIcNq1W4uqR
	 xR941YRvBQBtBw9a/6UQSXOwy6ImPaPSwJO05yaWNwmVZrJ03p4RKhY/NBDasluAHF27hhGxkxpj
	 tiJocSeOwTaBW7mywGD4j1AFnTHSxsQo2/36JwRtxQDVr9qaHZ+0O7Fj2WfFS7cNgl90WnAm/iUn
	 fyMhAK1VUZFYCQ0a26U/qmFs2WBSviXKasIc+q/GuyNgZba3K8rmPPOqk/E0KQeNr6tVpCPluOAi
	 Z7V3p0bGCEI2nHuW0J8b/wiTzcpNfZYzldN/iQOcZtCjtKCCqu2PD+ySPnVh6hPX2Qp8whdWQpb1
	 LGbIc4IyBxpVFiXYPrStLcCT1I3tJvOXVYzz1x/tTE2gv45yalKzrhze2/ZQB5iXmU6EoVbp0AKg
	 NublnQGwlR9sTgbOaX0Tm5njA+dC6sZPCTF3NdxSDhqhV28ecFZs5CpKMSyA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Zhaoyang Yu <2426767509@qq.com>
To: andriy.shevchenko@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kees@kernel.org,
	fourier.thomas@gmail.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Zhaoyang Yu <2426767509@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] tty: serial: pch_uart: add check for dma_alloc_coherent()
Date: Thu,  9 Apr 2026 13:41:58 +0800
X-OQ-MSGID: <20260409054158.14418-1-2426767509@qq.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235305-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,vger.kernel.org,bjtu.edu.cn,qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2426767509@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD57F3C667B
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


