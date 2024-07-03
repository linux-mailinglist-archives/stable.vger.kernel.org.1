Return-Path: <stable+bounces-57268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5898925E10
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17696B36B87
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6FD194C7E;
	Wed,  3 Jul 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hwPXhAUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE25194AFC;
	Wed,  3 Jul 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004366; cv=none; b=m+iAXJjbCHYlEIUAiZztEacWZWmFnIBhX3JCXNMvl81VzKQt/w2HFffGP4qOA4LQZr5wm6yDDsD/T+8s3CPLbPPJW3NRhI4t58vfMepEQd8432SX9tYpQdzloAQnE7NY66jLfoNrnInNcAjWSSs2WGN0tqbpBF+Apm3qfxBx668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004366; c=relaxed/simple;
	bh=D+FDawb9LKa4wu0fYg1WtNgnQL5xnPFKhYZXQzpnO4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3ttUhYMjjLfwZYbfF7KCoqtDMGDAo9XobShTPZFS2ocTs9LKqkyczGHM2JOtWcvWgVh7C++Bpykn4DnAa1c1PIFarXNBXyQGxthwr59/bHsvT6dHG2B/rmgX5+NEL9r0K+5/lLuNIcVulrWKscujlnTqDyGioEzNgJlzEgKXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwPXhAUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2308BC2BD10;
	Wed,  3 Jul 2024 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004366;
	bh=D+FDawb9LKa4wu0fYg1WtNgnQL5xnPFKhYZXQzpnO4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwPXhAUmxlRKCaOAuYvz7Ey95NYAb7S9CDC7Bn6xABQp10qxB1/6+0g6VHCo2nRrQ
	 e5YDy+J2/ahQX19vHMohyy7s2Sqww2p17A9a+39+mgbkJ3H9daNeYbZBBuV49XXH4s
	 iIo7bmgWl5YA+xy9icCQ3L0GjGrndqYB6JTOcFi8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Escande <nico.escande@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 003/290] wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects
Date: Wed,  3 Jul 2024 12:36:24 +0200
Message-ID: <20240703102904.306391686@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Nicolas Escande <nico.escande@gmail.com>

[ Upstream commit b7d7f11a291830fdf69d3301075dd0fb347ced84 ]

The hwmp code use objects of type mesh_preq_queue, added to a list in
ieee80211_if_mesh, to keep track of mpath we need to resolve. If the mpath
gets deleted, ex mesh interface is removed, the entries in that list will
never get cleaned. Fix this by flushing all corresponding items of the
preq_queue in mesh_path_flush_pending().

This should take care of KASAN reports like this:

unreferenced object 0xffff00000668d800 (size 128):
  comm "kworker/u8:4", pid 67, jiffies 4295419552 (age 1836.444s)
  hex dump (first 32 bytes):
    00 1f 05 09 00 00 ff ff 00 d5 68 06 00 00 ff ff  ..........h.....
    8e 97 ea eb 3e b8 01 00 00 00 00 00 00 00 00 00  ....>...........
  backtrace:
    [<000000007302a0b6>] __kmem_cache_alloc_node+0x1e0/0x35c
    [<00000000049bd418>] kmalloc_trace+0x34/0x80
    [<0000000000d792bb>] mesh_queue_preq+0x44/0x2a8
    [<00000000c99c3696>] mesh_nexthop_resolve+0x198/0x19c
    [<00000000926bf598>] ieee80211_xmit+0x1d0/0x1f4
    [<00000000fc8c2284>] __ieee80211_subif_start_xmit+0x30c/0x764
    [<000000005926ee38>] ieee80211_subif_start_xmit+0x9c/0x7a4
    [<000000004c86e916>] dev_hard_start_xmit+0x174/0x440
    [<0000000023495647>] __dev_queue_xmit+0xe24/0x111c
    [<00000000cfe9ca78>] batadv_send_skb_packet+0x180/0x1e4
    [<000000007bacc5d5>] batadv_v_elp_periodic_work+0x2f4/0x508
    [<00000000adc3cd94>] process_one_work+0x4b8/0xa1c
    [<00000000b36425d1>] worker_thread+0x9c/0x634
    [<0000000005852dd5>] kthread+0x1bc/0x1c4
    [<000000005fccd770>] ret_from_fork+0x10/0x20
unreferenced object 0xffff000009051f00 (size 128):
  comm "kworker/u8:4", pid 67, jiffies 4295419553 (age 1836.440s)
  hex dump (first 32 bytes):
    90 d6 92 0d 00 00 ff ff 00 d8 68 06 00 00 ff ff  ..........h.....
    36 27 92 e4 02 e0 01 00 00 58 79 06 00 00 ff ff  6'.......Xy.....
  backtrace:
    [<000000007302a0b6>] __kmem_cache_alloc_node+0x1e0/0x35c
    [<00000000049bd418>] kmalloc_trace+0x34/0x80
    [<0000000000d792bb>] mesh_queue_preq+0x44/0x2a8
    [<00000000c99c3696>] mesh_nexthop_resolve+0x198/0x19c
    [<00000000926bf598>] ieee80211_xmit+0x1d0/0x1f4
    [<00000000fc8c2284>] __ieee80211_subif_start_xmit+0x30c/0x764
    [<000000005926ee38>] ieee80211_subif_start_xmit+0x9c/0x7a4
    [<000000004c86e916>] dev_hard_start_xmit+0x174/0x440
    [<0000000023495647>] __dev_queue_xmit+0xe24/0x111c
    [<00000000cfe9ca78>] batadv_send_skb_packet+0x180/0x1e4
    [<000000007bacc5d5>] batadv_v_elp_periodic_work+0x2f4/0x508
    [<00000000adc3cd94>] process_one_work+0x4b8/0xa1c
    [<00000000b36425d1>] worker_thread+0x9c/0x634
    [<0000000005852dd5>] kthread+0x1bc/0x1c4
    [<000000005fccd770>] ret_from_fork+0x10/0x20

Fixes: 050ac52cbe1f ("mac80211: code for on-demand Hybrid Wireless Mesh Protocol")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Link: https://msgid.link/20240528142605.1060566-1-nico.escande@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh_pathtbl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index d936ef0c17a37..72ecce377d174 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -723,10 +723,23 @@ void mesh_path_discard_frame(struct ieee80211_sub_if_data *sdata,
  */
 void mesh_path_flush_pending(struct mesh_path *mpath)
 {
+	struct ieee80211_sub_if_data *sdata = mpath->sdata;
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct mesh_preq_queue *preq, *tmp;
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&mpath->frame_queue)) != NULL)
 		mesh_path_discard_frame(mpath->sdata, skb);
+
+	spin_lock_bh(&ifmsh->mesh_preq_queue_lock);
+	list_for_each_entry_safe(preq, tmp, &ifmsh->preq_queue.list, list) {
+		if (ether_addr_equal(mpath->dst, preq->dst)) {
+			list_del(&preq->list);
+			kfree(preq);
+			--ifmsh->preq_queue_len;
+		}
+	}
+	spin_unlock_bh(&ifmsh->mesh_preq_queue_lock);
 }
 
 /**
-- 
2.43.0




