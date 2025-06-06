Return-Path: <stable+bounces-151614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5533AD0259
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E7A7A03F6
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E3D28853E;
	Fri,  6 Jun 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUhpu31R"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F42356B9
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749213492; cv=none; b=sUTBYSiMwWHA/ziAGXCKrfd11oL2Oi0wvD1R6Y4Ed0vLIPXhhrs26X+aJq5fglqcaOozqYUCEefWM3VoTSXJQrAscD69ayeh44PvuV795JF5+DnHYO/HqERhFD01VFKQAfg9kbhP/YoWEGK2Ots+4jZOK7WA8S/MY2BAToX17LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749213492; c=relaxed/simple;
	bh=76ceGAtoe6msQi7Co3W0+hpA8OF7n2ceHM3GHX4Q6is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snwA0ga1t/uJgAWjgbfQrlKUgGdHhRWc1ubRDsT3VyAob1gu7ky/IdRcn9l39Te+lAntV8eVg6QQ7v6Ppfe5jQzlXG2C7Y19cUNkBqBGTTfFR+jR/b4PZzF6awNYsxZZLv+uEUI8NqjzEOzNC/6BgWMUvPg6MYTVBX8njtdJrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wUhpu31R; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso9855a12.0
        for <stable@vger.kernel.org>; Fri, 06 Jun 2025 05:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749213489; x=1749818289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeOQnwFRu1+Kj/2MlWTCn9hMSyDZ7M1MsWilhgviDz8=;
        b=wUhpu31RUtz1dPzebSVTy51HPG9j7LqL71+XHHkMy+yHxg/W8zYQgKB6yofETPDUim
         HuQvAWWv6SqdXC/YFAetMG//HLMC5YuusLQ8iDEEKZ/Ysj2n7PQ6JvhNeLA9NHAz4QR1
         UOt5Wm8sIuqP11m846Gbrga9ocy1cPZQhQqFAryMNqE9wcgA7XaUs53yuUU5mYXZM7Ze
         WQy1qRiQ7VuCss563lp8CIuKjFLNIUjjkSBh2mDD4xnejoaffMU3rhRuMwvBeN2lPd4t
         M7JP25cBO+eK5suTBSs+s0lkNVjNvxKUw8e8ooSk//ATpCaEni2RQIZ1TE4xMr3HrZWL
         LJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749213489; x=1749818289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeOQnwFRu1+Kj/2MlWTCn9hMSyDZ7M1MsWilhgviDz8=;
        b=O7RzSjLnTwlyRQT+zCDuMsK2zSyyz7f4CskTxe9SvhdL6w6Vj7pMMCE1q6Z5TNfxt9
         7xpFz5sP1MhdcbQltQkPSG3oPqQMWOUGssh6gWxLnkMX2Kq/nS1N3Brn8L8dC7Ue/DqT
         CKiUmDFrvfZ0LFl395JeK0LQc34CNt4Pyhn3fs5UIWeL5mRZ1xn3V35fAsQ74kvF+ut1
         vm4Pj9tm0j5XyEfsWmuo+9FYDSfNvRjSBQXE+xjADm9HJOPMOuTORfqC/4iy00BvhJ3j
         fFR5qFofaJLE7dn6NCZA05yzPNjnaN9nayUWbt/R+VzohGI7ncd3xDDHs+jGTn3rJRsA
         eezw==
X-Forwarded-Encrypted: i=1; AJvYcCVE+noOWd6F0gigyserS5AGmJ8nmHKk3dr/Ndj2CQoI6rIE7o3ahxiqQOqIFCPDEKR8Z9DjAzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdDmHKDSxgK6BDSrx6Kdpl48HzSObRG1aLE8GJp6TE8xLNAfO
	Oq8fPHbUOIlwF4Bk9VanzEu9h0hsUDA2TToeYSE8ZY66NCrl9EyRVDY7f4Yja3aIwUWtcnxPUTi
	Ec1f2Nmn2IH27QappAO1tIXhakSA6MIBcYbHE8ZLl
X-Gm-Gg: ASbGncv59qJB1xUSdAQYE97XEnAAV1Mohi86dPS0pnonGXSieLQq2GUtSNcg9hdBxPB
	F2ql+0DzggCzgcBOZUvE4RyqxTBkPGgaVOR4WmmXjMFTUmQJLLBBg5B+UO6OEQiA0hDmjIt0sK8
	V7eZppRoYCtrCutu1Sc6cE7c7jKaqj9istZ7uNvYI8tiDfSwJxxrJFPxCnUA2UCUMUHhOjzg==
