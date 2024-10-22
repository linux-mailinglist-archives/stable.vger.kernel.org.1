Return-Path: <stable+bounces-87747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D83B9AB248
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5581C21C99
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B41A070D;
	Tue, 22 Oct 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrsey+98"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C619D091
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611578; cv=none; b=sbPUu/zKyS4wR+LCiGhiULtMwdh9sv2PfsNEpZEId67mHy0DmG3FNEeOZTPL1uEq4cb9LFkJiigPOwq/5tzvGPMC6lQWLUdkvBm5RV3qAWGHwQp6xD3SSZZhabrsH7iJw4vRnEHLVhwytl9oCLrDrByNQwCQOJ9j+JPfykIkMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611578; c=relaxed/simple;
	bh=wcNc2MA1GyKb0CNLmVy6i3fGKYzMQ9ZDso8LkvyEZCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZuBNVDBxkLJ2uHIp1pgQ85XjH3sNn7+creuhjH3YsRHaplyEnS4B/LbVNT1vmnGVfOvUHwHBX1gu+ZX6YVtvGz76jqiWSruY7MHdcMjUhb2utYqRNTmZRMbM5klw9S2co/prN+JF2JVJ+kFx2chhqYHgmReFwG22MReYCup9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrsey+98; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7e9b2d75d6dso4783377a12.1
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729611576; x=1730216376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3y119MD9wmKtbCuck0m1HoKm8DFO9OxY9WfoV49VvA=;
        b=vrsey+98Ttl7/DSnaCzGWGBzRJcc7/IbYdggxin5OnANf/Mw3pxfY4CVR27t9adP8q
         fhX4X9LypDodT9b45UYBfUBHNjekV+5G0ezgCjEhf6ZfalC5aay0BfTC0uFmyHaFo2Hn
         iBO1ed5siuuFzMXnCBcifaoY8pYLpnlsVf3iSd6OlEHVAzw6Waf6y3XhFcBUkQwtES1m
         zyYM1trLoWDb4w93OPuXAWrtIHXTicmzaXViQka97kumovx8FzYbKOAgu2JW8OQkjIFq
         2vrPtyi9mvfGTrT1Wby2y/9+A3XRdG0edj7okiEOeQKWwwFKZK1YK1SULR/6TQofpBKN
         58Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611576; x=1730216376;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h3y119MD9wmKtbCuck0m1HoKm8DFO9OxY9WfoV49VvA=;
        b=cwtWuoEiquR5Te5Jov+BclLyfhGZIb6km+bILVhn3SxdNZ8gntggSL4/ge0oioGNzF
         y3emzpIB7KDrdHy1ul4IwmNFlQBHOWtijoIDm6cHkQj+cs8JDa1E0WVfjV3LmO9DeEBz
         yAn/Y5aFdFtD9XAgZtx9SfZV5bIYzM59nuHxMG31RXXHhjAax4KiS7w3kN0dOV7PjV8Z
         /iwES8JLvrPeMTfU9xl86KKyKoKosd+CvUSlwTUAO4emA+IbSIx+T6Y4QPSEbtsQMh/p
         q9Uyunw2ZkG+pou+fg7IMh27EiSwsTzw2ZTKIHhUOQ0h0Dwk0WUDQV1qn+1/sfOxPS5L
         fZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVGpwxftSUDCtv9hBNOev/fkyB0Gla2qSQH4kreU4ah1C7y8siPeJM+1j4dhGhXTS99MVj6zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypmnzIxnci+I9n1l/B9Kl/rpVoU2d+PskK8ZIuGNhwUV6L8JGe
	0j3dMPmwqDVw+yeOlYoAzAih4pk/Kbx/y3MEeq6LlbGV/qJJgPs+CDUjOrvLPcqYToG9SXjw4FY
	Lzw==
X-Google-Smtp-Source: AGHT+IGC9vYjja2RJe4yfi4oSZXSGryKcMpLP6CLXouCF0l5UeX3c76IyljH5E7eZYNj8rn5Bmx44Cfiq2k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:f545:0:b0:7ea:67a0:9651 with SMTP id
 41be03b00d2f7-7eacc6e6631mr17501a12.3.1729611576172; Tue, 22 Oct 2024
 08:39:36 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:39:34 -0700
