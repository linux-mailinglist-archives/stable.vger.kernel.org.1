Return-Path: <stable+bounces-125196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE5A6903D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2243A4C50
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3158C2135A1;
	Wed, 19 Mar 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="djrtkK3v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355D1DF986;
	Wed, 19 Mar 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395021; cv=none; b=D0Gn5rGguEWtcU84mfJHp3wc7l501Ef+akHgmki65k2Uw3BVEx8MxeeKex22hvTG3AE8hWDexRkD9bQhF2u+dC/fQknxvuQbquh6AkcaylODuTXSg2st8iO1dRRJCZ8qgWlPY78VK52n9ZVKnNmp8PXqiv/FLzfh4vfOomf+wMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395021; c=relaxed/simple;
	bh=IMdLFumwj1sP0csNTcXrmp/0+qTIRvF2ACybEt/jgL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbucKiaPUiW+137YQG7xYg+W6Il1tjzKMhnUpT2rRrZO/ZWHMTwT4Mw3RU3ZthwwJZxbcEjlsQMWjBDunG16qyoUZEypCa0FQM8WHfTtmi68wCUVTHtWrzfAjS1r+EpsoJBVUMLno7Y2UD0pGz1JOHctpqfr+ldgV3Ae5vTXX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=djrtkK3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDA0C4CEE4;
	Wed, 19 Mar 2025 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395020;
	bh=IMdLFumwj1sP0csNTcXrmp/0+qTIRvF2ACybEt/jgL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djrtkK3vyFwDJTZBRIT+jsn5L1BMMIaqlrwOklt7okucHzGef7QHIJXV96VHHDBd+
	 LD2PQxbUApj5pU1WPqsl5E04NTafUI8Yw6j422DybOFXloDRsZBKD3jFYoLE/UySAZ
	 CoNaXiQ3I5KEAkq8TS35Ul/Zdr4LsqNAbBEM23AE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taehee Yoo <ap420073@gmail.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 034/231] eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}
Date: Wed, 19 Mar 2025 07:28:47 -0700
Message-ID: <20250319143027.656446936@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit f09af5fdfbd9b0fcee73aab1116904c53b199e97 ]

When qstats-get operation is executed, callbacks of netdev_stats_ops
are called. The bnxt_get_queue_stats{rx | tx} collect per-queue stats
from sw_stats in the rings.
But {rx | tx | cp}_ring are allocated when the interface is up.
So, these rings are not allocated when the interface is down.

The qstats-get is allowed even if the interface is down. However,
the bnxt_get_queue_stats{rx | tx}() accesses cp_ring and tx_ring
without null check.
So, it needs to avoid accessing rings if the interface is down.

Reproducer:
 ip link set $interface down
 ./cli.py --spec netdev.yaml --dump qstats-get
OR
 ip link set $interface down
 python ./stats.py

Splat looks like:
 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 1680fa067 P4D 1680fa067 PUD 16be3b067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 0 UID: 0 PID: 1495 Comm: python3 Not tainted 6.14.0-rc4+ #32 5cd0f999d5a15c574ac72b3e4b907341
 Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
 RIP: 0010:bnxt_get_queue_stats_rx+0xf/0x70 [bnxt_en]
 Code: c6 87 b5 18 00 00 02 eb a2 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 01
 RSP: 0018:ffffabef43cdb7e0 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: ffffffffc04c8710 RCX: 0000000000000000
 RDX: ffffabef43cdb858 RSI: 0000000000000000 RDI: ffff8d504e850000
 RBP: ffff8d506c9f9c00 R08: 0000000000000004 R09: ffff8d506bcd901c
 R10: 0000000000000015 R11: ffff8d506bcd9000 R12: 0000000000000000
 R13: ffffabef43cdb8c0 R14: ffff8d504e850000 R15: 0000000000000000
 FS:  00007f2c5462b080(0000) GS:ffff8d575f600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000167fd0000 CR4: 00000000007506f0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die+0x20/0x70
  ? page_fault_oops+0x15a/0x460
  ? sched_balance_find_src_group+0x58d/0xd10
  ? exc_page_fault+0x6e/0x180
  ? asm_exc_page_fault+0x22/0x30
  ? bnxt_get_queue_stats_rx+0xf/0x70 [bnxt_en cdd546fd48563c280cfd30e9647efa420db07bf1]
  netdev_nl_stats_by_netdev+0x2b1/0x4e0
  ? xas_load+0x9/0xb0
  ? xas_find+0x183/0x1d0
  ? xa_find+0x8b/0xe0
  netdev_nl_qstats_get_dumpit+0xbf/0x1e0
  genl_dumpit+0x31/0x90
  netlink_dump+0x1a8/0x360

Fixes: af7b3b4adda5 ("eth: bnxt: support per-queue statistics")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Link: https://patch.msgid.link/20250309134219.91670-6-ap420073@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7293d7732d6ce..eba0f9991476c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15032,6 +15032,9 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 	struct bnxt_cp_ring_info *cpr;
 	u64 *sw;
 
+	if (!bp->bnapi)
+		return;
+
 	cpr = &bp->bnapi[i]->cp_ring;
 	sw = cpr->stats.sw_stats;
 
@@ -15055,6 +15058,9 @@ static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
 	struct bnxt_napi *bnapi;
 	u64 *sw;
 
+	if (!bp->tx_ring)
+		return;
+
 	bnapi = bp->tx_ring[bp->tx_ring_map[i]].bnapi;
 	sw = bnapi->cp_ring.stats.sw_stats;
 
-- 
2.39.5




