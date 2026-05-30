Return-Path: <stable+bounces-257439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EohIV8aG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:11:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2928460F198
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 212183021ED9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504363148DA;
	Sat, 30 May 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFLwsQ0f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E03191D0;
	Sat, 30 May 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161000; cv=none; b=aZLNiEL+MiLke8y0q8c8oRy1KRSUMbzZFEOlpkap1gzkx0pkUWuuvdbxRA1ljfMZeUCE1zvVUivnhPswaD4w9z3lW5ov6AxTKeEx5+qw57UNN8C26cUAK876sekwSja5fQEEBX1uA48JYr0QM8k6J+sE9U9a2g3ytdviFPbPhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161000; c=relaxed/simple;
	bh=jZ7umkRZ1r2uDXL2BA1V2xjQaVEAkbA7ClOcU3vC0oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkQt/DMrSzS/z7Y8y/YfjYuuvur6zhVSthZQaogyB2Sl9Ci+wQmQXnOUfgD8bMPpYauhNk+uDAOAlyKG+cQtExQjS3LSaem0QdU3c3V5I8g+pR4lY0GYzKQbziInlfzLL52rzPPW6RaXC4H0gsI7ee3GIZ+OrNwiF8+NNEffcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFLwsQ0f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8D01F00893;
	Sat, 30 May 2026 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160999;
	bh=c4t7XLvp6YyrSw2hsZceFec+pe2wlJIm7R9oqV9SLcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFLwsQ0fBtw/IQqDvWScrdo2hPYj8SW8itwxuHgwFhRawVTW3oULIgTlibRdlIWMV
	 /w0yeTz05ANPKiYU0Y99Rime2sZIJP8gILMZ4hzvScwNh1oU3l8ytMFK60kRNByh9d
	 9H1Em3BPJbT1wQU+l84+jm1+6CCZyr9eTNtxrtaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 469/969] net: bcmgenet: Remove TX ring full logging
Date: Sat, 30 May 2026 17:59:53 +0200
Message-ID: <20260530160313.239301281@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257439-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2928460F198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian.fainelli@broadcom.com>

[ Upstream commit df41fa677d9b4717c930afbe88b06f5cefdacb21 ]

There is no need to spam the kernel log with such an indication, remove
this message.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230728183945.760531-1-florian.fainelli@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 5393b2b5bee2 ("net: bcmgenet: fix racing timeout handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 650f51471a0e1..1d679de9c3235 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2072,12 +2072,8 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	spin_lock(&ring->lock);
 	if (ring->free_bds <= (nr_frags + 1)) {
-		if (!netif_tx_queue_stopped(txq)) {
+		if (!netif_tx_queue_stopped(txq))
 			netif_tx_stop_queue(txq);
-			netdev_err(dev,
-				   "%s: tx ring %d full when queue %d awake\n",
-				   __func__, index, ring->queue);
-		}
 		ret = NETDEV_TX_BUSY;
 		goto out;
 	}
-- 
2.53.0




