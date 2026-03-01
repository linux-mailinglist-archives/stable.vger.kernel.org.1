Return-Path: <stable+bounces-221775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLhSO/ubo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-221775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:52:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F21491CC1BB
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6B35309A16F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DF2DBF40;
	Sun,  1 Mar 2026 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeCN9o1Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF772DB7B5;
	Sun,  1 Mar 2026 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329106; cv=none; b=joZkte+iOM3Rg6pHyCnyG60zPF9sL1bU5axD1c/bfA1gqP4JNK9uROQjOU2d992lci5e6yTyuuqllqaYny6JUq92eQ4ERIXK3vtGRNmoDXk3MVhIExltukVVskEqFE1Ax0Zg+XXAdhjs4aImo+Fh9zP1GuM2H31Kfuk84iSNa7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329106; c=relaxed/simple;
	bh=DoKj3vyfM5GcvpNChcIjvZzgc1C5GmW4hqNlFvYo1Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0gRTSylhkkSSI2yHUYg3f/XqWePlUoeOyO47rEjfqQSb+Tvslp+BLXnI5jV6Bz0JYZq/o45tUBlNWpuNbXv439s6qKbRSwzUtl8oy2JIchu2mVIDZxVsPpGzuhXxm7c2bPAI7sjD9iQEYuWcioyn2YKxF2xxvvfVWTs0M17XxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeCN9o1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC93C19421;
	Sun,  1 Mar 2026 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329105;
	bh=DoKj3vyfM5GcvpNChcIjvZzgc1C5GmW4hqNlFvYo1Nc=;
	h=From:To:Cc:Subject:Date:From;
	b=FeCN9o1YbbyiHC9iPoEew4gGenj6OP4heu2ZKq2gLJDibjCri997S9htPphTEV/bM
	 iE74juUpw82gN0rSbMWwq3QnI4OLPW1/kckK3a5KA8xDSZFa3mxXB7l1QK+SZf2AgJ
	 NYYjKDaN0zRlybBRN1inno1HPQ8Bn/XdwqqNmm43phd0zfs1TiOgvRdJ7wGxLU8TvS
	 NQbjr2zXbNxy+IxiJOFXnMGgXukx067SK2UL5Uao9A4yMsAakGFj6wlmZES9kfUl0Z
	 I9sVwixVHvbpGH5E/qeJ+Gkh/L5bC9PdQNB7QMLDwBkSC5EKX8VbPIFQGJ8eS5z2MK
	 MlEo8TwmZtFpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haokexin@gmail.com
Cc: Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: macb: Fix tx/rx malfunction after phy link down and up" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:23 -0500
Message-ID: <20260301013824.1698820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221775-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: F21491CC1BB
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bf9cf80cab81e39701861a42877a28295ade266f Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 8 Feb 2026 16:45:52 +0800
Subject: [PATCH] net: macb: Fix tx/rx malfunction after phy link down and up

In commit 99537d5c476c ("net: macb: Relocate mog_init_rings() callback
from macb_mac_link_up() to macb_open()"), the mog_init_rings() callback
was moved from macb_mac_link_up() to macb_open() to resolve a deadlock
issue. However, this change introduced a tx/rx malfunction following
phy link down and up events. The issue arises from a mismatch between
the software queue->tx_head, queue->tx_tail, queue->rx_prepared_head,
and queue->rx_tail values and the hardware's internal tx/rx queue
pointers.

According to the Zynq UltraScale TRM [1], when tx/rx is disabled, the
internal tx queue pointer resets to the value in the tx queue base
address register, while the internal rx queue pointer remains unchanged.
The following is quoted from the Zynq UltraScale TRM:
  When transmit is disabled, with bit [3] of the network control register
  set low, the transmit-buffer queue pointer resets to point to the address
  indicated by the transmit-buffer queue base address register. Disabling
  receive does not have the same effect on the receive-buffer queue
  pointer.

Additionally, there is no need to reset the RBQP and TBQP registers in a
phy event callback. Therefore, move macb_init_buffers() to macb_open().
In a phy link up event, the only required action is to reset the tx
software head and tail pointers to align with the hardware's behavior.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm

Fixes: 99537d5c476c ("net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260208-macb-init-ring-v1-1-939a32c14635@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6511ecd5856bd..4ebb40adfab37 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -705,14 +705,12 @@ static void macb_mac_link_up(struct phylink_config *config,
 		if (rx_pause)
 			ctrl |= MACB_BIT(PAE);
 
-		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
-		 * cleared the pipeline and control registers.
-		 */
-		macb_init_buffers(bp);
-
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+			queue->tx_head = 0;
+			queue->tx_tail = 0;
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
+		}
 	}
 
 	macb_or_gem_writel(bp, NCFGR, ctrl);
@@ -2954,6 +2952,7 @@ static int macb_open(struct net_device *dev)
 	}
 
 	bp->macbgem_ops.mog_init_rings(bp);
+	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
-- 
2.51.0





