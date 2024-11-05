Return-Path: <stable+bounces-89844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 667669BCFAE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BCE1F23312
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56671D9588;
	Tue,  5 Nov 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvtRomnD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4381D933A
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818038; cv=none; b=bJwkJAZSDWqY2ejOeLS4VIk3yC5fNO0CaJiu173vyGpsDZKTWP9VO0Igbo6YkzsUSjaDUpFuAmGO+GYEw7/dcX2p2MzVh94zGI+4w7655tGX7cE4vFUYuaO2nVUr623C9+t7HdvrehztI8SvXX0ltG7XSRxymlmSs40LxPYIp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818038; c=relaxed/simple;
	bh=NUJeZp3Nw4C4ChRvfAMRe64rF+yZ4odrJKEqn8ZTWSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh4iIHIMORPBf2xNW12zNqzql2hobVzTg/0cd7OXeoOO82YiSHbfPNttC6UPZ2XaQk9kKTGDUPgWmQA4vlGF/4wH+4Y07WkeDCbRhkmwu/K6DcgEFQZeWceNKHkmawiOBxPXg3P+qu7Lvmaozb+/oyz7SNgWVZS3CP9jPMKsv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvtRomnD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e681ba70so22529e87.1
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730818035; x=1731422835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cagGAnxZqWV5y2Ato7lEE3OEZ0Tp2aD2OKM7V42p+E=;
        b=OvtRomnDheX7eUtU+qmm3Sfu6P7CUs5nMGW8ymONtzYmKZl71PArglOxzEhUv0G0XX
         MebGXCBVYTQQBWjsGUV6lupFS9syWAmuvtT+t5CXNpDKBVdQGSVcLEawtClTKlfA/bSN
         mJ5xA3omzW/T6+yVFNROPt876gT0bTLiFP/leIYSIV9mgE6GvpRof8zStX1blwMkpVl9
         /Gn2v30XfkfgJcrAKKWkKlHagr5FOwSSWpznDDe/792utbhGeVXGSjFqCy+NT8AD0QVe
         PJ7FoYbDG8lkcTFRVlWqTfiCF1zsJvbIDWerILMR5Pe/jNjpL1T1t7vNVrAkvkhqRmMq
         uaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818035; x=1731422835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cagGAnxZqWV5y2Ato7lEE3OEZ0Tp2aD2OKM7V42p+E=;
        b=QdkyqNA4Ug+b/2od/txOn4s28vF2P5OUMZbaZrDg+RIHJkHGp8IjkG25objfWgjrhh
         Vvf+O66S8PRpPUh9SzeuVPldFohMapFaaM346Fb0KWoz5BFzImgmj/UJl3/Y3YaQL40m
         o26FUr54use0xX49AXC2IRcrU5OTtTHFIlRZHLBCwYNVjGiPkvOExJe/KcSHSlYyvt37
         SJpOT82b297sndKeTIeQAUm2tPmdGT18Iaj7Lhbbkh3JvslpctyEAUkLrVybueF4AzDq
         LjHiYhLB9j7BXEFXAkmnOZ24Jyjh4uMuPvyTiDIpzB3MVZV7/JcpcnHMeulbNlbw/ngM
         sxBA==
X-Forwarded-Encrypted: i=1; AJvYcCU/8ovfBg5ur8TB0W37gmxBnwd9OPLOn9tQGoF5jtc/1g4g76nUIwELVXZucpwgsDby71RF9Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QU6jgaq8ZcxhwnjEHK3MomV+y3xNcA5/ndaPKXXLJ8932rNw
	wDdCw8tfMGt2fXMdT2z4eqVLDiEg6BEn8jmZZECeENTF7PQjCyJx6nfx55TI8opFM8550vK2pRM
	pKtMmddHEuCQtYkmwcL67p3zznkemEH1o+8ye
X-Gm-Gg: ASbGncvrefeGwUWGRspg7zeIZpf5alKxvHlVGmddjALEExIp6rxwsieq9YNOnyRPcFp
	dczOSywk6sKd4dX6fPVR0Wx0Ar5PAPK8HDnkxehqOoPFNTBW9Vrsuhh1Nkb8=
X-Google-Smtp-Source: AGHT+IGCupuoPoa9Be9DIeC1oLOgRsCVHzJMID/6QbIJuejsA52V25UUPkdSQbFWB5lj7opODxhrEwcgb4shAr5+SOU=
X-Received: by 2002:a05:6512:2243:b0:530:ae18:810e with SMTP id
 2adb3069b0e04-53d78c99ab2mr385358e87.5.1730818034320; Tue, 05 Nov 2024
 06:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-panthor-flush-page-fixes-v1-1-829aaf37db93@google.com> <Zynr3DIY8u2c7wrB@e110455-lin.cambridge.arm.com>
