Return-Path: <stable+bounces-271594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lKZ9GA0OR2rLSgAAu9opvQ
	(envelope-from <stable+bounces-271594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 03:19:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A42156FDB29
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 03:19:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=ud5qXez2;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271594-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271594-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B142302BBDD
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 01:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFA921256C;
	Fri,  3 Jul 2026 01:19:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26431D6BB;
	Fri,  3 Jul 2026 01:19:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783041543; cv=none; b=dpnIYrxDojrx5Ro6+cwJ5FtLMRM/qdcTh3AIewa2Gjpg4xA1xE9jiNNCQ8s1bvdS9yyUGOZgwDXlw5TaH9UNTQrWjrocS4fxFuJa+tzTyVEnEyvKJ64lssvoy6OI/+I2W74Vqkc4Urx1iUK08e6m5QAiiAThMO35Xfjz3kU2Ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783041543; c=relaxed/simple;
	bh=rVZrdj9O6NGeJt205M6CgPvXMoj13K8ppfUiUES4YvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2CjBviA3pmSfHgZv50Oi3VSmRNRSB5qQrAwPNxFxqEd2xKOp0W4ABgtgNWkH8pVCLvqtRl1dfusHGFFfvNW6DJ0m6zdi83ZXLrRWp7HP1iKKhwG4Kl/FsMJkwy0BdbglCYwJ8ROWbcWqNiVsvotQY+ZNW/45bN1bfHo0jHBNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ud5qXez2; arc=none smtp.client-ip=115.124.30.133
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783041532; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vlaYEmM5yHWyRftqrh5OqWf6FKrbWtq0+ONz8K/Op2E=;
	b=ud5qXez2mSTZPv6BZHW5vKeX9VZW2UXE+TW38m08kXt7ATiUaFsO2LSMx3cvXYg9cR8IcM4xl0NUoagIflJAbuZGCGv3vzDWuhPgf7AXd7dzLG3IXtRDIdGcFC9i54eG6Ue3p0q7aDEsC/YtguUN8W3Gh8QrEx/xWFvl6oRHjSs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X6GuTEm_1783041530;
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6GuTEm_1783041530 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 09:18:50 +0800
Message-ID: <918c72ae-dd3a-41e9-84ca-164f2e0e6d01@linux.alibaba.com>
Date: Fri, 3 Jul 2026 09:18:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: set PG_has_hwpoisoned only after new
 folio head is established
To: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, ziy@nvidia.com, liam@infradead.org,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, yang@os.amperecomputing.com,
 stable@vger.kernel.org
References: <20260701174235.3173401-1-riel@surriel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260701174235.3173401-1-riel@surriel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:riel@surriel.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:ziy@nvidia.com,m:liam@infradead.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:yang@os.amperecomputing.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271594-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,surriel.com:email,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A42156FDB29



On 7/2/26 1:42 AM, Rik van Riel wrote:
> __split_folio_to_order() copies the hwpoison state onto each new
> sub-folio while splitting a folio to a non-zero order.  It does so via
> 
> 	if (handle_hwpoison && page_range_has_hwpoisoned(new_head, new_nr_pages))
> 		folio_set_has_hwpoisoned(new_folio);
> 
> *before* clear_compound_head(new_head)/prep_compound_page(new_head, ...)
> turns @new_head from a tail page into a proper folio head.
> 
> PG_has_hwpoisoned is a FOLIO_SECOND_PAGE flag, so folio_set_has_hwpoisoned()
> resolves to folio_flags(folio, 1).  With the new compound_info-based
> page-flags layout, folio_flags() asserts the page is not a tail:
> 
> 	VM_BUG_ON_PGFLAGS(page->compound_info & 1, page);
> 	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags.f), page);
> 
> At the current call site @new_head still has the tail marker
> (compound_info bit 0 set, PG_head clear), so on CONFIG_DEBUG_VM kernels
> this hits:
> 
>    kernel BUG at include/linux/page-flags.h:354
>    folio_flags+0x82
>    folio_set_has_hwpoisoned
>    __split_folio_to_order
>    __split_unmapped_folio
>    __folio_split
>    truncate_inode_partial_folio  (shmem hole-punch / MADV_REMOVE)
> 
> Reproduced by syzkaller: hwpoison-inject a few subpages of a large shmem
> folio, then MADV_REMOVE (fallocate punch hole) on the same range, which
> splits the partial folio to a non-zero order.
> 
> memory_failure() tries to split the poisoned folio to order 0 first, but
> that split is best-effort; when it fails the folio is left large with
> PG_has_hwpoisoned set, the case fa5a06170036 added this hwpoison copying
> for.
> 
> Move the folio_set_has_hwpoisoned() call to after
> clear_compound_head()/prep_compound_page(), where @new_folio is a real
> order-new_order head folio (handle_hwpoison implies new_order != 0, so a
> second page always exists).  The flag still lands on the same struct page
> (page[1] of the new folio); only the ordering relative to compound-head
> setup changes, satisfying the FOLIO_SECOND_PAGE precondition.
> 
> Fixes: fa5a06170036 ("mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0 order")
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Cc: stable@vger.kernel.org
> ---

Good catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

