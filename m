Return-Path: <stable+bounces-65481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A127948E43
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 14:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5261F236FD
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7481BE244;
	Tue,  6 Aug 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpMOyxId"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292F1BDA99
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945615; cv=none; b=aWvCN1hy/4WG6vZ8XhiafSSpEWVIPiGqKHm4pLZpOxym/egUBbNi0/pwff27UDoSZ/AfUlfQb3kxa2FcTWdravlwJnMcMCKhJTLORjxHRa9d4Dsd2e5A6DfMCWGmZucAaNzi3cu2K/0YcHcg0nQjVZ6iiKbSfsq4vMWWS0DK7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945615; c=relaxed/simple;
	bh=bBv2cHHWcE2FsszcQBzisILn+uKryUE8Esyx/ZXDteQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMslFhjMQREAPoTbvAZqmewgjttM99dJBh3SUanyVMdwTualiyhz4XqvP4NC66/qa2eNiQKmc1aA4Zw+wpERmuiu9jzmtkDSXfg2omELJg+oRUOSpzgVgZFDb7eBpgjngdja8HJUgz4RxhPC8tgXbdZOiqlP+yVCaoGNQkOehh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpMOyxId; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722945612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jOJGHm4Br6LaHArjPowVXyqQXUfsOQYsBdbCDZ6CFQA=;
	b=IpMOyxIdiZHkihURojq0Oht/R8uG4go0rMf0gHLuGgbA0s1N3yl0UzCHXwMF/acN8ZPe6O
	shQM23TGZuKfxd+o2C9MqmVMATPQpvbOEzNCOof1lpjwDMlA9okkUvyxL1ip28qTs9e+tX
	ADrBGtj0eJxzv0KO/GImoZXWJ6RXXwQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-BCj39K_CNyWdd9sIDMBs6w-1; Tue, 06 Aug 2024 08:00:11 -0400
X-MC-Unique: BCj39K_CNyWdd9sIDMBs6w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280291f739so4740845e9.3
        for <stable@vger.kernel.org>; Tue, 06 Aug 2024 05:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945610; x=1723550410;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jOJGHm4Br6LaHArjPowVXyqQXUfsOQYsBdbCDZ6CFQA=;
        b=cLS4ubStwFo2NaVzgFfqgaQt9J4cUH9Sq5tkuQ6uZyY+qDlQtHDxPJMQAXySP/cKbr
         UEnWWoPbgMTDE0bcZxHiCZez8bac0A0EDCxTJWgLjdCnkPGaa7VkW3m7cMAJ6mNVr7TH
         1wFju4cr8YZQhGOT+gdisw3ij0s8UMb1J+Ka2BgIZNgJ/AVDexB5dTpc2wC+CJmvDSGk
         v0/rACb2+aRIWN+AVBmrAE+H2yrirxDj0KXCgGqRs5qwLnoalun3uDVmqagx8WIFHCWt
         uMCn0PwNMWbv6XvUBuY6Kk/NnPtfVeuHvgtPGSKNGBjavlRL65g4XjCA4BIkZfRe/nPT
         otBA==
X-Forwarded-Encrypted: i=1; AJvYcCWkv4pW/SM7DCIXL4CahsIGKp8uKOaAd9VN3hTGUCqCLI3qzFe1qqyRY7qs/OrD6ixsPmZa8tBTuPI7Eh7NrtQlHibSkDNe
X-Gm-Message-State: AOJu0YyWzNoi0xJGw+2f2r/DRecw17IVA9q1buN9H2Bv5c09+V1YJlUN
	pSDPlM1HINoHJ0QUcQn9/SA9i5R+dsPAR9iehseOQlxj5ynidGK5jrEkSWX6fJI+X78gL6RabwH
	B/kXTJEoCqcEJ+AqCJ/Y3TMZbzS20LgpNQRSRxKt2cmpJwM8UTrMuPw==
X-Received: by 2002:a05:600c:468c:b0:427:abed:3608 with SMTP id 5b1f17b1804b1-428e6af2fb9mr85689085e9.5.1722945610151;
        Tue, 06 Aug 2024 05:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2QasHYqkusBhWQLHdc8qVQblinwhGWx2cAkm/gc5JdYPrFP55UaOZZ1yyKwduUpTbjy595g==
X-Received: by 2002:a05:600c:468c:b0:427:abed:3608 with SMTP id 5b1f17b1804b1-428e6af2fb9mr85688825e9.5.1722945609620;
        Tue, 06 Aug 2024 05:00:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e727084dsm177397315e9.36.2024.08.06.05.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 05:00:09 -0700 (PDT)
Message-ID: <7564cf76-115b-4d5b-bfbd-fd3b1e55a5c1@redhat.com>
Date: Tue, 6 Aug 2024 14:00:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm: Fix endless reclaim on machines with unaccepted
 memory
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jianxiong Gao <jxgao@google.com>,
 stable@vger.kernel.org
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-2-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240805145940.2911011-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 16:59, Kirill A. Shutemov wrote:
> Unaccepted memory is considered unusable free memory, which is not
> counted as free on the zone watermark check. This causes
> get_page_from_freelist() to accept more memory to hit the high
> watermark, but it creates problems in the reclaim path.
> 
> The reclaim path encounters a failed zone watermark check and attempts
> to reclaim memory. This is usually successful, but if there is little or
> no reclaimable memory, it can result in endless reclaim with little to
> no progress. This can occur early in the boot process, just after start
> of the init process when the only reclaimable memory is the page cache
> of the init executable and its libraries.
> 
> Make unaccepted memory free from watermark check point of view. This way
> unaccepted memory will never be the trigger of memory reclaim.
> Accept more memory in the get_page_from_freelist() if needed.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Jianxiong Gao <jxgao@google.com>
> Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> Cc: stable@vger.kernel.org # v6.5+
> ---

Nothing jumped at me, sounds reasonable

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


