Return-Path: <stable+bounces-164244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A4B0DE48
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA5C1C87F67
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA52ECE92;
	Tue, 22 Jul 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dpBMZV5c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB82E1C53;
	Tue, 22 Jul 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193721; cv=none; b=DYe2a03rd0x+PeffJjhfyZQNTGMypxISbYZWIRBkBakdjOn73JYxfyE+0XQxQDmypcn88w0vbRn08U93M42YAPlfi9buQAekt8GpUqONh9Gx+ilKBi48wzgNPVqKIV2vSD+HTqTaul92HZAghu5o8gp8AZ1vba2hnuZQ+yQPEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193721; c=relaxed/simple;
	bh=mzMpo1hzdicSkAKtPNFCf3ze/INAa2hR5HHFyTgOtw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaBP+mvOZ7321XU0Ko6ZPBG8pQpE7M4CsEUT1iJ+iV3F8EMZY/ZzHJJkz04izuwoYXrXVHNrINyZYijL3ANlqR97mhupcg5bq5uMTN+stPtxdJGgLPrkhLwrFhiv45Qw/Oleh2PDiPBh/SL/Y7Xo6Vg3DS8jglbJ7hR39NzRHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dpBMZV5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D5CC4CEF1;
	Tue, 22 Jul 2025 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193721;
	bh=mzMpo1hzdicSkAKtPNFCf3ze/INAa2hR5HHFyTgOtw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpBMZV5csCH1Cq6y6UOfPULwJUv4yHQ/bDMJjg1/76Ii44kvt5mFPmLLUllNBwsz+
	 wot0NYIpAlh7s+MRHi9SeIfFKC7J8I62tEIzo2Rl0U3w4O2zG/BpESmaUEMMAeegMe
	 37oEqKi6cE5d9ql9us/htu8ymklIfM6yH5TZSl0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Razvan Cojocaru <rzvncj@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 145/187] netfilter: nf_conntrack: fix crash due to removal of uninitialised entry
Date: Tue, 22 Jul 2025 15:45:15 +0200
Message-ID: <20250722134351.187771395@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 2d72afb340657f03f7261e9243b44457a9228ac7 ]

A crash in conntrack was reported while trying to unlink the conntrack
entry from the hash bucket list:
    [exception RIP: __nf_ct_delete_from_lists+172]
    [..]
 #7 [ff539b5a2b043aa0] nf_ct_delete at ffffffffc124d421 [nf_conntrack]
 #8 [ff539b5a2b043ad0] nf_ct_gc_expired at ffffffffc124d999 [nf_conntrack]
 #9 [ff539b5a2b043ae0] __nf_conntrack_find_get at ffffffffc124efbc [nf_conntrack]
    [..]

The nf_conn struct is marked as allocated from slab but appears to be in
a partially initialised state:

 ct hlist pointer is garbage; looks like the ct hash value
 (hence crash).
 ct->status is equal to IPS_CONFIRMED|IPS_DYING, which is expected
 ct->timeout is 30000 (=30s), which is unexpected.

Everything else looks like normal udp conntrack entry.  If we ignore
ct->status and pretend its 0, the entry matches those that are newly
allocated but not yet inserted into the hash:
  - ct hlist pointers are overloaded and store/cache the raw tuple hash
  - ct->timeout matches the relative time expected for a new udp flow
    rather than the absolute 'jiffies' value.

If it were not for the presence of IPS_CONFIRMED,
__nf_conntrack_find_get() would have skipped the entry.

Theory is that we did hit following race:

cpu x 			cpu y			cpu z
 found entry E		found entry E
 E is expired		<preemption>
 nf_ct_delete()
 return E to rcu slab
					init_conntrack
					E is re-inited,
					ct->status set to 0
					reply tuplehash hnnode.pprev
					stores hash value.

cpu y found E right before it was deleted on cpu x.
E is now re-inited on cpu z.  cpu y was preempted before
checking for expiry and/or confirm bit.

					->refcnt set to 1
					E now owned by skb
					->timeout set to 30000

If cpu y were to resume now, it would observe E as
expired but would skip E due to missing CONFIRMED bit.

					nf_conntrack_confirm gets called
					sets: ct->status |= CONFIRMED
					This is wrong: E is not yet added
					to hashtable.

cpu y resumes, it observes E as expired but CONFIRMED:
			<resumes>
			nf_ct_expired()
			 -> yes (ct->timeout is 30s)
			confirmed bit set.

cpu y will try to delete E from the hashtable:
			nf_ct_delete() -> set DYING bit
			__nf_ct_delete_from_lists

Even this scenario doesn't guarantee a crash:
cpu z still holds the table bucket lock(s) so y blocks:

			wait for spinlock held by z

					CONFIRMED is set but there is no
					guarantee ct will be added to hash:
					"chaintoolong" or "clash resolution"
					logic both skip the insert step.
					reply hnnode.pprev still stores the
					hash value.

					unlocks spinlock
					return NF_DROP
			<unblocks, then
			 crashes on hlist_nulls_del_rcu pprev>

In case CPU z does insert the entry into the hashtable, cpu y will unlink
E again right away but no crash occurs.

Without 'cpu y' race, 'garbage' hlist is of no consequence:
ct refcnt remains at 1, eventually skb will be free'd and E gets
destroyed via: nf_conntrack_put -> nf_conntrack_destroy -> nf_ct_destroy.

To resolve this, move the IPS_CONFIRMED assignment after the table
insertion but before the unlock.

Pablo points out that the confirm-bit-store could be reordered to happen
before hlist add resp. the timeout fixup, so switch to set_bit and
before_atomic memory barrier to prevent this.

