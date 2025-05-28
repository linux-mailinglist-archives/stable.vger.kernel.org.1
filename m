Return-Path: <stable+bounces-148000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFAEAC71F3
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 22:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965C3188A28B
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 20:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E981220F55;
	Wed, 28 May 2025 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XycRLVnL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAC220689
	for <stable@vger.kernel.org>; Wed, 28 May 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748462462; cv=none; b=dBQ87sXTQBaTSZSx5uKgnNiGacpY098uByAy1C13Xyn6Ustmt51SeEuuMQhHaOsXgczBDMnFQgpjrmQfFIeuYfCUmRo7Mvqwt/LEYFByWNmleSPfFOx6xO0iVN08ACjflyW8CNQx5Xhe1CwC137HRCE205ajxvSLtVzoG6C4LRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748462462; c=relaxed/simple;
	bh=KqrLmv35uoKda9csT1p9zJ9SSwocl++gGV7O1tqD2og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuFfA24fk1QvQ3Lbsn5rI/FJ6W7WxanWAcKyM+TVnjroI1ovHK9o7gEWBy7b6Z7rVnyoPB1pLSV257giWIWulT4hiQy68UWJK8PrNyjNLQfD5XCEWTO+fxhus0Ja55zP5hWMF92KAWmzk1o4HpJhBJCM2P2MT5rUwQcKFu7MyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XycRLVnL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748462459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=93E838XESEujavn6CtgRlZj0LiotNbJUH5vfb4rXjr0=;
	b=XycRLVnL/zHiDXCDfrr5f+22nKUdDMZwrxYcnagN7do2vPqo44iNOvzNCP1wnV48M/h8UK
	OvZbVa9wyMJP7uGEEhsnpmDP1DhAaHQoU7OcgrE+H26AdSIz97D/r+VspKuO8Kz6ozUYCY
	ZUVvYlVoKCxiIY1fevX5N80FGW9DuCg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-dPrcTRl-Pb2aPCN0-6pWbQ-1; Wed, 28 May 2025 16:00:55 -0400
X-MC-Unique: dPrcTRl-Pb2aPCN0-6pWbQ-1
X-Mimecast-MFC-AGG-ID: dPrcTRl-Pb2aPCN0-6pWbQ_1748462454
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eb9c80deso117658f8f.0
        for <stable@vger.kernel.org>; Wed, 28 May 2025 13:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748462454; x=1749067254;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=93E838XESEujavn6CtgRlZj0LiotNbJUH5vfb4rXjr0=;
        b=gNQASPmGm3XtcDdFEMkrGR2+v1UPlpG5W1+l7DMJeqdI0nSeUV0xGXDJIkBmgLVL9c
         c/bR2/23Njx6b8O4MLGMlx5kZ2u5SZP993dAFlvXnay/dM0bbNXMxBiWK955+LT9eRLl
         J4+cTxeWAcBKjrplKJVn5qTW+LnXUOyxx9rH+J4No1UCYwR1Hk8VYGtc/g0Q8/XenbW8
         6DWPVxUX1lTMhDro9JkxQP6KPViRIPNyQJHee9unW48k9c+yzXlOUL1FvCN6MvgIeGOl
         j0ru8uie37oJOYf2Ijh4But+kugzb+VsF96oW4N7MFQCBaX57mvggjc/skXcVvIc7a2d
         SFTA==
X-Forwarded-Encrypted: i=1; AJvYcCUIFBbilBNr5v/YK0ymQ1oC04dVDoyOKZh2o0P27trAi4SiAuif0gk+bYzs3HLwG/szvuXXWv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXHaaFgzulbI+EM+NcnFFliFmU98HwDVxDO4d/5L3TNDc1q9hq
	c49dOwa3+C1M4DVrPwyXxRRNGtFAfzVtiMAy1VZ7CVmQsrJwA8xCR6iGjPoQW9X3W+hiHmjZUFt
	OmWmxhsGRnCL/o1b4c8DA3TjGjQCa/bGpzKpx3uMH1q2ipp8ZMCPHlTjuZQ==
