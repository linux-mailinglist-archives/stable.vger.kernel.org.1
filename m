Return-Path: <stable+bounces-213375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JePHlE1g2kwjAMAu9opvQ
	(envelope-from <stable+bounces-213375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 13:02:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49085E57B0
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 13:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8C303010B4A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B63E8C5D;
	Wed,  4 Feb 2026 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="OuUdBs2q"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461A3D34BC
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206389; cv=none; b=DSqPokHFO4J93m1rIwN/IDxE0YWxlF8p3+4HOXW3VxC1oVBaok7DgBcmghI8se7I3JoGneZ4eIHov1qegkLCgDGpVhUx0tjyfsK0VQqqbRPTaVoHlZmJ2arOg/L48SDL1oVOA9sWEIXfRq2NvbnUO91Z5bCv8Cd/Ebp0mJcWlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206389; c=relaxed/simple;
	bh=sL3lbel97wCAcju1tZxEYx/dmfXnuUa+po8wLHGqa+o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=f6rhB2Lu0Wm0eouMt8nsjPyPjPiBNXUbgPZDaTmSdO3e9Tx2FVHKdbKky5zclSI8z38mJdNVHddZV0/c/C9oT7R/Mdo1PHy1L+NWAl0oltJlewKi7/h3XtdtCybhInaD/3sIZ7EqbCpF5JQqOJsxDtqqA5fWENmuEdX2p5zhjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=OuUdBs2q; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1770206382;
	bh=acf9v2In1VhMXgp9DjXtKJLUnNunARrEYfSEOQ/hh/s=;
	h=From:To:Cc:Subject:Date;
	b=OuUdBs2q8zpOcP3Y+p01M6tnWY08Qx9Rb/AmeyFFGsfTK/U3h2HvcgLq4TbyeFQoS
	 t6uBfAgxsWzWlcy6NpvfiNjH3AIUUUfnjOXb/pgnQjmcbVg/jQp2l0YSXeQzaTFJ/8
	 spzV9mAjlBtDLUGgXLcULcuw0tgxYVqJbK1yB/yg=
Received: from ubuntu24.corp.ad.wrs.com ([183.241.55.101])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id E0001C4D; Wed, 04 Feb 2026 19:56:00 +0800
X-QQ-mid: xmsmtpt1770206160ts0k4u13u
Message-ID: <tencent_C601CC6B4333AD570DF747A9A49AB5058E06@qq.com>
X-QQ-XMAILINFO: OfvX3Hktv4fRwHN1/fsWLrqw4c9HKx1EIVGd+wPWposjj1eeqU2PKKehHF7I5w
	 h98Gdqc7UuwMJI9lADk6zu6mY1BP3iEHaRh7YCVF2sQa52gaCKcsNHxSkUwVzqs09vEEVbAgzws1
	 w1JxFFc9suo9udD/17SRXMPbgZ4Js5VdATAiUa35uFHHyahJhCfecKk5JHcDBWb6tThKE1hNufL0
	 JTDrTo3bOtCZ/NMMPM3HvMQ+id99Giyq14v5rNStanJN1o7wFUvJBJgmRgwmm/nIk1K2qTT9617f
	 Y7ZqXJx6d4xdMH+0BtnYM06W8PEGHhjXMJxOo0z6dDUDxE+7UjaqIoHjQ7DKYmopNOdb+k9vNq8k
	 EhBNe8OiHz2i8LjO6GnZeujPQhQTknxRyfuZaDtUkS+EvGqKH70i/t65E8BatOBrYaD2d7ZezowS
	 B+6oovaj6kq59ppMrdp6OGnzhzMjPjV9kOtFgOGGhl/KhtoJ+xUGlTFqEtjI64Gug+C+E2Gr3pgP
	 UtILzYNXy9CAWqsV7aEpox89hSpWsXFXfGB5vv7SeD2Q+r+HCoP/3v6s8lxQK1cXvXAyFp18IVTB
	 tOWuLSObRI7VSlQ71XE07bf0EKCSDmUBUCVGVuBbi5qa/ZRyLZUipVeM79swUIF8iZSZnkkKa2u+
	 ENk6V50POZahuYiPOeZ9CqBJlniFnyhbs06jMv/d74/IhdTkft+zEXhsgxeNJtzd3qBxd0GPAL2k
	 5Sl99i080dpLZ7pbQktywzULLuzK6B7stNSYVVbZxq41QDJusvD8+l88+eyjR6FKs7Ic1+kLGWrU
	 6t3+fWnzILrko50BT0jP9/+x9iq78Tj0e3B7Nx1OInr8ylXOj/6FxCQK5LrUugE4QfvGZHd19YCR
	 B5Y/uGTIxTA13pS/tRNe9fymOV1o5lfT9Hg1y2nIBXUZw9k4CRyMkHK/W+RV+sl66FnnPF80Tp9v
	 d964PclE6ajS0F52V3FsdW4JYdl7jxaMFuBhQBBuyGTIviV507A7Vci+IdKkLhoHiEO1gr6zbLUv
	 KIprUit7H34KjKQRQD3d72tdhhgw/W+T5wY2li4RWahY/riTNc9CLzRFqSwpV+7j37smiIMJpC+t
	 SLz8Km
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] ptr_ring: do not block hard interrupts in ptr_ring_resize_multiple()
Date: Wed,  4 Feb 2026 11:55:59 +0000
X-OQ-MSGID: <20260204115559.4491-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213375-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[msgid.link:query timed out,appspotmail.com:query timed out];
	FREEMAIL_CC(0.00)[google.com,syzkaller.appspotmail.com,redhat.com,kernel.org,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,f56a5c5eac2b28439810];
	RSPAMD_EMAILBL_FAIL(0.00)[jasowang.redhat.com:query timed out,mst.redhat.com:query timed out,alvalan9.foxmail.com:query timed out,edumazet.google.com:query timed out,syzbot.syzkaller.appspotmail.com:query timed out];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,qq.com:mid]
