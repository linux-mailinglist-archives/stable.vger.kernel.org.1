Return-Path: <stable+bounces-261129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PaVsJHtGJWr2FgIAu9opvQ
	(envelope-from <stable+bounces-261129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:22:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B85164F989
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:22:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qDEO+6lK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261129-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261129-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78396307771B
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EE323392F;
	Sun,  7 Jun 2026 10:15:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD62AD00;
	Sun,  7 Jun 2026 10:15:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827359; cv=none; b=ArRH2OpCk22Sg0z16oLPkanDJiLxL1Clgs6hiR+jeayNnfw6q9E7FdJUBK/MueRQW4OLIE6kgW2qfkd9iEeRHBscSrCGCj20qsT6bR63L9gSPDbstSmQ8+xlwaqAqA0VD+ecbbRawM3EZExz5PhsYLoE5dnCoVAqQAZ+erWdkjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827359; c=relaxed/simple;
	bh=SglHvW/Grpks+DwiApCHTQd5j+oHzlP+ekkiqvSqq98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9anQ1klvFQEnVKjd0t9gcr7pVlLKcBqTYIF6yNnjU76ZcfT0rZfoAFQb8Fjspq1a4S++pA2AuKh5JhpungF6OrYGhjXOYZ1EDQEPKzH+Z15ANPEPeO56AkI6qk4Z72VorUjLxQp53TDhnqJXIw4N434Pa9yin7JmGQSsx5JaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qDEO+6lK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586031F00893;
	Sun,  7 Jun 2026 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827358;
	bh=YsZw3SLnrSIAXp0meE44gEURI1pqvTP12rnHRw3v9d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qDEO+6lKO3Z50GrOPVsIoXhqfC+2bjSXjCyFRMSo1yDXgu1Nybf8rEHU+6WeGq3s0
	 lN5Hwuzd+L6j9eP72Q+ku2CHCconKxElE1HursSZKgXcFmAiC43GcU2dSwFrF+U1RN
	 mdojdBj3nvaAiyauJzW09FgIVwZxQGDqLQiNvF1M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jijie Shao <shaojijie@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 086/332] net: hibmcge: move dma_rmb() after dma_sync_single_for_cpu() in RX path
Date: Sun,  7 Jun 2026 11:57:35 +0200
Message-ID: <20260607095731.305144198@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-261129-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:shaojijie@huawei.com,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,huawei.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B85164F989

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit b545b6ea1802b32436fa97f1d2918718212cc831 ]

The dma_rmb() barrier was placed before dma_sync_single_for_cpu(), which
is incorrect. DMA sync must complete first to make the buffer accessible
to the CPU, then the rmb barrier ensures subsequent descriptor reads
observe the latest data written by the hardware.

Reorder the operations so dma_sync_single_for_cpu() is called before
dma_rmb() to guarantee the driver reads consistent data from the DMA
buffer.

Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20260525144525.94884-3-shaojijie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index a4ea92c31c2fea..0ae31499467693 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -452,12 +452,12 @@ static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
 {
 	struct hbg_rx_desc *rx_desc;
 
-	/* make sure HW write desc complete */
-	dma_rmb();
-
 	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->page_dma,
 				buffer->page_size, DMA_FROM_DEVICE);
 
+	/* make sure HW write desc complete */
+	dma_rmb();
+
 	rx_desc = (struct hbg_rx_desc *)buffer->page_addr;
 	return FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2) != 0;
 }
-- 
2.53.0




