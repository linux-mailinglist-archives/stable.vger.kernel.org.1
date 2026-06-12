Return-Path: <stable+bounces-262845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Y0PGaJzK2p09wMAu9opvQ
	(envelope-from <stable+bounces-262845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:49:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B098B676532
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:49:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AIYeBAK9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262845-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262845-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1D731AD2A2
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 02:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53B42E7BD9;
	Fri, 12 Jun 2026 02:49:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77130FF27
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 02:48:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232543; cv=none; b=e6rPJDY+e10/jyYPUQSz9EO4n/Dk5zYFgbphmHabR8aNLAwqbBXO9WC/VKw2SaFQ3Bj/Ao3JmIDkWZYKpwx1L/idFKXZvEJqHuIL+Au79l2A+L54jaUE7F+7seFwAVdTanXgh/KbyH1wngMaXNlbyimZT1Fc2o16Em2zS3Fpa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232543; c=relaxed/simple;
	bh=VecvOYcTQO/W5JHpFGTv/YpZ/5Zi8gx8U+NSnHNsa2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQxiqVMq0pC8H5PivsqDMzsm+5W2Q516rAYt/gFqjY7ccVZhp3b8L5OvQ7ju6HwUgfiFba82CliQoSowoyMf2+8gePC+qdGgkqMigtYJHxOmGzXNlnKu+Hp0sdTnc99Wz5OgpmK9BbqA6qE8PVlOlVT4iTYfmJJWFDK/Dfemjew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIYeBAK9; arc=none smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6912f4acca4so872816a12.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 19:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781232524; x=1781837324; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW5LTHcSdOfeWakS3C16seYcAzTrZg2/iKaqqksQyEk=;
        b=AIYeBAK9E2NlxQ+gwEMo3kpJO5nCUtI+JWOoYE6Gtbtnz0EWauqJ/Rc87B+lCX1ED+
         OeXicMAG971Hd3I67Q91F9/uhlHUYBuh+e1J3l0IH6meKqFznURrdhjEQMyARLsFavyX
         x/HcfIaN1U+hO12IkYyVA3HcZjXe/GzkbmmWMzjCE/RMdlCIeIpSLC606ohdQVOzmOti
         vX0eJZr3std+4RLCIbp7qoZk2amSBDnLJsyuYY6aMa0v9RlKmyOM2enmzc7Vbl7UNrDp
         7URXI4dnWti1XEQKG7fe8D7W0e6oW/UF7QL8anzB2G8arvqwIa5buQiQsz/hC/iR5NgK
         5jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781232524; x=1781837324;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW5LTHcSdOfeWakS3C16seYcAzTrZg2/iKaqqksQyEk=;
        b=guPS90Z1aoyZ+ChtEslk8oBfr9tAX+HpXrzF0++W2HHNJOxZg5aWI0doZapz+4DIXl
         pIM+0NCMBWkRnZPue0qvrxb8DznYfYNUwKE8gWa+15LD63GLtAnn+0VCauqW1FHUpoxW
         QBxsSQXVbfVR+WG/UAJxXeCKQTa0vkjgepCrBtd1leDrXXT6Ojv7kib5vA553Gtg/epM
         0hrIhZXznhjZX5yLEZ5cj9kFAd8Liz6pgC3pA685IcsBkV0N0xPrxP4eXPoyJOJ2E170
         k7ZKTnoX2PW9ouO3f8QRFpTAaTx3jI4LbUt1ShOgUQIb79j1yKmTKkw/5k0BnyZxHpj+
         2Jlg==
X-Forwarded-Encrypted: i=1; AFNElJ+heElP+DsvIeT/CBtObex60pz/gcf+VZeT00HiRnLbBj1hsY4B1eRAx8cP6sLNtNyef3xwevw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pOilSp9ouzK3NFBv4Ho6PXZp5rLQIHLcfP/w0fab+Y5R9HJj
	4mxkP7q2p5zVPrwFxbem94HmW3iFV0Ke0LDF3M/oWivKa2x3aLLdkfRW
X-Gm-Gg: Acq92OGHhBFg6i+qlNivs4/bt1ujGClAQ3lp61tFAdapYUEkKBxupFH6goLXHvZ8kqB
	BL66x0VUd/8UjAaAMV3AG1SkbIthyuQCqMFiUBMCcNRPSqeQWCTwiIDBakYjMX4XAkUQaR4W8Zf
	0hQgPLD9/pt2MG63t69DWYQKKS+wrF97HGoMLryGlQoZOl4Ego0ZzY/Eoap0WQg7hp8LnxUJpMw
	9cEviZR5Zs+hIx6lSgtt/zi9eHg9sMjnRcO8i9jVJKd1XgoEc30sP1O5zLie8dkcDWTEKzcnrW6
	oQ4jJ0OT7QIaFYd+7xEpRcEaTkO3fjlN+1cZC/E3/IQ7TUOG3qqr+r4Xu/s+fFQIgB2Cw3Bu2dC
	S6g7Tc5ZQFb6dFZUn3p13pqB6q3EsLWV6C0AFNTLmEXwNSPpxIhTxdIPlIddNfKsZTideCw+RdJ
	re2LmUUmOHml4DAuVmSbD5ZQ==
X-Received: by 2002:a05:6402:51c8:b0:68a:5107:4f6f with SMTP id 4fb4d7f45d1cf-693788fd509mr309343a12.12.1781232523794;
        Thu, 11 Jun 2026 19:48:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937919a009sm108066a12.2.2026.06.11.19.48.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jun 2026 19:48:42 -0700 (PDT)
Date: Fri, 12 Jun 2026 02:48:40 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, Balbir Singh <balbirs@nvidia.com>,
	akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
	jannh@google.com, sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260612024840.qdw76serbgj67yrv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
 <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
 <20260512143542.izpp3gu4iqxttw3f@master>
 <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:richard.weiyang@gmail.com,m:balbirs@nvidia.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:sj@kernel.org,m:ziy@nvidia.com,m:linux-mm@kvack.org,m:lorenzo.stoakes@oracle.com,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262845-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[master:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,linux-foundation.org,kernel.org,surriel.com,infradead.org,google.com,kvack.org,oracle.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B098B676532

On Tue, May 12, 2026 at 08:55:47PM +0200, David Hildenbrand (Arm) wrote:
>On 5/12/26 16:35, Wei Yang wrote:
>> On Tue, May 12, 2026 at 02:43:54PM +0200, David Hildenbrand (Arm) wrote:
>>> On 5/9/26 00:48, Balbir Singh wrote:
>>>>
>>>> Could you elaborate a more on the improper situation?
>>>>
>>>>
>>>> Do we need to check softleaf_is_device_private() twice, can't we hold the pmd
>>>> lock and check once?
>>>
>>> I think what we try to do here is, is to only grab the lock if we verified that there is something of interest in there.
>>>
>>> I wonder if we should rewrite that whole thing to just do a pmd_same() check after grabbing the lock.
>>>
>>> Something a lot cleaner like:
>>>
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index a4d52fdb3056..de6a255cc847 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -242,40 +242,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>                 */
>>>                pmde = pmdp_get_lockless(pvmw->pmd);
>>>
>>> -               if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>> -                       pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> -                       pmde = *pvmw->pmd;
>>> -                       if (!pmd_present(pmde)) {
>>> -                               softleaf_t entry;
>>> -
>>> -                               if (!thp_migration_supported() ||
>>> -                                   !(pvmw->flags & PVMW_MIGRATION))
>>> -                                       return not_found(pvmw);
>>> -                               entry = softleaf_from_pmd(pmde);
>>> -
>>> -                               if (!softleaf_is_migration(entry) ||
>>> -                                   !check_pmd(softleaf_to_pfn(entry), pvmw))
>>> -                                       return not_found(pvmw);
>>> -                               return true;
>>> -                       }
>>> -                       if (likely(pmd_trans_huge(pmde))) {
>>> -                               if (pvmw->flags & PVMW_MIGRATION)
>>> -                                       return not_found(pvmw);
>>> -                               if (!check_pmd(pmd_pfn(pmde), pvmw))
>>> -                                       return not_found(pvmw);
>>> -                               return true;
>>> -                       }
>>> -                       /* THP pmd was split under us: handle on pte level */
>>> -                       spin_unlock(pvmw->ptl);
>>> -                       pvmw->ptl = NULL;
>>> -               } else if (!pmd_present(pmde)) {
>>> -                       const softleaf_t entry = softleaf_from_pmd(pmde);
>>> -
>>> -                       if (softleaf_is_device_private(entry)) {
>>> -                               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> -                               return true;
>>> -                       }
>>> +               if (pmd_present(pmde)) {
>>> +                       if (!pmd_leaf(pmde))
>>> +                               goto pte_table;
>>> +                       if (pvmw->flags & PVMW_MIGRATION)
>>> +                               return not_found(pvmw);
>>> +                       if (!check_pmd(pmd_pfn(pmde), pvmw))
>>> +                               return not_found(pvmw);
>>> +               } else if (pmd_is_migration_entry(pmde)) {
>>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>> +
>>> +                       if (!(pvmw->flags & PVMW_MIGRATION))
>>> +                               return not_found(pvmw);
>>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>> +                               return not_found(pvmw);
>>> +               } else if (pmd_is_device_private_entry(pmde)) {
>>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>>
>>> +                       if (pvmw->flags & PVMW_MIGRATION)
>>> +                               return not_found(pvmw);
>>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>> +                               return not_found(pvmw);
>>> +               } else {
>>>                        if ((pvmw->flags & PVMW_SYNC) &&
>>>                            thp_vma_suitable_order(vma, pvmw->address,
>>>                                                   PMD_ORDER) &&
>>> @@ -285,6 +273,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>                        step_forward(pvmw, PMD_SIZE);
>>>                        continue;
>>>                }
>>> +
>>> +               /* Double-check under PTL that the PMD didn't change. */
>>> +               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> +               if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
>>> +                       return true;
>>> +               spin_unlock(pvmw->ptl);
>>> +               pvmw->ptl = NULL;
>>> +               goto restart;
>>> +pte_table:
>>>                if (!map_pte(pvmw, &pmde, &ptl)) {
>>>                        if (!pvmw->pte)
>>>
>>>
>>>
>>>
>>> There is likely room to clean this up / compress it further.
>> 
>> I tried to compress above logic like this, hope it could look cleaner.
>> 
>> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
>> 		unsigned long pfn;
>> 		bool is_migration = pmd_is_migration_entry(pmde);
>> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
>> 
>> 		if (is_migration != for_migration)
>> 			return not_found(pvmw);
>> 
>> 		if (pmd_trans_huge(pmde))
>> 			pfn = pmd_pfn(pmde);
>> 		else
>> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
>> 
>> 		if (!check_pmd(pfn, pvmw))
>> 			return not_found(pvmw);
>> 	} else if (!pmd_present(pmde)) {
>
>It's more compact, but not necessarily cleaner. In particular, I detest
>pmd_trans_huge(), we should phase it out.
>
>if (pmd_present(pmde) && !pmd_leaf(pmde)) {
>	goto pte_table;
>} else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))
>
>...
>
>Might work as well. But once we add support for other softleaf types, we'll have
>to touch it again. So I'd rather just list what we actually expect.
>

Hi, David

I may not follow you. Just want to confirm whether you prefer this goes as a
fix first, or you prefer it goes as what you suggested here as a cleanup?

>-- 
>Cheers,
>
>David

-- 
Wei Yang
Help you, Help me

