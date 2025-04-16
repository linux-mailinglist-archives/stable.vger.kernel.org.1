Return-Path: <stable+bounces-132874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBE2A90869
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57BA448142
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994A208973;
	Wed, 16 Apr 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ge7k7Xix"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AE211715
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819855; cv=none; b=uaYMCTHuuXXD3lLzni7M2Nx/H1kzS2rlpytFI+SgzedHzKJ8fEfS10J2cTcKQzXn1o3DwjCEQeJFp+iahkLRuCpmTQl4H5s1w5tHD+VL/LKUJzr315hoytxwxCDSf1QB7cpTi9vWUtqcjQuRWqCQy8pF/00AVPb6xQOYelExcuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819855; c=relaxed/simple;
	bh=MESf1vjTuHy3kjhFRgv2yWu96CrENhlNl83PIj2AewE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVM+yT7Ue2nlA7FG4twzJOW3OAMTfit4WLBDN5Gu7amhQC0d/B9/fFkO2RNE0ELLy0BrqlBZffzn7SecoO7XIrCAH+hxMnKN0WoeRsgfaIy4wF8otz+ehPakZAqZNsb0QJ9gCKeC0cx6JDH4QJb2wyDXA+l1nBzb4MZA0w/jLgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ge7k7Xix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744819852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o6ARJki+qaXMp4MS04T2ajKyOGVrN2invKy0HZHX3Is=;
	b=Ge7k7XixfaGX89jILC1fpYkomciTieUbWnszGZL9+d52AJ5a+VCUtOGcvgvTWUqKvHNW9b
	wKgaW8+EG8dCsNQWgAS2GIYadEgwFK+eDpecqflemVTzDMFLKHDqPT+zRhe99Gkw9OsK+m
	xcy9pFf3XHE6ZzT1pBVuxFXQKl0XFmI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-nQWjcEq1NKSnrfCZxBybjQ-1; Wed, 16 Apr 2025 12:10:50 -0400
X-MC-Unique: nQWjcEq1NKSnrfCZxBybjQ-1
X-Mimecast-MFC-AGG-ID: nQWjcEq1NKSnrfCZxBybjQ_1744819848
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so35674465e9.0
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 09:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819848; x=1745424648;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o6ARJki+qaXMp4MS04T2ajKyOGVrN2invKy0HZHX3Is=;
        b=B7N8yNUKkEdHqE8iCmRqO34zxGivtnLlPDWhJ5AXcOCNoHFWyBVKSCJviUYEZbbyAE
         VfMgRrj284YaiJ5kSqftYN14z2bTqFXHvSlCcjZRw/aH3DbJ9rMMl+zLnLpoC1AbLHNu
         dzIx9lGzeNVXvHYUXi9HMv4X/RYKDAdWWu2E/kQ5JLSAoHHZJ/h+i+0FGFsrSalyinZS
         H4LPQ4BXgrqvOYHSwmps1r5FMBMvIE4rPgHhZLk0eC/EvZbVuoLLzlu848b7vjOCArNG
         ja70AM+Tf60CtjI61alZwbWTfX8bF/PZNJPX2/1K6LoG9ZZxE2AHEVDEYJ2EIpN77QjP
         E3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXwkxbygre9w2vc17TDJiViLWWPv16dtm99guHXgr+//T8XbugT+gTrAX6Fqy8tDXXAWQWLIWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRaGN4k0XGL0BuBC0G1iAGK+ZFaqyPulhRoydkNjW/TpxumAR
	i6Ks8szXat/tJy6kUgJ/29stDhViO/0Gdz0YV76k4/DRpgARnAV3eCgUdoKA6biymoaNF035Kcg
	JxeUbolSWGcB2PHr4LDpq+Ujop+H+1binczONPMA1qDju+GKOIq9fiw==
