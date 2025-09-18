Return-Path: <stable+bounces-165215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1620B15C19
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182D918C2F61
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF1277CAF;
	Wed, 30 Jul 2025 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pkMNbgW9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE4273D95;
	Wed, 30 Jul 2025 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868249; cv=none; b=lF4vPcghzuh3NDvNAN0OfU6wlG8YHCAnaAvODHbwXkvO30cyKTy/xptbHjgpPQyZMagzDJTkFB6nso8yJufiNIyKVCfky2f9tNLJ8s2ftTNwGMMx61C0+nphODxcJIblNoirJuP70wuu5HptcsiOpxjP2whUIzVHDaETU79TV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868249; c=relaxed/simple;
	bh=fRABStxVSDO9DgTxaWrFl3IPhv0l729K0Y88q+WcmPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lfo/poY4NVkncqXp0CYlu6tw2+08js1OwgPvvt9XAbVp6U6fd+niXz4NGqJgPIA25p/tsan68QI1/Gdpxc6s2oGfDzAw6W4Rn/4D29u5uDIctQOrEF6LO11m96semqpxH+5ij3htWn/yyfnbrtv0U+rbI3H8NG1pHqqYQBfcKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pkMNbgW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3138FC4CEF9;
	Wed, 30 Jul 2025 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868248;
	bh=fRABStxVSDO9DgTxaWrFl3IPhv0l729K0Y88q+WcmPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkMNbgW9hbXIYIXQHjprR7UB1tepL7oj7jL30SRRdAK70A8a38CUaPRcvse/NBKMe
	 tyXG05Zl1TU1sN5IYnDZsGEafvmtrpsrNH+Zjbc88PZ3UzvohafjJgHoRKjBMY+LiD
	 g46CU7/Uu+8CbOoyZ7SihU7Mpjd1VH9sf7lrdJnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 17/76] net: appletalk: Fix use-after-free in AARP proxy probe
Date: Wed, 30 Jul 2025 11:35:10 +0200
Message-ID: <20250730093227.521317996@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kito Xu (veritas501) <hxzene@gmail.com>

[ Upstream commit 6c4a92d07b0850342d3becf2e608f805e972467c ]

The AARP proxy‐probe routine (aarp_proxy_probe_network) sends a probe,
releases the aarp_lock, sleeps, then re-acquires the lock.  During that
window an expire timer thread (__aarp_expire_timer) can remove and
kfree() the same entry, leading to a use-after-free.

race condition:

         cpu 0                          |            cpu 1
    atalk_sendmsg()                     |   atif_proxy_probe_device()
    aarp_send_ddp()                     |   aarp_proxy_probe_network()
    mod_timer()                         |   lock(aarp_lock) // LOCK!!
    timeout around 200ms                |   alloc(aarp_entry)
    and then call                       |   proxies[hash] = aarp_entry
    aarp_expire_timeout()               |   aarp_send_probe()
                                        |   unlock(aarp_lock) // UNLOCK!!
    lock(aarp_lock) // LOCK!!           |   msleep(100);
    __aarp_expire_timer(&proxies[ct])   |
    free(aarp_entry)                    |
    unlock(aarp_lock) // UNLOCK!!       |
                                        |   lock(aarp_lock) // LOCK!!
                                        |   UAF aarp_entry !!

==================================================================
BUG: KASAN: slab-use-after-free in aarp_proxy_probe_network+0x560/0x630 net/appletalk/aarp.c:493
Read of size 4 at addr ffff8880123aa360 by task repro/13278