In-Reply-To: <CAJD7tkb2oUre-tgVyW6XgUaNfGQSSKp=QNAfB0iZoTvHcc0n0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <Zxa60Ftbh8eN1MG5@casper.infradead.org> <ZxcKjwhMKmnHTX8Q@google.com>
 <ZxcgR46zpW8uVKrt@casper.infradead.org> <ZxcrJHtIGckMo9Ni@google.com> <CAJD7tkb2oUre-tgVyW6XgUaNfGQSSKp=QNAfB0iZoTvHcc0n0w@mail.gmail.com>
Message-ID: <ZxfHNo1dUVcOLJYK@google.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into free_pages_prepare()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024, Yosry Ahmed wrote:
> On Mon, Oct 21, 2024 at 9:33=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> >
> > On Tue, Oct 22, 2024 at 04:47:19AM +0100, Matthew Wilcox wrote:
> > > On Tue, Oct 22, 2024 at 02:14:39AM +0000, Roman Gushchin wrote:
> > > > On Mon, Oct 21, 2024 at 09:34:24PM +0100, Matthew Wilcox wrote:
> > > > > On Mon, Oct 21, 2024 at 05:34:55PM +0000, Roman Gushchin wrote:
> > > > > > Fix it by moving the mlocked flag clearance down to
> > > > > > free_page_prepare().
> > > > >
> > > > > Urgh, I don't like this new reference to folio in free_pages_prep=
are().
> > > > > It feels like a layering violation.  I'll think about where else =
we
> > > > > could put this.
> > > >
> > > > I agree, but it feels like it needs quite some work to do it in a n=
icer way,
> > > > no way it can be backported to older kernels. As for this fix, I do=
n't
> > > > have better ideas...
> > >
> > > Well, what is KVM doing that causes this page to get mapped to usersp=
ace?
> > > Don't tell me to look at the reproducer as it is 403 Forbidden.  All =
I
> > > can tell is that it's freed with vfree().
> > >
> > > Is it from kvm_dirty_ring_get_page()?  That looks like the obvious th=
ing,
> > > but I'd hate to spend a lot of time on it and then discover I was loo=
king
> > > at the wrong thing.
> >
> > One of the pages is vcpu->run, others belong to kvm->coalesced_mmio_rin=
g.
>=20
> Looking at kvm_vcpu_fault(), it seems like we after mmap'ing the fd
> returned by KVM_CREATE_VCPU we can access one of the following:
> - vcpu->run
> - vcpu->arch.pio_data
> - vcpu->kvm->coalesced_mmio_ring
> - a page returned by kvm_dirty_ring_get_page()
>=20
> It doesn't seem like any of these are reclaimable,

Correct, these are all kernel allocated pages that KVM exposes to userspace=
 to
facilitate bidirectional sharing of large chunks of data.

> why is mlock()'ing them supported to begin with?

Because no one realized it would be problematic, and KVM would have had to =
go out
of its way to prevent mlock().

> Even if we don't want mlock() to err in this case, shouldn't we just do
> nothing?

Ideally, yes.

> I see a lot of checks at the beginning of mlock_fixup() to check
> whether we should operate on the vma, perhaps we should also check for
> these KVM vmas?

Definitely not.  KVM may be doing something unexpected, but the VMA certain=
ly
isn't unique enough to warrant mm/ needing dedicated handling.

Focusing on KVM is likely a waste of time.  There are probably other subsys=
tems
and/or drivers that .mmap() kernel allocated memory in the same way.  Odds =
are
good KVM is just the messenger, because syzkaller knows how to beat on KVM.=
  And
even if there aren't any other existing cases, nothing would prevent them f=
rom
coming along in the future.

> Trying to or maybe set VM_SPECIAL in kvm_vcpu_mmap()? I am not
> sure tbh, but this doesn't seem right.

Agreed.  VM_DONTEXPAND is the only VM_SPECIAL flag that is remotely appropr=
iate,
but setting VM_DONTEXPAND could theoretically break userspace, and other th=
an
preventing mlock(), there is no reason why the VMA can't be expanded.  I do=
ubt
any userspace VMM is actually remapping and expanding a vCPU mapping, but t=
rying
to fudge around this outside of core mm/ feels kludgy and has the potential=
 to
turn into a game of whack-a-mole.

> FWIW, I think moving the mlock clearing from __page_cache_release ()
> to free_pages_prepare() (or another common function in the page
> freeing path) may be the right thing to do in its own right. I am just
> wondering why we are not questioning the mlock() on the KVM vCPU
> mapping to begin with.
>=20
> Is there a use case for this that I am missing?

Not that I know of, I suspect mlock() is allowed simply because it's allowe=
d by
default.

