Return-Path: <stable+bounces-245806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLa/BEhFA2ri2QEAu9opvQ
	(envelope-from <stable+bounces-245806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:20:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93052385D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F36AE3092398
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CDB3B5F62;
	Tue, 12 May 2026 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brPjBarW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C943ADBAC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596546; cv=none; b=WXBZVmf96owVhBVRNujcYVHrfpDQoGVfW9N4vKQrFtgXIrM7WfGJ0hpvhIv7NnCpSl4x/5rzOdFO6ouMLHsvPkWLX+J0ww3CYf5d6RBu4oUOUKoy6Jzwfn6DieTnihYW1jlOCV1b6dRUS75jHc2sVwdQxuKX1Nukx3XIlX6mtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596546; c=relaxed/simple;
	bh=upePEqXE1zP/s22XRDwITn5fUrpC095gaJURkMGDRcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsBxWV2pVotxQJQ9jrnwxDMOjcguiFZX71o/zMCo96AYkosI/HVoHaX9LujiCTZs/1iPp8SgDnhLlR1E3UH7lPZ4nT1jjHY2mtyNGhNh3CF0jLx5ZVeMHEFmtI3Zzbv1yEZWc9SZQeup3iMrg1hYXA+OKohlZ2l29lcNhrECijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brPjBarW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so50986695e9.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596543; x=1779201343; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZWzQImWOyWQ14r2Z/b/dDDI7psqgO5EhZ1ndo1M8aw=;
        b=brPjBarWKA5tCkylgzu9h5GUak2m8knjPL5gtF/yHZ6irWmkBPFG9hlpq9O+JuVnAM
         O6UURZs2yerPOSlHDNRx2jmR8ddGF2jwouD1F85CkIhT5I0qvRMxaRKdLJZCaYEz5Lto
         NI6u0y2/Fmjgl8yCOgUwV5w/dg6huTw1X53eMISNnXkTXgLh4+BadcrzJNGA2n+DyKlV
         n3ZWhkyoZ8mUuyDCAuqfYoW9rK9tKlVFaWclVRF4T5k5n5Q+hK89lFjJLx+ViZBhsMDz
         wi4NRAXxyRXUQFLdqDcPFrFjk9o5eEbM+HevjMh4lnuVhYDjm5n72Qjqxq6af1u2qsDH
         eURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596543; x=1779201343;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZWzQImWOyWQ14r2Z/b/dDDI7psqgO5EhZ1ndo1M8aw=;
        b=mYE+An7rmLqsgUYzS6pvARl2jswUq7p7TG3lWenQjkM2s1HfijE46RFdtqxU7IZNyW
         11ynQ5nk0TxLQrs+KEd/N1NUvAj24o18zWlGclAevYehtznkoxRewgXxKM3tHkVb62ZK
         ZJ6leDv4TgzpDj4g6er140j9NqWfyXL9UW/o5s/lXiFmGtP56jgU/f4hpB2vZXSz/OSA
         9FfYGGiMnAJGUXZOByb3KEhyIDooweNIJxeCkAx0w/hvMyWhX48Pk9DzDVK0nlphOtCN
         1p60M2r7fvvi8m5IDtzw01NKFYsIDPfS7Mehub+rVKx9xsghrszsGupJNQPabBv9lHUZ
         egbw==
X-Forwarded-Encrypted: i=1; AFNElJ/c47PsvXDCcgfINFfC275agy8z6JGoz8oNFOPNPjg/ia2TVHZI2p9dYKyCopyBvf6ZyGJshIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVngI3DXTqLDTNxX7hAIUnEycKrodpI+EHsl299n1Q7QNYXfM
	j02oK8KIsHw6kzNbwp7id0/VpG2H/TXclOg9Z8090kGYlZ8EePdeOSd5
X-Gm-Gg: Acq92OFy3P65IWNWX3qDj79/a+2cnQox3MsEuXSN24r/DIrpLCorE3OsA2FXhSadd6g
	ueGgdnQ7zgg56i5tgIlEVuadKaG5iUzPuCNPhLPfJNXgP4+DJVXB/xvo715YyHUbJSdvmji2xIP
	vlzC5+dHIn7f7LMkb2xVoKgna7w5FsW+tL6DTBtq0vPwTLfx8QizFQyiRYyX26pEEhooMMex1Iv
	sr9vEyE1wGgikUgxWGz+AGO+xOZlGQiAuLp6b4vevYpTZOUJY5sqdlNbZhtNqFgome4FQS9ei08
	XE4+ivW6fFJyGJkENKkWZT0kKampgZ6lMpf7ng6UuizeCv5jOloEAICrN7Y6fLTpdMs52h52x42
	Citbu7UovXspgd+ybFwZiIhLaVVQAAl5e4Q8xSMNA0QvOS/eNkym+GRyi5ba93duD0uD7bHObDf
	oTTSZykgwYGUzHaLLCyeZPnA==
X-Received: by 2002:a05:600c:a11a:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e8fe4dc0bmr38431565e9.2.1778596543205;
        Tue, 12 May 2026 07:35:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8cd49fesm3135415e9.0.2026.05.12.07.35.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2026 07:35:42 -0700 (PDT)
Date: Tue, 12 May 2026 14:35:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
	jannh@google.com, sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260512143542.izpp3gu4iqxttw3f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
 <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Queue-Id: 2F93052385D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-245806-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,linux-foundation.org,kernel.org,surriel.com,infradead.org,google.com,kvack.org,oracle.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 02:43:54PM +0200, David Hildenbrand (Arm) wrote:
>On 5/9/26 00:48, Balbir Singh wrote:
>> On 5/8/26 11:37, Wei Yang wrote:
>>> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>>> before return the pmd entry:
>>>
>>>   * re-validate pmd entry
>>>   * check PVMW_MIGRATION
>>>   * check_pmd()
>>>   * handle on pte level if split under us
>>>
>>> But for device-private pmd, we just return after pmd_lock(). This may
>>> lead to inproper situation.
>>>
>> 
>> Could you elaborate a more on the improper situation?
>> 
>>> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
>>> support device-private entries") by following the same pattern as
>>> pmd_trans_huge() and pmd_is_migration_entry().
>>>
>>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Cc: David Hildenbrand <david@kernel.org>
>>> Cc: Balbir Singh <balbirs@nvidia.com>
>>> Cc: SeongJae Park <sj@kernel.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>  mm/page_vma_mapped.c | 34 +++++++++++++++++++++++-----------
>>>  1 file changed, 23 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index a4d52fdb3056..5d337ea43019 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -269,21 +269,33 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>  			spin_unlock(pvmw->ptl);
>>>  			pvmw->ptl = NULL;
>>>  		} else if (!pmd_present(pmde)) {
>>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>>> +			softleaf_t entry = softleaf_from_pmd(pmde);
>>>  
>>>  			if (softleaf_is_device_private(entry)) {
>>>  				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> -				return true;
>>> -			}
>>> -
>>> -			if ((pvmw->flags & PVMW_SYNC) &&
>>> -			    thp_vma_suitable_order(vma, pvmw->address,
>>> -						   PMD_ORDER) &&
>>> -			    (pvmw->nr_pages >= HPAGE_PMD_NR))
>>> -				sync_with_folio_pmd_zap(mm, pvmw->pmd);
>>> +				entry = softleaf_from_pmd(*pvmw->pmd);
>>> +
>>> +				if (softleaf_is_device_private(entry)) {
>> 
>> Do we need to check softleaf_is_device_private() twice, can't we hold the pmd
>> lock and check once?
>
>I think what we try to do here is, is to only grab the lock if we verified that there is something of interest in there.
>
>I wonder if we should rewrite that whole thing to just do a pmd_same() check after grabbing the lock.
>
>Something a lot cleaner like:
>
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index a4d52fdb3056..de6a255cc847 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -242,40 +242,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                 */
>                pmde = pmdp_get_lockless(pvmw->pmd);
> 
>-               if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>-                       pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>-                       pmde = *pvmw->pmd;
>-                       if (!pmd_present(pmde)) {
>-                               softleaf_t entry;
>-
>-                               if (!thp_migration_supported() ||
>-                                   !(pvmw->flags & PVMW_MIGRATION))
>-                                       return not_found(pvmw);
>-                               entry = softleaf_from_pmd(pmde);
>-
>-                               if (!softleaf_is_migration(entry) ||
>-                                   !check_pmd(softleaf_to_pfn(entry), pvmw))
>-                                       return not_found(pvmw);
>-                               return true;
>-                       }
>-                       if (likely(pmd_trans_huge(pmde))) {
>-                               if (pvmw->flags & PVMW_MIGRATION)
>-                                       return not_found(pvmw);
>-                               if (!check_pmd(pmd_pfn(pmde), pvmw))
>-                                       return not_found(pvmw);
>-                               return true;
>-                       }
>-                       /* THP pmd was split under us: handle on pte level */
>-                       spin_unlock(pvmw->ptl);
>-                       pvmw->ptl = NULL;
>-               } else if (!pmd_present(pmde)) {
>-                       const softleaf_t entry = softleaf_from_pmd(pmde);
>-
>-                       if (softleaf_is_device_private(entry)) {
>-                               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>-                               return true;
>-                       }
>+               if (pmd_present(pmde)) {
>+                       if (!pmd_leaf(pmde))
>+                               goto pte_table;
>+                       if (pvmw->flags & PVMW_MIGRATION)
>+                               return not_found(pvmw);
>+                       if (!check_pmd(pmd_pfn(pmde), pvmw))
>+                               return not_found(pvmw);
>+               } else if (pmd_is_migration_entry(pmde)) {
>+                       softleaf_t entry = softleaf_from_pmd(pmde);
>+
>+                       if (!(pvmw->flags & PVMW_MIGRATION))
>+                               return not_found(pvmw);
>+                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+                               return not_found(pvmw);
>+               } else if (pmd_is_device_private_entry(pmde)) {
>+                       softleaf_t entry = softleaf_from_pmd(pmde);
> 
>+                       if (pvmw->flags & PVMW_MIGRATION)
>+                               return not_found(pvmw);
>+                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+                               return not_found(pvmw);
>+               } else {
>                        if ((pvmw->flags & PVMW_SYNC) &&
>                            thp_vma_suitable_order(vma, pvmw->address,
>                                                   PMD_ORDER) &&
>@@ -285,6 +273,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                        step_forward(pvmw, PMD_SIZE);
>                        continue;
>                }
>+
>+               /* Double-check under PTL that the PMD didn't change. */
>+               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>+               if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
>+                       return true;
>+               spin_unlock(pvmw->ptl);
>+               pvmw->ptl = NULL;
>+               goto restart;
>+pte_table:
>                if (!map_pte(pvmw, &pmde, &ptl)) {
>                        if (!pvmw->pte)
>
>
>
>
>There is likely room to clean this up / compress it further.

I tried to compress above logic like this, hope it could look cleaner.

	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
		unsigned long pfn;
		bool is_migration = pmd_is_migration_entry(pmde);
		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);

		if (is_migration != for_migration)
			return not_found(pvmw);

		if (pmd_trans_huge(pmde))
			pfn = pmd_pfn(pmde);
		else
			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));

		if (!check_pmd(pfn, pvmw))
			return not_found(pvmw);
	} else if (!pmd_present(pmde)) {

>I'll note that this now also adds proper check_pmd() checks to pmd_is_device_private_entry().
>
>The not_found(pvmw) if check_pmd() fails is rather weird ... but likely this works because
>THPs can really only be mapped through one PMD, and we always will look at the right spot ...
>
>-- 
>Cheers,
>
>David

-- 
Wei Yang
Help you, Help me

