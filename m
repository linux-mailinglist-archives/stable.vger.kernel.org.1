Return-Path: <stable+bounces-34948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B452989419D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89301C2173B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB764481D1;
	Mon,  1 Apr 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D86r42ty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87581481B7;
	Mon,  1 Apr 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989836; cv=none; b=M0o96Zlkt8rlU+p1HXM/UzzcX8fFn5zAq1tE/NW3fzI5bOPDFpOOXhWGCCNLE3U8rX6haSHoEenlJnYGN93n6bYWCWsqgV/hhjT4sxCqr7Q9+giCHUm4+iFbq7nixrf8Hse/C8szXuR/Pmjfek8EH0J5ZhlEJwzw8ol53vGvKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989836; c=relaxed/simple;
	bh=hNZ9e+HWPRBieXTYUlG2RuW8UOsAOE+doO0rqR9A398=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izVOGgxXQhg1cufZJUB0OkbscrZxEjn+tROFQBfpvV65f7C/ISg9IxAVsDZGaaxEmQqaijIp3DQU2mXlcijsHoENiykUb5qLWRL+SWBcEsHE9+8e/GzrdZG/cWed0jDdwMmv6UsO4M9OAUpJrTau1hfE5l2reY/utiNwILDTdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D86r42ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA58C433F1;
	Mon,  1 Apr 2024 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989836;
	bh=hNZ9e+HWPRBieXTYUlG2RuW8UOsAOE+doO0rqR9A398=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D86r42tyBxTDrUBikjwmaxeqXb9Sl1yMD9sYiwnfByMw9AOhZTD4mu+Em8LuyKoRH
	 jad6+XMngHpyqCpUKZ4rS3AoB0b+tw8Ilpq20QmkenQQ4Mmakk0Y2aGsY1+Jfy8FtC
	 4+OfJNpmM5FtomawDEQE5bfjEc4nK/T40BjK8tkA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Kumlien <ian.kumlien@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	"Anatoli N . Chechelnickiy" <Anatoli.Chechelnickiy@m.interpipe.biz>
Subject: [PATCH 6.6 167/396] net: esp: fix bad handling of pages from page_pool
Date: Mon,  1 Apr 2024 17:43:36 +0200
Message-ID: <20240401152552.919362744@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit c3198822c6cb9fb588e446540485669cc81c5d34 ]

When the skb is reorganized during esp_output (!esp->inline), the pages
coming from the original skb fragments are supposed to be released back
to the system through put_page. But if the skb fragment pages are
originating from a page_pool, calling put_page on them will trigger a
page_pool leak which will eventually result in a crash.

This leak can be easily observed when using CONFIG_DEBUG_VM and doing
ipsec + gre (non offloaded) forwarding:

  BUG: Bad page state in process ksoftirqd/16  pfn:1451b6
  page:00000000de2b8d32 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1451b6000 pfn:0x1451b6
  flags: 0x200000000000000(node=0|zone=2)
  page_type: 0xffffffff()
  raw: 0200000000000000 dead000000000040 ffff88810d23c000 0000000000000000
  raw: 00000001451b6000 0000000000000001 00000000ffffffff 0000000000000000
  page dumped because: page_pool leak
  Modules linked in: ip_gre gre mlx5_ib mlx5_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat xt_addrtype br_netfilter rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_uverbs ib_core overlay zram zsmalloc fuse [last unloaded: mlx5_core]
  CPU: 16 PID: 96 Comm: ksoftirqd/16 Not tainted 6.8.0-rc4+ #22
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x36/0x50
   bad_page+0x70/0xf0
   free_unref_page_prepare+0x27a/0x460
   free_unref_page+0x38/0x120
   esp_ssg_unref.isra.0+0x15f/0x200
   esp_output_tail+0x66d/0x780
   esp_xmit+0x2c5/0x360
   validate_xmit_xfrm+0x313/0x370
   ? validate_xmit_skb+0x1d/0x330
   validate_xmit_skb_list+0x4c/0x70
   sch_direct_xmit+0x23e/0x350
   __dev_queue_xmit+0x337/0xba0
   ? nf_hook_slow+0x3f/0xd0
   ip_finish_output2+0x25e/0x580
   iptunnel_xmit+0x19b/0x240
   ip_tunnel_xmit+0x5fb/0xb60
   ipgre_xmit+0x14d/0x280 [ip_gre]
   dev_hard_start_xmit+0xc3/0x1c0
   __dev_queue_xmit+0x208/0xba0
   ? nf_hook_slow+0x3f/0xd0
   ip_finish_output2+0x1ca/0x580
   ip_sublist_rcv_finish+0x32/0x40
   ip_sublist_rcv+0x1b2/0x1f0
   ? ip_rcv_finish_core.constprop.0+0x460/0x460
   ip_list_rcv+0x103/0x130
   __netif_receive_skb_list_core+0x181/0x1e0
   netif_receive_skb_list_internal+0x1b3/0x2c0
   napi_gro_receive+0xc8/0x200
   gro_cell_poll+0x52/0x90
   __napi_poll+0x25/0x1a0
   net_rx_action+0x28e/0x300
   __do_softirq+0xc3/0x276
   ? sort_range+0x20/0x20
   run_ksoftirqd+0x1e/0x30
   smpboot_thread_fn+0xa6/0x130
   kthread+0xcd/0x100
   ? kthread_complete_and_exit+0x20/0x20
   ret_from_fork+0x31/0x50
   ? kthread_complete_and_exit+0x20/0x20
   ret_from_fork_asm+0x11/0x20
   </TASK>

The suggested fix is to introduce a new wrapper (skb_page_unref) that
covers page refcounting for page_pool pages as well.

Cc: stable@vger.kernel.org
Fixes: 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling")
Reported-and-tested-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
Link: https://lore.kernel.org/netdev/CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h | 10 ++++++++++
 net/ipv4/esp4.c        |  8 ++++----
 net/ipv6/esp6.c        |  8 ++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ddfe86deb4e7f..2922059908cc5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3438,6 +3438,16 @@ static inline void skb_frag_ref(struct sk_buff *skb, int f)
 
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
+static inline void
+skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+{
+#ifdef CONFIG_PAGE_POOL
+	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+		return;
+#endif
+	put_page(page);
+}
+
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4ccfc104f13a5..fe501d2186bcf 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -95,7 +95,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			put_page(sg_page(sg));
+			skb_page_unref(skb, sg_page(sg), false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
@@ -260,7 +260,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
@@ -639,7 +639,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 2cc1a45742d82..a3fa3eda388a4 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -112,7 +112,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			put_page(sg_page(sg));
+			skb_page_unref(skb, sg_page(sg), false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
@@ -294,7 +294,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	esp_output_encap_csum(skb);
@@ -677,7 +677,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
-- 
2.43.0




