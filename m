Return-Path: <stable+bounces-246703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHVcEXS0A2oR9QEAu9opvQ
	(envelope-from <stable+bounces-246703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:15:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA952B3BA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0356E306846B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2D3A5454;
	Tue, 12 May 2026 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIohSncA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E02385D76
	for <stable@vger.kernel.org>; Tue, 12 May 2026 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627688; cv=none; b=PH4lqq3Lqg68pCHHfXQGZ+wnmRfIMIgNC9z8qiiE8HgIdRGSvahlLPNWcN/Q2vS0BZlOOYjcrAHBHDN2EX4LTfnA+8iCdZxAMqoqcK/J6Nykn4IxygrsUZK1/JHuTFSaQhiub9/qV7JRQxIz3bw1cxpuPM7l0O3LOZdcFzamCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627688; c=relaxed/simple;
	bh=/ELHwLPuyFlLKnMqRZMDyYqGnl7kJXW+rh81Mrf8+nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM8Hax49EAftZKriem0/aJzehnRKo1Svlv8V8QhB8K6HrHG8oAT+wVFj3oMnTGrucm4wxSqvxBxzD1gNv6nxhy2vl6lW0Vpa073WwJrtwXExcJd6nZkZabQWtNhF5JUuO/dhzGyr5irO+AlEvD3oE73h0o/E6isAX5Q+cm3vp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIohSncA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so9309670a12.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778627685; x=1779232485; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw9fzchRFgfkvRIdlxPrTBX7TqGm6u/FMto+t8FqrcA=;
        b=TIohSncAxI21YdaGtHc0KBvp3Bqdt5FJm3Z8QZ+pd51+I5aGgFlMQ5hKQT6pX3wRJC
         CJVwUjkswvydKxhB8RPNxqEIx1Q4rddEuVNftJLYbTMAAZRKHsShiW7jxQPYYvkFAGRf
         iZqcxVVk+d3/6cSzNqR0NEOp5jv6eKHQ44UxU4mGCM0oXGOhbbwfNZoZOKCxnieZatc/
         9rkua9Kh5wxsb3IMfYZHjxNXfjcoxIVqZ3g3orWDCFeUbRNBnAVNpbiuSzD8aTgmUBP4
         aoUgf5CRGFFD40xU/V2TNY0bvTx/nIV79iYkn8rwaaHQlHECFtIqSalcuFfixOzFlET5
         fLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778627685; x=1779232485;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lw9fzchRFgfkvRIdlxPrTBX7TqGm6u/FMto+t8FqrcA=;
        b=Wl5gGbm4Pu9GYF9kvOdKL5X+murD9eh57XCz0Hft4ouXg5n8DIWiiKliB7ViN3yODh
         8JDCP5XgmaV5leCdRr3gMKQeyzyrdhJJF1BXYw1Yma4hSKYoiHvOmyW9cNYYctWO3dqj
         gIXMW2JPJzvccJHAR/M5Oc3ShzzGF7vxizEGeM8fyH6FsGRMSvzT3smiaGg4LeAz/n/n
         86EQ7sLevAPnYk4TK9mVRKQi0i3hiprhuQPznw3UNuv1aYWvOC8arLO8+mf01QkGj+uS
         ijhimzQ+EkeRiuzK1Q5faIxseoAOY19GzNxlgzB3BatMJdbtkTJiG7INSEl2szxnsHLA
         StPg==
X-Forwarded-Encrypted: i=1; AFNElJ+6SIXQ2UPJ/KfhZRA4uc6Hzl3Egft8p/I3wYih9i6sqEr+Dbg2Ag5FbVW4SaKniitYVK5keXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyshaONKTPMdm6M0d2MZpnmYVdVxk5kfD5JMS199vZUGvixQB09
	HKrE4Y7TC8MqKOHPhRS3OljK3X7rFP7KfN8SL4AY+ityl7VjxwT8njV+
X-Gm-Gg: Acq92OFUifVUevcTBp68SyRCRganibTb8W2KFPE3CMOUcggM5NI4ovfRG526bc6oB+m
	xs3v4Y4HcO2yw810RrXhSAeoSeXFsDVOmWjjCCAQLeUpNU8Qxi8yblRhdAkrrMw6eF7Dk/LnzSB
	mS+uu+OXQyD1lOxWbouE/B/NomdRrxAOAhsWohCZ7HxTKGCa5JJl9xwHtGop0FKk3B7dyMP/gV8
	pXIoYFMfKgMORN8FxB25EC5+hnw4TYNoOHmDyiseHdW9VtSjFmyhP9tAKz03GKA61bwfgfhCF+Z
	JPVppzmSRE6blvT89Dt6OeAu8+rG1NssnzfBP036/EL1U16GmNr2IM4s5HvtfgN+06bQkNkNeXP
	dzkEOvfYMuKMkWQ6qT2nlfevh8oPSwNwndWCLwcgXMlrT1/wrNEvOu9y+D4iaCS1WbvpfmRIlLs
	bA2iJge6UJoTCn1aRcb3pWVw==
X-Received: by 2002:aa7:cacc:0:b0:67b:e6fd:2ece with SMTP id 4fb4d7f45d1cf-6823178d136mr356803a12.10.1778627684946;
        Tue, 12 May 2026 16:14:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b6a648sm5557471a12.7.2026.05.12.16.14.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2026 16:14:43 -0700 (PDT)
Date: Tue, 12 May 2026 23:14:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260512231442.53qwj37fbykp2qus@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
 <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
 <20260512143542.izpp3gu4iqxttw3f@master>
 <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
 <9a56d762-ebe5-429e-9fc8-a9c9e5d0d434@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a56d762-ebe5-429e-9fc8-a9c9e5d0d434@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Queue-Id: CADA952B3BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-246703-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,surriel.com,infradead.org,google.com,nvidia.com,kvack.org,oracle.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 09:03:47AM +1000, Balbir Singh wrote:
>On 5/13/26 04:55, David Hildenbrand (Arm) wrote:
>> On 5/12/26 16:35, Wei Yang wrote:
>>> On Tue, May 12, 2026 at 02:43:54PM +0200, David Hildenbrand (Arm) wrote:
>>>> On 5/9/26 00:48, Balbir Singh wrote:
>>>>>
>>>>> Could you elaborate a more on the improper situation?
>>>>>
>>>>>
>>>>> Do we need to check softleaf_is_device_private() twice, can't we hold the pmd
>>>>> lock and check once?
>>>>
>>>> I think what we try to do here is, is to only grab the lock if we verified that there is something of interest in there.
>>>>
>>>> I wonder if we should rewrite that whole thing to just do a pmd_same() check after grabbing the lock.
>>>>
>>>> Something a lot cleaner like:
>>>>
>>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>> index a4d52fdb3056..de6a255cc847 100644
>>>> --- a/mm/page_vma_mapped.c
>>>> +++ b/mm/page_vma_mapped.c
>>>> @@ -242,40 +242,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>                 */
>>>>                pmde = pmdp_get_lockless(pvmw->pmd);
>>>>
>>>> -               if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>>> -                       pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>> -                       pmde = *pvmw->pmd;
>>>> -                       if (!pmd_present(pmde)) {
>>>> -                               softleaf_t entry;
>>>> -
>>>> -                               if (!thp_migration_supported() ||
>>>> -                                   !(pvmw->flags & PVMW_MIGRATION))
>>>> -                                       return not_found(pvmw);
>>>> -                               entry = softleaf_from_pmd(pmde);
>>>> -
>>>> -                               if (!softleaf_is_migration(entry) ||
>>>> -                                   !check_pmd(softleaf_to_pfn(entry), pvmw))
>>>> -                                       return not_found(pvmw);
>>>> -                               return true;
>>>> -                       }
>>>> -                       if (likely(pmd_trans_huge(pmde))) {
>>>> -                               if (pvmw->flags & PVMW_MIGRATION)
>>>> -                                       return not_found(pvmw);
>>>> -                               if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>> -                                       return not_found(pvmw);
>>>> -                               return true;
>>>> -                       }
>>>> -                       /* THP pmd was split under us: handle on pte level */
>>>> -                       spin_unlock(pvmw->ptl);
>>>> -                       pvmw->ptl = NULL;
>>>> -               } else if (!pmd_present(pmde)) {
>>>> -                       const softleaf_t entry = softleaf_from_pmd(pmde);
>>>> -
>>>> -                       if (softleaf_is_device_private(entry)) {
>>>> -                               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>> -                               return true;
>>>> -                       }
>>>> +               if (pmd_present(pmde)) {
>>>> +                       if (!pmd_leaf(pmde))
>>>> +                               goto pte_table;
>>>> +                       if (pvmw->flags & PVMW_MIGRATION)
>>>> +                               return not_found(pvmw);
>>>> +                       if (!check_pmd(pmd_pfn(pmde), pvmw))
>>>> +                               return not_found(pvmw);
>>>> +               } else if (pmd_is_migration_entry(pmde)) {
>>>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>>> +
>>>> +                       if (!(pvmw->flags & PVMW_MIGRATION))
>>>> +                               return not_found(pvmw);
>>>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>>> +                               return not_found(pvmw);
>>>> +               } else if (pmd_is_device_private_entry(pmde)) {
>>>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>>>
>>>> +                       if (pvmw->flags & PVMW_MIGRATION)
>>>> +                               return not_found(pvmw);
>>>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>>> +                               return not_found(pvmw);
>>>> +               } else {
>>>>                        if ((pvmw->flags & PVMW_SYNC) &&
>>>>                            thp_vma_suitable_order(vma, pvmw->address,
>>>>                                                   PMD_ORDER) &&
>>>> @@ -285,6 +273,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>                        step_forward(pvmw, PMD_SIZE);
>>>>                        continue;
>>>>                }
>>>> +
>>>> +               /* Double-check under PTL that the PMD didn't change. */
>>>> +               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>>> +               if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
>>>> +                       return true;
>>>> +               spin_unlock(pvmw->ptl);
>>>> +               pvmw->ptl = NULL;
>>>> +               goto restart;
>>>> +pte_table:
>>>>                if (!map_pte(pvmw, &pmde, &ptl)) {
>>>>                        if (!pvmw->pte)
>>>>
>>>>
>>>>
>>>>
>>>> There is likely room to clean this up / compress it further.
>>>
>>> I tried to compress above logic like this, hope it could look cleaner.
>>>
>>> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
>>> 		unsigned long pfn;
>>> 		bool is_migration = pmd_is_migration_entry(pmde);
>>> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
>>>
>>> 		if (is_migration != for_migration)
>>> 			return not_found(pvmw);
>>>
>
>I got some time to look at PVMW_MIGRATION, remove_migration_ptes
>is invoked for device private pages, would we want them to skip
>device private pmd pages?
>

Not get you clearly.

You mean skip device-private pmd page in remove_migration_ptes()?

>>> 		if (pmd_trans_huge(pmde))
>>> 			pfn = pmd_pfn(pmde);
>>> 		else
>>> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
>>>
>>> 		if (!check_pmd(pfn, pvmw))
>>> 			return not_found(pvmw);
>>> 	} else if (!pmd_present(pmde)) {
>> 
>> It's more compact, but not necessarily cleaner. In particular, I detest
>> pmd_trans_huge(), we should phase it out.
>> 
>> if (pmd_present(pmde) && !pmd_leaf(pmde)) {
>> 	goto pte_table;
>> } else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))
>> 
>> ...
>> 
>> Might work as well. But once we add support for other softleaf types, we'll have
>> to touch it again. So I'd rather just list what we actually expect.
>> 
>
>Balbir

-- 
Wei Yang
Help you, Help me