X-Rspamd-Queue-Id: 49085E57B0
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a126061c80d5efb4baef4bcf346094139cd81df6 ]

Jakub added a lockdep_assert_no_hardirq() check in __page_pool_put_page()
to increase test coverage.

syzbot found a splat caused by hard irq blocking in
ptr_ring_resize_multiple() [1]

As current users of ptr_ring_resize_multiple() do not require
hard irqs being masked, replace it to only block BH.

Rename helpers to better reflect they are safe against BH only.

- ptr_ring_resize_multiple() to ptr_ring_resize_multiple_bh()
- skb_array_resize_multiple() to skb_array_resize_multiple_bh()

[1]

WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 __page_pool_put_page net/core/page_pool.c:709 [inline]
WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c:780
Modules linked in:
CPU: 1 UID: 0 PID: 9150 Comm: syz.1.1052 Not tainted 6.11.0-rc3-syzkaller-00202-gf8669d7b5f5d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__page_pool_put_page net/core/page_pool.c:709 [inline]
RIP: 0010:page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c:780
Code: 74 0e e8 7c aa fb f7 eb 43 e8 75 aa fb f7 eb 3c 65 8b 1d 38 a8 6a 76 31 ff 89 de e8 a3 ae fb f7 85 db 74 0b e8 5a aa fb f7 90 <0f> 0b 90 eb 1d 65 8b 1d 15 a8 6a 76 31 ff 89 de e8 84 ae fb f7 85
RSP: 0018:ffffc9000bda6b58 EFLAGS: 00010083
RAX: ffffffff8997e523 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000fbd0000 RSI: 0000000000001842 RDI: 0000000000001843
RBP: 0000000000000000 R08: ffffffff8997df2c R09: 1ffffd40003a000d
R10: dffffc0000000000 R11: fffff940003a000e R12: ffffea0001d00040
R13: ffff88802e8a4000 R14: dffffc0000000000 R15: 00000000ffffffff
FS:  00007fb7aaf716c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa15a0d4b72 CR3: 00000000561b0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tun_ptr_free drivers/net/tun.c:617 [inline]
 __ptr_ring_swap_queue include/linux/ptr_ring.h:571 [inline]
 ptr_ring_resize_multiple_noprof include/linux/ptr_ring.h:643 [inline]
 tun_queue_resize drivers/net/tun.c:3694 [inline]
 tun_device_event+0xaaf/0x1080 drivers/net/tun.c:3714
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_change_tx_queue_len+0x158/0x2a0 net/core/dev.c:9024
 do_setlink+0xff6/0x41f0 net/core/rtnetlink.c:2923
 rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3201
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550

Fixes: ff4e538c8c3e ("page_pool: add a lockdep check for recycling in hardirq")
Reported-by: syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/671e10df.050a0220.2b8c0f.01cf.GAE@google.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://patch.msgid.link/20241217135121.326370-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ 2c321f3f70bc ("mm: change inlined allocation helpers to account at the call site")
  is not ported to Linux-6.6.y. So remove the suffix "_noprof". ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/net/tap.c         |  6 +++---
 drivers/net/tun.c         |  6 +++---
 include/linux/ptr_ring.h  | 17 ++++++++---------
 include/linux/skb_array.h | 14 ++++++++------
 net/sched/sch_generic.c   |  4 ++--
 5 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index e7212a64a591..2c4f9d19827f 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1330,9 +1330,9 @@ int tap_queue_resize(struct tap_dev *tap)
 	list_for_each_entry(q, &tap->queue_list, next)
 		rings[i++] = &q->ring;
 
