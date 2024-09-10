Return-Path: <stable+bounces-75656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCF9739C3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC17B2388F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E2E6A01E;
	Tue, 10 Sep 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BoVCG2ue"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAC192B61
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978214; cv=none; b=D0dT0YwFDiUutyi1B7d7bsiXI3S1ps+0YeTtHyHXkNHCuNiLqA+4fJQxPim0b4zaWQ7T+0LQdt0ImNvroX03vsSQY2fJkA/2E5EKVMvGX+fai4eLTlMrzNey3PCIWx38yreHU7/X+6dnXgHqhb58ifQm/jfdJqLRTtttEN6surs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978214; c=relaxed/simple;
	bh=oVRbXLj532BXhiOT5C4+qRrYGXt4OjydJknjPFbePeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSk4OJo1egjFJCB2muLMYHVRldquj+ikrTSJrJq2gAMkCKsrY/ZPBrEkLzN2JYt06AlboKs1uhhqrP8aTtTSooR6l6aCzXh3doxH9yhKOgLxFX9xzRciQQw+ngzVv0gBb/68aZxIj0T0N6IM3weM2p1g2s5XIKh8+YS3sdPFU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BoVCG2ue; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e1cd7f930fso115917eaf.2
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725978212; x=1726583012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81lETcO+41yZt1CbWmF21krOLTzEKBsg3XQNJ7wzck4=;
        b=BoVCG2ueKczyfkKLKfITtnwe0/pedgXgZWH0lmwdq2iOg6fW1sskyKGyrR/tKr/m6y
         eG4p/CRr+k6X4Q2/GpbRHlOCHdX9KVhjllqTNZ2d4LpbfntFALfqrmPY4/PPqfDqomIP
         4b6bWPsOZZK2/Pgz2w1rlYgHg286pX8ZsOmFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725978212; x=1726583012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81lETcO+41yZt1CbWmF21krOLTzEKBsg3XQNJ7wzck4=;
        b=D0RLiOPaWAwth9k8Qac2KXyXQPgE3ST9GJ904eaR3XqKjRJvgmG+gxSMhpVQ6S+7it
         RwAgH5B5IkM9aj81cnP/gYu0YQu6q5ndIEKDvZ5fT3Rqigo5YUqIogvzahG43rKPzvZG
         szvmljfW1nlZLhxG4MMYmE2M9ZvttowITVpYveBM9R5DJ79+bDB38FjsflBLZvOdQrRf
         AF1R+JZx4YWuAJELggiNrbH1BpMWhFSTFUhZuXsJw+3+iinMRxwGBMiSlFlzvwGNbt+I
         BR8qkhu1jfufGQMm5Nvt30OoApD3QOL6hBgNX10xIwXPgqXn8j0Lvfak2VzWUNaoZW7p
         RfIA==
X-Gm-Message-State: AOJu0YyuxzZpgusIcYOVtVrjS7HijrGlncJSBbWhWx654Hn6Hz5j1bTH
	Lx+0RKd1g5P8tnHs/bG/R8snWvIESRoddZknjl3HjQmpByP8NcuW5Xa2cTm9QVFQjpjCGvY0KvT
	Gc/GvArl+Uj+rxBEbvozyPjWuo6uTl5htGeku
X-Google-Smtp-Source: AGHT+IE0einZMCpCTFUXN657fJfRl8aXLCLD+vZ7naZGZqVajrcI5CNad900VWdQ/m9RhQIueD/NTav9o0Yk9+TxZpk=
X-Received: by 2002:a05:6870:7184:b0:260:ccfd:1efe with SMTP id
 586e51a60fabf-27b82f9cff1mr5859066fac.6.1725978211598; Tue, 10 Sep 2024
 07:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092622.245959861@linuxfoundation.org> <20240910092623.314101083@linuxfoundation.org>
In-Reply-To: <20240910092623.314101083@linuxfoundation.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 10 Sep 2024 07:23:19 -0700
Message-ID: <CABi2SkV-FdDQy2bjDkpgpqz7hX7ybeTjCrUgUf6WcYqGkuxWMQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 032/375] selftests: mm: fix build errors on armhf
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Kees Cook <kees@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I'm not sure this is a correct fix.

Since mseal is a security feature, an attacker can access syscall
directly, so the test should utilize syscall directly instead of
adding glibc as an extra layer.

The correct fix is probably one of below:
1> switch to __NR_mmap2 for this test on all architecture,
or
2> switch to __NR_mmap2 for ARMHF

Though I'm not sure which one is more appropriate, because I don't
have a test environment for ARMHF .

Although, I don't think we need to block this  getting into 6.10, we
can backport  again when a future fix is available.

Thanks
-Jeff


