Return-Path: <stable+bounces-233140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cTHQLQJBz2mduQYAu9opvQ
	(envelope-from <stable+bounces-233140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 06:24:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFDE390E06
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 06:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AFC530175FC
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D7E347BB5;
	Fri,  3 Apr 2026 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NHnh5hQY"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FC2D3ED2
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 04:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190272; cv=none; b=SRD+Ry0Eq+CqrRTpvTqYBJfb8D/JcWUgV2kvC254upYenTc93aVY7qDOfF3nvot0izYPnTek1Oji7lpwNtZZ7O6i3jW6rH8Gj5nFYunNyAAGdN3Vd2NFIBCKmsWVIBNVJFdxN7uBTwM6hDPugibdwgMokawHlDtgvvPz220+mYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190272; c=relaxed/simple;
	bh=Y/GMDowuL3EDOD8dwzxYyKhUt+4KSDITy7baqB8lsBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBLJdCzgyfuiMQ3b2o9VKi9siOqhlMpgh7FegsxclNTeTlv+RJlt5FRi6BPKgVDhjmWYXUQr7hnZHFPPoma8ch4IVW+X5lOGVSxldZJKutfFiFWAVLYaBWnk4pmCQ9iXClC10qPmRzt0PCwZOOnLqYDn88M3tzKF+qZ/0NfERN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NHnh5hQY; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4bb6d46b-afc8-4d35-952e-8301df5026ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775190258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cErbKdi32QMH2dzlzoL5zUK31mzqGlUsJK8tpfLDBsY=;
	b=NHnh5hQYagWyfnu4knCBFIoHSA96++GT6HlgM1Q+86YOBBRPB6jqSGhB95MtgzUu+S5E57
	HJW4NldnRpgAWyHkf16HAfxbMYbu3uSBws19t8jIhLOP4Bwy0NUIPUB2PMl9SYeFYL4dgz
	PrlXplwDn3JxTrfML6rm4xQxqk6T1GY=
Date: Fri, 3 Apr 2026 12:24:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-unstable 1/1] mm: fix deferred split queue races during
 migration
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 david@kernel.org
Cc: ljs@kernel.org, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, richard.weiyang@gmail.com,
 usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kartikey406@gmail.com,
 syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260401131032.13011-1-lance.yang@linux.dev>
 <C4A8301D-C76B-430B-A6A6-8B642B80FE2E@nvidia.com>
 <FB71A764-0F10-4E5A-B4A0-BA4C7F138408@nvidia.com>
 <20260401161958.38ab50f44e7629e6475d3eca@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260401161958.38ab50f44e7629e6475d3eca@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233140-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,oracle.com,redhat.com,arm.com,intel.com,gmail.com,sk.com,gourry.net,nvidia.com,linux.dev,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,a7067a757858ac8eb085];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BFDE390E06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/2 07:19, Andrew Morton wrote:
> On Wed, 01 Apr 2026 18:55:48 -0400 Zi Yan <ziy@nvidia.com> wrote:
> 
>> Can you apply the fixup below to move the comment? Lance told me he
>> would be away for a while, so he could not send a fixup to move
>> the comment.
> 
> Thanks.  I folded that into Lance's base patch so here's the whole
> thing:
> 

Thank you all!
Lance

> 
> From: Lance Yang <lance.yang@linux.dev>
> Subject: mm: fix deferred split queue races during migration
> Date: Wed, 1 Apr 2026 21:10:32 +0800
> 
> migrate_folio_move() records the deferred split queue state from src and
> replays it on dst.  Replaying it after remove_migration_ptes(src, dst, 0)
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
> [ziy@nvidia.com: move the comment]
>    Link: https://lkml.kernel.org/r/FB71A764-0F10-4E5A-B4A0-BA4C7F138408@nvidia.com
> Link: https://syzkaller.appspot.com/bug?extid=a7067a757858ac8eb085
> Link: https://lkml.kernel.org/r/20260401131032.13011-1-lance.yang@linux.dev
> Fixes: 8a8ca142a488 ("mm: migrate: requeue destination folio on deferred split queue")
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reported-by: syzbot+a7067a757858ac8eb085@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/69ccb65b.050a0220.183828.003a.GAE@google.com/
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Deepanshu Kartikey <kartikey406@gmail.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Usama Arif <usama.arif@linux.dev>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   mm/huge_memory.c |   15 ++++++++++-----
>   mm/migrate.c     |   18 +++++++++---------
>   2 files changed, 19 insertions(+), 14 deletions(-)
> 
> --- a/mm/huge_memory.c~mm-fix-deferred-split-queue-races-during-migration
> +++ a/mm/huge_memory.c
> @@ -4542,7 +4542,7 @@ retry:
>   				goto next;
>   		}
>   		if (!folio_trylock(folio))
> -			goto next;
> +			goto requeue;
>   		if (!split_folio(folio)) {
>   			did_split = true;
>   			if (underused)
> @@ -4551,13 +4551,18 @@ retry:
>   		}
>   		folio_unlock(folio);
>   next:
> +		/*
> +		 * If thp_underused() returns false, or if split_folio()
> +		 * succeeds, or if split_folio() fails in the case it was
> +		 * underused, then consider it used and don't add it back to
> +		 * split_queue.
> +		 */
>   		if (did_split || !folio_test_partially_mapped(folio))
>   			continue;
> +requeue:
>   		/*
> -		 * Only add back to the queue if folio is partially mapped.
> -		 * If thp_underused returns false, or if split_folio fails
> -		 * in the case it was underused, then consider it used and
> -		 * don't add it back to split_queue.
> +		 * Add back partially mapped folios, or underused folios that
> +		 * we could not lock this round.
>   		 */
>   		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
>   		if (list_empty(&folio->_deferred_list)) {
> --- a/mm/migrate.c~mm-fix-deferred-split-queue-races-during-migration
> +++ a/mm/migrate.c
> @@ -1384,6 +1384,15 @@ static int migrate_folio_move(free_folio
>   		goto out;
>   
>   	/*
> +	 * Requeue the destination folio on the deferred split queue if
> +	 * the source was on the queue.  The source is unqueued in
> +	 * __folio_migrate_mapping(), so we recorded the state from
> +	 * before move_to_new_folio().
> +	 */
> +	if (src_deferred_split)
> +		deferred_split_folio(dst, src_partially_mapped);
> +
> +	/*
>   	 * When successful, push dst to LRU immediately: so that if it
>   	 * turns out to be an mlocked page, remove_migration_ptes() will
>   	 * automatically build up the correct dst->mlock_count for it.
> @@ -1399,15 +1408,6 @@ static int migrate_folio_move(free_folio
>   	if (old_page_state & PAGE_WAS_MAPPED)
>   		remove_migration_ptes(src, dst, 0);
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
>   out_unlock_both:
>   	folio_unlock(dst);
>   	folio_set_owner_migrate_reason(dst, reason);
> _
> 


