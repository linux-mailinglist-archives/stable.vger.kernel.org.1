Return-Path: <stable+bounces-134658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD5A9407B
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 01:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CCE7A36F4
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A825253B76;
	Fri, 18 Apr 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RK+lAKyS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11572248A8
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745020424; cv=none; b=TlqbMlxbKBVmKptTieb16fNZxQMIeB+3y3gPCBTEtBjRmfHn8w8p80D7pad4s3MtK8MfPB7bdP7cuIFlzO2ZAkUGN6+QS1YsrvWCi2ajkFU3Ri4XUmnnFad2JyzYUtMCQgL2CMxcabOR8gbVUTltlyHjN04LQxgm+pkMzd/6AKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745020424; c=relaxed/simple;
	bh=ldQjJ7UNLxo/lWytezcOzNcPcncGo2138Gtpk78cBTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GK91dsTMQxOi+KZ7/v5UJ83hDycHOEDrE5XirPVXvSwqpdRAFg9FFv87tIJS88bDw+IY9V585Qg0+j575Tw7wfMYfM6gaRNcuTUlIWsELS1xfWaVnz8NSXnryYSnhlXyibmV/oZRPfp6jn/MZ+oXYW7QAICVNSkUXisnwBaXOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RK+lAKyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745020421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h/Vp0gMyIMKcL+uPWAU540HesIREHi5pomWL/DZBmY=;
	b=RK+lAKySjnvRKAswnewzHdHaUZwXOZnqRIi+EqJLG5ucoEWsJZ1NtaZ6D40CVh79F6vqMT
	z8+NDsoyey3q2CiZwOqMJNEWnD5bZ9O4vnAwfW3hSqkyjFqZtCyIRQrWgn/1NPC+Ar8Bh6
	YJwwKODHc7tggkBnitwurKuLIJ0ISTA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-H7eD2TyON_-gS_-6DgSjzw-1; Fri, 18 Apr 2025 19:53:40 -0400
X-MC-Unique: H7eD2TyON_-gS_-6DgSjzw-1
X-Mimecast-MFC-AGG-ID: H7eD2TyON_-gS_-6DgSjzw_1745020419
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22c35bafdbdso33020485ad.1
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 16:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745020419; x=1745625219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+h/Vp0gMyIMKcL+uPWAU540HesIREHi5pomWL/DZBmY=;
        b=MZ0RQlb6TmGxNE77FT39KOcg1rgF7vn9mFVQSQuIECAHx0VWrM4kgt4qlGfq7rgyxC
         T/FMLi1LIssY/AG4Pyg50lacjLrIllfaaPXG8IKnWJf1gzScUcq5rJoNLG4ebJzuWzwl
         qHJZHrH1kg4C7mXy7Wr5zMJLbdTxqktbz/45MVoAuhh18tXZlOOgKwZs/X/bMQR5g3v5
         0uzXTdl9SHtpb7OPB0VZLZQs9lTPQgqiARNJdUkT2vAdzo6gFK1maYggjq+V5vRxEk8L
         uZSqDdL8uyRbouy1FqA4QIzHJRY1kakeogRuyLiKQLeMYXsq/Sa3k1T4EvYOehSO9DKD
         hhHw==
X-Forwarded-Encrypted: i=1; AJvYcCVHBiA0cBZKjNOmkVmQJ5e1vSzK4Ql3y527KmoMu5adjTzLp383Im4+DUTgGP3injjaAH2F3no=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUD7rQwggi5dcFGoNMLb6KYPeg0PJL9hYcAIgbV3OSjIF0OM7u
	hBSpVXzzrWlSlQRC+Wn3gWMvQyBResr4yEVqUW2hXfNqH1HQRYx5Uiu+w5/W3u3txXusQKTWMYj
	u9kQGDEsdFV56Zl6QXtj+ApqVCGil31m/hUwVshJeNSOdZHl8yYsZFaKeoVHauA==
X-Gm-Gg: ASbGncuy15zKDMZlswg1/8nqag8QTcc5B17zmvy4YaNqn1DJSACmhr7kOY0+nftVxLA
	Kh6nWWYLgdbyaUaHG8k60ZhYr1aSONYLCzrLRWymlgRX9NySiGSaaA4lVAw6KXXxNnJ690k8jUm
	WD1V5KoOgiK1xi6dBusqS+15eBbuf+KEnLKWDOIX/y4QCKDu9XCV+cEcVbrnZUdxzTvT3PT528p
	P8zJUb23omaQbLkFfz20krSSImrzOySQaIQMCpjGVE9wh70gtOycODYLR8KJCJRBiXcsXWdzAGF
	O1HPDJDKS3GM
