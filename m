Return-Path: <stable+bounces-119282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36397A425B2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EB119C433F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D012571CB;
	Mon, 24 Feb 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0NlT99J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332BB146A63;
	Mon, 24 Feb 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408937; cv=none; b=MGTwWLm10sTS12vFEHhsDZpIbuWP5IYPjWW07hgYK4VI+8yBkdEa6pbFed9ArppHcbPZ9GsN0yO/9ZMhrJ8fYt1uSiShf0KL4+fYlWpntPnx0PjeoT9cd0CVIep8FuDdpiaMA2FtbrSY/jDF2TVjOL96eUILtdlRn88GJkAmnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408937; c=relaxed/simple;
	bh=UO/O2FqXhZPe1oYBDh3IQlsb8T6y+/uTOTvIM2YGY8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUodwzbibVnV4n74NfByR+gW/LU4kquZ5tAhATPXdUtn0KH3JfEn1kvVQxswaKWBpwp5aTDV1n/czqWnhL0Oc9xsm1ErdYlSJC07/KYGPrTyI+lehHltBGF5SoSeU++9P4qfcPaOe+Qy4zZPxhtslroNr0CHu94TL93jxX31wUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k0NlT99J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EEBC4CED6;
	Mon, 24 Feb 2025 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408937;
	bh=UO/O2FqXhZPe1oYBDh3IQlsb8T6y+/uTOTvIM2YGY8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0NlT99JhgF3vxsHpPbGTo4l+vfxeS5BKCeyyBwJlSGpaj7L+958BiHSGprGQYiVj
	 y21eMj/fwPWczMz1lk0JjjblRDiAaQL/WrfCd1HokJKPAuUjRIM3bVWzXyDDRoNN7i
	 5wwSoK4xcAosbDX3mL/QxnLlIFB/kob90vFiPAgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 048/138] net: allow small head cache usage with large MAX_SKB_FRAGS values
Date: Mon, 24 Feb 2025 15:34:38 +0100
Message-ID: <20250224142606.364995859@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 14ad6ed30a10afbe91b0749d6378285f4225d482 ]

Sabrina reported the following splat:

    WARNING: CPU: 0 PID: 1 at net/core/dev.c:6935 netif_napi_add_weight_locked+0x8f2/0xba0
    Modules linked in:
    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc1-net-00092-g011b03359038 #996
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
    RIP: 0010:netif_napi_add_weight_locked+0x8f2/0xba0
    Code: e8 c3 e6 6a fe 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc c7 44 24 10 ff ff ff ff e9 8f fb ff ff e8 9e e6 6a fe <0f> 0b e9 d3 fe ff ff e8 92 e6 6a fe 48 8b 04 24 be ff ff ff ff 48
    RSP: 0000:ffffc9000001fc60 EFLAGS: 00010293
    RAX: 0000000000000000 RBX: ffff88806ce48128 RCX: 1ffff11001664b9e
    RDX: ffff888008f00040 RSI: ffffffff8317ca42 RDI: ffff88800b325cb6
    RBP: ffff88800b325c40 R08: 0000000000000001 R09: ffffed100167502c
    R10: ffff88800b3a8163 R11: 0000000000000000 R12: ffff88800ac1c168
    R13: ffff88800ac1c168 R14: ffff88800ac1c168 R15: 0000000000000007
    FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffff888008201000 CR3: 0000000004c94001 CR4: 0000000000370ef0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
    <TASK>
    gro_cells_init+0x1ba/0x270
    xfrm_input_init+0x4b/0x2a0
    xfrm_init+0x38/0x50
    ip_rt_init+0x2d7/0x350
    ip_init+0xf/0x20
    inet_init+0x406/0x590
    do_one_initcall+0x9d/0x2e0
    do_initcalls+0x23b/0x280
    kernel_init_freeable+0x445/0x490
    kernel_init+0x20/0x1d0
    ret_from_fork+0x46/0x80
    ret_from_fork_asm+0x1a/0x30
    </TASK>
    irq event stamp: 584330
    hardirqs last  enabled at (584338): [<ffffffff8168bf87>] __up_console_sem+0x77/0xb0
    hardirqs last disabled at (584345): [<ffffffff8168bf6c>] __up_console_sem+0x5c/0xb0
    softirqs last  enabled at (583242): [<ffffffff833ee96d>] netlink_insert+0x14d/0x470
    softirqs last disabled at (583754): [<ffffffff8317c8cd>] netif_napi_add_weight_locked+0x77d/0xba0

on kernel built with MAX_SKB_FRAGS=45, where SKB_WITH_OVERHEAD(1024)
is smaller than GRO_MAX_HEAD.

Such built additionally contains the revert of the single page frag cache
so that napi_get_frags() ends up using the page frag allocator, triggering
the splat.

Note that the underlying issue is independent from the mentioned
revert; address it ensuring that the small head cache will fit either TCP
and GRO allocation and updating napi_alloc_skb() and __netdev_alloc_skb()
to select kmalloc() usage for any allocation fitting such cache.

Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/gro.h |  3 +++
 net/core/gro.c    |  3 ---
 net/core/skbuff.c | 10 +++++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index b9b58c1f8d190..7b548f91754bf 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -11,6 +11,9 @@
 #include <net/udp.h>
 #include <net/hotdata.h>
 
+/* This should be increased if a protocol with a bigger head is added. */
+#define GRO_MAX_HEAD (MAX_HEADER + 128)
+
 struct napi_gro_cb {
 	union {
 		struct {
diff --git a/net/core/gro.c b/net/core/gro.c
index d1f44084e978f..78b320b631744 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -7,9 +7,6 @@
 
 #define MAX_GRO_SKBS 8
 
-/* This should be increased if a protocol with a bigger head is added. */
-#define GRO_MAX_HEAD (MAX_HEADER + 128)
-
 static DEFINE_SPINLOCK(offload_lock);
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6841e61a6bd0b..f251a99f8d421 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -69,6 +69,7 @@
 #include <net/dst.h>
 #include <net/sock.h>
 #include <net/checksum.h>
+#include <net/gro.h>
 #include <net/gso.h>
 #include <net/hotdata.h>
 #include <net/ip6_checksum.h>
@@ -95,7 +96,9 @@
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #endif
 
-#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(MAX_TCP_HEADER)
+#define GRO_MAX_HEAD_PAD (GRO_MAX_HEAD + NET_SKB_PAD + NET_IP_ALIGN)
+#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(max(MAX_TCP_HEADER, \
+					       GRO_MAX_HEAD_PAD))
 
 /* We want SKB_SMALL_HEAD_CACHE_SIZE to not be a power of two.
  * This should ensure that SKB_SMALL_HEAD_HEADROOM is a unique
@@ -736,7 +739,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	/* If requested length is either too small or too big,
 	 * we use kmalloc() for skb->head allocation.
 	 */
-	if (len <= SKB_WITH_OVERHEAD(1024) ||
+	if (len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
@@ -816,7 +819,8 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 	 * When the small frag allocator is available, prefer it over kmalloc
 	 * for small fragments
 	 */
-	if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) ||
+	if ((!NAPI_HAS_SMALL_PAGE_FRAG &&
+	     len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
-- 
2.39.5




