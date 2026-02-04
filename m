Return-Path: <stable+bounces-214345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PgpK7ufg2kLqQMAu9opvQ
	(envelope-from <stable+bounces-214345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:36:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E3EC1C9
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C51C30055F5
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 19:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5B642316F;
	Wed,  4 Feb 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R34k9rUv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361832E137
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233782; cv=none; b=kP3hl1QiIq7qv51cvpjv790R2FhWrFqCFG9hNj3Bke7ZiisW4VrlyU96OKgfKVvXCdI2ZUAnsrlpNkbYn4xUDL3ghtvXiZVqvF0BhsGg6Ae4o00TIOG215gYyJmoWTE/mJAer4iPCSjxBIWqTdNMIe9dQWzo3f0+pyCefp2LhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233782; c=relaxed/simple;
	bh=QU3jrWsGIuZ9o2iKsCUnTMZ1BLOu3kxDvnNgU0Q6PbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/1AVUmrN9DC5gZyRb2XijO1VoBxbQCkVc34fVUJgFL4XYexJ95WbWTKTALMY9IkDu+8Xt48jO7+2mGuuvuzew7NfziH2J5MUrfOtmbL9gBQCCMhG9W9iDhHtPMhv8iRIc7ZGZLImJhJljJ455NhnEjwGbkT/6F2pYi8B3UJAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R34k9rUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92C9C4CEF7;
	Wed,  4 Feb 2026 19:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770233782;
	bh=QU3jrWsGIuZ9o2iKsCUnTMZ1BLOu3kxDvnNgU0Q6PbY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R34k9rUvrSuNHWvpokBkg5c1iGffIx40UJz0bBuQO2uqidy8D5Hh3vxwD5PzHVfsj
	 nW28jOkm5TfKDV8kT/dm/8hvYVaYLD1NzPsq0XGiDQxGKrd7PSLYlBrWPSSFKOyY+C
	 pZ5bJ0VmHcqmagN/VlHHdmWW35iw8X7sYJ1lWiPet4wje/wnx6Pt53yjKx/KhxdMTZ
	 ZR0y+BDzRVipQ8sPc/y/ess5IJ2zydaSQzhYI1Jh9xlKATMpYq8fneH2wj75r8ZEwv
	 VfH0BZRyG/Xim/MxAfcZ7LuwlFJiRxfO6edj5Yp5bGsbRLMDoVHNZ0TVSCXHSGwtUa
	 q3uQPohPCSEFA==
Message-ID: <d3f4456d-f2e1-4d8f-aa92-77ccd1606d59@kernel.org>
Date: Wed, 4 Feb 2026 20:36:16 +0100
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
 lorenzo.stoakes@oracle.com, riel@surriel.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, harry.yoo@oracle.com, jannh@google.com, ziy@nvidia.com,
 gavinguo@igalia.com, baolin.wang@linux.alibaba.com
Cc: linux-mm@kvack.org, Lance Yang <lance.yang@linux.dev>,
 stable@vger.kernel.org
References: <20260204004219.6524-1-richard.weiyang@gmail.com>
From: "David Hildenbrand (arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260204004219.6524-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214345-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,oracle.com,surriel.com,suse.cz,google.com,nvidia.com,igalia.com,linux.alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,nvidia.com:email]
X-Rspamd-Queue-Id: AC1E3EC1C9
X-Rspamd-Action: no action

Sorry for the late reply. I saw that I was CCed in v1 but I am only now 
catching up with mails ... slowly but steadily.

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

Ah, that explains magic number 513.

> 
> This patch fixes this by restart page_vma_mapped_walk() after
> split_huge_pmd_locked(). Because split_huge_pmd_locked() may fall back to
> (freeze = false) if folio_try_share_anon_rmap_pmd() fails and the PMD is
> just split instead of split to migration entry. 

Right, but folio_try_share_anon_rmap_pmd() should never fail on the 
folios that have already been shared? (above you write that it is shared 
with 512 children)

The only case where  folio_try_share_anon_rmap_pmd() could fail would be 
if the folio would not be shared, and there would only be a single PMD 
then, so there is nothing you can do -> abort.

Returning "false" from try_to_migrate_one() is the real issue, as it 
makes rmap_walk_anon() to just stop -> abort the walk.


So I suspect v1 was actually sufficient, or what am I missing where the 
restart would actually be required?


(maybe we should get rid of the usage of booleans here at some point, an 
enum like abort/continue would have been much clearer)

> Restart
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

The change looks more consistent to what we have in try_to_unmap().

But the explanation above is not quite right I think. And consequently 
the comment above as well.

PAE being set implies "single PMD" -> unshared.

-- 
Cheers,

David