It doesn't matter if other CPUs can observe a newly inserted entry right
before the CONFIRMED bit was set:

Such event cannot be distinguished from above "E is the old incarnation"
case: the entry will be skipped.

Also change nf_ct_should_gc() to first check the confirmed bit.

The gc sequence is:
 1. Check if entry has expired, if not skip to next entry
 2. Obtain a reference to the expired entry.
 3. Call nf_ct_should_gc() to double-check step 1.

nf_ct_should_gc() is thus called only for entries that already failed an
expiry check. After this patch, once the confirmed bit check passes
ct->timeout has been altered to reflect the absolute 'best before' date
instead of a relative time.  Step 3 will therefore not remove the entry.

Without this change to nf_ct_should_gc() we could still get this sequence:

 1. Check if entry has expired.
 2. Obtain a reference.
 3. Call nf_ct_should_gc() to double-check step 1:
    4 - entry is still observed as expired
    5 - meanwhile, ct->timeout is corrected to absolute value on other CPU
      and confirm bit gets set
    6 - confirm bit is seen
    7 - valid entry is removed again

First do check 6), then 4) so the gc expiry check always picks up either
confirmed bit unset (entry gets skipped) or expiry re-check failure for
re-inited conntrack objects.

This change cannot be backported to releases before 5.19. Without
commit 8a75a2c17410 ("netfilter: conntrack: remove unconfirmed list")
|= IPS_CONFIRMED line cannot be moved without further changes.

Cc: Razvan Cojocaru <rzvncj@gmail.com>
Link: https://lore.kernel.org/netfilter-devel/20250627142758.25664-1-fw@strlen.de/
Link: https://lore.kernel.org/netfilter-devel/4239da15-83ff-4ca4-939d-faef283471bb@gmail.com/
Fixes: 1397af5bfd7d ("netfilter: conntrack: remove the percpu dying list")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack.h | 15 +++++++++++++--
 net/netfilter/nf_conntrack_core.c    | 26 ++++++++++++++++++++------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 3f02a45773e81..ca26274196b99 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -306,8 +306,19 @@ static inline bool nf_ct_is_expired(const struct nf_conn *ct)
 /* use after obtaining a reference count */
 static inline bool nf_ct_should_gc(const struct nf_conn *ct)
 {
-	return nf_ct_is_expired(ct) && nf_ct_is_confirmed(ct) &&
-	       !nf_ct_is_dying(ct);
+	if (!nf_ct_is_confirmed(ct))
+		return false;
+
+	/* load ct->timeout after is_confirmed() test.
+	 * Pairs with __nf_conntrack_confirm() which:
+	 * 1. Increases ct->timeout value
+	 * 2. Inserts ct into rcu hlist
+	 * 3. Sets the confirmed bit
+	 * 4. Unlocks the hlist lock
+	 */
+	smp_acquire__after_ctrl_dep();
+
+	return nf_ct_is_expired(ct) && !nf_ct_is_dying(ct);
 }
 
 #define	NF_CT_DAY	(86400 * HZ)
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 7f8b245e287ae..e720505177607 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1121,6 +1121,12 @@ static int nf_ct_resolve_clash_harder(struct sk_buff *skb, u32 repl_idx)
 
 	hlist_nulls_add_head_rcu(&loser_ct->tuplehash[IP_CT_DIR_REPLY].hnnode,
 				 &nf_conntrack_hash[repl_idx]);
+	/* confirmed bit must be set after hlist add, not before:
+	 * loser_ct can still be visible to other cpu due to
+	 * SLAB_TYPESAFE_BY_RCU.
+	 */
+	smp_mb__before_atomic();
+	set_bit(IPS_CONFIRMED_BIT, &loser_ct->status);
 
 	NF_CT_STAT_INC(net, clash_resolve);
 	return NF_ACCEPT;
@@ -1257,8 +1263,6 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 	 * user context, else we insert an already 'dead' hash, blocking
 	 * further use of that particular connection -JM.
 	 */
-	ct->status |= IPS_CONFIRMED;
-
 	if (unlikely(nf_ct_is_dying(ct))) {
 		NF_CT_STAT_INC(net, insert_failed);
 		goto dying;
@@ -1290,7 +1294,7 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 		}
 	}
 
-	/* Timer relative to confirmation time, not original
+	/* Timeout is relative to confirmation time, not original
 	   setting time, otherwise we'd get timer wrap in
 	   weird delay cases. */
 	ct->timeout += nfct_time_stamp;
@@ -1298,11 +1302,21 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 	__nf_conntrack_insert_prepare(ct);
 
 	/* Since the lookup is lockless, hash insertion must be done after
-	 * starting the timer and setting the CONFIRMED bit. The RCU barriers
-	 * guarantee that no other CPU can find the conntrack before the above
-	 * stores are visible.
+	 * setting ct->timeout. The RCU barriers guarantee that no other CPU
+	 * can find the conntrack before the above stores are visible.
 	 */
 	__nf_conntrack_hash_insert(ct, hash, reply_hash);
+
+	/* IPS_CONFIRMED unset means 'ct not (yet) in hash', conntrack lookups
+	 * skip entries that lack this bit.  This happens when a CPU is looking
+	 * at a stale entry that is being recycled due to SLAB_TYPESAFE_BY_RCU
+	 * or when another CPU encounters this entry right after the insertion
+	 * but before the set-confirm-bit below.  This bit must not be set until
+	 * after __nf_conntrack_hash_insert().
+	 */
+	smp_mb__before_atomic();
+	set_bit(IPS_CONFIRMED_BIT, &ct->status);
+
 	nf_conntrack_double_unlock(hash, reply_hash);
 	local_bh_enable();
 
-- 
2.39.5