On Tue, Sep 10, 2024 at 2:42=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
> commit b808f629215685c1941b1cd567c7b7ccb3c90278 upstream.
>
> The __NR_mmap isn't found on armhf.  The mmap() is commonly available
> system call and its wrapper is present on all architectures.  So it shoul=
d
> be used directly.  It solves problem for armhf and doesn't create problem
> for other architectures.
>
> Remove sys_mmap() functions as they aren't doing anything else other than
> calling mmap().  There is no need to set errno =3D 0 manually as glibc
> always resets it.
>
> For reference errors are as following:
>
>   CC       seal_elf
> seal_elf.c: In function 'sys_mmap':
> seal_elf.c:39:33: error: '__NR_mmap' undeclared (first use in this functi=
on)
>    39 |         sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
>       |                                 ^~~~~~~~~
>
> mseal_test.c: In function 'sys_mmap':
> mseal_test.c:90:33: error: '__NR_mmap' undeclared (first use in this func=
tion)
>    90 |         sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
>       |                                 ^~~~~~~~~
>
> Link: https://lkml.kernel.org/r/20240809082511.497266-1-usama.anjum@colla=
bora.com
> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Jeff Xu <jeffxu@chromium.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  tools/testing/selftests/mm/mseal_test.c |   37 +++++++++++--------------=
-------
>  tools/testing/selftests/mm/seal_elf.c   |   13 -----------
>  2 files changed, 14 insertions(+), 36 deletions(-)
>
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -128,17 +128,6 @@ static int sys_mprotect_pkey(void *ptr,
>         return sret;
>  }
>
> -static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
> -       unsigned long flags, unsigned long fd, unsigned long offset)
> -{
> -       void *sret;
> -
> -       errno =3D 0;
> -       sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> -               flags, fd, offset);
> -       return sret;
> -}
> -
>  static int sys_munmap(void *ptr, size_t size)
>  {
>         int sret;
> @@ -219,7 +208,7 @@ static void setup_single_address(int siz
>  {
>         void *ptr;
>
> -       ptr =3D sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVA=
TE, -1, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, =
-1, 0);
>         *ptrOut =3D ptr;
>  }
>
> @@ -228,7 +217,7 @@ static void setup_single_address_rw(int
>         void *ptr;
>         unsigned long mapflags =3D MAP_ANONYMOUS | MAP_PRIVATE;
>
> -       ptr =3D sys_mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1=
, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0)=
;
>         *ptrOut =3D ptr;
>  }
>
> @@ -252,7 +241,7 @@ bool seal_support(void)
>         void *ptr;
>         unsigned long page_size =3D getpagesize();
>
> -       ptr =3D sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_=
PRIVATE, -1, 0);
> +       ptr =3D mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIV=
ATE, -1, 0);
>         if (ptr =3D=3D (void *) -1)
>                 return false;
>
> @@ -528,8 +517,8 @@ static void test_seal_zero_address(void)
>         int prot;
>
>         /* use mmap to change protection. */
> -       ptr =3D sys_mmap(0, size, PROT_NONE,
> -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +       ptr =3D mmap(0, size, PROT_NONE,
> +                  MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>         FAIL_TEST_IF_FALSE(ptr =3D=3D 0);
>
>         size =3D get_vma_size(ptr, &prot);
> @@ -1256,8 +1245,8 @@ static void test_seal_mmap_overwrite_pro
>         }
>
>         /* use mmap to change protection. */
> -       ret2 =3D sys_mmap(ptr, size, PROT_NONE,
> -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +       ret2 =3D mmap(ptr, size, PROT_NONE,
> +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>         if (seal) {
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
>                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> @@ -1287,8 +1276,8 @@ static void test_seal_mmap_expand(bool s
>         }
>
>         /* use mmap to expand. */
> -       ret2 =3D sys_mmap(ptr, size, PROT_READ,
> -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +       ret2 =3D mmap(ptr, size, PROT_READ,
> +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>         if (seal) {
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
>                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> @@ -1315,8 +1304,8 @@ static void test_seal_mmap_shrink(bool s
>         }
>
>         /* use mmap to shrink. */
> -       ret2 =3D sys_mmap(ptr, 8 * page_size, PROT_READ,
> -                       MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> +       ret2 =3D mmap(ptr, 8 * page_size, PROT_READ,
> +                   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
>         if (seal) {
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
>                 FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> @@ -1697,7 +1686,7 @@ static void test_seal_discard_ro_anon_on
>         ret =3D fallocate(fd, 0, 0, size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       ptr =3D sys_mmap(NULL, size, PROT_READ, mapflags, fd, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ, mapflags, fd, 0);
>         FAIL_TEST_IF_FALSE(ptr !=3D MAP_FAILED);
>
>         if (seal) {
> @@ -1727,7 +1716,7 @@ static void test_seal_discard_ro_anon_on
>         int ret;
>         unsigned long mapflags =3D MAP_ANONYMOUS | MAP_SHARED;
>
> -       ptr =3D sys_mmap(NULL, size, PROT_READ, mapflags, -1, 0);
> +       ptr =3D mmap(NULL, size, PROT_READ, mapflags, -1, 0);
>         FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
>
>         if (seal) {
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -61,17 +61,6 @@ static int sys_mseal(void *start, size_t
>         return sret;
>  }
>
> -static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
> -       unsigned long flags, unsigned long fd, unsigned long offset)
> -{
> -       void *sret;
> -
> -       errno =3D 0;
> -       sret =3D (void *) syscall(__NR_mmap, addr, len, prot,
> -               flags, fd, offset);
> -       return sret;
> -}
> -
>  static inline int sys_mprotect(void *ptr, size_t size, unsigned long pro=
t)
>  {
>         int sret;
> @@ -87,7 +76,7 @@ static bool seal_support(void)
>         void *ptr;
>         unsigned long page_size =3D getpagesize();
>
> -       ptr =3D sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_=
PRIVATE, -1, 0);
> +       ptr =3D mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIV=
ATE, -1, 0);
>         if (ptr =3D=3D (void *) -1)
>                 return false;
>
>
>

