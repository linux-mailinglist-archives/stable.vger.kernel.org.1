Return-Path: <stable+bounces-36291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4EA89B3CA
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 21:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FB31F21A86
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E96B3D3A2;
	Sun,  7 Apr 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itvcH/o/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41C39FF3
	for <stable@vger.kernel.org>; Sun,  7 Apr 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517607; cv=none; b=TfzWmwkCRHaRBpNWyGO+6o5GA6Qz9b9BbIJX9JNGF4o/yQ1mRhrs3vsvgVuFw1D+eY1mcszpayHTBe8cBYpqlpUO9HKrl37TcXOvccvCY8VK2dpd0X8ph0KHAno4OeBuMmYsWeIacFSw15ZhlZ0Q29Q4iIykLcStV11P70uqSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517607; c=relaxed/simple;
	bh=yKUf9+eI9dHg7NMd2gkSCi29eY0g+VVpaWcKMEypZ50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA0I3yoPJ2kjwMB4X7l0nf8DLMYOGXR7fqsaCReWXxRdmS5a3cIODL/lvb19arRQaeN5aakJaMzvGzDRUdtg/hOIOI0SF57gbg/BrdA78B10qNr9DP+zdsAcjNTv+zXN+OLwgviRyej2rT+Qo+GzJ1+AT6YaJEAVCWuBmnlHboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itvcH/o/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712517604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epmQzRcGvXH7QxC5v7WEbN06GWyO/3oH4p1c8L2F2xA=;
	b=itvcH/o/mX1rb0jBNgEpD3Jrw24ZOZ1CBw52kpj9PAv3fs1suCKcvlgT2LIBN0AY4ZOnTW
	+EulL+6vdvtxGocQH1ktCC0nF3nsTY+sWHuUV5xstdxEC7oQgjbdmPRSun9Msh93o0k3+2
	220765E5RWv481TqBHI33tZCU3/UyZs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-XbvQ2nB2OpyrvjoT4j40Ow-1; Sun, 07 Apr 2024 15:20:00 -0400
X-MC-Unique: XbvQ2nB2OpyrvjoT4j40Ow-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-699133268a7so2275406d6.1
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 12:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712517599; x=1713122399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epmQzRcGvXH7QxC5v7WEbN06GWyO/3oH4p1c8L2F2xA=;
        b=QhPhFR1yuCLaQHvnQ9u9IMnDln5dXyHXe2gzAyrVgnMDcRgrG5w+eo9zGnx+M9/tq5
         OHaLWOz8w22r1/UObmZ930UxaGtc8xb7vnVFzK6e51yMObHFY/Sv8bkbp8aqtj6XR1gZ
         vrDXj7bZ70qq7Lnj6HeQlqgv//sPG8pZgGxtghmX5eVv19ktQFj/cew+br5v/n2kbsiE
         ZWnN1S9onnvA9HaiMSuxRFukRA1WeZwvJFpHFJQAuFbcztzyQasC/+lBEYqdckn7/teb
         iE7Rgw1SyfV4nb14xzcrDBldeXL5CMgMGjt5MWyARCMW6E93b2xjQYJlx+DA0BQCn0hE
         GEnA==
X-Forwarded-Encrypted: i=1; AJvYcCXrqhDFyx92Hllpo7g2U4uxHgZTkm08YR2IHeJFwlAF4e0YAVFHYwWJYGLgX0V3KtMvN1Spy8GEiuIaVX9dLFje5HaRpIKR
X-Gm-Message-State: AOJu0YyepwL+0ZxqBn6waoLmvUabDfZHqq1tZalMiKPC1i5BcwPw/9GY
	4rNY+5HViJUmKnJ2VTvqtD73I/Z3ydpoMVaKWnKLINypKlJJpVopiyGi+40j0fY5+RFbZajdZi4
	hxAplmS6NmAUobaIocL4uw7ZS6WzNiO8hxJBozZAnjDX6BEOnTjc9xg==
