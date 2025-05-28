Return-Path: <stable+bounces-148002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D43AC722C
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 22:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77258167C83
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037721E087;
	Wed, 28 May 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmOn/k5D"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF800210F59
	for <stable@vger.kernel.org>; Wed, 28 May 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464019; cv=none; b=gU+17Y6Xt5mTIQtf3hjztcrcKpNSMFVASt5s1lp+hLVyVJ/wW8V5v9lbgAHH76pY+u9VFKD2Xvr80UjpfeEYFxrIngniXWI1oQ9vnrH7Z1qNz7rCQ1c5W8Vv3J2l4yDpmcV8GoFUvVhoZKyW/ifRlLJs/AwJ7OmQldbAWaUdQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464019; c=relaxed/simple;
	bh=1qlSlQLUMQn0f6CCbuO8uPQqSSrtOQ6FaVh8vkOL1cM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WFxlaJZp58zifRLBiOl9Yza2cKgmzTwym4i1LRilu3a/y3Vj+2RWHsElYqVlUXy48FNZJE5G0wJ2R1N5V7SmVMUX04WHtWwSSLZMYphJKaUmMB3OQU7N2QOSeTWfuvICNdS9yxcEYfQ1ExDVLQQyMxZK5KkGFH5pQrjqhap/0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmOn/k5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748464005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FC7FWOIvZGBtznnKQ9ub2nhNjZp56JzMAsF9Q1073Xk=;
	b=VmOn/k5D35LCjMK3HoeQJO6SKOEvhMOGdiUzcgrgCo75AhV/4622z2gzhlaosIZW2aKTbm
	jc//CWiE5vk6V+rlcr38hXz3saEe/a3riguNL8o1tg9K4y+4cyZqCKxKwKSlilLxlZooQU
	dcdENlH1lYPfB+JcmOkXwM4uvhcSQl8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-AmtFYruwMGKDOASI-zrVGg-1; Wed, 28 May 2025 16:26:09 -0400
X-MC-Unique: AmtFYruwMGKDOASI-zrVGg-1
X-Mimecast-MFC-AGG-ID: AmtFYruwMGKDOASI-zrVGg_1748463967
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43efa869b19so2040035e9.2
        for <stable@vger.kernel.org>; Wed, 28 May 2025 13:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463967; x=1749068767;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FC7FWOIvZGBtznnKQ9ub2nhNjZp56JzMAsF9Q1073Xk=;
        b=MeiqtJN8TtHo1tc35H1eaXdvPSxzYq2yPi34I8ruHA3kHcAx77M5Qq77Ht7cEDKq/t
         yd4aHHvni9Qr8vy7Myz38jIyCwaljhM9VALKX7PQBPhcHcAXHKV7C0Y6X16kcBLPB/eV
         K81mphOHjljTAqd52Py5HC/tDLNFOEiJIazpvgZR8BeuHQo7O/X2Nm/hatTW+6KsSW9t
         aynErPdvSxc+kYZhR6sFeUZMVwL1Sdq7bgAuUDmqH6aX5K0O7vE6JbmOLZzbCU2KbIN2
         /tviqBq9O5BgE0mUMqwWZeHhM4gk94kOc2+dGSriDNsFyKMjsIvojFTku9BxWXzkQ8hz
         nyKA==
X-Forwarded-Encrypted: i=1; AJvYcCVwVAgDjRIL6vXgeBTlMuuS98cx+Ad2m0RgwwJ/0U2qQOit/Sn9woS/chJY4eZj5kLkcK34O+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XL92+BDgq5L2C6q2FvLB2f0Pxo2M/SPun4l3AbHxjFV51c8t
	Vs8ly2x+4+L7+kga6XpoIOK4eeZk+lXVT5kOEDJqg8CRSFHYE66WsV60RqoF8EVVLqBDwSB8Ute
	qljJ4H3AmR1/xmpHXuXvLeQVey/b8PhgoNKgKYqJPH/S8+NuYEvDoc4ZmzQ==
