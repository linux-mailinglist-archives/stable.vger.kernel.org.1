Return-Path: <stable+bounces-220049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBkGD5KYomlI4QQAu9opvQ
	(envelope-from <stable+bounces-220049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 08:26:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE8D1C0F73
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 08:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D264B302BA5F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 07:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED6247280;
	Sat, 28 Feb 2026 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ixNrre9g"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E772634
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263566; cv=none; b=uKGmV7Jc5UiuEelArUT32RzYWoTD2ZhO1+J7SXSakts70iYmylCEjOpjFmFH400MU8Zevjeo6RWvxvP21WuIaA1Q98B1OCqOiIkfT+Y5+5EkeQyhKA4ZuPg0sr0P8SLFzWM8fJgUwoKdzwD6xe5FpYZSoa5k9ZlxDLMyylu2mHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263566; c=relaxed/simple;
	bh=8LZbrHpwwuF2ferkjyjQYBP8do692BnqfTt7XPHlvfY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hc72voXuLQ/QZzFqs0sIPdCRJd/uzQ/bwxFLJ1JuyeRCBKiMn5Q4cnoKnUoU0b88ptSMBqzYnhqXEdZVqkNaxzoXd7+oHj/mr/hZPPEmyn44YvVAACU07hniDAABbBH/1JEhz0zY8uiqyREnndRs1U7fk5NsE52efNGZrCxdZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ixNrre9g; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/i
	Obyi9mVdc/q5sgxGSdgYrWUHkTGrmQ3KM1LRUvoKg=; b=ixNrre9gtgU2gLdI3t
	nMu1K0g7qP2MIl1k03tnDPxdetGAJAw/gIabZUG0HYuhWLFIjh0b2ddaRd8FcbYF
	H/63UwCLWj+py18nrrAqewhBqq0/mFb7D1rLxONUCYlX3/e6qVaetGczwBuTvRqw
	2UZ84yBlpCpxU1VGItgg6oRLA=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wC3_jh5mKJpS8XBOQ--.61955S2;
	Sat, 28 Feb 2026 15:25:46 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()
Date: Sat, 28 Feb 2026 15:25:45 +0800
Message-ID: <20260228072545.4110-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3_jh5mKJpS8XBOQ--.61955S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWUuw4kGF15Zw4rXFyDAwb_yoW5JF4xpF
	W5G3W5GrWqqr40vFsrG3W8Zr15Xrs0grWUurW2gws7Z345JryYvFn7CayavFWDJryUZ3Z8
	AF43Jw1rC3yDGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhL05UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxBtHEGmimHtTZAAA3X
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-220049-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2AE8D1C0F73
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
index e8d71b35593e..bac4905c47db 100644
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