X-Google-Smtp-Source: AGHT+IE+fznf396DEdYbm7FDbiMqK8DD7+M7vFeKn4D5k96LIDFgmHNB35OHueWQZma6dil8qwRaIjQmLGcvzLI2aTE=
X-Received: by 2002:a05:6402:3887:b0:600:9008:4a40 with SMTP id
 4fb4d7f45d1cf-6077498ed18mr90476a12.4.1749213488536; Fri, 06 Jun 2025
 05:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606092809.4194056-1-ryan.roberts@arm.com>
In-Reply-To: <20250606092809.4194056-1-ryan.roberts@arm.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Jun 2025 14:37:32 +0200
X-Gm-Features: AX0GCFvlWBvUofLsMql7uPnqlPQ_I7AwEatSw2rWNXAV8LpXKA2kOKqETQmhfQc
Message-ID: <CAG48ez1VHfcTJNDLZcoupQBJQ5xpKzEMss8oBhmGYgHFidRU_A@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Close theoretical race where stale TLB entries
 could linger
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 11:28=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
> Commit 3ea277194daa ("mm, mprotect: flush TLB if potentially racing with
> a parallel reclaim leaving stale TLB entries") described a theoretical
> race as such:
>
> """
> Nadav Amit identified a theoritical race between page reclaim and
> mprotect due to TLB flushes being batched outside of the PTL being held.
>
> He described the race as follows:
>
>         CPU0                            CPU1
>         ----                            ----
>                                         user accesses memory using RW PTE
>                                         [PTE now cached in TLB]
>         try_to_unmap_one()
>         =3D=3D> ptep_get_and_clear()
>         =3D=3D> set_tlb_ubc_flush_pending()
>                                         mprotect(addr, PROT_READ)
>                                         =3D=3D> change_pte_range()
>                                         =3D=3D> [ PTE non-present - no fl=
ush ]
>
>                                         user writes using cached RW PTE
>         ...
>
>         try_to_unmap_flush()
>
> The same type of race exists for reads when protecting for PROT_NONE and
> also exists for operations that can leave an old TLB entry behind such
> as munmap, mremap and madvise.
> """
>
> The solution was to introduce flush_tlb_batched_pending() and call it
> under the PTL from mprotect/madvise/munmap/mremap to complete any
> pending tlb flushes.
>
> However, while madvise_free_pte_range() and
> madvise_cold_or_pageout_pte_range() were both retro-fitted to call
> flush_tlb_batched_pending() immediately after initially acquiring the
> PTL, they both temporarily release the PTL to split a large folio if
> they stumble upon one. In this case, where re-acquiring the PTL
> flush_tlb_batched_pending() must be called again, but it previously was
> not. Let's fix that.
>
> There are 2 Fixes: tags here: the first is the commit that fixed
> madvise_free_pte_range(). The second is the commit that added
> madvise_cold_or_pageout_pte_range(), which looks like it copy/pasted the
> faulty pattern from madvise_free_pte_range().
>
> This is a theoretical bug discovered during code review.

Yeah, good point. So we could race like this:

CPU 0                         CPU 1
madvise_free_pte_range
  pte_offset_map_lock
  flush_tlb_batched_pending
  pte_unmap_unlock
                              try_to_unmap_one
                                get_and_clear_full_ptes
                                set_tlb_ubc_flush_pending
  pte_offset_map_lock
[old PTE still cached in TLB]

which is not a security problem for the kernel (a TLB flush will
happen before the page is actually freed) but affects userspace
correctness.

(Maybe we could at some point refactor this into tlb_finish_mmu(), and
give tlb_finish_mmu() a boolean parameter for "did we maybe try to
unmap/protect some range of memory"; just like how tlb_finish_mmu()
already does the safety flush against concurrent mmu_gather
operations. Maybe that would make it harder to mess this up?)

> Cc: stable@vger.kernel.org
> Fixes: 3ea277194daa ("mm, mprotect: flush TLB if potentially racing with =
a parallel reclaim leaving stale TLB entries")
> Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Jann Horn <jannh@google.com>

