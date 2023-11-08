Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1C7E5C85
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKHRji (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 12:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjKHRjg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 12:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC6C6
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 09:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699465127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=nSCtCbyHMnF6JFI8adpt+DXBLzsY60+au4G0WAaEdvY=;
        b=DmW+ZUXTuC7p2BUV8Kyxuk5+tUQxP8vWFHbnb+QY+0m7qtZ1KZSu++Fq80OAt3r4PBam+B
        kOLK8eoM1XUoPwyQma+c/iHkz+IIJ0XxF7+AyLat/l7EZAIACr26OHOygm3cllIZXjkNZy
        BQxurJLQ6DNC0TCjD9UPFGeYsOiNxh4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-2xoqfKZQP7ugktuAfX7hJQ-1; Wed, 08 Nov 2023 12:38:46 -0500
X-MC-Unique: 2xoqfKZQP7ugktuAfX7hJQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40920512cd3so46338005e9.1
        for <stable@vger.kernel.org>; Wed, 08 Nov 2023 09:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699465125; x=1700069925;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSCtCbyHMnF6JFI8adpt+DXBLzsY60+au4G0WAaEdvY=;
        b=pQqfJACNmyJqXk8X4FWcUcSabHyF2cecwUyLkY9/K7olEkIAke9yZaQviL2LVglmzW
         UFq0Hn4bQN7Y38OZ2W705/Q9MFw2Bl+zTVu/xW1xEVrJT9iMhwgpzg6NaxT0HIK3eyOK
         cDMr2z7tHhfhJ2mk/bZXnj77Yn7yMBfyjLTNBZjflQES+Zkn9zyYrH5AtMNuOUFOxqwj
         UTmynm1iucpTv/Is4Mt2sGztE6BfSs3PBUVgQcrIjj1Nrw4zIt/cT5qdWR9YI4QsoCAV
         iMI+dF5qFWejc0Ndt73A1PrVTCrKJKpZcfSjUUDaOWn3K78TO5Jr0bcbuT17N3SQ7rLF
         gDMg==
X-Gm-Message-State: AOJu0Yxf5659Fc1vrydki++kFe+H375j+4PkAmBFWVh38b3KsQaja3Kf
        +MwN7Dc51TC98/hNLzj87Gc6/9xrG2NU+XPFphbbUZjTxVzKLWXGul13wg5l7uLQn7Uo3UNyjgO
        bDlAnnK5z0Erl7yyQ
X-Received: by 2002:a05:600c:1f84:b0:409:404e:5b9a with SMTP id je4-20020a05600c1f8400b00409404e5b9amr2258250wmb.33.1699465125356;
        Wed, 08 Nov 2023 09:38:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+Z6a00/hgMXAxPLvE7vBVK4NKGT2M4vzBYtwq67VEVG6qWmFrmi8XUsY/BgdAvKt2H6ibuQ==
X-Received: by 2002:a05:600c:1f84:b0:409:404e:5b9a with SMTP id je4-20020a05600c1f8400b00409404e5b9amr2258229wmb.33.1699465124947;
        Wed, 08 Nov 2023 09:38:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c712:c800:c9f8:7b16:67ce:ff2a? (p200300cbc712c800c9f87b1667ceff2a.dip0.t-ipconnect.de. [2003:cb:c712:c800:c9f8:7b16:67ce:ff2a])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d68c1000000b0032da022855fsm5428790wrw.111.2023.11.08.09.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 09:38:44 -0800 (PST)
Message-ID: <f994665e-9fe1-4aaa-9760-07f876441a64@redhat.com>
Date:   Wed, 8 Nov 2023 18:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Fix for negative counter: nr_file_hugepages
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, willy@infradead.org
References: <20231108171517.2436103-1-shr@devkernel.io>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231108171517.2436103-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 08.11.23 18:15, Stefan Roesch wrote:
> While qualifiying the 6.4 release, the following warning was detected in
> messages:
> 
> vmstat_refresh: nr_file_hugepages -15664
> 
> The warning is caused by the incorrect updating of the NR_FILE_THPS
> counter in the function split_huge_page_to_list. The if case is checking
> for folio_test_swapbacked, but the else case is missing the check for
> folio_test_pmd_mappable. The other functions that manipulate the counter
> like __filemap_add_folio and filemap_unaccount_folio have the
> corresponding check.
> 
> I have a test case, which reproduces the problem. It can be found here:
>    https://github.com/sroeschus/testcase/blob/main/vmstat_refresh/madv.c
> 
> The test case reproduces on an XFS filesystem. Running the same test
> case on a BTRFS filesystem does not reproduce the problem.
> 
> AFAIK version 6.1 until 6.6 are affected by this problem.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Co-debugged-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: stable@vger.kernel.org
> ---
>   mm/huge_memory.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 064fbd90822b4..874000f97bfc1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2737,13 +2737,15 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>   			int nr = folio_nr_pages(folio);
>   
>   			xas_split(&xas, folio, folio_order(folio));
> -			if (folio_test_swapbacked(folio)) {
> -				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
> -							-nr);
> -			} else {
> -				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
> -							-nr);
> -				filemap_nr_thps_dec(mapping);
> +			if (folio_test_pmd_mappable(folio)) {
> +				if (folio_test_swapbacked(folio)) {
> +					__lruvec_stat_mod_folio(folio,
> +							NR_SHMEM_THPS, -nr);
> +				} else {
> +					__lruvec_stat_mod_folio(folio,
> +							NR_FILE_THPS, -nr);
> +					filemap_nr_thps_dec(mapping);
> +				}

Reviewed-by: David Hildenbrand <david@redhat.com>

Yes, that's the current state: update these counters only for 
(traditional, IOW PMD-sized) THP. What we'll do with non-pmd-sized THP 
remains to be discussed (Ryan had some ideas).

-- 
Cheers,

David / dhildenb

