Return-Path: <stable+bounces-232820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDOGBaJMzWl6bgYAu9opvQ
	(envelope-from <stable+bounces-232820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:49:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5910837E278
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6E931921FF
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096C426D08;
	Wed,  1 Apr 2026 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AphRW5s8"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519EE4657DC
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060961; cv=none; b=nk1N8VtNN4tWH0jfi+smc4iVjKVvCGvbMlqN2X/trJGe532Zfdr9k0HPbrVD1583YS829/40KQIOqCF47LIUzQDvKhYk2Z0A26p17L6gyBgtC7ig0c/czWXFSfvvfGa+J85bOrqXR5AUvo4wHRygsZYKkgTxZYn3b6NJiVsBcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060961; c=relaxed/simple;
	bh=bBKM0ztGKZiazPOuWr8a0zlMOiziUMv4UdE/jqDvu+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVuJK0RtdSbpbGtF0PuZwgZlgFI4425XoullBWllo/vQi0fVCJuwZs9lALeCk0f01HTKxb2zBohrebbV7v7s0BToTY89VNtEaqVL3oSr5yjf4BaqvhTVCsftgGwyaaxqSMJ0S2SnNpcRZ0v7zHSmN2OI9lduQhu4BRpAGt8lgKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AphRW5s8; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775060947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/F3w2zUvV0WycgwDhHoSaMjFosjjuSB+DlsqHi2/eOc=;
	b=AphRW5s823Zt1SPOwvVYdbtW6LttToaWtO2AN2frz4rLWfPyyHug5O+hnPkvXhOD8CPzo6
	8lNWuXBjQ72MNyRKBZjfDs4ntgLVMHBIDo21zNiAynwjm9jgi8aCnjafdsKl1XQ7iCxgjw
	YY7AB2ceRqb25ejRGdxqMzm3SCJfvy8=
From: Usama Arif <usama.arif@linux.dev>
To: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	richard.weiyang@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kartikey406@gmail.com,
	syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/1] mm: fix deferred split queue races during migration
Date: Wed,  1 Apr 2026 09:28:53 -0700
Message-ID: <20260401162855.146945-1-usama.arif@linux.dev>
In-Reply-To: <20260401131032.13011-1-lance.yang@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,oracle.com,redhat.com,arm.com,intel.com,gmail.com,sk.com,gourry.net,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-232820-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,a7067a757858ac8eb085];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 5910837E278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  1 Apr 2026 21:10:32 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> From: Lance Yang <lance.yang@linux.dev>
> 
> migrate_folio_move() records the deferred split queue state from src and
> replays it on dst. Replaying it after remove_migration_ptes(src, dst, 0)
> makes dst visible before it is requeued, so a concurrent rmap-removal path
> can mark dst partially mapped and trip the WARN in deferred_split_folio().
> 
> Move the requeue before remove_migration_ptes() so dst is back on the
> deferred split queue before it becomes visible again.
> 
> Because migration still holds dst locked at that point, teach
> deferred_split_scan() to requeue a folio when folio_trylock() fails.
> Otherwise a fully mapped underused folio can be dequeued by the shrinker
> and silently lost from split_queue.
> 
> Link: https://syzkaller.appspot.com/bug?extid=a7067a757858ac8eb085
> Fixes: 8a8ca142a488 ("mm: migrate: requeue destination folio on deferred split queue")
> Reported-by: syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/69ccb65b.050a0220.183828.003a.GAE@google.com/
> Cc: <stable@vger.kernel.org>
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> 
> [ Backport note ]
> This patch is a follow-up fix for 8a8ca142a488 ("mm: migrate: requeue
> destination folio on deferred split queue"), which is currently only in
> mm-stable, and should be backported together with it.
> 
> Credit for this fix goes to David, thanks!
> 
>  mm/huge_memory.c | 12 +++++++-----
>  mm/migrate.c     | 18 +++++++++---------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 


Thanks for the fix! And sorry for introducing the bug in
migrate_folio_move() :)

So I am happy with the migrate_folio_move() change, it makes sense.

The goto next if folio is locked in deferred_split_scan() was actually
on purpose. The reasoning was that if the folio is locked, we consider
it as in use by someone and therefore we shouldnt split it. Eventhough
thp_underused() does a zero-filled check, the whole point of the shrinker
was to split THPs that are "not in use", and in my mind, locked folio
is a folio in use. So not sure about that change..


> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ff9a42abd1b6..ac6d823e351f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4558,7 +4558,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  				goto next;
>  		}
>  		if (!folio_trylock(folio))
> -			goto next;
> +			goto requeue;
>  		if (!split_folio(folio)) {
>  			did_split = true;
>  			if (underused)
> @@ -4569,11 +4569,13 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  next:
>  		if (did_split || !folio_test_partially_mapped(folio))
>  			continue;
> +requeue:
>  		/*
> -		 * Only add back to the queue if folio is partially mapped.
> -		 * If thp_underused returns false, or if split_folio fails
> -		 * in the case it was underused, then consider it used and
> -		 * don't add it back to split_queue.
> +		 * Add back partially mapped folios, or underused folios
> +		 * that we could not lock this round.  If thp_underused()
> +		 * returns false, or if split_folio() succeeds, or if
> +		 * split_folio() fails in the case it was underused, then
> +		 * consider it used and don't add it back to split_queue.
>  		 */
>  		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
>  		if (list_empty(&folio->_deferred_list)) {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 05cb408846f2..8a64291ab5b4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1385,6 +1385,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>  	if (rc)
>  		goto out;
>  
> +	/*
> +	 * Requeue the destination folio on the deferred split queue if
> +	 * the source was on the queue.  The source is unqueued in
> +	 * __folio_migrate_mapping(), so we recorded the state from
> +	 * before move_to_new_folio().
> +	 */
> +	if (src_deferred_split)
> +		deferred_split_folio(dst, src_partially_mapped);
> +
>  	/*
>  	 * When successful, push dst to LRU immediately: so that if it
>  	 * turns out to be an mlocked page, remove_migration_ptes() will
> @@ -1401,15 +1410,6 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>  	if (old_page_state & PAGE_WAS_MAPPED)
>  		remove_migration_ptes(src, dst, 0);
>  
> -	/*
> -	 * Requeue the destination folio on the deferred split queue if
> -	 * the source was on the queue.  The source is unqueued in
> -	 * __folio_migrate_mapping(), so we recorded the state from
> -	 * before move_to_new_folio().
> -	 */
> -	if (src_deferred_split)
> -		deferred_split_folio(dst, src_partially_mapped);
> -
>  out_unlock_both:
>  	folio_unlock(dst);
>  	folio_set_owner_migrate_reason(dst, reason);
> -- 
> 2.49.0
> 
> 