In-Reply-To: <Zynr3DIY8u2c7wrB@e110455-lin.cambridge.arm.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 5 Nov 2024 15:46:37 +0100
Message-ID: <CAG48ez1YjoQMe-daQ8NSqN46STGw1UWygzU2-qo75FLBDBqaow@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: Be stricter about IO mapping flags
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 10:56=E2=80=AFAM Liviu Dudau <liviu.dudau@arm.com> w=
rote:
> On Tue, Nov 05, 2024 at 12:17:13AM +0100, Jann Horn wrote:
> > The current panthor_device_mmap_io() implementation has two issues:
> >
> > 1. For mapping DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET,
> >    panthor_device_mmap_io() bails if VM_WRITE is set, but does not clea=
r
> >    VM_MAYWRITE. That means userspace can use mprotect() to make the map=
ping
> >    writable later on. This is a classic Linux driver gotcha.
> >    I don't think this actually has any impact in practice:
> >    When the GPU is powered, writes to the FLUSH_ID seem to be ignored; =
and
> >    when the GPU is not powered, the dummy_latest_flush page provided by=
 the
> >    driver is deliberately designed to not do any flushes, so the only t=
hing
> >    writing to the dummy_latest_flush could achieve would be to make *mo=
re*
> >    flushes happen.
> >
> > 2. panthor_device_mmap_io() does not block MAP_PRIVATE mappings (which =
are
> >    mappings without the VM_SHARED flag).
> >    MAP_PRIVATE in combination with VM_MAYWRITE indicates that the VMA h=
as
> >    copy-on-write semantics, which for VM_PFNMAP are semi-supported but
> >    fairly cursed.
> >    In particular, in such a mapping, the driver can only install PTEs
> >    during mmap() by calling remap_pfn_range() (because remap_pfn_range(=
)
> >    wants to **store the physical address of the mapped physical memory =
into
> >    the vm_pgoff of the VMA**); installing PTEs later on with a fault
> >    handler (as panthor does) is not supported in private mappings, and =
so
> >    if you try to fault in such a mapping, vmf_insert_pfn_prot() splats =
when
> >    it hits a BUG() check.
> >
> > Fix it by clearing the VM_MAYWRITE flag (userspace writing to the FLUSH=
_ID
> > doesn't make sense) and requiring VM_SHARED (copy-on-write semantics fo=
r
> > the FLUSH_ID don't make sense).
> >
> > Reproducers for both scenarios are in the notes of my patch on the mail=
ing
> > list; I tested that these bugs exist on a Rock 5B machine.
> >
> > Note that I only compile-tested the patch, I haven't tested it; I don't
> > have a working kernel build setup for the test machine yet. Please test=
 it
> > before applying it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > First testcase (can write to the FLUSH_ID):
> >
> > ```
> >
>
> There is a missing line here, I guess is something like
>
> #define SYSCHK(x) ({  \

Oops. Yes, sorry, the tool that I stored this comment message in
interpreted all lines starting with "#" as comments... the proper
versions:

First testcase (can write to the FLUSH_ID):

```
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>

#define SYSCHK(x) ({          \
  typeof(x) __res =3D (x);      \
  if (__res =3D=3D (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

#define GPU_PATH "/dev/dri/by-path/platform-fb000000.gpu-card"
#define DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET (1ull << 56)

int main(void) {
  int fd =3D SYSCHK(open(GPU_PATH, O_RDWR));

  // sanity-check that PROT_WRITE+MAP_SHARED fails
  void *mmap_write_res =3D mmap(NULL, 0x1000, PROT_READ|PROT_WRITE,
      MAP_SHARED, fd, DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET);
  if (mmap_write_res =3D=3D MAP_FAILED) {
    perror("mmap() with PROT_WRITE+MAP_SHARED failed as expected");
  } else {
    errx(1, "mmap() with PROT_WRITE+MAP_SHARED worked???");
  }

  // make a PROT_READ+MAP_SHARED mapping, and upgrade it to writable
  void *mmio_page =3D SYSCHK(mmap(NULL, 0x1000, PROT_READ, MAP_SHARED,
      fd, DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET));
  SYSCHK(mprotect(mmio_page, 0x1000, PROT_READ|PROT_WRITE));

  volatile uint32_t *flush_counter =3D (volatile uint32_t*)mmio_page;

  uint32_t last_old =3D -1;
  while (1) {
    uint32_t old_val =3D *flush_counter;
    *flush_counter =3D 1111;
    uint32_t new_val =3D *flush_counter;
    if (old_val !=3D last_old)
      printf("flush counter: old=3D%u, new=3D%u\n", old_val, new_val);
    last_old =3D old_val;
  }
}
```

Second testcase (triggers BUG() splat):
```
#include <err.h>
#include <fcntl.h>
#include <stddef.h>
#include <sys/mman.h>

#define SYSCHK(x) ({          \
  typeof(x) __res =3D (x);      \
  if (__res =3D=3D (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

#define GPU_PATH "/dev/dri/by-path/platform-fb000000.gpu-card"
#define DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET (1ull << 56)

int main(void) {
  int fd =3D SYSCHK(open(GPU_PATH, O_RDWR));

  // make a PROT_READ+**MAP_PRIVATE** mapping
  void *ptr =3D SYSCHK(mmap(NULL, 0x1000, PROT_READ, MAP_PRIVATE,
      fd, DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET));

  // trigger a read fault
  *(volatile char *)ptr;
}
```

