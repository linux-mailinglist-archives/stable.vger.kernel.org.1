Return-Path: <stable+bounces-87775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D175A9AB72E
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 21:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930C2285064
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBC91CB311;
	Tue, 22 Oct 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvgVpv4Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B417C98
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626779; cv=none; b=qxsSJirBrdzzSSls8b+r1RrGLfM5mVw2tJmjNmZKQpEWACHjxB7JeEF+wj1HfLh9H0XMiwPYfl/aCssQwSDcOl2oTPzoIC8ZOua3Tczj7O2hDdNMcjjy9yspeVdviVqUweHfQbRIYfXrKJbjH64c3LiAfzNIQ12sSJ8aeEZ8D0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626779; c=relaxed/simple;
	bh=900jALxWYVLS8Z+BChGV7e1343M0eNmQQ/AjG1m8sVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BmqNbpctTnf8cefYCxA2iwZdA3rAU0y/rojg9LFPlnSVZxzuH/2ghr/DCpzVL7pIulLZHhyDrJYSttT/DK0nP+uGC2/3QSE9bqD48VuIyvpNSgvdBtHiKIotyUcm+DO3jRY0tGFC7oT3ycWkcD+pZ5eL98XyAn4+jAQdDGnf7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvgVpv4Q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35199eb2bso112687717b3.3
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729626776; x=1730231576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+SI51bEi1jKFAwZYIZIZnZEYLQDC0ghYZ/VkhDOKRw=;
        b=kvgVpv4Q1LpCe1Tv/iDrc/0DEkCJjWZg7CJTnSvMMMTzl7sirwPFXoZ9U6WrT5nkGM
         3cwQijCaZqSwdLd11FMFSksqkwgEjh05jIoAiZsQG1JEPfagurmEHaU2K/UABYwL4/N/
         f/z/7dyIcVl6htI0RKbqj4ZFAQr0NEXAVliu7E7BuD8gqXt+Gg2/Qo2UakVPlLd/hU9y
         W4AXMBQ5xRJw3Csl0G+7OfrvOOQnMB5ZeRcWzsMOFncn9my7wNiHIXoXCBihScfxpUUB
         mXLLOZicMT+N7eQKmc5H/nAn/T3uNDQgtVlo8lgR8LmA9FMS23c/B3xb6/4CloqfPGph
         c9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729626776; x=1730231576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+SI51bEi1jKFAwZYIZIZnZEYLQDC0ghYZ/VkhDOKRw=;
        b=kyZjgs/qbOzg9KYSZ6gzohlhBfjr7nsEzHbOt55s6MtdlH7BV7ogUsADMHm6Vf3/8B
         E6q0rliBQ4q2FIuRMeDQEqFaFPAAWJF2bfcbvjYZZIFnHT0o2OfCUoTl/el3qW48BQVM
         2I/XtnRGUbGYTTNUES4MoteKMbvHYsuxs0tRsR0IM6Ew+igJip0G3sYcD9T32SBI6Tcf
         mySEKtXqQh0+TtOlPd7y3MiYeSHHsd8VADelyA84ScC64qZT80oE+GbxSVvhVITW2QHZ
         nOmEgewM0+HMUt0LY73PQlESCKxO+NrMI43loEp59mvygLPyc13c01er1uquO7D7cICm
         2tkw==
X-Forwarded-Encrypted: i=1; AJvYcCXj0z9vDez+0ZzBpEdtkTgDrRXm0IlqBUqbc0lr+qJUvxsdEZUvEvItD3UsP6+AOy4GyjhyxoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74VvT1Gt/a8zUUG9icF8XofWJVpBmq3DtHZt+opdwv/L5s7UU
	RmGAcfL5l5k9pma2Una8y76IKt/LixyEQQsYugx2q/ikgW+fQRmBno2AdiAdy+T1bmrqlanFLET
	2fw==
X-Google-Smtp-Source: AGHT+IEwPnDeQbkgHiRpbdb78i0IZVB0bvSwR5nuQygXUzqVgLEvYnoLPehcPVfIe+hCt8gRKA6p7HNV+TE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1818:b0:e2e:3131:337f with SMTP id
 3f1490d57ef6-e2e3a624ed7mr37276.4.1729626776174; Tue, 22 Oct 2024 12:52:56
 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:52:54 -0700
In-Reply-To: <ZxfZ_VSeOo2Vnmmg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <Zxa60Ftbh8eN1MG5@casper.infradead.org> <ZxcKjwhMKmnHTX8Q@google.com>
 <ZxcgR46zpW8uVKrt@casper.infradead.org> <ZxcrJHtIGckMo9Ni@google.com>
 <CAJD7tkb2oUre-tgVyW6XgUaNfGQSSKp=QNAfB0iZoTvHcc0n0w@mail.gmail.com>
 <ZxfHNo1dUVcOLJYK@google.com> <ZxfZ_VSeOo2Vnmmg@casper.infradead.org>
Message-ID: <ZxgCllkf_vka3sM-@google.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into free_pages_prepare()
From: Sean Christopherson <seanjc@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 22, 2024, Matthew Wilcox wrote:
> On Tue, Oct 22, 2024 at 08:39:34AM -0700, Sean Christopherson wrote:
> > > Trying to or maybe set VM_SPECIAL in kvm_vcpu_mmap()? I am not
> > > sure tbh, but this doesn't seem right.
> > 
> > Agreed.  VM_DONTEXPAND is the only VM_SPECIAL flag that is remotely appropriate,
> > but setting VM_DONTEXPAND could theoretically break userspace, and other than
> > preventing mlock(), there is no reason why the VMA can't be expanded.  I doubt
> > any userspace VMM is actually remapping and expanding a vCPU mapping, but trying
> > to fudge around this outside of core mm/ feels kludgy and has the potential to
> > turn into a game of whack-a-mole.
> 
> Actually, VM_PFNMAP is probably ideal.  We're not really mapping pages
> here (I mean, they are pages, but they're not filesystem pages or
> anonymous pages ... there's no rmap to them).  We're mapping blobs of
> memory whose refcount is controlled by the vma that maps them.  We don't
> particularly want to be able to splice() this memory, or do RDMA to it.
> We probably do want gdb to be able to read it (... yes?)

More than likely, yes.  And we probably want the pages to show up in core dumps,
and be gup()-able.  I think that's the underlying problem with KVM's pages.  In
many cases, we want them to show up as vm_normal_page() pages.  But for a few
things, e.g. mlock(), it's nonsensical because they aren't entirely normal, just
mostly normal.

> which might be a complication with a PFNMAP VMA.
> 
> We've given a lot of flexibility to device drivers about how they
> implement mmap() and I think that's now getting in the way of some
> important improvements.  I want to see a simpler way of providing the
> same functionality, and I'm not quite there yet.