X-Received: by 2002:a05:6214:2408:b0:699:2d88:744f with SMTP id fv8-20020a056214240800b006992d88744fmr7791719qvb.4.1712517599496;
        Sun, 07 Apr 2024 12:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdyfcCTiDHVrnBYdH/QV6bU53cJSUCzy2yWOpLwTRXIDtNac8PNjf55b5kNOa6A1BTkng8Qg==
X-Received: by 2002:a05:6214:2408:b0:699:2d88:744f with SMTP id fv8-20020a056214240800b006992d88744fmr7791699qvb.4.1712517598978;
        Sun, 07 Apr 2024 12:19:58 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id do18-20020a056214097200b0069942d4cc06sm2111164qvb.115.2024.04.07.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 12:19:58 -0700 (PDT)
Date: Sun, 7 Apr 2024 15:19:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm,swapops: Update check in is_pfn_swap_entry for
 hwpoison entries
Message-ID: <ZhLx3fwzQNPDbBei@x1n>
References: <20240407130537.16977-1-osalvador@suse.de>
 <ZhKmAecilbb2oSD9@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhKmAecilbb2oSD9@localhost.localdomain>

On Sun, Apr 07, 2024 at 03:56:17PM +0200, Oscar Salvador wrote:
> On Sun, Apr 07, 2024 at 03:05:37PM +0200, Oscar Salvador wrote:
> > Tony reported that the Machine check recovery was broken in v6.9-rc1,
> > as he was hitting a VM_BUG_ON when injecting uncorrectable memory errors
> > to DRAM.
> > After some more digging and debugging on his side, he realized that this
> > went back to v6.1, with the introduction of 'commit 0d206b5d2e0d ("mm/swap: add
> > swp_offset_pfn() to fetch PFN from swap entry")'.
> > That commit, among other things, introduced swp_offset_pfn(), replacing
> > hwpoison_entry_to_pfn() in its favour.
> > 
> > The patch also introduced a VM_BUG_ON() check for is_pfn_swap_entry(),
> > but is_pfn_swap_entry() never got updated to cover hwpoison entries, which
> > means that we would hit the VM_BUG_ON whenever we would call
> > swp_offset_pfn() for such entries on environments with CONFIG_DEBUG_VM set.
> > Fix this by updating the check to cover hwpoison entries as well, and update
> > the comment while we are it.
> > 
> > Reported-by: Tony Luck <tony.luck@intel.com>
> > Closes: https://lore.kernel.org/all/Zg8kLSl2yAlA3o5D@agluck-desk3/
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")

Totally unexpected, as this commit even removed hwpoison_entry_to_pfn().
Obviously even until now I assumed hwpoison is accounted as pfn swap entry
but it's just missing..

Since this commit didn't really change is_pfn_swap_entry() itself, I was
thinking maybe an older fix tag would apply, but then I noticed the old
code indeed should work well even if hwpoison entry is missing.  For
example, it's a grey area on whether a hwpoisoned page should be accounted
in smaps.  So I think the Fixes tag is correct, and thanks for fixing this.

Reviewed-by: Peter Xu <peterx@redhat.com>

> > Cc: <stable@vger.kernel.org> # 6.1.x
> 
> I think I need to clarify why the stable.
> 
> It is my understanding that some distros ship their kernel with
> CONFIG_DEBUG_VM set by default (I think Fedora comes to my mind?).
> I am fine with backing down if people think that this is an
> overreaction.

Fedora stopped having DEBUG_VM for some time, but not sure about when it's
still in the 6.1 trees.  It looks like cc stable is still reasonable from
that regard.

A side note is that when I'm looking at this, I went back and see why in
some cases we need the pfn maintained for the poisoned, then I saw the only
user is check_hwpoisoned_entry() who wants to do fast kills in some
contexts and that includes a double check on the pfns in a poisoned entry.
Then afaict this path is just too rarely used and buggy.

A few things we may need fixing, maybe someone in the loop would have time
to have a look:

- check_hwpoisoned_entry()
  - pte_none check is missing
  - all the rest swap types are missing (e.g., we want to kill the proc too
    if the page is during migration)
- check_hwpoisoned_pmd_entry()
  - need similar care like above (pmd_none is covered not others)

I copied Naoya too.

Thanks,

-- 
Peter Xu