X-Received: by 2002:a17:902:d58b:b0:223:6254:b4ba with SMTP id d9443c01a7336-22c53581279mr58727265ad.13.1745020418955;
        Fri, 18 Apr 2025 16:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyrip1Pzd8BkTMwT9ZS60iZqs7EzZWLS+zXlCELfu4PB6UgO81P4DA6EMlM4UyTwwkyBVHwA==
X-Received: by 2002:a17:902:d58b:b0:223:6254:b4ba with SMTP id d9443c01a7336-22c53581279mr58727125ad.13.1745020418641;
        Fri, 18 Apr 2025 16:53:38 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed0f85sm22505245ad.178.2025.04.18.16.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 16:53:37 -0700 (PDT)
Message-ID: <e66af83a-f628-4c5b-8d48-aa6a5d4b4948@redhat.com>
Date: Sat, 19 Apr 2025 09:53:32 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
To: David Hildenbrand <david@redhat.com>, Gavin Guo <gavinguo@igalia.com>,
 linux-mm@kvack.org, akpm@linux-foundation.org
Cc: willy@infradead.org, ziy@nvidia.com, linmiaohe@huawei.com,
 hughd@google.com, revest@google.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250418085802.2973519-1-gavinguo@igalia.com>
 <b1312600-1855-406c-9249-c7426f3a7324@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <b1312600-1855-406c-9249-c7426f3a7324@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 4/18/25 8:42 PM, David Hildenbrand wrote:
> On 18.04.25 10:58, Gavin Guo wrote:
>> When migrating a THP, concurrent access to the PMD migration entry
>> during a deferred split scan can lead to a invalid address access, as
>> illustrated below. To prevent this page fault, it is necessary to check
>> the PMD migration entry and return early. In this context, there is no
>> need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
>> equality of the target folio. Since the PMD migration entry is locked,
>> it cannot be served as the target.
>>
>> Mailing list discussion and explanation from Hugh Dickins:
>> "An anon_vma lookup points to a location which may contain the folio of
>> interest, but might instead contain another folio: and weeding out those
>> other folios is precisely what the "folio != pmd_folio((*pmd)" check
>> (and the "risk of replacing the wrong folio" comment a few lines above
>> it) is for."
>>
>> BUG: unable to handle page fault for address: ffffea60001db008
>> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
>> Call Trace:
>> <TASK>
>> try_to_migrate_one+0x28c/0x3730
>> rmap_walk_anon+0x4f6/0x770
>> unmap_folio+0x196/0x1f0
>> split_huge_page_to_list_to_order+0x9f6/0x1560
>> deferred_split_scan+0xac5/0x12a0
>> shrinker_debugfs_scan_write+0x376/0x470
>> full_proxy_write+0x15c/0x220
>> vfs_write+0x2fc/0xcb0
>> ksys_write+0x146/0x250
>> do_syscall_64+0x6a/0x120
>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> The bug is found by syzkaller on an internal kernel, then confirmed on
>> upstream.
>>
>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Hugh Dickins <hughd@google.com>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
>> ---
>> V1 -> V2: Add explanation from Hugh and correct the wording from page
>> fault to invalid address access.
>>
>>   mm/huge_memory.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>

Reviewed-by: Gavin Shan <gshan@redhat.com>

>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2a47682d1ab7..0cb9547dcff2 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>                  pmd_t *pmd, bool freeze, struct folio *folio)
>>   {
>> +    bool pmd_migration = is_pmd_migration_entry(*pmd);
>> +
>>       VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>       VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>       VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>        * require a folio to check the PMD against. Otherwise, there
>>        * is a risk of replacing the wrong folio.
>>        */
>> -    if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>> -        is_pmd_migration_entry(*pmd)) {
>> -        if (folio && folio != pmd_folio(*pmd))
>> -            return;
>> +    if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
>> +        if (folio) {
>> +            /*
>> +             * Do not apply pmd_folio() to a migration entry; and
>> +             * folio lock guarantees that it must be of the wrong
>> +             * folio anyway.
>> +             */
>> +            if (pmd_migration)
>> +                return;
>> +            if (folio != pmd_folio(*pmd))
>> +                return;
> 
> Nit: just re-reading, I would have simply done
> 
> if (pmd_migration || folio != pmd_folio(*pmd)
>      return;
> 
> Anyway, this will hopefully get cleaned up soon either way, so I don't particularly mind. :)
> 

If v3 is needed to fix Zi's comments (commit log improvement), it can be improved
slightly based on David's suggestion, to avoid another nested if statement. Otherwise,
it's fine since it needs to be cleaned up soon.

	/*
	 * Do not apply pmd_folio() to a migration entry, and folio lock
	 * guarantees that it must be of the wrong folio anyway.
	 */
	if (folio && (pmd_migration || folio != pmd_filio(*pmd))
		return;

Thanks,
Gavin


