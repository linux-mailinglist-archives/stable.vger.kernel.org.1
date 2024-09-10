Return-Path: <stable+bounces-75672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F77973E4B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F651F22515
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2E196D81;
	Tue, 10 Sep 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MKO9+WNb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDD19DF85
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988330; cv=none; b=Ak6tbs+EJYf5OJPYkm3QuItpC7wfbTi0i3rcYC6AF/ZOBTt3oT469ISXtHu5i7XezoL4vUOQqpAm9QAkD+j3CD9Lim7OvD/9isapZe/85caHrNOwC3AKMlwN3fwxqzbHpgIVTJdzc9nxIbp9ZwixQpai9RDFbgbi4ombzDlq6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988330; c=relaxed/simple;
	bh=8LxEBjza5dsTFcKZtz4RkJrIXyx6u197K1kp7KQ12Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hX5eSLFM6rCOo5kx9++C6ILnHyKHE6wGFKXF3rPslU5Z1z01Gae5Ub4LDaTA3KxgvxiBf1YLiUHdjl3VkcudwGm7vQV8X4JLg/ooXGOQrfMSQ4KRI7wNSN9eZlPKe0oAIDsUai9nFWZEJyUVZMhGz+x6sk+ryXTVFczvXk5Rdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MKO9+WNb; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-268d0979e90so185987fac.3
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725988327; x=1726593127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxJ605K8OvezjsKk4Oa4fS/5UoU/4CUFi0pauBi3M3E=;
        b=MKO9+WNbSObr4OCZWwLwuw/IFy/KCaeAeIYcLz+3Gl/fmMXhXsyY5SkaRowkpyt0/X
         FfGKskcvQPG1hIoPxclGHIlrhPuA2uk3eTOWmMsD9cIU7NKVu66A5D3ewVYbxPQyesWE
         VoeXlDuyOdYoToCXiUjsGkX/5f56ZhM1bggJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988327; x=1726593127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxJ605K8OvezjsKk4Oa4fS/5UoU/4CUFi0pauBi3M3E=;
        b=E4KOgomOautOK1nKdqpF3zFtqt+TD4zP82aARMn4B/xQ3ZpU/gq/MYlFPThZrRBCX9
         lIAuJIpyDQWXeXdH5RnccxujxIkD1oM9hI81psXatY59kBpJedTNEO3V/xNPnnv9Nqvw
         S2NGn6NP61ShSdkRyxS6+zS3qUJg+RF4M2VzaT+XYJbaOBPJ8yaV2HRjDbBRoYPepmPK
         sMpYIPWRqg5szUfbqeir5Jva1t6Yvb3PG176YKEseHkaXGHVxei7WUmOf+8ABdEbAZZF
         HFaDDOtYCKd6EwFhabsDnHgjFG+OtqfiUinipfA/GbS445qEyjy8zpm6DzIEyNFgo7V0
         5hIA==
X-Forwarded-Encrypted: i=1; AJvYcCWeQpC4c6GSU4qrYaUSsv/RG8W4dbW2tgOSqH4f1yCDwbGKn+xXRYEvta/wl6+hYR3cN4ODako=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WMjr3GnLGWInNa3EQT8G4GfGC6Hr0GLy+Cr2+djhLOa0ChVG
	VQK0L/jDUgD9OJAJn/K4EgnFYWciRXuNiTQ2UQkmmOskKl17Cc2YRM0Ak5PlylZnsMNvSLIs2NG
	rQbNJ0BIw2F0sLp5NbW98jR9Bl4nk0Fd5Tf2z
X-Google-Smtp-Source: AGHT+IGMTHmxlx16LP1N2LhU4l5/p4zyklSRCGzFFF6e58y1q2iGqdYBpUd7t6JV9ohZiZJfTVBScwmm6dgwZECdXOs=
X-Received: by 2002:a05:6871:3a0e:b0:26c:78ce:b0cc with SMTP id
 586e51a60fabf-27b830171famr6163341fac.8.1725988327173; Tue, 10 Sep 2024
 10:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092622.245959861@linuxfoundation.org> <20240910092623.314101083@linuxfoundation.org>
 <CABi2SkV-FdDQy2bjDkpgpqz7hX7ybeTjCrUgUf6WcYqGkuxWMQ@mail.gmail.com> <s663e6vb3dgxnedvugt65t6cao55lofznpq4fnkejh227myxxp@6ppza2y4tj2t>