X-Gm-Gg: ASbGncsaKLTB3p9/Ju63h4vFLb9gxQJ1m0opxAQ6LNNg4AwXA8GXWpLmMxW02Zmm+3Q
	G8/lDc8jVOJMiddd11/foV2rb1zEAPooQvGwuUfpspyk4nwDZT0iW3edWKhbRpvIuJxRtwawk94
	3l2nTqoQUV0TrsW18AgJtaNzOrqA+7Eng6xXR6MKVvUvm6p3kI9KL8cNKtKEd19GDOZ2xhnno+S
	BiFA3g90ecDgHugcr7ADm7YdnZabMh1rriuynjjyUcIY6+bu20qQc6tFbYu0QgrHVICcyh0uYts
	8ZkXUU0hrSx2ITks60GBB/RCOUc6jEN1EuoVmsKcR/xKfvwwYs1Tybu5PlLAb9Rk+vpUYf9SH+U
	ahMJFF7zCBDJ3WfPkPdBxnWy4rHObFqfed4qlIaI=
X-Received: by 2002:a05:600c:4684:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-44c955dc476mr165327295e9.21.1748463966598;
        Wed, 28 May 2025 13:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl9iKLxUdb8Lx653EW40oPpCh5HAsCocZ1VcQx/sJxTqqrIx/uvv3RMhUjhg1voWirB1ECYA==
X-Received: by 2002:a05:600c:4684:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-44c955dc476mr165327105e9.21.1748463966158;
        Wed, 28 May 2025 13:26:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc0344asm1185555e9.11.2025.05.28.13.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 13:26:05 -0700 (PDT)
Message-ID: <04ecf2e3-651a-47c9-9f30-d31423e2c9d7@redhat.com>
Date: Wed, 28 May 2025 22:26:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
From: David Hildenbrand <david@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Gavin Guo <gavinguo@igalia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 akpm@linux-foundation.org, mike.kravetz@oracle.com, kernel-dev@igalia.com,
 stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
References: <20250528023326.3499204-1-gavinguo@igalia.com>
 <aDbXEnqnpDnAx4Mw@localhost.localdomain> <aDcl2YM5wX-MwzbM@x1.local>
 <629bb87e-c493-4069-866c-20e02c14ddcc@redhat.com>
 <aDcvplLNH0nGsLD1@localhost.localdomain>
 <4cc7e0bb-f247-419d-bf6f-07dc5e88c9c1@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4cc7e0bb-f247-419d-bf6f-07dc5e88c9c1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 22:00, David Hildenbrand wrote:
> On 28.05.25 17:45, Oscar Salvador wrote:
>> On Wed, May 28, 2025 at 05:09:26PM +0200, David Hildenbrand wrote:
>>> On 28.05.25 17:03, Peter Xu wrote:
>>>> So I'm not 100% sure we need the folio lock even for copy; IIUC a refcount
>>>> would be enough?
>>>
>>> The introducing patches seem to talk about blocking concurrent migration /
>>> rmap walks.
>>
>> I thought the main reason was because PageLock protects us against writes,
>> so when copying (in case of copying the underlying file), we want the
>> file to be stable throughout the copy?
> 
> Well, we don't do the same for ordinary pages, why should we do for hugetlb?
> 
> See wp_page_copy().
> 
> If you have a MAP_PRIVATE mapping of a file and modify the pagecache
> pages concurrently (write to another MAP_SHARED mapping, write() ...),
> there are no guarantees about one observing any specific page state.
> 
> At least not that I am aware of ;)
> 
> 
>>
>>> Maybe also concurrent fallocate(PUNCH_HOLE) is a problem regarding
>>> reservations? Not sure ...
>>
>> fallocate()->hugetlb_vmdelete_list() tries to grab the vma in write-mode,
>> and hugetlb_wp() grabs the lock in read-mode, so we should be covered?
> 
> Yeah, maybe that's the case nowadays. Maybe it wasn't in the past ...
> 
>>
>> Also, hugetlbfs_punch_hole()->remove_inode_hugepages() will try to grab the mutex.
>>
>> The only fishy thing I see is hugetlbfs_zero_partial_page().
>>
>> But that is for old_page, and as I said, I thought main reason was to
>> protect us against writes during the copy.
> 
> See above, I really wouldn't understand why that is required.
> 
>>
>>> For 2) I am also not sure if we need need the pagecache folio locked; I
>>> doubt it ... but this code is not the easiest to follow.
>>    
>> I have been staring at that code and thinking about potential scenarios
>> for a few days now, and I cannot convice myself that we need
>> pagecache_folio's lock when pagecache_folio != old_folio because as a
>> matter of fact I cannot think of anything it protects us against.
>>
>> I plan to rework this in a more sane way, or at least less offusctaed, and then
>> Galvin can fire his syzkaller to check whether we are good.

