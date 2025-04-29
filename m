Return-Path: <stable+bounces-137740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0BBAA14FE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB35A98350D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390B253935;
	Tue, 29 Apr 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LsKEYHII"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF4216605;
	Tue, 29 Apr 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946986; cv=none; b=ocz9mntTcTq/xHW+5fpmUhfE/FqvK5YmY+PKdIn/t5FWtQZcDVZ/2SGkze1hBQd3AvurgUOufceOrpPx57azWytvOYmT/zja/HXV3iyB+0b3XpCIjSoLJAlvfEwAegLB3rRT8tjYW5Q4FBVkvp6F8Y8tPANVfwLcgbki5h290Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946986; c=relaxed/simple;
	bh=0wszCN1CWtBLFHTQXigRok2vJjQrSPtIRxrVwQiVHz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyxF/xhnAen5h4nu4bgZRTYZw5geqomXTfE9lbwWG8ff+FzWcP5rhkja8iujdXltKEzQqiEhTN1OilZlkFo5lZbTquTF6vrSUYX1tDRXE7h+Zd1kx9WFiJKCXcXyJ/0AvhBBjWpoAA6MG7Dc7vpkrXkMQz6UFqp2ePBVwKLS+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LsKEYHII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F74C4CEE3;
	Tue, 29 Apr 2025 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946985;
	bh=0wszCN1CWtBLFHTQXigRok2vJjQrSPtIRxrVwQiVHz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsKEYHIIpgH2tm4h9fFDA3fHGUp+Pr+gnax687/45YMXFiAoxljLeaIX/7Ko/t1Gr
	 LCg8ZbTDAzJAXWwOfOyQkl/t8nePq3yv7ud5IdjovY5KMJyNC4LxxpF5/8E9d/F9LG
	 2dQ0nQSdvMQES/09/Uy7jSeIL3uGmV4pI8arHK/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Remi Pommarel <repk@triplefau.lt>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 103/286] wifi: mac80211: Update skbs control block key in ieee80211_tx_dequeue()
Date: Tue, 29 Apr 2025 18:40:07 +0200
Message-ID: <20250429161112.094788329@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit a104042e2bf6528199adb6ca901efe7b60c2c27f ]

The ieee80211 skb control block key (set when skb was queued) could have
been removed before ieee80211_tx_dequeue() call. ieee80211_tx_dequeue()
already called ieee80211_tx_h_select_key() to get the current key, but
the latter do not update the key in skb control block in case it is
NULL. Because some drivers actually use this key in their TX callbacks
(e.g. ath1{1,2}k_mac_op_tx()) this could lead to the use after free
below:

  BUG: KASAN: slab-use-after-free in ath11k_mac_op_tx+0x590/0x61c
  Read of size 4 at addr ffffff803083c248 by task kworker/u16:4/1440

  CPU: 3 UID: 0 PID: 1440 Comm: kworker/u16:4 Not tainted 6.13.0-ge128f627f404 #2
  Hardware name: HW (DT)
  Workqueue: bat_events batadv_send_outstanding_bcast_packet
  Call trace:
   show_stack+0x14/0x1c (C)
   dump_stack_lvl+0x58/0x74
   print_report+0x164/0x4c0
   kasan_report+0xac/0xe8
   __asan_report_load4_noabort+0x1c/0x24
   ath11k_mac_op_tx+0x590/0x61c
   ieee80211_handle_wake_tx_queue+0x12c/0x1c8
   ieee80211_queue_skb+0xdcc/0x1b4c
   ieee80211_tx+0x1ec/0x2bc
   ieee80211_xmit+0x224/0x324
   __ieee80211_subif_start_xmit+0x85c/0xcf8
   ieee80211_subif_start_xmit+0xc0/0xec4
   dev_hard_start_xmit+0xf4/0x28c
   __dev_queue_xmit+0x6ac/0x318c
   batadv_send_skb_packet+0x38c/0x4b0
   batadv_send_outstanding_bcast_packet+0x110/0x328
   process_one_work+0x578/0xc10
   worker_thread+0x4bc/0xc7c
   kthread+0x2f8/0x380
   ret_from_fork+0x10/0x20

  Allocated by task 1906:
   kasan_save_stack+0x28/0x4c
   kasan_save_track+0x1c/0x40
   kasan_save_alloc_info+0x3c/0x4c
   __kasan_kmalloc+0xac/0xb0
   __kmalloc_noprof+0x1b4/0x380
   ieee80211_key_alloc+0x3c/0xb64
   ieee80211_add_key+0x1b4/0x71c
   nl80211_new_key+0x2b4/0x5d8
   genl_family_rcv_msg_doit+0x198/0x240
  <...>

  Freed by task 1494:
   kasan_save_stack+0x28/0x4c
   kasan_save_track+0x1c/0x40
   kasan_save_free_info+0x48/0x94
   __kasan_slab_free+0x48/0x60
   kfree+0xc8/0x31c
   kfree_sensitive+0x70/0x80
   ieee80211_key_free_common+0x10c/0x174
   ieee80211_free_keys+0x188/0x46c
   ieee80211_stop_mesh+0x70/0x2cc
   ieee80211_leave_mesh+0x1c/0x60
   cfg80211_leave_mesh+0xe0/0x280
   cfg80211_leave+0x1e0/0x244
  <...>

Reset SKB control block key before calling ieee80211_tx_h_select_key()
to avoid that.

Fixes: bb42f2d13ffc ("mac80211: Move reorder-sensitive TX handlers to after TXQ dequeue")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Link: https://patch.msgid.link/06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0d6d12fc3c07e..5615575595efb 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3691,6 +3691,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
+	info->control.hw_key = NULL;
 	r = ieee80211_tx_h_select_key(&tx);
 	if (r != TX_CONTINUE) {
 		ieee80211_free_txskb(&local->hw, skb);
-- 
2.39.5




