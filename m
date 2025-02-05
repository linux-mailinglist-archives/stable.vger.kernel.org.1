Return-Path: <stable+bounces-113831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A343A2948A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD73A8854
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E167190063;
	Wed,  5 Feb 2025 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MFNRJ9JV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3118FDDA;
	Wed,  5 Feb 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768311; cv=none; b=L9oAoVA2WMsCiedqu5LSJ7Ew+bdsFLTXqyIxG62ldNg9uCSZ8vAJGgtAdB8EXMdo6ACOPLSVIN2ZHWI+EYyStmo+DB7wbBOa/RRtppXjWngGVq+H+b8z9DkAom7B+WOSIhGjW2lETI2WHAC66+lsxsK9Fa3c0Ift1S7Y9dQKklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768311; c=relaxed/simple;
	bh=tKfMy8BddGnjhqUT2B3zvx7IYwh731szXMWXhBsKO/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jY8XDPgDB7VEfxw9W8o0WPWlyUrlQf1QKiRSMVpW0me8VP8yR7HButDqOgHAT5+7ZhlcXm/YTN26+N/VQqvd50mOD7dwfL6elIrpmkFoA7zhWPyOQ2pgpNnqSl5LLlbgSeh0imfNTD5d3HA+RYh+boB4X4/jt3hF17ZjTYE6CWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MFNRJ9JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3C1C4CED6;
	Wed,  5 Feb 2025 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768311;
	bh=tKfMy8BddGnjhqUT2B3zvx7IYwh731szXMWXhBsKO/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFNRJ9JVN3J6uoXl3j3qXJKut7nF+TN+nR5R8lv26nTxX5vhx07s95Y88r4tZZzFz
	 hBXoOIblUMs0bijaI2qCOMldKUHNJm/0i5B6H3ToQFgyFTwdyA/K65onEPIi03fNhp
	 nZA9Ra9LlTeJb1VhxwYuY5ZTxEZZ0+jw4OO+kQEc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 529/623] rxrpc, afs: Fix peer hash locking vs RCU callback
Date: Wed,  5 Feb 2025 14:44:31 +0100
Message-ID: <20250205134516.464436617@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 79d458c13056559d49b5e41fbc4b6890e68cf65b ]

In its address list, afs now retains pointers to and refs on one or more
rxrpc_peer objects.  The address list is freed under RCU and at this time,
it puts the refs on those peers.

Now, when an rxrpc_peer object runs out of refs, it gets removed from the
peer hash table and, for that, rxrpc has to take a spinlock.  However, it
is now being called from afs's RCU cleanup, which takes place in BH
context - but it is just taking an ordinary spinlock.

The put may also be called from non-BH context, and so there exists the
possibility of deadlock if the BH-based RCU cleanup happens whilst the hash
spinlock is held.  This led to the attached lockdep complaint.

Fix this by changing spinlocks of rxnet->peer_hash_lock back to
BH-disabling locks.

    ================================
    WARNING: inconsistent lock state
    6.13.0-rc5-build2+ #1223 Tainted: G            E
    --------------------------------
    inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
    swapper/1/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
    ffff88810babe228 (&rxnet->peer_hash_lock){+.?.}-{3:3}, at: rxrpc_put_peer+0xcb/0x180
    {SOFTIRQ-ON-W} state was registered at:
      mark_usage+0x164/0x180
      __lock_acquire+0x544/0x990
      lock_acquire.part.0+0x103/0x280
      _raw_spin_lock+0x2f/0x40
      rxrpc_peer_keepalive_worker+0x144/0x440
      process_one_work+0x486/0x7c0
      process_scheduled_works+0x73/0x90
      worker_thread+0x1c8/0x2a0
      kthread+0x19b/0x1b0
      ret_from_fork+0x24/0x40
      ret_from_fork_asm+0x1a/0x30
    irq event stamp: 972402
    hardirqs last  enabled at (972402): [<ffffffff8244360e>] _raw_spin_unlock_irqrestore+0x2e/0x50
    hardirqs last disabled at (972401): [<ffffffff82443328>] _raw_spin_lock_irqsave+0x18/0x60
    softirqs last  enabled at (972300): [<ffffffff810ffbbe>] handle_softirqs+0x3ee/0x430
    softirqs last disabled at (972313): [<ffffffff810ffc54>] __irq_exit_rcu+0x44/0x110

    other info that might help us debug this:
     Possible unsafe locking scenario:
           CPU0
           ----
      lock(&rxnet->peer_hash_lock);
      <Interrupt>
        lock(&rxnet->peer_hash_lock);

     *** DEADLOCK ***
    1 lock held by swapper/1/0:
     #0: ffffffff83576be0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire+0x7/0x30

    stack backtrace:
    CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G            E      6.13.0-rc5-build2+ #1223
    Tainted: [E]=UNSIGNED_MODULE
    Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
    Call Trace:
     <IRQ>
     dump_stack_lvl+0x57/0x80
     print_usage_bug.part.0+0x227/0x240
     valid_state+0x53/0x70
     mark_lock_irq+0xa5/0x2f0
     mark_lock+0xf7/0x170
     mark_usage+0xe1/0x180
     __lock_acquire+0x544/0x990
     lock_acquire.part.0+0x103/0x280
     _raw_spin_lock+0x2f/0x40
     rxrpc_put_peer+0xcb/0x180
     afs_free_addrlist+0x46/0x90 [kafs]
     rcu_do_batch+0x2d2/0x640
     rcu_core+0x2f7/0x350
     handle_softirqs+0x1ee/0x430
     __irq_exit_rcu+0x44/0x110
     irq_exit_rcu+0xa/0x30
     sysvec_apic_timer_interrupt+0x7f/0xa0
     </IRQ>

