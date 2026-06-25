Return-Path: <stable+bounces-268325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 73ohMpT7PGpvvQgAu9opvQ
	(envelope-from <stable+bounces-268325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:57:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA31E6C4719
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:57:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V2iWDiFU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268325-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268325-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BA7630091FB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574BF3C1418;
	Thu, 25 Jun 2026 09:57:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3139B4AF
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:57:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381453; cv=none; b=tJVj0mK9E6HAsBdNgHHuJJJagUj7yp/o7FmqQiakZwkh3UYJxCVGwXDtnq8zIds7qcuG7RvSHZkppNFP+AsECQMVymbd4YwfaaaYVKj/jywWbQ0SKlM5fsLx1vRpiFg4oWVc+NfsXFpXRM+iVcf5xcSaX8jo7HRNmg587nZyvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381453; c=relaxed/simple;
	bh=q2KabJX42bL8EImuTVvaaueU8PiA8BEkZ4p1E+Vp5to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRVVAORZ6BssI3lSGdpyBlirrc39KjF3zqFNUmKIswyeM7j+GbW1KKhbf+zftH9TeTGWuqK22aZbYmm35Iju+diyKZNQH6ZyX3HJIjpuzyzphAOWm/nRJQO29eDhRPJd5ivIATGx9qxh/5AZh0r2YGTRs1iWCQArCQ8OQgAoO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2iWDiFU; arc=none smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c07c67ad9f2so184946766b.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782381450; x=1782986250; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYTjzOSxFoYpxoE4t1ZZfdj5C3kUNVB/dQ5bdM12Xk0=;
        b=V2iWDiFUNUDz/zhe74HXOzSKTQNcuTQXJqHvwOQzJxkA16W10LStbumzI5qIs/ktQ+
         X/qcrem9GM7mx3CdUdgSCijtbYStt1y247faxm72t2ITUCxsAUWqPJ8F/IVZqj71nKJl
         KRDbO8NZHMZUUXZtyOmZGJZfr6gQW9xX47uzrznfV/RqU9Cce8H9KRnV0VSZN2KGT/4S
         e0tXhkV2XJQlWtwOmvNSg36CrysWhZZuzK0SEnINBX0CWH9IvLcQaixHeIw5BqHfHtlk
         2h340x8iObvAM23VHERjlPgbZsxgfelaiZipbLImmVLwJ1yYdt1BDSYAE2zwA1BwbJYN
         g7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782381450; x=1782986250;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYTjzOSxFoYpxoE4t1ZZfdj5C3kUNVB/dQ5bdM12Xk0=;
        b=mI1EW1Xqo0z9jGAGAI+Sdv+YUMPxIp0B4a9BBZzyZVgfWRpbkgx8v2VWR35WlNI82O
         XPjN3LnIGHOYstS2GVf5lxmHj7RnXIqRpeKF/ef8zCTB0yUb4AtN+2lyZ293pnFzDakg
         ufXhnX6KNComDqDCxyuvQ+se7aOXYaBrff7AIe1ZqSW8tx0XDCFSIyY3TUhhokazYrlD
         tkdmF7J/5jpjds+2CTGj/YmKNhWzfq+GM+LUqmA0V37w8y/sgj4XMGqP/M1zYrm8YqRV
         AIEQhV134wYWNfkbTP414Ga2j/u/32uZJRD0wEreWFs1d92vk3DS1SiupwWyCADV/NFj
         W5EA==
X-Forwarded-Encrypted: i=1; AHgh+RocbzvlVcVgx/OOBNN/Na+jKYMWR1Hg2++HlSAO7Itu5VNuL1gKOHkBe8ORKShwCqDxlu8yeYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbeTg5oH+GCSn8qVoBWxNbL9Xkz5vFsw/6jQlA/ZyZ8qeJyKi
	8EMRnXzQNnCMW9R68Py2TJMVXLa2k91N3ZQDWQ2UQrdkWhsklopVAKmV
X-Gm-Gg: AfdE7cmwrat+Cina6L2CsBOdtAGK6p+ClLwQxxrB05dUu7t3PnD6snAUNpB3pnI/qK/
	jDlPkXCf8ise7lp1Kz5n8nPUz9It2WmtWTlZt8Ny84FLLbukvjObMiMRuQaRb4gBu7NheGVvGGu
	ucDdTy8+I/jB5yU5EXgXU4lwOC3v/tl8B/S37IzBpJp4h0t7c4R3DxV0VfQe0voxnpAtmFLJ5KL
	7CffOXvu9cTwOIjzqr8tCwmdNvlaRw6yZrU7g87tIpR9SNeXiIcZs0vCCSL5Nv70lJNxiGq+nnE
	putXfFYxiHeUSckMs9xa2WvfgnMuOgJ4vjOSS/NqNVAMdg4oZlPch3c9EOMrKq9BcmqtmlMMwaY
	LNnNwd4UVVdlrOC7XrtsqX7D1zZ5UCGItTnTi5EJzXkcWgy8gLEXrWVrRuUtjtrMypLVxRSEPw0
	oNziw/lNEnnQI=
X-Received: by 2002:a17:907:c8a4:b0:bef:3ab2:bed1 with SMTP id a640c23a62f3a-c10309ba204mr624280266b.16.1782381449884;
        Thu, 25 Jun 2026 02:57:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbed6c78sm144027766b.60.2026.06.25.02.57.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jun 2026 02:57:29 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:57:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: richard.weiyang@gmail.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <20260625095728.woikmkxb6gskth3b@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <20260624085756.6598-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624085756.6598-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:richard.weiyang@gmail.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:ziy@nvidia.com,m:sj@kernel.org,m:balbirs@nvidia.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268325-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,nvidia.com:email,master:mid];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA31E6C4719

