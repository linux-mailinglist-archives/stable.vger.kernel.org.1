Return-Path: <stable+bounces-223115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDnzAGVwqGkkugAAu9opvQ
	(envelope-from <stable+bounces-223115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:48:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CB6205691
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A0130AE372
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628BF3CB2E8;
	Wed,  4 Mar 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ctaQX3UB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680C3CA48F;
	Wed,  4 Mar 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646312; cv=none; b=FljrJTHe791wbNzqSR1sFbFFIry3amvpO7cQbjGlreJqteNvio9PjtU15fAqDgFJ58RTO12WtxWpUuXQVLn56RKOWcL/f8HAsLFgLGum5ztKWLmeFvBcDfgk4oy5s5lUQuBapy1I9kD6tQNpVDk64jlESI0SxTLqImobWof+tcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646312; c=relaxed/simple;
	bh=SY4SK3XgsQkUnLcRj5uCelZ4icGKJP9DqamZrTudYuU=;
	h=Date:To:From:Subject:Message-Id; b=VWqmNnmg84ldC/6bAkczfPBqexa5QfmOPHaEkr/qjGyqwsO35nqv/fCq8t8X3Q1mKCaAOGZ49qAKCJF2/IrB31IMiUR0UodBhNWz6FXcymsxbb3LvUorss6MJsZ8/YAbUbnRRwdH6frIiXwvpNvpSt1JyUmuP+v3G1kjQWxxp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ctaQX3UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2239C19425;
	Wed,  4 Mar 2026 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772646312;
	bh=SY4SK3XgsQkUnLcRj5uCelZ4icGKJP9DqamZrTudYuU=;
	h=Date:To:From:Subject:From;
	b=ctaQX3UBoNLUW2zxMG5/XO3CQJOxw1/kjeDw7E/8ticLhtG3E1hgVI3o8mA23s2si
	 IjNwzPMHZvUo4SW8maot0t/HdmtnFjt4yjStcQi/bfYtIghWJtbeerxBGuIv0E5eMB
	 tdx9O7XTj5vG5Ic6XaS8yCYMYfYhswIZg/2eeenk=
Date: Wed, 04 Mar 2026 09:45:11 -0800
To: mm-commits@vger.kernel.org,vbabka@suse.com,stable@vger.kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,muchun.song@linux.dev,mhocko@kernel.org,hannes@cmpxchg.org,hao.li@linux.dev,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] memcg-fix-slab-accounting-in-refill_obj_stock-trylock-path.patch removed from -mm tree
Message-Id: <20260304174511.F2239C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 57CB6205691
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-223115-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,linux-foundation.org:dkim,linux-foundation.org:email,suse.com:email,linux.dev:email,cmpxchg.org:email]
X-Rspamd-Action: no action


The quilt patch titled
     Subject: memcg: fix slab accounting in refill_obj_stock() trylock path
has been removed from the -mm tree.  Its filename was
     memcg-fix-slab-accounting-in-refill_obj_stock-trylock-path.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Hao Li <hao.li@linux.dev>
Subject: memcg: fix slab accounting in refill_obj_stock() trylock path
Date: Thu, 26 Feb 2026 19:51:37 +0800

In the trylock path of refill_obj_stock(), mod_objcg_mlstate() should use
the real alloc/free bytes (i.e., nr_acct) for accounting, rather than
nr_bytes.

The user-visible impact is that the NR_SLAB_RECLAIMABLE_B and
NR_SLAB_UNRECLAIMABLE_B stats can end up being incorrect.

For example, if a user allocates a 6144-byte object, then before this
fix efill_obj_stock() calls mod_objcg_mlstate(..., nr_bytes=2048), even
though it should account for 6144 bytes (i.e., nr_acct).

When the user later frees the same object with kfree(),
refill_obj_stock() calls mod_objcg_mlstate(..., nr_bytes=6144).  This
ends up adding 6144 to the stats, but it should be applying -6144
(i.e., nr_acct) since the object is being freed.

Link: https://lkml.kernel.org/r/20260226115145.62903-1-hao.li@linux.dev
Fixes: 200577f69f29 ("memcg: objcg stock trylock without irq disabling")
Signed-off-by: Hao Li <hao.li@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memcontrol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memcontrol.c~memcg-fix-slab-accounting-in-refill_obj_stock-trylock-path
+++ a/mm/memcontrol.c
@@ -3086,7 +3086,7 @@ static void refill_obj_stock(struct obj_
 
 	if (!local_trylock(&obj_stock.lock)) {
 		if (pgdat)
-			mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
+			mod_objcg_mlstate(objcg, pgdat, idx, nr_acct);
 		nr_pages = nr_bytes >> PAGE_SHIFT;
 		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
 		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
_

Patches currently in -mm which might be from hao.li@linux.dev are



