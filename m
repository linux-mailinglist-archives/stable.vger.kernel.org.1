Return-Path: <stable+bounces-213336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aECNLqWqgmkMXwMAu9opvQ
	(envelope-from <stable+bounces-213336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 03:10:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A029E0B4B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 03:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A6F9307180E
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 02:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA742586C8;
	Wed,  4 Feb 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DtTqsKhp"
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0322D4DC
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170951; cv=none; b=RIOOxIpEtpJMRxIo8q3DOg/YjrurzejpLt/4wQep6/4c3fydGxxYLd0KSMZK46C47tJRrPSrQXkVDmI0M3YgL1El4dN/urhVAhb3rd51KK94dfxzXN11y3bWpa0AUtIjz0JQtjkkkh97OxkVjSK/E3ER8rgYVoFJIucZQ9qjbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170951; c=relaxed/simple;
	bh=4F5mVsuwAz7ohrogfu8nghY2SdzHnQV4iAhKCZCrWv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXaZa2zeH8ngCUCIoZI8EoWnYfl+q+ibPvsmvYZ8hi0l7UJ+OaL46qIA/TLweHmGWAT0Rg7JI2Jby+m5Ryj2zXJP0cqpszrzitjRcFO4cAxnpeDdArgWl9w9lJcFq6rJrMohoGA9+b8Q5tgDIvb/RMSjVVOqZRuS3wy+V66WEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DtTqsKhp; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770170947; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jBt7Z/V5pgKMFlIjdcHweNeN5RveOulAhKPeOcD39KA=;
	b=DtTqsKhpAFjYxuUXsnKFHANdwoghiidUtvJm1zM+pb4wv6XMbgmBcv4uz5SkHr44iDFmjpQ23xcRHd57ueMhRP0uyiPXL/yiqRS1f0qfBEOP/6tvDbKDp4NMyktjR5/IJ32ejmJl2QRa3yQLOEKPG0xJSOxjLA7Is38sMKUOXGY=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WyUk0nd_1770170629 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Feb 2026 10:03:49 +0800
Message-ID: <ad71b58d-cdb9-4a88-9a80-d0c4339e54f1@linux.alibaba.com>
Date: Wed, 4 Feb 2026 10:03:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 david@kernel.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, ziy@nvidia.com, gavinguo@igalia.com
Cc: linux-mm@kvack.org, Lance Yang <lance.yang@linux.dev>,
 stable@vger.kernel.org
References: <20260204004219.6524-1-richard.weiyang@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260204004219.6524-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213336-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kernel.org,oracle.com,surriel.com,suse.cz,google.com,nvidia.com,igalia.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,igalia.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 1A029E0B4B
X-Rspamd-Action: no action



On 2/4/26 8:42 AM, Wei Yang wrote:
> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
> split_huge_pmd_locked()") return false unconditionally after
> split_huge_pmd_locked() which may fail early during try_to_migrate() for
> shared thp. This will lead to unexpected folio split failure.
> 
> One way to reproduce:
> 
>      Create an anonymous thp range and fork 512 children, so we have a
>      thp shared mapped in 513 processes. Then trigger folio split with
>      /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
>      order 0.
> 
> Without the above commit, we can successfully split to order 0.
> With the above commit, the folio is still a large folio.
> 
> The reason is the above commit return false after split pmd
> unconditionally in the first process and break try_to_migrate().
> 
> The tricky thing in above reproduce method is current debugfs interface
> leverage function split_huge_pages_pid(), which will iterate the whole
> pmd range and do folio split on each base page address. This means it
> will try 512 times, and each time split one pmd from pmd mapped to pte
> mapped thp. If there are less than 512 shared mapped process,
> the folio is still split successfully at last. But in real world, we
> usually try it for once.
> 
> This patch fixes this by restart page_vma_mapped_walk() after
> split_huge_pmd_locked(). Because split_huge_pmd_locked() may fall back to
> (freeze = false) if folio_try_share_anon_rmap_pmd() fails and the PMD is
> just split instead of split to migration entry. Restart
> page_vma_mapped_walk() and let try_to_migrate_one() try on each PTE
> again and fail try_to_migrate() early if it fails.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
> Cc: Gavin Guo <gavinguo@igalia.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: <stable@vger.kernel.org>
> 
> ---
> v2:
>    * restart page_vma_mapped_walk() after split_huge_pmd_locked()
> ---

The fix looks reasonable to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/rmap.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 618df3385c8b..5b853ec8901d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2446,11 +2446,16 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>   			__maybe_unused pmd_t pmdval;
>   
>   			if (flags & TTU_SPLIT_HUGE_PMD) {
> +				/*
> +				 * After split_huge_pmd_locked(), restart the
> +				 * walk to detect PageAnonExclusive handling
> +				 * failure in __split_huge_pmd_locked().
> +				 */
>   				split_huge_pmd_locked(vma, pvmw.address,
>   						      pvmw.pmd, true);
> -				ret = false;
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				flags &= ~TTU_SPLIT_HUGE_PMD;
> +				page_vma_mapped_walk_restart(&pvmw);
> +				continue;
>   			}
>   #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>   			pmdval = pmdp_get(pvmw.pmd);


