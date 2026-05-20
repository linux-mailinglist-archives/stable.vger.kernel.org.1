Return-Path: <stable+bounces-251329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G8rBjbxDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:36:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C02CA5941D6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C088F3041B92
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E3369999;
	Wed, 20 May 2026 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xz6XXZ3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69136A357;
	Wed, 20 May 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297699; cv=none; b=onYwyqRa4lrWHnsDiwpBdKN8XOL/xe/50wnurMnZxOePZzFV5syk9ssm5Hl4DuPsxDkVup1p5exUyy0T8OoW5XP1vkRPsCj5ARwZgVAaN89aOzNNGs6Er0jvxOGw8PA0RQn79pFhkJNL6YSwy18/1V3Nc5YTAIhoLaB7zvqSTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297699; c=relaxed/simple;
	bh=sPbOMyc1jHLUYNktxgFfqztroh/m0wH0cwZqOhgprWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEVzmZhFd01xWN6UQFDrwxa9XMNMDdYZClJFe3hIHn2sosLZRyhyLVO20HY++sG3u9fFPhtndMjNPESBeGB9jfWxnCo7V9Ou9GFkvMSlgZau3qjfadbkQoQska9yOwD00J/wrdDAnMb2uPv/XIQHNmvwuU/DLMcFuX3Px8Hbm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xz6XXZ3f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE011F000E9;
	Wed, 20 May 2026 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297698;
	bh=P1mRQmRD2sOsVyJXYXHF4+Ai4/cbHAWiVaRD9jF4JxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xz6XXZ3fBcHevXIntU/xD9uvoNumRCMPgBTycP1AdQ24L/TA916PfJvOS7yCmOWNz
	 3tcepJ4FkEGJNUoDdHSypMXyNjCwn4AF6mZvbcpGdGyZMmw2qzaZhxqGQHax5Qphw8
	 rUWX9TqfiXvzi3vvwhPuQJsXgjH2U2BAO9sKcFao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 088/957] wifi: mt76: Fix memory leak destroying device
Date: Wed, 20 May 2026 18:09:31 +0200
Message-ID: <20260520162136.469171398@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251329-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nbd.name:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: C02CA5941D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 6b470f36616e3448d44b0ef4b1de2a3e3a31b5be ]

All MT76 rx queues have an associated page_pool even if the queue is not
associated to a NAPI (e.g. WED RRO queues with WED enabled). Destroy the
page_pool running mt76_dma_cleanup routine during module unload.
Moreover returns pages to the page pool if WED is not enabled for WED RRO
queues.

Fixes: 950d0abb5cd94 ("wifi: mt76: mt7996: add wed rx support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20251208-mt76-fix-memory-leak-v1-1-cba813fc62b8@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 1fa7de1d2c45e..9ef073c27f309 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -878,7 +878,12 @@ mt76_dma_rx_cleanup(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!buf)
 			break;
 
-		if (!mt76_queue_is_wed_rro(q))
+		if (mtk_wed_device_active(&dev->mmio.wed) &&
+		    mt76_queue_is_wed_rro(q))
+			continue;
+
+		if (!mt76_queue_is_wed_rro_rxdmad_c(q) &&
+		    !mt76_queue_is_wed_rro_ind(q))
 			mt76_put_page_pool_buf(buf, false);
 	} while (1);
 
@@ -1169,10 +1174,6 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
-		if (mtk_wed_device_active(&dev->mmio.wed) &&
-		    mt76_queue_is_wed_rro(q))
-			continue;
-
 		netif_napi_del(&dev->napi[i]);
 		mt76_dma_rx_cleanup(dev, q);
 
-- 
2.53.0




