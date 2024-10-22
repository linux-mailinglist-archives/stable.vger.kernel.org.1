Return-Path: <stable+bounces-87685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D29A9C7C
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6D51C23690
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C1F171066;
	Tue, 22 Oct 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jC6EnA1X"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29014161310
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585622; cv=none; b=qHq8TI3NftCYvmvuqLdJ5XFVU+xrWM1E8W7HIbY3maIN3QoVCGP/jTDocZb0kLcPNSUDTv+52ICtIasbJgSr1cUUrgx51slen2tWZ1CNvG2neJfAbnhUceYWrDia9XvG48noOzRRs5H83U6K9kt0ExrCvVPoTI4JG9+yu49IJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585622; c=relaxed/simple;
	bh=7tvE9XV1b+UMspHAVG7r8xj9pj7djTt7CCt1dacV9Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8xeRMaDeDVXV434QOHkj5JK6Tet6OamBxuY3CzQDMZkXTOtT/h9VjjAeQGLK4yMy71HOBrRieeKc/OLSORGCP0FZhI3Ilx+rch2nEfvSbe1kCMYqcuA23hD6IC1FilJ37vUClcPjbMAaFa6rVTsisbdrgmqxHs+eIh9sAaLCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jC6EnA1X; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53a007743e7so6442468e87.1
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 01:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729585618; x=1730190418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0GiliwIaLCyGRQWXYx66I75LIQA84ct+U2DkcDdwKs=;
        b=jC6EnA1XYcYtW5w9vgeDDtPEK5T2hyDLcAYkCeLCwkiSMn5pu/ALjoEWMTrJsdJNiF
         lmCUjwXpEFlvRr+oRdQLeDbq6dtzzDbTBg70QS2NFllhKmZT91M3r4aQb3MbSktRwkFV
         ZJDrkq7Qdwyy+vxUCCv+hy5i5FZwEA6UdceSVobUotr1SiOv3O1x2JL34uG39WfWszT/
         jRBE0lzkV14mwjUSDV8MQb3k283ugTKaEFpUqGsPqN0zB/w4d5G8qxYa/HB1cUzSAYoW
         KWzHjsBfmVxls0qXKJqKisXF8c1Te8ywVPQqJyo6t2kbEzWoDHMslWNuGwuXQBu3nSY2
         m1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585618; x=1730190418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0GiliwIaLCyGRQWXYx66I75LIQA84ct+U2DkcDdwKs=;
        b=ePS1yQAu4qKsrlUi1fdzxsvaJ+YT3dQ67yCTUj267svJEAVebmVrEj4UWa+LmB1VzK
         Jiv36BSn5eAE83MvzQ9ZzWGAfzczplDhySxNytm20A7Iq/rsY2S+Gv3MC87K9Hh7WR05
         McuOYqO9aH+pkk/cKpx7FH7suHo6ODhKYCooLdlh0MCroEeMlnn8neB/5qkkr7aO2Ihd
         yicqH8thPacceBo7L6NTSRfC8swgZupPhPMX8SKDMFk+vrfcflA2Zjx6YXgoKrTSrXiw
         CewIvpdsJiM4Ro7qn2UL5vK0woGlDPEl70GyEvktlTM6Xu+kqB0dM26iD5QjFrXQz5Oz
         T+9w==
X-Forwarded-Encrypted: i=1; AJvYcCWIKnctnMwQQ4tc48lUB8pP8HSypdwtNZfKi1+icw56BLn2cCwPqWbeBtyohpVFflny1VMozFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySuMrQbcJm37gDdja2qd4STQ2aj+vNR9R/mgnJV5J9wzIVNnby
	snB7bYt3OBrRg+P8Il5Y5EL1X1nX8tRj6EA+Kt9nh0dOP4YRGr9gVdioge1Gw5OfpZJaxKvwsmd
	V7KIk0iTXGJK2hsLEQyMV3ZPx/nMdnLzhBkgS
X-Google-Smtp-Source: AGHT+IEQucMr9xh3AiasaWZklpACkjyVewVAf4ZNFK0lBETmdd0R2zeParDjP7G/u52mxSejv4EmSK84cRfEwEw36kY=
X-Received: by 2002:a05:6512:3f04:b0:539:ee04:2321 with SMTP id
 2adb3069b0e04-53b139f1c95mr847888e87.33.1729585618041; Tue, 22 Oct 2024
 01:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <Zxa60Ftbh8eN1MG5@casper.infradead.org> <ZxcKjwhMKmnHTX8Q@google.com>
 <ZxcgR46zpW8uVKrt@casper.infradead.org> <ZxcrJHtIGckMo9Ni@google.com>