Fixes: 72904d7b9bfb ("rxrpc, afs: Allow afs to pin rxrpc_peer objects")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/2095618.1737622752@warthog.procyon.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/peer_event.c  | 16 ++++++++--------
 net/rxrpc/peer_object.c | 12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 552ba84a255c4..5d0842efde69f 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -238,7 +238,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 	bool use;
 	int slot;
 
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 
 	while (!list_empty(collector)) {
 		peer = list_entry(collector->next,
@@ -249,7 +249,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 			continue;
 
 		use = __rxrpc_use_local(peer->local, rxrpc_local_use_peer_keepalive);
-		spin_unlock(&rxnet->peer_hash_lock);
+		spin_unlock_bh(&rxnet->peer_hash_lock);
 
 		if (use) {
 			keepalive_at = peer->last_tx_at + RXRPC_KEEPALIVE_TIME;
@@ -269,17 +269,17 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 			 */
 			slot += cursor;
 			slot &= mask;
-			spin_lock(&rxnet->peer_hash_lock);
+			spin_lock_bh(&rxnet->peer_hash_lock);
 			list_add_tail(&peer->keepalive_link,
 				      &rxnet->peer_keepalive[slot & mask]);
-			spin_unlock(&rxnet->peer_hash_lock);
+			spin_unlock_bh(&rxnet->peer_hash_lock);
 			rxrpc_unuse_local(peer->local, rxrpc_local_unuse_peer_keepalive);
 		}
 		rxrpc_put_peer(peer, rxrpc_peer_put_keepalive);
-		spin_lock(&rxnet->peer_hash_lock);
+		spin_lock_bh(&rxnet->peer_hash_lock);
 	}
 
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 }
 
 /*
@@ -309,7 +309,7 @@ void rxrpc_peer_keepalive_worker(struct work_struct *work)
 	 * second; the bucket at cursor + 1 goes at now + 1s and so
 	 * on...
 	 */
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	list_splice_init(&rxnet->peer_keepalive_new, &collector);
 
 	stop = cursor + ARRAY_SIZE(rxnet->peer_keepalive);
@@ -321,7 +321,7 @@ void rxrpc_peer_keepalive_worker(struct work_struct *work)
 	}
 
 	base = now;
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 
 	rxnet->peer_keepalive_base = base;
 	rxnet->peer_keepalive_cursor = cursor;
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 49dcda67a0d59..956fc7ea4b734 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -313,10 +313,10 @@ void rxrpc_new_incoming_peer(struct rxrpc_local *local, struct rxrpc_peer *peer)
 	hash_key = rxrpc_peer_hash_key(local, &peer->srx);
 	rxrpc_init_peer(local, peer, hash_key);
 
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	hash_add_rcu(rxnet->peer_hash, &peer->hash_link, hash_key);
 	list_add_tail(&peer->keepalive_link, &rxnet->peer_keepalive_new);
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 }
 
 /*
@@ -348,7 +348,7 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 			return NULL;
 		}
 
-		spin_lock(&rxnet->peer_hash_lock);
+		spin_lock_bh(&rxnet->peer_hash_lock);
 
 		/* Need to check that we aren't racing with someone else */
 		peer = __rxrpc_lookup_peer_rcu(local, srx, hash_key);
@@ -361,7 +361,7 @@ struct rxrpc_peer *rxrpc_lookup_peer(struct rxrpc_local *local,
 				      &rxnet->peer_keepalive_new);
 		}
 
-		spin_unlock(&rxnet->peer_hash_lock);
+		spin_unlock_bh(&rxnet->peer_hash_lock);
 
 		if (peer)
 			rxrpc_free_peer(candidate);
@@ -411,10 +411,10 @@ static void __rxrpc_put_peer(struct rxrpc_peer *peer)
 
 	ASSERT(hlist_empty(&peer->error_targets));
 
-	spin_lock(&rxnet->peer_hash_lock);
+	spin_lock_bh(&rxnet->peer_hash_lock);
 	hash_del_rcu(&peer->hash_link);
 	list_del_init(&peer->keepalive_link);
-	spin_unlock(&rxnet->peer_hash_lock);
+	spin_unlock_bh(&rxnet->peer_hash_lock);
 
 	rxrpc_free_peer(peer);
 }
-- 
2.39.5