X-Gm-Gg: ASbGncvRnhb9hxsugxnRTOr2Ncy9blAppyCNT35c7J43eoOwkm78WuoCCPwIrVx325Y
	HoYgqJYER8AOjw+OvbhIXKKvU6fnzWmxy1L75E16O/o1SC0N4PDdIDVEprhw60UrQtsqOPAfdOy
	ozrAABOVdxHZ9fwbXuE11mXO/dRUp8Kh1w/V20n6bbrpwJE3yvt5+vXb+T0ROwU7nv8K3qwWdXc
	fI2cQzrpcH8c5BA8321/U4ZSsk+Tw4rMLVPY6Lk+8rinXIJJIGEmqOrY7DJsrvG0Yk4Uxg+q9+Q
	aDqAq75IYN3RfAYeEjbHMdY0w0vCwNRaPAl6us3H0lojoFrBFeF7OGKTi9yCOVT0c6jjOj7maFL
	EzKq3umK115GEIRxGl+4CwMK1wWkp0FUMrbwDog==
X-Received: by 2002:a05:600c:5494:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-4405d6ae57fmr20633675e9.25.1744819848169;
        Wed, 16 Apr 2025 09:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfLCIMoVAMXKFkQlkSnsh6Z8XgTYyYys8PDrFPT+NPDNYsQ5O8pnSfMYztcFTmVbaTdPycrQ==
X-Received: by 2002:a05:600c:5494:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-4405d6ae57fmr20633215e9.25.1744819847680;
        Wed, 16 Apr 2025 09:10:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f02:2900:f54f:bad7:c5f4:9404? (p200300d82f022900f54fbad7c5f49404.dip0.t-ipconnect.de. [2003:d8:2f02:2900:f54f:bad7:c5f4:9404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce0asm17572713f8f.70.2025.04.16.09.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 09:10:47 -0700 (PDT)
Message-ID: <27d13454-280f-4966-b694-d7e58d991547@redhat.com>
Date: Wed, 16 Apr 2025 18:10:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix dereferencing invalid pmd migration
 entry
To: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: willy@infradead.org, ziy@nvidia.com, linmiaohe@huawei.com,
 hughd@google.com, revest@google.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250414072737.1698513-1-gavinguo@igalia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250414072737.1698513-1-gavinguo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.04.25 09:27, Gavin Guo wrote:
> When migrating a THP, concurrent access to the PMD migration entry
> during a deferred split scan can lead to a page fault, as illustrated
> below. To prevent this page fault, it is necessary to check the PMD
> migration entry and return early. In this context, there is no need to
> use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the equality
> of the target folio. Since the PMD migration entry is locked, it cannot
> be served as the target.
> 
> BUG: unable to handle page fault for address: ffffea60001db008
> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
> Call Trace:
> <TASK>
> try_to_migrate_one+0x28c/0x3730
> rmap_walk_anon+0x4f6/0x770
> unmap_folio+0x196/0x1f0
> split_huge_page_to_list_to_order+0x9f6/0x1560
> deferred_split_scan+0xac5/0x12a0
> shrinker_debugfs_scan_write+0x376/0x470
> full_proxy_write+0x15c/0x220
> vfs_write+0x2fc/0xcb0
> ksys_write+0x146/0x250
> do_syscall_64+0x6a/0x120
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The bug is found by syzkaller on an internal kernel, then confirmed on
> upstream.
> 
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> ---
>   mm/huge_memory.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a47682d1ab7..0cb9547dcff2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   			   pmd_t *pmd, bool freeze, struct folio *folio)
>   {
> +	bool pmd_migration = is_pmd_migration_entry(*pmd);
> +
>   	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>   	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>   	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   	 * require a folio to check the PMD against. Otherwise, there
>   	 * is a risk of replacing the wrong folio.
>   	 */
> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> -	    is_pmd_migration_entry(*pmd)) {
> -		if (folio && folio != pmd_folio(*pmd))
> -			return;

Why not something like

struct folio *entry_folio;

if (folio) {	
	if (is_pmd_migration_entry(*pmd))
		entry_folio = pfn_swap_entry_folio(pmd_to_swp_entry(*pmd)));
	else
		entry_folio = pmd_folio(*pmd));

	if (folio != entry_folio)
		return;
}


(can likely be cleaned up a bit by moving stuff into a separate function)


-- 
Cheers,

David / dhildenb


