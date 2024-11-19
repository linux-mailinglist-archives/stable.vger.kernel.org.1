Return-Path: <stable+bounces-94015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C659D2838
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA521F21A51
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A01CCEE1;
	Tue, 19 Nov 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNcbVnlb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E401CC8BC
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026806; cv=none; b=VjwqAxMsUTL5SRYMo6DID1v6aTFChN0Cu+269MnnE71/2nZ7ocxhLwWKQlbc6I6c4KJWPuWA9viGMSvhEVLBqSs/yJ0jUNOAP9ADdiarjIm+RYeSOvN/WgiCoOmj/Rdvh01oLchprOV2CzxZ6Yj6EcFaQbQ2FK9akIHYoP2+Zig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026806; c=relaxed/simple;
	bh=Oo6PxYvoWGt6gDckq2WNlGbiHQHBf99MOZZ7THfBN+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSm6XPx/Z/s1Kvj4XQdRmc4xFZL7IDr/RdKuH/zCdbID+t0K7i/1nKPvzGh/OVswnP7hRyRtDHIL4LcXQwbqjoy8QG8h3Y6vPHz2Naq5i7bHJLFr99ndurEA98ymuI/TA+avqP0h2hM4TC7lXffq3hlen/7TBdgOyXFVSS7P2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNcbVnlb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732026803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qmftc/BcUXTV6+a5UVFoGoUb0H1Sxzi1dJ/PD5jtCJs=;
	b=bNcbVnlbPzxmmu/4slgt0Il4LZyhUq35n/6Lo8o/nHBEjb+VUm23OFln7dnoSPo9eO9OFa
	EYhMNPe8j/QEsofFfJclHFpYKYzCC8bdk8R8vaFOABr/VKOT2IXmgsr+juLTHY5nBUF21+
	vdm453FxUTZS0iZSNoyn532sZTFKgrk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-zHM4RNl-MxS-328VDajnxQ-1; Tue, 19 Nov 2024 09:33:21 -0500
X-MC-Unique: zHM4RNl-MxS-328VDajnxQ-1
X-Mimecast-MFC-AGG-ID: zHM4RNl-MxS-328VDajnxQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43152cd2843so34879825e9.3
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 06:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026800; x=1732631600;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qmftc/BcUXTV6+a5UVFoGoUb0H1Sxzi1dJ/PD5jtCJs=;
        b=meHN0XMpY+Qtq95wemcx0AIBHnf4ryvlDKhU/Gy9INrQtsLunqlZd4Mzrwsqzutd+V
         2falwTciAFBTU9PsGmTeSL0GO1LWkMpo4qFfMo4ZRF1zUn2YUirwGRlBsAnGWPhXU8IZ
         Zev7Ep/VX2o3fZ332+vIR3AeqqP6PO65n/YnzOCZhHo77LIIykOAmBRHWU4otclFbl4H
         C/0NhmONX/Hxvw9dYIT8qK4TIajSDpkT0tclTKF3/LGXnBhoowl+0QN/uPONKWs3FGaT
         qHz1EzR2OdRGwA2v+e7X4EbaXwIoybcHDC9j/FQ6aYJVgzXsgbqw7vQi9JyHZMdDLQ5+
         JTGw==
X-Forwarded-Encrypted: i=1; AJvYcCXl7ZfYGeQc+fwnSpcqEDl+fAu426OsH7fwWJrYTjAUC+IZC6w1VJCsADtALn47Z/IztIQWnR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8baSirmaztyn74BcKOCUsK0FR/mebxW+eKJcNfkEr55qcAb+/
	LozuqynWiaiijqHV5BVbK0OMxOlfzPAdtXlBdbFLJWu2wXiLk8PN+r8Yn23IIYMW2Qt64qVGkNY
	7G2sZit4sInmesdMq4apuNgdmnvgE5c4On+MZGwblj6LTjWR0Nx4kqQ==
X-Received: by 2002:a05:600c:190c:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-432df798ea0mr126547745e9.33.1732026800496;
        Tue, 19 Nov 2024 06:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK04L/GIJiJ8vNgjrI2CiUK8dHSGl4HJK5JLorjAOloBqWd2eRjT1GOw/AFWFeYpU3ISdIHQ==
X-Received: by 2002:a05:600c:190c:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-432df798ea0mr126547475e9.33.1732026800145;
        Tue, 19 Nov 2024 06:33:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac216a4sm193824675e9.44.2024.11.19.06.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 06:33:18 -0800 (PST)
