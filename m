Return-Path: <stable+bounces-213222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK7eHQ3vgWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:50:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AAFD953A
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5F8830A7A77
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2C34679B;
	Tue,  3 Feb 2026 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2KC1KkxM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310C34679C
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122930; cv=none; b=fOBdLrP58n9LEXulBH7OqO/Z/t3X92xHI5tumMTLazvRAUzWzNb5NG8v0kUh53UuGSr/sBWcDQnAHmnA24JB0kwOkG1SF1FqBQdtYDynBv+DUhTTue086+doECM1VELKBzyTb4z1JGhku+0RblKflkxTv2is6ALPS0jayrk8P8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122930; c=relaxed/simple;
	bh=rUdE9S6cc55EP4KTc1pGZ7xHsTc7WSEWaLEfw7OtAuo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m6k0EtjGgW9HocP+Vwyju+Q5lICb0hxNWQTdeXZLz5UQv9ccfdWEl3M44MyiLqRdavUB1ePoMUNqJtIOT264pNSzxcKlat35qKcaADASRCbUdzqUay+E87maMKrDJTyyps5LnEV66t9S0K256Od5xMwJz3bEhnWOM/6Xrpe2ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2KC1KkxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD52C19425;
	Tue,  3 Feb 2026 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122929;
	bh=rUdE9S6cc55EP4KTc1pGZ7xHsTc7WSEWaLEfw7OtAuo=;
	h=Subject:To:Cc:From:Date:From;
	b=2KC1KkxMNhYRGz5o+YLC1c+MCbvIVH0DNfDqFU7xB4IYbeGUv2DeUkhc+ZtFD7jI7
	 Q6TmqKOqInB+kWY6HASSQ91lqx/hE0+gZhngC7S4O7uix2jD/HyULIWWBq+WcfJ9BQ
	 J9s2gnQ+k2VFLCNOQASMrHGNcGsjhHIud6V4cIRk=
Subject: FAILED: patch "[PATCH] mm/kfence: randomize the freelist on initialization" failed to apply to 6.6-stable tree
To: pimyn@google.com,akpm@linux-foundation.org,dvyukov@google.com,elver@google.com,ernesto.martinezgarcia@tugraz.at,glider@google.com,gregkh@linuxfoundation.org,kees@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:48:38 +0100
Message-ID: <2026020338-hemstitch-magnolia-fb91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213222-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tugraz.at:email,linuxfoundation.org:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9AAFD953A
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 870ff19251bf3910dda7a7245da826924045fedd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020338-hemstitch-magnolia-fb91@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 870ff19251bf3910dda7a7245da826924045fedd Mon Sep 17 00:00:00 2001
From: Pimyn Girgis <pimyn@google.com>
Date: Tue, 20 Jan 2026 17:15:10 +0100
Subject: [PATCH] mm/kfence: randomize the freelist on initialization

Randomize the KFENCE freelist during pool initialization to make
allocation patterns less predictable.  This is achieved by shuffling the
order in which metadata objects are added to the freelist using
get_random_u32_below().

Additionally, ensure the error path correctly calculates the address range
to be reset if initialization fails, as the address increment logic has
been moved to a separate loop.

Link: https://lkml.kernel.org/r/20260120161510.3289089-1-pimyn@google.com
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Pimyn Girgis <pimyn@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index da0f5b6f5744..4f79ec720752 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -596,7 +596,7 @@ static void rcu_guarded_free(struct rcu_head *h)
 static unsigned long kfence_init_pool(void)
 {
 	unsigned long addr, start_pfn;
-	int i;
+	int i, rand;
 
 	if (!arch_kfence_init_pool())
 		return (unsigned long)__kfence_pool;
@@ -647,13 +647,27 @@ static unsigned long kfence_init_pool(void)
 		INIT_LIST_HEAD(&meta->list);
 		raw_spin_lock_init(&meta->lock);
 		meta->state = KFENCE_OBJECT_UNUSED;
-		meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
-		list_add_tail(&meta->list, &kfence_freelist);
+		/* Use addr to randomize the freelist. */
+		meta->addr = i;
 
 		/* Protect the right redzone. */
-		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
+		if (unlikely(!kfence_protect(addr + 2 * i * PAGE_SIZE + PAGE_SIZE)))
 			goto reset_slab;
+	}
 
+	for (i = CONFIG_KFENCE_NUM_OBJECTS; i > 0; i--) {
+		rand = get_random_u32_below(i);
+		swap(kfence_metadata_init[i - 1].addr, kfence_metadata_init[rand].addr);
+	}
+
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		struct kfence_metadata *meta_1 = &kfence_metadata_init[i];
+		struct kfence_metadata *meta_2 = &kfence_metadata_init[meta_1->addr];
+
+		list_add_tail(&meta_2->list, &kfence_freelist);
+	}
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		kfence_metadata_init[i].addr = addr;
 		addr += 2 * PAGE_SIZE;
 	}
 
@@ -666,6 +680,7 @@ static unsigned long kfence_init_pool(void)
 	return 0;
 
 reset_slab:
+	addr += 2 * i * PAGE_SIZE;
 	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
 		struct page *page;
 