On Wed, Jun 24, 2026 at 04:57:56PM +0800, Lance Yang wrote:
>
>On Wed, Jun 24, 2026 at 06:53:53AM +0000, Wei Yang wrote:
>>Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>>device-private entries") introduced the concept of device-private
>>PMD entries, but did not correctly update the rmap walk code to
>>account for them.
>>
>>As a result, when page_vma_mapped_walk() encounters device-private
>>PMD entries, it takes no action other than to acquire the PMD lock
>>and exit.
>>
>>However this is highly problematic for two reasons - firstly,
>>device private entries possess a PFN so check_pmd() needs to be
>>called to ensure an overlapping PFN range.
>>
>>Secondly, and more importantly, if PVMW_MIGRATION is set the
>>caller assumes the returned entry is a migration entry, resulting
>>in memory corruption when the caller tries to interpret the device
>>private entry as such.
>>
>>In addition, commit 146287290023 ("mm/huge_memory: implement
>>device-private THP splitting") allowed device private PMDs to be
>>split like THP mappings, but again did not update this code path.
>>
>>As a result, we might race a PMD split prior to acquiring the PMD
>>lock.
>>
>>This patch addresses all of these issues by invoking check_pmd(),
>>ensuring PMVW_MIGRATION is not set and checks whether a split raced
>>us we do for PMD THP and migration entries.
>>
>>Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>>Cc: <stable@vger.kernel.org>
>>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>Suggested-by: David Hildenbrand <david@kernel.org>
>
>Shouldn't we add
>
>Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
>
>as well?
>
>v4 mostly follows Lorenzo's comments, code bits included. Feels only fair.

Fair enough, added.

>
>>Cc: David Hildenbrand <david@kernel.org>
>>Cc: Balbir Singh <balbirs@nvidia.com>
>>Cc: SeongJae Park <sj@kernel.org>
>>Cc: Zi Yan <ziy@nvidia.com>
>>Cc: Lorenzo Stoakes <ljs@kernel.org>
>>Cc: Lance Yang <lance.yang@linux.dev>
>>
>>---
>>v4:
>>  * refine subject and commit log based on Lorenzo's suggestion
>>  * put pmd device-private entry handling in its own if branch,
>>    suggested by Lorenzo
>>
>>v3:
>>  * remove cleanup part, only fix the issue for device-private entry
>>  * refine user effect description based on Lorenzo's suggestion
>>
>>v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>>  * specify the possible error case of current code and user visible effect
>>  * besides fix, cleanup the pmd entry handling based on David's suggestion
>>
>>v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
>>---
>> mm/page_vma_mapped.c | 20 +++++++++++++++-----
>> 1 file changed, 15 insertions(+), 5 deletions(-)
>>
>>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>index 2ccbabfb2cc1..17dff8aab9f9 100644
>>--- a/mm/page_vma_mapped.c
>>+++ b/mm/page_vma_mapped.c
>>@@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>
>
>Hmm ... looks like there may still be a race here ...
>
>Current code picks the branch from the lockless PMD value:
>
>		pmde = pmdp_get_lockless(pvmw->pmd);
>
>		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>			pmde = *pvmw->pmd;
>			if (!pmd_present(pmde)) {
>				softleaf_t entry;
>
>				if (!thp_migration_supported() ||
>				    !(pvmw->flags & PVMW_MIGRATION))
>					return not_found(pvmw);
>				entry = softleaf_from_pmd(pmde);
>
>				if (!softleaf_is_migration(entry) ||
>				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>					return not_found(pvmw);
>				return true;
>			}
>		}
>
>But after taking PTL, the PMD may already be a different non-present PMD
>type:
>
>CPU0: pmde = pmdp_get_lockless();   // sees PMD migration entry
>
>CPU1: remove_migration_ptes(src, dst /* device-private */)
>        ... via rmap_walk(dst) ...
>        page_vma_mapped_walk(&pvmw /* src, PVMW_MIGRATION */)
>          returns with PTL held for the PMD migration entry
>        remove_migration_pmd(new = dst page)
>          installs a device-private PMD
>        next page_vma_mapped_walk()
>          drops PTL via not_found()
>
>CPU0: takes PTL
>      pmde = *pvmw->pmd;            // now device-private PMD
>
>So when PVMW_MIGRATION is not set, current code can return not_found()
>before we even decode the locked PMD as a device-private entry.
>
>Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>device-private entries") made the
>
>device-private PMD <-> PMD migration
>
>transition possible.
>
>set_pmd_migration_entry() can replace a device-private PMD with a PMD
>migration entry, and remove_migration_pmd() can restore a PMD migration
>entry back to a device-private PMD when the new folio is device-private.
>

Nice catch.

But I think this matters if migration fail and restore the pmd to src folio.
When we successfully migrate to new folio, check_pmd() could catch it and
return not_found(). IIUC.

One more question: assume A unmap a folio, and B migrate the same one. 

If B set_pmd_migration_entry() first, then A won't see this PMD from
page_vma_mapped_walk(), IIUC. Then B failed to migrate, and restore the folio
as this PMD migration entry is there. So A should check the status after
unmap, right? Would it see unstable status?

I am a little lost what is the correct way to do here.

>Maybe decode the locked softleaf entry first, before the migration-only
>checks? Something like this on top:
>
>---8<---
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index 17dff8aab9f9..97babd408dba 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -249,10 +249,18 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 			if (!pmd_present(pmde)) {
> 				softleaf_t entry;
>
>+				entry = softleaf_from_pmd(pmde);
>+				if (softleaf_is_device_private(entry)) {
>+					if (pvmw->flags & PVMW_MIGRATION)
>+						return not_found(pvmw);
>+					if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+						return not_found(pvmw);
>+					return true;
>+				}
>+

If we have to do this, I am afraid we can put all three cases handling
here...

Not necessary to put pmd_is_device_private_entry() handling in two places.

> 				if (!thp_migration_supported() ||
> 				    !(pvmw->flags & PVMW_MIGRATION))
> 					return not_found(pvmw);
>-				entry = softleaf_from_pmd(pmde);
>
> 				if (!softleaf_is_migration(entry) ||
> 				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>@@ -266,7 +274,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 					return not_found(pvmw);
> 				return true;
> 			}
>-			/* THP pmd was split under us: handle on pte level */
>+			/*
>+			 * THP pmd was split under us, or device-private PMD
>+			 * changed under us: handle on pte level.
>+			 */
> 			spin_unlock(pvmw->ptl);
> 			pvmw->ptl = NULL;
> 		} else if (pmd_is_device_private_entry(pmde)) {
>--
>
>Anyway, that stuff is getting kinda messy now. Feels like it really needs
>a cleanup on top before it bites us again :)

Agree.

I haven't imagined this would be more complicated than I thought :-)

>Cheers, Lance

-- 
Wei Yang
Help you, Help me