In-Reply-To: <s663e6vb3dgxnedvugt65t6cao55lofznpq4fnkejh227myxxp@6ppza2y4tj2t>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 10 Sep 2024 10:11:54 -0700
Message-ID: <CABi2SkWZAYKnEeBTs8eRbTCRDoqbMYqxfey-OhxM5fatmC7CjA@mail.gmail.com>
Subject: Re: [PATCH 6.10 032/375] selftests: mm: fix build errors on armhf
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:44=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [240910 10:23]:
> > Hi
> >
> > I'm not sure this is a correct fix.
>
> This should be backported, mainly to help facilitate future backports.
>
> ...
>
> > Although, I don't think we need to block this  getting into 6.10, we
> > can backport  again when a future fix is available.
>
> Please move this discussion to the mm mailing list.
>
> Any changes to the area will depend on the stable and upstream kernel
> being in sync for easier backporting.  Without the fix, armhf will fail
> to build the selftest.  So our choices are to have a working selftest
> that helps backporting in the future or broken selftest on certain archs
> and potentially more work for the stable team.
>
I'm ok with applying this to 6.10 :-)
-Jeff

> Thanks,
> Liam
>
> >
> > Thanks
> > -Jeff
> >
> >
> > On Tue, Sep 10, 2024 at 2:42=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 6.10-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > >
> > > commit b808f629215685c1941b1cd567c7b7ccb3c90278 upstream.
> > >
> > > The __NR_mmap isn't found on armhf.  The mmap() is commonly available
> > > system call and its wrapper is present on all architectures.  So it s=
hould
> > > be used directly.  It solves problem for armhf and doesn't create pro=
blem
> > > for other architectures.
> > >
> > > Remove sys_mmap() functions as they aren't doing anything else other =
than
> > > calling mmap().  There is no need to set errno =3D 0 manually as glib=
c
> > > always resets it.
> > >
> > > For reference errors are as following:
> > >
> > >   CC       seal_elf
> > > seal_elf.c: In function 'sys_mmap':
> > > seal_elf.c:39:33: error: '__NR_mmap' undeclared (first use in this fu=
nction)
> > >    39 |         sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> > >       |                                 ^~~~~~~~~
> > >
> > > mseal_test.c: In function 'sys_mmap':
> > > mseal_test.c:90:33: error: '__NR_mmap' undeclared (first use in this =
function)
> > >    90 |         sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> > >       |                                 ^~~~~~~~~
> > >
> > > Link: https://lkml.kernel.org/r/20240809082511.497266-1-usama.anjum@c=
ollabora.com
> > > Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
> > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > Cc: Jeff Xu <jeffxu@chromium.org>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  tools/testing/selftests/mm/mseal_test.c |   37 +++++++++++----------=
-----------
> > >  tools/testing/selftests/mm/seal_elf.c   |   13 -----------
> > >  2 files changed, 14 insertions(+), 36 deletions(-)
> > >
> > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > +++ b/tools/testing/selftests/mm/mseal_test.c
> > > @@ -128,17 +128,6 @@ static int sys_mprotect_pkey(void *ptr,
> > >         return sret;
> > >  }
> > >
> > > -static void *sys_mmap(void *addr, unsigned long len, unsigned long p=
rot,
> > > -       unsigned long flags, unsigned long fd, unsigned long offset)
> > > -{
> > > -       void *sret;
> > > -
> > > -       errno =3D 0;
> > > -       sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> > > -               flags, fd, offset);
> > > -       return sret;
> > > -}
> > > -
> > >  static int sys_munmap(void *ptr, size_t size)
> > >  {
> > >         int sret;
> > > @@ -219,7 +208,7 @@ static void setup_single_address(int siz
> > >  {
> > >         void *ptr;
> > >
> > > -       ptr =3D sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_P=
RIVATE, -1, 0);
> > > +       ptr =3D mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVA=
TE, -1, 0);
> > >         *ptrOut =3D ptr;
> > >  }
> > >
> > > @@ -228,7 +217,7 @@ static void setup_single_address_rw(int
> > >         void *ptr;
> > >         unsigned long mapflags =3D MAP_ANONYMOUS | MAP_PRIVATE;
> > >
> > > -       ptr =3D sys_mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags=
, -1, 0);
> > > +       ptr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1=
, 0);
> > >         *ptrOut =3D ptr;
> > >  }
> > >
> > > @@ -252,7 +241,7 @@ bool seal_support(void)
> > >         void *ptr;
> > >         unsigned long page_size =3D getpagesize();
> > >
> > > -       ptr =3D sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | =
MAP_PRIVATE, -1, 0);
> > > +       ptr =3D mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_=
PRIVATE, -1, 0);
> > >         if (ptr =3D=3D (void *) -1)
> > >                 return false;
> > >
> > > @@ -528,8 +517,8 @@ static void test_seal_zero_address(void)
> > >         int prot;
> > >
> > >         /* use mmap to change protection. */
> > > -       ptr =3D sys_mmap(0, size, PROT_NONE,
> > > -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, =
0);
> > > +       ptr =3D mmap(0, size, PROT_NONE,
> > > +                  MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > >         FAIL_TEST_IF_FALSE(ptr =3D=3D 0);
> > >
> > >         size =3D get_vma_size(ptr, &prot);
> > > @@ -1256,8 +1245,8 @@ static void test_seal_mmap_overwrite_pro
> > >         }
> > >
> > >         /* use mmap to change protection. */
> > > -       ret2 =3D sys_mmap(ptr, size, PROT_NONE,
> > > -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, =
0);
> > > +       ret2 =3D mmap(ptr, size, PROT_NONE,
> > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > >         if (seal) {
> > >                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > >                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > > @@ -1287,8 +1276,8 @@ static void test_seal_mmap_expand(bool s
> > >         }
> > >
> > >         /* use mmap to expand. */
> > > -       ret2 =3D sys_mmap(ptr, size, PROT_READ,
> > > -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, =
0);
> > > +       ret2 =3D mmap(ptr, size, PROT_READ,
> > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > >         if (seal) {
> > >                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > >                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > > @@ -1315,8 +1304,8 @@ static void test_seal_mmap_shrink(bool s
> > >         }
> > >
> > >         /* use mmap to shrink. */
> > > -       ret2 =3D sys_mmap(ptr, 8 * page_size, PROT_READ,
> > > -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, =
0);
> > > +       ret2 =3D mmap(ptr, 8 * page_size, PROT_READ,
> > > +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > >         if (seal) {
> > >                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > >                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > > @@ -1697,7 +1686,7 @@ static void test_seal_discard_ro_anon_on
> > >         ret =3D fallocate(fd, 0, 0, size);
> > >         FAIL_TEST_IF_FALSE(!ret);
> > >
> > > -       ptr =3D sys_mmap(NULL, size, PROT_READ, mapflags, fd, 0);
> > > +       ptr =3D mmap(NULL, size, PROT_READ, mapflags, fd, 0);
> > >         FAIL_TEST_IF_FALSE(ptr !=3D MAP_FAILED);
> > >
> > >         if (seal) {
> > > @@ -1727,7 +1716,7 @@ static void test_seal_discard_ro_anon_on
> > >         int ret;
> > >         unsigned long mapflags =3D MAP_ANONYMOUS | MAP_SHARED;
> > >
> > > -       ptr =3D sys_mmap(NULL, size, PROT_READ, mapflags, -1, 0);
> > > +       ptr =3D mmap(NULL, size, PROT_READ, mapflags, -1, 0);
> > >         FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > >
> > >         if (seal) {
> > > --- a/tools/testing/selftests/mm/seal_elf.c
> > > +++ b/tools/testing/selftests/mm/seal_elf.c
> > > @@ -61,17 +61,6 @@ static int sys_mseal(void *start, size_t
> > >         return sret;
> > >  }
> > >
> > > -static void *sys_mmap(void *addr, unsigned long len, unsigned long p=
rot,
> > > -       unsigned long flags, unsigned long fd, unsigned long offset)
> > > -{
> > > -       void *sret;
> > > -
> > > -       errno =3D 0;
> > > -       sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> > > -               flags, fd, offset);
> > > -       return sret;
> > > -}
> > > -
> > >  static inline int sys_mprotect(void *ptr, size_t size, unsigned long=
 prot)
> > >  {
> > >         int sret;
> > > @@ -87,7 +76,7 @@ static bool seal_support(void)
> > >         void *ptr;
> > >         unsigned long page_size =3D getpagesize();
> > >
> > > -       ptr =3D sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | =
MAP_PRIVATE, -1, 0);
> > > +       ptr =3D mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_=
PRIVATE, -1, 0);
> > >         if (ptr =3D=3D (void *) -1)
> > >                 return false;
> > >
> > >
> > >