Message-ID: <64d5e357-94b5-48b4-b6cf-0a7a578f82ae@redhat.com>
Date: Tue, 19 Nov 2024 15:33:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: handle NULL pages in unpin_user_pages()
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Oscar Salvador <osalvador@suse.de>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Dave Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>, stable@vger.kernel.org
References: <20241119044923.194853-1-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241119044923.194853-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.24 05:49, John Hubbard wrote:
> The recent addition of "pofs" (pages or folios) handling to gup has a
> flaw: it assumes that unpin_user_pages() handles NULL pages in the
> pages** array. That's not the case, as I discovered when I ran on a new
> configuration on my test machine.
> 
> Fix this by skipping NULL pages in unpin_user_pages(), just like
> unpin_folios() already does.
> 
> Details: when booting on x86 with "numa=fake=2 movablecore=4G" on Linux
> 6.12, and running this:
> 
>      tools/testing/selftests/mm/gup_longterm
> 
> ...I get the following crash:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> RIP: 0010:sanity_check_pinned_pages+0x3a/0x2d0
> ...
> Call Trace:
>   <TASK>
>   ? __die_body+0x66/0xb0
>   ? page_fault_oops+0x30c/0x3b0
>   ? do_user_addr_fault+0x6c3/0x720
>   ? irqentry_enter+0x34/0x60
>   ? exc_page_fault+0x68/0x100
>   ? asm_exc_page_fault+0x22/0x30
>   ? sanity_check_pinned_pages+0x3a/0x2d0
>   unpin_user_pages+0x24/0xe0
>   check_and_migrate_movable_pages_or_folios+0x455/0x4b0
>   __gup_longterm_locked+0x3bf/0x820
>   ? mmap_read_lock_killable+0x12/0x50
>   ? __pfx_mmap_read_lock_killable+0x10/0x10
>   pin_user_pages+0x66/0xa0
>   gup_test_ioctl+0x358/0xb20
>   __se_sys_ioctl+0x6b/0xc0
>   do_syscall_64+0x7b/0x150
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 94efde1d1539 ("mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases")
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Junxiao Chang <junxiao.chang@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> I got a nasty shock when I tried out a new test machine setup last
> night--I wish I'd noticed the problem earlier! But anyway, this should
> make it all better...
> 
> I've asked Greg K-H to hold off on including commit 94efde1d1539
> ("mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases")
> in linux-stable (6.11.y), but if this fix-to-the-fix looks good, then
> maybe both fixes can ultimately end up in stable.
> 

Ouch!

> thanks,
> John Hubbard
> 
>   mm/gup.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ad0c8922dac3..6e417502728a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -52,7 +52,12 @@ static inline void sanity_check_pinned_pages(struct page **pages,
>   	 */
>   	for (; npages; npages--, pages++) {
>   		struct page *page = *pages;
> -		struct folio *folio = page_folio(page);
> +		struct folio *folio;
> +
> +		if (!page)
> +			continue;
> +
> +		folio = page_folio(page);
>   
>   		if (is_zero_page(page) ||
>   		    !folio_test_anon(folio))
> @@ -248,9 +253,14 @@ static inline struct folio *gup_folio_range_next(struct page *start,
>   static inline struct folio *gup_folio_next(struct page **list,
>   		unsigned long npages, unsigned long i, unsigned int *ntails)
>   {
> -	struct folio *folio = page_folio(list[i]);
> +	struct folio *folio;
>   	unsigned int nr;
>   
> +	if (!list[i])
> +		return NULL;
> +

I don't particularly enjoy returning NULL here, if we don't teach the 
other users of that function about that possibility. There are two other 
users.

Also: we are not setting "ntails" to 1. I think the callers uses that as 
"nr" to advance npages. So the caller has to make sure to set "nr = 1" 
in case it sees "NULL".

Alternatively ...

> +	folio = page_folio(list[i]);
> +
>   	for (nr = i + 1; nr < npages; nr++) {
>   		if (page_folio(list[nr]) != folio)
>   			break;
> @@ -410,6 +420,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
>   	sanity_check_pinned_pages(pages, npages);
>   	for (i = 0; i < npages; i += nr) {

... handle it here

if (!pages[i]) {
	nr = 1;
	continue;
}

No strong opinion. But I think we should either update all callers to 
deal with returning NULL from this function, and set "nr = 1".

-- 
Cheers,

David / dhildenb