Digging a bit:

commit 56c9cfb13c9b6516017eea4e8cbe22ea02e07ee6
Author: Naoya Horiguchi <nao.horiguchi@gmail.com>
Date:   Fri Sep 10 13:23:04 2010 +0900

     hugetlb, rmap: fix confusing page locking in hugetlb_cow()
     
     The "if (!trylock_page)" block in the avoidcopy path of hugetlb_cow()
     looks confusing and is buggy.  Originally this trylock_page() was
     intended to make sure that old_page is locked even when old_page !=
     pagecache_page, because then only pagecache_page is locked.

Added the comment

+       /*
+        * hugetlb_cow() requires page locks of pte_page(entry) and
+        * pagecache_page, so here we need take the former one
+        * when page != pagecache_page or !pagecache_page.
+        * Note that locking order is always pagecache_page -> page,
+        * so no worry about deadlock.
+        */


And

commit 0fe6e20b9c4c53b3e97096ee73a0857f60aad43f
Author: Naoya Horiguchi <nao.horiguchi@gmail.com>
Date:   Fri May 28 09:29:16 2010 +0900

     hugetlb, rmap: add reverse mapping for hugepage
     
     This patch adds reverse mapping feature for hugepage by introducing
     mapcount for shared/private-mapped hugepage and anon_vma for
     private-mapped hugepage.
     
     While hugepage is not currently swappable, reverse mapping can be useful
     for memory error handler.
     
     Without this patch, memory error handler cannot identify processes
     using the bad hugepage nor unmap it from them. That is:
     - for shared hugepage:
       we can collect processes using a hugepage through pagecache,
       but can not unmap the hugepage because of the lack of mapcount.
     - for privately mapped hugepage:
       we can neither collect processes nor unmap the hugepage.
     This patch solves these problems.
     
     This patch include the bug fix given by commit 23be7468e8, so reverts it.

Added the real locking magic.

Not that much changed regarding locking until COW support was added in

commit 1e8f889b10d8d2223105719e36ce45688fedbd59
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Fri Jan 6 00:10:44 2006 -0800

     [PATCH] Hugetlb: Copy on Write support
     
     Implement copy-on-write support for hugetlb mappings so MAP_PRIVATE can be
     supported.  This helps us to safely use hugetlb pages in many more
     applications.  The patch makes the following changes.  If needed, I also have
     it broken out according to the following paragraphs.


Confusing.

Locking the *old_folio* when calling hugetlb_wp() makes sense when it is
an anon folio because we might want to call folio_move_anon_rmap() to adjust the rmap root.

Locking the pagecache folio when calling hugetlb_wp() if old_folio is an anon folio ...
does not make sense to me.

Locking the pagecache folio when calling hugetlb_wp if old_folio is a pageache folio ...
also doesn't quite make sense for me.

Again, we don't take the lock for ordinary pages, so what's special about hugetlb for the last
case (reservations, I assume?).

-- 
Cheers,

David / dhildenb


