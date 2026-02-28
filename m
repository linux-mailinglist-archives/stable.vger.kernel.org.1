Return-Path: <stable+bounces-220047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /4n1JRmQomlq4AQAu9opvQ
	(envelope-from <stable+bounces-220047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 07:50:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6F11C0A50
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 07:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2F7130557D1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 06:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D1F17A2E8;
	Sat, 28 Feb 2026 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e5BdCpMd"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F42368961
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261396; cv=none; b=Qyc7sVjmCjyViD3w1kZWmIJLJ1AKDYGgooxY9fKI8MCILdGU/F42c8/ucgpvX3QOnds2LByBs0cJT4Ka5SN5eON7/HpQfhKJEFFdH83PO5YrFtDwcy+rONWUfYrqDptpqzUsuVC2lITpKPrHooqILYaVFrLzL0KKwgQu5DvXgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261396; c=relaxed/simple;
	bh=mazFypRdT/7871IFHk1fz2wYmneewAZIiErHVJzangg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3PEkAH1a1hv9aESIend/geASKTVnPwxiVgppto9Tc3qCBjH0gtPkmWvLEIQ9DbDpOj3zOZjgThOMI+lXMGu8mtPCQBijJ65dnnTG7m38y9kO/AitckSXFgbzoS08ZRM1dyd7c4R4CqwwCkdrYY0yEj+qDjhj84PKsz/UDKFj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e5BdCpMd; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=B8
	3wcq6VJo6yYT/xEL9GE/hqnZUnSqtLXZU7FxthW/E=; b=e5BdCpMdkRvaPN1VwN
	gYw/RS+XMkKe4FWAV/zqb7nVUGW9+g2HAqnL79TeBGuCIMXCaXuAJhkM4UT6lYqm
	RUPUI482sjDVIwi65BfK9eix5Wg6M8sMaRNXYw61g04zizLryintkNt+RFD1i/ge
	DdasYYUNXhalxwL4+VaohpfLY=
Received: from ubuntu24.corp.ad.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBHzJmUj6JpYDTGNw--.34513S2;
	Sat, 28 Feb 2026 14:47:50 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Guodong Xu <guodong@riscstar.com>,
	Juan Li <lijuan@linux.spacemit.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y] dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()
Date: Sat, 28 Feb 2026 14:47:36 +0800
Message-ID: <20260228064736.4134-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHzJmUj6JpYDTGNw--.34513S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWUuw4kGF15Zw4rXFyDAwb_yoW5JF4xpF
	W5J3W5GrWqqr40vFZrC3WrZr15XFs0grWUurW2gwsrZ345Jw1YvF1xCayavFWDJry7ZFnx
	AF43Jw1Fk3yDGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piFdgJUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxBgN1Wmij5igcwAA3L
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220047-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[riscstar.com,linux.spacemit.com,kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 2F6F11C0A50
X-Rspamd-Action: no action

From: Guodong Xu <guodong@riscstar.com>

[ Upstream commit a143545855bc2c6e1330f6f57ae375ac44af00a7 ]

Add proper locking in mmp_pdma_residue() to prevent use-after-free when
accessing descriptor list and descriptor contents.

The race occurs when multiple threads call tx_status() while the tasklet
on another CPU is freeing completed descriptors:

CPU 0                              CPU 1
-----                              -----
mmp_pdma_tx_status()
mmp_pdma_residue()
  -> NO LOCK held
     list_for_each_entry(sw, ..)
                                   DMA interrupt
                                   dma_do_tasklet()
                                     -> spin_lock(&desc_lock)
                                        list_move(sw->node, ...)
                                        spin_unlock(&desc_lock)
  |                                     dma_pool_free(sw) <- FREED!
  -> access sw->desc <- UAF!

This issue can be reproduced when running dmatest on the same channel with
multiple threads (threads_per_chan > 1).

Fix by protecting the chain_running list iteration and descriptor access
with the chan->desc_lock spinlock.

Signed-off-by: Juan Li <lijuan@linux.spacemit.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Link: https://patch.msgid.link/20251216-mmp-pdma-race-v1-1-976a224bb622@riscstar.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[ Minor context conflict resolved. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index ebdfdcbb4f7a..046358e328eb 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -764,6 +764,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 {
 	struct mmp_pdma_desc_sw *sw;
 	u32 curr, residue = 0;
+	unsigned long flags;
 	bool passed = false;
 	bool cyclic = chan->cyclic_first != NULL;
 
@@ -779,6 +780,8 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 	else
 		curr = readl(chan->phy->base + DSADR(chan->phy->idx));
 
+	spin_lock_irqsave(&chan->desc_lock, flags);
+
 	list_for_each_entry(sw, &chan->chain_running, node) {
 		u32 start, end, len;
 
@@ -822,6 +825,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 			continue;
 
 		if (sw->async_tx.cookie == cookie) {
+			spin_unlock_irqrestore(&chan->desc_lock, flags);
 			return residue;
 		} else {
 			residue = 0;
@@ -829,6 +833,8 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 		}
 	}
 
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
+
 	/* We should only get here in case of cyclic transactions */
 	return residue;
 }
-- 
2.43.0