-	ret = ptr_ring_resize_multiple(rings, n,
-				       dev->tx_queue_len, GFP_KERNEL,
-				       __skb_array_destroy_skb);
+	ret = ptr_ring_resize_multiple_bh(rings, n,
+					  dev->tx_queue_len, GFP_KERNEL,
+					  __skb_array_destroy_skb);
 
 	kfree(rings);
 	return ret;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c1fdf8804d60..97dbec8d7807 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3682,9 +3682,9 @@ static int tun_queue_resize(struct tun_struct *tun)
 	list_for_each_entry(tfile, &tun->disabled, next)
 		rings[i++] = &tfile->tx_ring;
 
-	ret = ptr_ring_resize_multiple(rings, n,
-				       dev->tx_queue_len, GFP_KERNEL,
-				       tun_ptr_free);
+	ret = ptr_ring_resize_multiple_bh(rings, n,
+					  dev->tx_queue_len, GFP_KERNEL,
+					  tun_ptr_free);
 
 	kfree(rings);
 	return ret;
diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 808f9d3ee546..65da2155cce2 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -613,15 +613,14 @@ static inline int ptr_ring_resize(struct ptr_ring *r, int size, gfp_t gfp,
 /*
  * Note: producer lock is nested within consumer lock, so if you
  * resize you must make sure all uses nest correctly.
- * In particular if you consume ring in interrupt or BH context, you must
- * disable interrupts/BH when doing so.
+ * In particular if you consume ring in BH context, you must
+ * disable BH when doing so.
  */
-static inline int ptr_ring_resize_multiple(struct ptr_ring **rings,
-					   unsigned int nrings,
-					   int size,
-					   gfp_t gfp, void (*destroy)(void *))
+static inline int ptr_ring_resize_multiple_bh(struct ptr_ring **rings,
+						     unsigned int nrings,
+						     int size, gfp_t gfp,
+						     void (*destroy)(void *))
 {
-	unsigned long flags;
 	void ***queues;
 	int i;
 
@@ -636,12 +635,12 @@ static inline int ptr_ring_resize_multiple(struct ptr_ring **rings,
 	}
 
 	for (i = 0; i < nrings; ++i) {
-		spin_lock_irqsave(&(rings[i])->consumer_lock, flags);
+		spin_lock_bh(&(rings[i])->consumer_lock);
 		spin_lock(&(rings[i])->producer_lock);
 		queues[i] = __ptr_ring_swap_queue(rings[i], queues[i],
 						  size, gfp, destroy);
 		spin_unlock(&(rings[i])->producer_lock);
-		spin_unlock_irqrestore(&(rings[i])->consumer_lock, flags);
+		spin_unlock_bh(&(rings[i])->consumer_lock);
 	}
 
 	for (i = 0; i < nrings; ++i)
diff --git a/include/linux/skb_array.h b/include/linux/skb_array.h
index e2d45b7cb619..6c7f856e211a 100644
--- a/include/linux/skb_array.h
+++ b/include/linux/skb_array.h
@@ -198,16 +198,18 @@ static inline int skb_array_resize(struct skb_array *a, int size, gfp_t gfp)
 	return ptr_ring_resize(&a->ring, size, gfp, __skb_array_destroy_skb);
 }
 
-static inline int skb_array_resize_multiple(struct skb_array **rings,
-					    int nrings, unsigned int size,
-					    gfp_t gfp)
+static inline int skb_array_resize_multiple_bh(struct skb_array **rings,
+						      int nrings,
+						      unsigned int size,
+						      gfp_t gfp)
 {
 	BUILD_BUG_ON(offsetof(struct skb_array, ring));
-	return ptr_ring_resize_multiple((struct ptr_ring **)rings,
-					nrings, size, gfp,
-					__skb_array_destroy_skb);
+	return ptr_ring_resize_multiple_bh((struct ptr_ring **)rings,
+					          nrings, size, gfp,
+					          __skb_array_destroy_skb);
 }
 
+
 static inline void skb_array_cleanup(struct skb_array *a)
 {
 	ptr_ring_cleanup(&a->ring, __skb_array_destroy_skb);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 1b51b3038b4b..c1c67da2d3fc 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -910,8 +910,8 @@ static int pfifo_fast_change_tx_queue_len(struct Qdisc *sch,
 		bands[prio] = q;
 	}
 
-	return skb_array_resize_multiple(bands, PFIFO_FAST_BANDS, new_len,
-					 GFP_KERNEL);
+	return skb_array_resize_multiple_bh(bands, PFIFO_FAST_BANDS, new_len,
+					    GFP_KERNEL);
 }
 
 struct Qdisc_ops pfifo_fast_ops __read_mostly = {
-- 
2.43.0


