Return-Path: <stable+bounces-151616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCF3AD0284
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28A318921BA
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09C1ABEC5;
	Fri,  6 Jun 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xEYH2/qf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFEF9EC
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214183; cv=none; b=BFxwUSzpxzPelL6R1kQnYXHP+gb6worZk12T23ZLBwRQ+pGQeuP3uqIiB56nOQq2iiWE2i0YWc5RHi0nxWtDVmiLJ/ylHhsxvSReYJ4VAs9eXe12O7lU+Kif3DqEOA57JopKqiV3F04bNMPOa/7uqa4AR2Uw6cM6eDpN2ofSINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214183; c=relaxed/simple;
	bh=Kl162rCV+ypEM/wfn7pzFhevVmvQmQXR77cvA0nqf9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPG16bTRVBKmT1roGkolUjgPBa3I+QVrzIOMQXoWBM5m9XEzXfNDfHVEuQSIU4hUU7XBYXaD0U0pYvDpeMC5+ZCMqaQ/j4DZ81sAj/OQx3Hx+/lLa247Wf+yIha3wh93LbCaAL6bLigUvRxB4CS8bMnqayZwBBNT4f3lH5UrOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xEYH2/qf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso9921a12.0
        for <stable@vger.kernel.org>; Fri, 06 Jun 2025 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749214180; x=1749818980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT+AT6MqsJ3M+MYT3uZEthRD6VpQnEM0vp9KYd7MzOw=;
        b=xEYH2/qf1sHLXnOM81CDAF563Fwd1m4Nikqw992j5v+bP4mDVuri3cRtaHhTnQhnlO
         A4qUsVfNATAh3cxDfsIjD6KlnSlSEWRo0HcStf+4npQvreyRKUXjKYxsABx6zzWMw6Mz
         oywWwF4Fei1EE5QIdj0NoVqDa8p+g3ngN0C0yw1Gv4+ea1XFgGxmp4J6HwfR+quax+RS
         WHqEX3je4nSVb7+gXFcVMHX6rpszDKLPekJEMk95CxDHcPkJ/pI60b4yiXC73/dfatc/
         cRKELom3GnuDSZdiWka9YNwtisu+ct2YGQl0aTDt5fgsqphzDj9lak0vLQTn1ubBvFdm
         +hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749214180; x=1749818980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT+AT6MqsJ3M+MYT3uZEthRD6VpQnEM0vp9KYd7MzOw=;
        b=VAT2iJ2wtQduB41dmU7Xmdh15mTZIIfaPk6CLVIMHSWStpTT/p3M/DVLsRNLLr4nZi
         RyCPTi+nbHtm9/5zaZEhFf9CAcLsUMmgr63LEM4Z/J/033+2t/Gw+ZpkorthFSWFaMrI
         ezSFwnU9fyrB/zuVpygfJaddhYifUYXwOUsbHhuOuok81ZgWArEplqHj7WIV04KFFiI1
         NcmV/yIformOH+wsjUKJQ72laTcD9C6ACT06LeaJloMeQ5q2NDihht67UoQ3VgPgT72o
         xnnTQova30q9cab6oHXAVasbctRI+0LNV3h+bq+O6jZKHPkx39vuwyhi1dNCfWlhfCTb
         emuA==
X-Forwarded-Encrypted: i=1; AJvYcCUyvyrRbOWXC7OUDBdzV+1kaL2zgy7qJqUCvP1+CVN/wpk3eYpE42A2OARCNbbiHrkdTiujEP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZrVz47/a84n6H11IBOmV4ROzRye9g0fTRqJABZOB3FRk5xI1
	wx6oHNKfLqDWV4xZCetKuN/eYqq/82D7X1133pybF2QLEYl0/OG9OFhYHdiXNoRJGItFDKQGt76
	9ElORXBPIOKfnesUKZM3Rz8H8gzzyUXiUwvqQ0KLw
X-Gm-Gg: ASbGncu8diCU2KUNSfGG3ezrWR0luhY9PUGzxI6pe7pOP6q/1Of0u/rE8sERXZYYYmj
	f1kfAw+CSjRZ5eMXK6MTOogOMkC76wZGZsYesRY4YO16AkYqTO4n9rr1fYrzRZFT9GeVITck+X5
	cn/ZWWg8Ydo0uPDNR25fuoI7/5HEKB/HYfGsgnGwUoxretINd0kLJsFG8FBjNHyanryr8Elml7o
	kpOqU9f
X-Google-Smtp-Source: AGHT+IEj+Za0UCwvZRT2mQseG+6UqOCA9QEGxUq6fGXHr3bK5GUTUQ0XMmeQy0xVJPsfoDBqZGJWVfK2y2vy3sqMkxY=
X-Received: by 2002:a05:6402:344:b0:606:9166:767 with SMTP id
 4fb4d7f45d1cf-60773eca718mr76167a12.2.1749214179846; Fri, 06 Jun 2025
 05:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com> <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
In-Reply-To: <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Jun 2025 14:49:03 +0200
X-Gm-Features: AX0GCFt0UyWLtHOJ7Xl9oT_PxdylGZdccUKq5b21dR__hVZmMxZwE8eGyyenLKQ
Message-ID: <CAG48ez0eGkBCNSy1Lp7Fz41uyQym0UMvik9vVVjD1GKGhvGpqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory snapshot
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:21=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> @@ -917,7 +917,25 @@ copy_present_page(struct vm_area_struct *dst_vma, st=
ruct vm_area_struct *src_vma
>         /*
>          * We have a prealloc page, all good!  Take it
>          * over and copy the page & arm it.
> +        *
> +        * One nasty aspect is that we could be in a multithreaded proces=
s or
> +        * such, where another thread is in the middle of writing to memo=
ry
> +        * while this thread is forking. As long as we're just marking PT=
Es as
> +        * read-only to make copy-on-write happen *later*, that's easy; w=
e just
> +        * need to do a single TLB flush before dropping the mmap/VMA loc=
ks, and
> +        * that's enough to guarantee that the child gets a coherent snap=
shot of
> +        * memory.
> +        * But here, where we're doing an immediate copy, we must ensure =
that
> +        * threads in the parent process can no longer write into the pag=
e being
> +        * copied until we're done forking.
> +        * This means that we still need to mark the source PTE as read-o=
nly,
> +        * with an immediate TLB flush.
> +        * (To make the source PTE writable again after fork() is done, w=
e can
> +        * rely on the page fault handler to do that lazily, thanks to
> +        * PageAnonExclusive().)
>          */
> +       ptep_set_wrprotect(src_vma->vm_mm, addr, src_pte);
> +       flush_tlb_page(src_vma, addr);

Hmm... this is actually wrong, because we did
arch_enter_lazy_mmu_mode() up in copy_pte_range(). So I guess I
actually have to do:

arch_leave_lazy_mmu_mode();
ptep_set_wrprotect(src_vma->vm_mm, addr, src_pte);
flush_tlb_page(src_vma, addr);
arch_enter_lazy_mmu_mode();

(arch_flush_lazy_mmu_mode() would look a bit nicer, but powerpc
doesn't implement that.)

