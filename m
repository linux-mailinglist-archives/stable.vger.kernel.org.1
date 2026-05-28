Return-Path: <stable+bounces-254891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIQIBLgrGGqwfAgAu9opvQ
	(envelope-from <stable+bounces-254891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:49:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A32C5F188A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CB8D3047BC3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6A63E6394;
	Thu, 28 May 2026 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrQius6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A43E6386
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968800; cv=none; b=lJMCzW31iZjePZf+ZOv05IkPCW6OetBLji4A2GH0Eqb5LN4MV+Ys9d/5/3m1vGAemBALA0EIjASH+k1K1JYa17lYJCDsgCKpO8b6ZCoMRqPRZjfsTgFuOXD8t68EvMC/mnwpxE8AEKOe4wg9pnFaaZUyJ0RvGL+zTKE9J0OfCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968800; c=relaxed/simple;
	bh=Tz1XPef0+cFkdVZ3KHSNEpNjOc+ik31MzW3rY02Q+a8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nHFndl5vzlaqmM/WXXopDu3ZE+9kPzUUWMqB/Z44uNmnvrea4Bo/QwmkotZ6VBcBVfDW3a9DJl5Sqb4B1GCwOgHgItZfEeMMhk+o2uHTCYVTiZOdWmN44G8XXq8YRdz4dWTmTPE9Ff2rJ8gmpfMfFINm///aQgEjJe6J7G3Qccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrQius6N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318AA1F000E9;
	Thu, 28 May 2026 11:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968796;
	bh=KrapkTAh6XAkMJSIAhyiG4uPv4RDb0oHDgGiQYsMiwA=;
	h=Subject:To:Cc:From:Date;
	b=qrQius6NOkqN2guX1X3jbMO3loVXMy7Edz+5MCwb9tBe7jTxnQE1yyvqXdUhJLnuk
	 Fh0Xts6GIUQ1YFFLvLoweVYVSkqVEsVQz+rM0iJ0TGl6tGqVSm6kxWy/TyMPPjqqPn
	 WqepwVK+sKov4KbpLzucuIwad7f4+C21/au96I+0=
Subject: FAILED: patch "[PATCH] mm/slub: hold cpus_read_lock around" failed to apply to 6.18-stable tree
To: wangqing7171@gmail.com,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:45:43 +0200
Message-ID: <2026052843-flavoring-boat-ccba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254891-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:email]
X-Rspamd-Queue-Id: 7A32C5F188A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 67ea9d353d0ba12bdbc9183ff568dead9e949b80
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052843-flavoring-boat-ccba@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 67ea9d353d0ba12bdbc9183ff568dead9e949b80 Mon Sep 17 00:00:00 2001
From: Qing Wang <wangqing7171@gmail.com>
Date: Tue, 12 May 2026 11:50:35 +0800
Subject: [PATCH] mm/slub: hold cpus_read_lock around
 flush_rcu_sheaves_on_cache()

flush_rcu_sheaves_on_cache() calls queue_work_on() in a
for_each_online_cpu() loop, which requires the cpu to stay online.
But cpus_read_lock() is not held in kvfree_rcu_barrier_on_cache() and the
set of "online cpus" is subject to change.

There are two paths that call flush_rcu_sheaves_on_cache():

  // has cpus_read_lock()
  flush_all_rcu_sheaves()
    -> flush_rcu_sheaves_on_cache()

  // no cpus_read_lock()
  kvfree_rcu_barrier_on_cache()
    -> flush_rcu_sheaves_on_cache()

Fix this by holding cpus_read_lock() in kvfree_rcu_barrier_on_cache().

Why not move cpus_read_lock() from flush_all_rcu_sheaves() into
flush_rcu_sheaves_on_cache()? The reason is it would introduce a new lock
order (slab_mutex -> cpu_hotplug_lock). The reverse order
(cpu_hotplug_lock -> slab_mutex) is established by

- cpuhp_setup_state_nocalls(..., slub_cpu_setup, ...)
- kmem_cache_destroy()

The two orders together would form an AB-BA deadlock.

Finally, add lockdep_assert_cpus_held() in flush_rcu_sheaves_on_cache()
to catch the same problem in the future.

Fixes: 0f35040de593 ("mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
Link: https://patch.msgid.link/20260512035035.762317-1-wangqing7171@gmail.com
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/mm/slab_common.c b/mm/slab_common.c
index d5a70a831a2a..8b661fff5eed 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2110,7 +2110,9 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
 {
 	if (cache_has_sheaves(s)) {
+		cpus_read_lock();
 		flush_rcu_sheaves_on_cache(s);
+		cpus_read_unlock();
 		rcu_barrier();
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index 0baa906f39ab..9ad80b7f601a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4024,6 +4024,7 @@ void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
 	struct slub_flush_work *sfw;
 	unsigned int cpu;
 
+	lockdep_assert_cpus_held();
 	mutex_lock(&flush_lock);
 
 	for_each_online_cpu(cpu) {


