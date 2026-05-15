Return-Path: <stable+bounces-248404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BofLCVWB2p7zAIAu9opvQ
	(envelope-from <stable+bounces-248404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:21:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215C554E4B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 994753142165
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754DA4963A0;
	Fri, 15 May 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDagb5YZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B0494A0E;
	Fri, 15 May 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861650; cv=none; b=McGyy3MxclPkia+tTeB157/FGxSu/vXBhNxnTHuhAFNcKHYtAeAcfXcOKnVLZGg2+HCQsvvVgFa+xU87nzxoUcOIAcBo5qWhqaovc1BuJRjPPwbiG9P8Bg2C5vyOONcjCzaceaOcy8iiMKPt4x9GaDL/iSmvdG4ZypRRhlPTqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861650; c=relaxed/simple;
	bh=B7G0vOi4bQoBfo6ez7hT1sVe3p3Ef51L95HJApK2OW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hn0Y6tCDro9XPVNFgQwLX60K+CwogT+j87vukY0Jhj1HP1lyTFVGTxY/buZ7cxt2WzcuRP36BBX5W7rEp/3IjwqrMpOzwRd71zUAXsvBbaTRfHnN5LQIMvrmPNVD4ejA4UiBpyKKK3li0pEVgV97FNyFio8ELMTGgHt8PT8Y1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDagb5YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE503C2BCB0;
	Fri, 15 May 2026 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861650;
	bh=B7G0vOi4bQoBfo6ez7hT1sVe3p3Ef51L95HJApK2OW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDagb5YZ6ei7FqV7uK8RnggqdX3QSzxrG9v714gxXGOzTY1r0TMliBKCs7Bmv3eDP
	 vEOqbwW0lnikhGsiFaFMyiCepTvUtY3iJMNcMFrL/FR0qeUD2M5CVgZHa9KvJoGTaU
	 X+V3kcPPT3Zxnb0/TOpIy8msHrYgljR43mF403F4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 409/474] net: stmmac: avoid shadowing global buf_sz
Date: Fri, 15 May 2026 17:48:38 +0200
Message-ID: <20260515154723.902983506@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3215C554E4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248404-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,armlinux.org.uk,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,armlinux.org.uk:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit 876cfb20e8892143c0c967b3657074f9131f9b5f ]

stmmac_rx() declares a local variable named "buf_sz" but there is also
a global variable for a module parameter which is called the same. To
avoid confusion, rename the local variable.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Furong Xu <0x1207@gmail.com>
Link: https://patch.msgid.link/E1tpswi-005U6C-Py@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0bb05e6adfa9 ("net: stmmac: Prevent NULL deref when RX memory exhausted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5279,10 +5279,10 @@ static int stmmac_rx(struct stmmac_priv
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
 	int xdp_status = 0;
-	int buf_sz;
+	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
-	buf_sz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
 	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
@@ -5397,7 +5397,7 @@ read_again:
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 
-			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
+			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
 