In-Reply-To: <ZxcrJHtIGckMo9Ni@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 22 Oct 2024 01:26:20 -0700
Message-ID: <CAJD7tkb2oUre-tgVyW6XgUaNfGQSSKp=QNAfB0iZoTvHcc0n0w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into free_pages_prepare()
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:33=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Tue, Oct 22, 2024 at 04:47:19AM +0100, Matthew Wilcox wrote:
> > On Tue, Oct 22, 2024 at 02:14:39AM +0000, Roman Gushchin wrote:
> > > On Mon, Oct 21, 2024 at 09:34:24PM +0100, Matthew Wilcox wrote:
> > > > On Mon, Oct 21, 2024 at 05:34:55PM +0000, Roman Gushchin wrote:
> > > > > Fix it by moving the mlocked flag clearance down to
> > > > > free_page_prepare().
> > > >
> > > > Urgh, I don't like this new reference to folio in free_pages_prepar=
e().
> > > > It feels like a layering violation.  I'll think about where else we
> > > > could put this.
> > >
> > > I agree, but it feels like it needs quite some work to do it in a nic=
er way,
> > > no way it can be backported to older kernels. As for this fix, I don'=
t
> > > have better ideas...
> >
> > Well, what is KVM doing that causes this page to get mapped to userspac=
e?
> > Don't tell me to look at the reproducer as it is 403 Forbidden.  All I
> > can tell is that it's freed with vfree().
> >
> > Is it from kvm_dirty_ring_get_page()?  That looks like the obvious thin=
g,
> > but I'd hate to spend a lot of time on it and then discover I was looki=
ng
> > at the wrong thing.
>
> One of the pages is vcpu->run, others belong to kvm->coalesced_mmio_ring.

Looking at kvm_vcpu_fault(), it seems like we after mmap'ing the fd
returned by KVM_CREATE_VCPU we can access one of the following:
- vcpu->run
- vcpu->arch.pio_data
- vcpu->kvm->coalesced_mmio_ring
- a page returned by kvm_dirty_ring_get_page()

It doesn't seem like any of these are reclaimable, why is mlock()'ing
them supported to begin with? Even if we don't want mlock() to err in
this case, shouldn't we just do nothing?

I see a lot of checks at the beginning of mlock_fixup() to check
whether we should operate on the vma, perhaps we should also check for
these KVM vmas? or maybe set VM_SPECIAL in kvm_vcpu_mmap()? I am not
sure tbh, but this doesn't seem right.

FWIW, I think moving the mlock clearing from __page_cache_release ()
to free_pages_prepare() (or another common function in the page
freeing path) may be the right thing to do in its own right. I am just
wondering why we are not questioning the mlock() on the KVM vCPU
mapping to begin with.

Is there a use case for this that I am missing?

>
> Here is the reproducer:
>
> #define _GNU_SOURCE
>
> #include <endian.h>
> #include <fcntl.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/mount.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> #ifndef __NR_mlock2
> #define __NR_mlock2 325
> #endif
>
> uint64_t r[3] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffff=
ffff};
>
> #ifndef KVM_CREATE_VM
> #define KVM_CREATE_VM 0xae01
> #endif
>
> #ifndef KVM_CREATE_VCPU
> #define KVM_CREATE_VCPU 0xae41
> #endif
>
> int main(void)
> {
>   syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=
=3D*/0ul,
>           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D=
*/-1,
>           /*offset=3D*/0ul);
>   syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
>           /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
>           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D=
*/-1,
>           /*offset=3D*/0ul);
>   syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=
=3D*/0ul,
>           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D=
*/-1,
>           /*offset=3D*/0ul);
>   intptr_t res =3D syscall(__NR_openat, /*fd=3D*/0xffffff9c, /*file=3D*/"=
/dev/kvm",
>                 /*flags=3D*/0, /*mode=3D*/0);
>   if (res !=3D -1)
>     r[0] =3D res;
>   res =3D syscall(__NR_ioctl, /*fd=3D*/r[0], /*cmd=3D*/KVM_CREATE_VM, /*t=
ype=3D*/0ul);
>   if (res !=3D -1)
>     r[1] =3D res;
>   res =3D syscall(__NR_ioctl, /*fd=3D*/r[1], /*cmd=3D*/KVM_CREATE_VCPU, /=
*id=3D*/0ul);
>   if (res !=3D -1)
>     r[2] =3D res;
>   syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0xb36000ul,
>           /*prot=3DPROT_SEM|PROT_WRITE|PROT_READ|PROT_EXEC*/ 0xful,
>           /*flags=3DMAP_FIXED|MAP_SHARED*/ 0x11ul, /*fd=3D*/r[2], /*offse=
t=3D*/0ul);
>   syscall(__NR_mlock2, /*addr=3D*/0x20000000ul, /*size=3D*/0x400000ul,
>           /*flags=3D*/0ul);
>   syscall(__NR_mremap, /*addr=3D*/0x200ab000ul, /*len=3D*/0x1000ul,
>           /*newlen=3D*/0x1000ul,
>           /*flags=3DMREMAP_DONTUNMAP|MREMAP_FIXED|MREMAP_MAYMOVE*/ 7ul,
>           /*newaddr=3D*/0x20ffc000ul);
>   return 0;
> }
>

