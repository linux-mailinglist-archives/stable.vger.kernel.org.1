Return-Path: <stable+bounces-94526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 799739D4E88
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 15:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A06B2163B
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674A1D3593;
	Thu, 21 Nov 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klmx4jTI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A379433D9;
	Thu, 21 Nov 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198703; cv=none; b=aTGafalCcgHpZomvab/1U0J4Rce7dne5Mn580fc51YxOelfc3ymYnNKMBd91yNQo5mA5LlR4YkZd3ylFSI0sP4t/OZKiuPoz7eLyuMVh2Sx5/VaJ+4gfdkhHNS1OFuoG3I2JOlXEnP2QL+QigGr/1DJRt1wIIio8Gc2E1y7OkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198703; c=relaxed/simple;
	bh=ZUMsJx+5O8f/eLQMDGl/N2/wmI/7flRQsYvpNlQOEC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJQo5xAOjpEbGID6Sb4jzcgtEGHq95QHb4A2j3ncIxAqmIBNrF4qoKLKKfCmqDmtgzDWi4LkCLmjLHnYOnwzvJnMPxVaHnzeH0eUGbcKIqhhC+U5xkdh3e7iJNJonIDLkVXQuzUGmoiEmjSUnq5D1Q/CdQndNPT2a31Df6SLXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klmx4jTI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso769563a12.1;
        Thu, 21 Nov 2024 06:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732198701; x=1732803501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CALR2H2D3U/mYafWaLcVRPmC0di/XIaiP/+GiuvQ46Q=;
        b=klmx4jTITRJ45x7jdxqmvsWZKsR3WpOBCqETuJXf5mR9RBu4vCMaqf8AHNTqMpG6iD
         3kPrmGDMcYqq4l2FjA/AKhvrnvOQ0SqG//o7j+/IOUUsmNxvVM/gvdWnkTIekyYr5g47
         9JGONGlHwi4IE/QqDtaWMYtoAVOcweHXtw2jkEbq/os7iKtTy1N9098NuI+gGkGQtivT
         5okC2xGDjswT2hBWD37BfMsuBZcdaAKK2poMeVg9mxRwI3sDsKDLbl87uTZWx+wHmyRO
         9/nTdHL3SvVjjqtcc9l7eyW4jwCJWyfgsb0u253Z+s10aRd0i0t488/X7jamgIul0J4e
         CTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732198701; x=1732803501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CALR2H2D3U/mYafWaLcVRPmC0di/XIaiP/+GiuvQ46Q=;
        b=FTq8NTxooi3bLjBFlnQnr79vmLu4x99uSR7CilSOV8y++UyvY1D6BIfPrPmspzGhpc
         9oKMA5rp9R9BEm771RgkbQu4oBMn40o+QAl4L4mkfqGzyR6PXOx2RN0SsIUR39AZlgAK
         mrYxB64FlcPGxZbGDCXTe/QgltnE3FLYyReaPavticNDvCvs7w/kPPPtAEuIfyKLRHaD
         6kyRBYyX8LwE81oJKfB96aKLD9EnhZmHtRtjjj1n8s7jr4zXlmh6MHFpXXRhCOJtmdtr
         S8O2aDYxsQca9a3NMG6pWBxvAU8V+Y/7mAZl5Ohiq2DJiNsbif4GQ2QxN4eXvdZPjCOl
         TPNA==
X-Forwarded-Encrypted: i=1; AJvYcCVVBuMk/jnKGRsM1zndZHcvWa12Vg8SckeROW/S0q8lbXI3yqXuNM76rBeebVnk/ncyUFG5X33+@vger.kernel.org, AJvYcCWu4PCsWKmrZ9G2xbUl9v5Q/+KFHopM3vN4RngsYTTSo6FOIUTAqux9BcdV+XNjDIbboVShmRRumTBZn2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mvvdA4g+sBT9fo/d/nzdLZfqT0o/4YaYsbxLvtBOubThsdbH
	qGgzrVxnUkDd3ai9rusoffkkYUF/cV4Zs2590nchdMIG5KokJ83DI/KoWZVNItKL/H8UpaAaP7S
	9zPzA4/U2UkocIP0Da7ZLz6OidE8=
X-Gm-Gg: ASbGncteyai3VywgVkKnYsL/hp1Ygd+SUPeKwo02rFEgZ2Knmf72psbOjgfdfBxCE5t
	AF3eLhNX5NsoTXlG2HAeTkydQOz1qy+zHsg==
X-Google-Smtp-Source: AGHT+IF6cviDJenkMJV9ucQ1uvKXIxjAuYkLgfqhfhoGebSGpWKKCIG8IV0WPgRrVISfm4ttZcsY3HS0egDnHFDyrto=
X-Received: by 2002:a17:90b:17c3:b0:2ea:7752:d5e4 with SMTP id
 98e67ed59e1d1-2eaca709ca6mr8700345a91.15.1732198701486; Thu, 21 Nov 2024
 06:18:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121124113.66166-1-aha310510@gmail.com> <26b82074-891f-4e26-b0a7-328ee2fa08d3@redhat.com>
 <25ead85f-2716-4362-8fb5-3422699e308c@redhat.com>
In-Reply-To: <25ead85f-2716-4362-8fb5-3422699e308c@redhat.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 21 Nov 2024 23:18:12 +0900
Message-ID: <CAO9qdTE8WO100AJo_bgM+J5yCpTtv=tRniNV2Rq3YAwQjx3JrA@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory: Fix to make vma_adjust_trans_huge() use
 find_vma() correctly
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, dave@stgolabs.net, willy@infradead.org, 
	Liam.Howlett@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

David Hildenbrand <david@redhat.com> wrote:
>
> On 21.11.24 14:44, David Hildenbrand wrote:
> > On 21.11.24 13:41, Jeongjun Park wrote:
> >> vma_adjust_trans_huge() uses find_vma() to get the VMA, but find_vma() uses
> >> the returned pointer without any verification, even though it may return NULL.
> >> In this case, NULL pointer dereference may occur, so to prevent this,
> >> vma_adjust_trans_huge() should be fix to verify the return value of find_vma().
> >>
> >> Cc: <stable@vger.kernel.org>
> >> Fixes: 685405020b9f ("mm/khugepaged: stop using vma linked list")
> >
> > If that's an issue, wouldn't it have predated that commit?
> >
> > struct vm_area_struct *next = vma->vm_next;
> > unsigned long nstart = next->vm_start;
> >
> > Would have also assumed that there is a next VMA that can be
> > dereferenced, no?
> >
>
> And looking into the details, we only assume that there is a next VMA if
> we are explicitly told to by the caller of vma_adjust_trans_huge() using
> "adjust_next".
>
> There is only one such caller,
> vma_merge_existing_range()->commit_merge() where we set adj_start ->
> "adjust_next" where we seem to have a guarantee that there is a next VMA.

I also thought that it would not be a problem in general cases, but I think
that there may be a special case (for example, a race condition...?) that can
occur in certain conditions, although I have not found it yet.

In addition, most functions except this one unconditionally check the return
value of find_vma(), so I think it would be better to handle the return value
of find_vma() consistently in this function as well, rather than taking the
risk and leaving it alone just because it seems to be okay.

Regards,

Jeongjun Park

>
> So I don't think there is an issue here (although the code does look
> confusing ...).
>
> Not sure, though, if a
>
> if (WARN_ON_ONCE(!next))
>         return;
>
> would be reasonable.
>
> --
> Cheers,
>
> David / dhildenb
>