CPU: 3 UID: 0 PID: 13278 Comm: repro Not tainted 6.15.2 #3 PREEMPT(full)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc1/0x630 mm/kasan/report.c:521
 kasan_report+0xca/0x100 mm/kasan/report.c:634
 aarp_proxy_probe_network+0x560/0x630 net/appletalk/aarp.c:493
 atif_proxy_probe_device net/appletalk/ddp.c:332 [inline]
 atif_ioctl+0xb58/0x16c0 net/appletalk/ddp.c:857
 atalk_ioctl+0x198/0x2f0 net/appletalk/ddp.c:1818
 sock_do_ioctl+0xdc/0x260 net/socket.c:1190
 sock_ioctl+0x239/0x6a0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x194/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcb/0x250 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Allocated:
 aarp_alloc net/appletalk/aarp.c:382 [inline]
 aarp_proxy_probe_network+0xd8/0x630 net/appletalk/aarp.c:468
 atif_proxy_probe_device net/appletalk/ddp.c:332 [inline]
 atif_ioctl+0xb58/0x16c0 net/appletalk/ddp.c:857
 atalk_ioctl+0x198/0x2f0 net/appletalk/ddp.c:1818

Freed:
 kfree+0x148/0x4d0 mm/slub.c:4841
 __aarp_expire net/appletalk/aarp.c:90 [inline]
 __aarp_expire_timer net/appletalk/aarp.c:261 [inline]
 aarp_expire_timeout+0x480/0x6e0 net/appletalk/aarp.c:317

The buggy address belongs to the object at ffff8880123aa300
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 96 bytes inside of
 freed 192-byte region [ffff8880123aa300, ffff8880123aa3c0)

Memory state around the buggy address:
 ffff8880123aa200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880123aa280: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880123aa300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff8880123aa380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880123aa400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
Link: https://patch.msgid.link/20250717012843.880423-1-hxzene@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/appletalk/aarp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index c7236daa24152..0d7c14a496681 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -35,6 +35,7 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/etherdevice.h>
+#include <linux/refcount.h>
 
 int sysctl_aarp_expiry_time = AARP_EXPIRY_TIME;
 int sysctl_aarp_tick_time = AARP_TICK_TIME;
@@ -44,6 +45,7 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
 /* Lists of aarp entries */
 /**
  *	struct aarp_entry - AARP entry
+ *	@refcnt: Reference count
  *	@last_sent: Last time we xmitted the aarp request
  *	@packet_queue: Queue of frames wait for resolution
  *	@status: Used for proxy AARP
@@ -55,6 +57,7 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
  *	@next: Next entry in chain
  */
 struct aarp_entry {
+	refcount_t			refcnt;
 	/* These first two are only used for unresolved entries */
 	unsigned long		last_sent;
 	struct sk_buff_head	packet_queue;
@@ -79,6 +82,17 @@ static DEFINE_RWLOCK(aarp_lock);
 /* Used to walk the list and purge/kick entries.  */
 static struct timer_list aarp_timer;
 
+static inline void aarp_entry_get(struct aarp_entry *a)
+{
+	refcount_inc(&a->refcnt);
+}
+
+static inline void aarp_entry_put(struct aarp_entry *a)
+{
+	if (refcount_dec_and_test(&a->refcnt))
+		kfree(a);
+}
+
 /*
  *	Delete an aarp queue
  *
@@ -87,7 +101,7 @@ static struct timer_list aarp_timer;
 static void __aarp_expire(struct aarp_entry *a)
 {
 	skb_queue_purge(&a->packet_queue);
-	kfree(a);
+	aarp_entry_put(a);
 }
 
 /*
@@ -380,9 +394,11 @@ static void aarp_purge(void)
 static struct aarp_entry *aarp_alloc(void)
 {
 	struct aarp_entry *a = kmalloc(sizeof(*a), GFP_ATOMIC);
+	if (!a)
+		return NULL;
 
-	if (a)
-		skb_queue_head_init(&a->packet_queue);
+	refcount_set(&a->refcnt, 1);
+	skb_queue_head_init(&a->packet_queue);
 	return a;
 }
 
@@ -508,6 +524,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 	entry->dev = atif->dev;
 
 	write_lock_bh(&aarp_lock);
+	aarp_entry_get(entry);
 
 	hash = sa->s_node % (AARP_HASH_SIZE - 1);
 	entry->next = proxies[hash];
@@ -533,6 +550,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 		retval = 1;
 	}
 
+	aarp_entry_put(entry);
 	write_unlock_bh(&aarp_lock);
 out:
 	return retval;
-- 
2.39.5




