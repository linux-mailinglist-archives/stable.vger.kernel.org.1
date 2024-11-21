Return-Path: <stable+bounces-94502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439709D4890
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 09:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3D11F21F60
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD01CB321;
	Thu, 21 Nov 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/j21Q+I"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2331CB305
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176693; cv=none; b=Jtnz4W99EFke9pWGRDrTl+9ClINACobvrpa0y5R2xQGU09rHvjjzs59uTvNZToZuzqp7Eh4wqi5gG24irHxqCF+K8xgTS0/m9dAemsbH6LS/1y9SZhRiUZHePV/B/NOnoAdl3uXyaSYKnv0PXX9WcpTa8kThqIXYa6WmM1U+FhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176693; c=relaxed/simple;
	bh=hxm/TjqGHYcd4OhGW1XpqfbpyKGfD9gCI32GfJjgMSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIK8DQq1501nB1RkMlGmyEY9EOkV3aAq3VGOJ7zWO3LWIycK933TOWDL1XkHFGVcN19N12iXBWI8bQyX2NZiQW48BYTDrwHo589/i0jySLZMlCI0oaXC2ttoOdVba97h5JCk7PBCw9zLrPqWA2VOwhhCzAQjkGvzT0tyno5MPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/j21Q+I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732176690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j7c2yRYP0godLKKdOAgJYMv4rz+u6pVZgcG/16jBlNQ=;
	b=U/j21Q+IsjZPOZ1c1DnldW8cybr/lFE+HakUPPNZP69rtQu85gpkTE9MRZcbGvtVYrmtF7
	fdPZLdk9gbbN/JCq6eIYW7HoP4nVcI0lsbUZjfBkXwe3VbRjAGtDQjPh7q9g7KbAJOCv7P
	6l4LrDL+ZB2CXg4ejcb3dTxyTLVkFJQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-yUFF2sCDNw-r-V4nugLkEA-1; Thu, 21 Nov 2024 03:11:28 -0500
X-MC-Unique: yUFF2sCDNw-r-V4nugLkEA-1
X-Mimecast-MFC-AGG-ID: yUFF2sCDNw-r-V4nugLkEA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99fff1ad9cso50688466b.2
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 00:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176687; x=1732781487;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j7c2yRYP0godLKKdOAgJYMv4rz+u6pVZgcG/16jBlNQ=;
        b=CHRHl4HR4itU5m8OxXLxXIAXKnCD2mHLEqMnkPL51Rg0BGBoYVc6XZDrM7braFPdBX
         flxiDtz7DE7GUTsQpoQ6/U8CHbIdfF1KVg/3bZDyQEMh/bqUXG+bw0Nh5ckbWNqabJ+4
         dd0fKXlmOU/QKtcHikxr5QPO59zgNvDEKsh3ZJpWcSg1gHPl7uxXxFne4JLYbRZnuxjj
         wuGoIc1F4kl6bhjXhJ+umjFQ3Fj8ooEme+4Cv/bJFFqF7PJBKu8jWxYZenx0+HyHe99v
         xRTpFcxY6cx3gcDqxJAsdOLyHSFekQvqX2pHjeKQJxJADkN/mCBL58ZUO6QGb6TEs8M3
         aGaA==
X-Forwarded-Encrypted: i=1; AJvYcCVJy7aog1eUaATkBJJIcxEkfEStCTXklMmneZpqkb8lRWVuambjjum94n9YrHTRzaJKnsUe0Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqP2GmG284reGzS6dE8psOWHMZJJ+sIrGbFNBAobhP0xPRY9Xr
	AQjrOSMAj14UiC1Gg4GU29z9PHlHjFhk63795ZjqeJSKqLn671P2+uem6Ent9r/Ken4hhER3ruw
	hBFdkj7Vnf2HUpdxUA9Qu3gRv2Ni/Z3f+X5WZ0n/GjZwNZ8zNvUmuQQ==
X-Received: by 2002:a17:907:7ea5:b0:a9a:1918:c6c6 with SMTP id a640c23a62f3a-aa4dd53dab6mr500369066b.8.1732176687537;
        Thu, 21 Nov 2024 00:11:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1UxBW98t/86zlYyR3XA7RvuDh1PHWXkfY4E/qCph5vuLhp2/hlukVtaf5kqObRf1WCRpNvA==
X-Received: by 2002:a17:907:7ea5:b0:a9a:1918:c6c6 with SMTP id a640c23a62f3a-aa4dd53dab6mr500367266b.8.1732176687183;
        Thu, 21 Nov 2024 00:11:27 -0800 (PST)
Received: from [192.168.3.141] (p4ff231bf.dip0.t-ipconnect.de. [79.242.49.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490c29fsm4121510f8f.32.2024.11.21.00.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:11:25 -0800 (PST)
Message-ID: <91a621ea-d18a-4428-b1a5-943b4cf2c79e@redhat.com>
Date: Thu, 21 Nov 2024 09:11:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/gup: handle NULL pages in unpin_user_pages()
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
References: <20241121034933.77502-1-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241121034933.77502-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 04:49, John Hubbard wrote:
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

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