X-Gm-Gg: ASbGncvRrGsAtMIqn16Widc8/T0A2/bVpBelBukcmwWSDWtdXp1vUhqCiovUkXJwCNG
	SwBcsi4FfLh7Hq1s5AkVSlzyPHwribILYNsfb9ABw2yM0r0fUtj/ubzV0ibs2d/2zRlVNAOHjh1
	6K8bIpPzLHewguUNKZ6qMPUohihnowJolC4roGCznPcJy+Znb3dqJVRwX213Jabkzo9bZOMsPkN
	jqt/Vax5I4vWaU88EPmDyIdCXskV3swRkJLr0bKBKDpFVGqIG/VVWXDIgCACgPWiW7yGY+iW5tp
	fPAnhBEHcPU6/eTST/rFoKuBeUp3QfuRXPFaZlUmj9XH3buqGuOfiPk4KNM/rOHkDFlcgtPBTiT
	thtukzuePrz+GDVJ9YnY3UA+ORTdDXNJAHLc4eTs=
X-Received: by 2002:a5d:5f8b:0:b0:3a0:bad4:1247 with SMTP id ffacd0b85a97d-3a4cb43214amr14077332f8f.15.1748462453912;
        Wed, 28 May 2025 13:00:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBqsLwtFcwOenCmYLpxNpkEXnrA8AqUwB7ajvLJSL+i9CQyVRLcPLGZQcSU4LE00ooD3Gfig==
X-Received: by 2002:a5d:5f8b:0:b0:3a0:bad4:1247 with SMTP id ffacd0b85a97d-3a4cb43214amr14077297f8f.15.1748462453524;
        Wed, 28 May 2025 13:00:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eace3278sm2272546f8f.88.2025.05.28.13.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 13:00:53 -0700 (PDT)
Message-ID: <4cc7e0bb-f247-419d-bf6f-07dc5e88c9c1@redhat.com>
Date: Wed, 28 May 2025 22:00:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aDcvplLNH0nGsLD1@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 17:45, Oscar Salvador wrote:
> On Wed, May 28, 2025 at 05:09:26PM +0200, David Hildenbrand wrote:
>> On 28.05.25 17:03, Peter Xu wrote:
>>> So I'm not 100% sure we need the folio lock even for copy; IIUC a refcount
>>> would be enough?
>>
>> The introducing patches seem to talk about blocking concurrent migration /
>> rmap walks.
> 
> I thought the main reason was because PageLock protects us against writes,
> so when copying (in case of copying the underlying file), we want the
> file to be stable throughout the copy?

Well, we don't do the same for ordinary pages, why should we do for hugetlb?

See wp_page_copy().

If you have a MAP_PRIVATE mapping of a file and modify the pagecache 
pages concurrently (write to another MAP_SHARED mapping, write() ...), 
there are no guarantees about one observing any specific page state.

At least not that I am aware of ;)


> 
>> Maybe also concurrent fallocate(PUNCH_HOLE) is a problem regarding
>> reservations? Not sure ...
> 
> fallocate()->hugetlb_vmdelete_list() tries to grab the vma in write-mode,
> and hugetlb_wp() grabs the lock in read-mode, so we should be covered?

Yeah, maybe that's the case nowadays. Maybe it wasn't in the past ...

> 
> Also, hugetlbfs_punch_hole()->remove_inode_hugepages() will try to grab the mutex.
> 
> The only fishy thing I see is hugetlbfs_zero_partial_page().
> 
> But that is for old_page, and as I said, I thought main reason was to
> protect us against writes during the copy.

See above, I really wouldn't understand why that is required.

> 
>> For 2) I am also not sure if we need need the pagecache folio locked; I
>> doubt it ... but this code is not the easiest to follow.
>   
> I have been staring at that code and thinking about potential scenarios
> for a few days now, and I cannot convice myself that we need
> pagecache_folio's lock when pagecache_folio != old_folio because as a
> matter of fact I cannot think of anything it protects us against.
> 
> I plan to rework this in a more sane way, or at least less offusctaed, and then
> Galvin can fire his syzkaller to check whether we are good.
> 


-- 
Cheers,

David / dhildenb


