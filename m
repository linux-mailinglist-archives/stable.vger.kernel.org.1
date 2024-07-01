Return-Path: <stable+bounces-56284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FC91EA5F
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77521F254AE
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26AF16CD28;
	Mon,  1 Jul 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVHhwud/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32597168D0
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869531; cv=none; b=T56aRx0Cg6ZbBaDXIXI6cm2fOl69gAOefgSLQc9vr4nDa8967n6SnGhC0lNayJOrGHQxvs6VGckiItThtom03URx3ZMZ6LwQyKOHXexlhFZK1+lQykk/kzl4dhRoYV6jk3ydbN85M4m9FBvqJv8FtPzYb02sbgeCsbjH4h7tvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869531; c=relaxed/simple;
	bh=tEUarioCUcFbNaP2RfuhoLjmS+WOS0rQMGx8A45M7DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyT9n2876qADm6gPicICc+pBSqYE2h7btlMRNucBQcRMRKjJT0FDrynM+qE0bsvZUNCh5Ox/crGP+cCcjAH/1LCKGQjbMj3Sx/Eg8KTXxqNbGPKxMadkvZItbsVYEOufrVF4WxqABEnU0tbYxknzJJ5CwlMKj4HcMExtN/eMKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IVHhwud/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-444fe7e9f11so684191cf.0
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719869529; x=1720474329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J67WCzSlHWFlY+A0bs0l9CZDhvuEPnOb2uXCOASkodI=;
        b=IVHhwud/zfLQIbn58QsKQsL3whsnz7AViRU0ou1kwBl7FGSslNBm0w4lF7X8sfHKzv
         YMKN3zP5rhzOFHbzCumzC+2KIf8WSUzX2DiO7V8MEi6sy5dBqzozEF+aVvAr/JxnxcZc
         OmerQ+zFleeamSPwUpBcSE3OH/JlcCJw9GNZrVlpcw2R0zd+qxPKtpIWb1GaolrQAI6P
         w1XWn735jrV6d8eFEv3NmgN6Lm569mKb0e4LmeOvXS4df+rEbw2mk3PVN5+6tX3ztyPI
         /LyyAh2niOqM1neZXEhXKuFzr6GuRNffSgwmCD5vcy0sVur6i8aLwz9ZIhFBotGRfiSI
         VUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869529; x=1720474329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J67WCzSlHWFlY+A0bs0l9CZDhvuEPnOb2uXCOASkodI=;
        b=DHvmIXjIPEO9X/wM+A7C9hF3yExfv6Sbay5BHcD6GdRi0sT1IthHinGTsQBuZBSpyd
         +VYrWjOVYUm7TTjSWHSTV1op1i2WwrN9NAnz0ASUPkkhjyQoxKEM8jb0Ixg3DhfjBvq5
         n8mOwUoaSM1kjzkIAKjvUnGGtVN3QvKV4kwOAYrKTFoiVJD4N9e/7kSbGMbiH37Bkkk9
         lZBSx3hUdXerXQkpDn+GdZO68J9CMBnON3Vl8AUioMSevjFRBnEUFYuINfIInL+gV27T
         zJs38lONXZXUtrfuKkYaloXvSvvhGRTjSTKMHGAkrhzCtd//g+0kM+5Pf64LocgGN+xN
         Rc+A==
X-Forwarded-Encrypted: i=1; AJvYcCUE7us0e3eW9NX/7EyXZjsfAFvNTF2/r8deqlYqwrALKZMTIREJ3bxDcMHUBbajNefVbfzDiIZ/5vVnbHxzbWJbfWMjU+JH
X-Gm-Message-State: AOJu0YzWbKJKrA/fq6JnDQQAdhyRbtXO+rDVHU+zfcVlchzZNXKzWYLH
	qoGvgD08HpxhZhFHLHqVVRjYrWtT9n67A26td2WNKNX1BNJd/FMhAtHkgGVN72fAF10iyVB6uhk
	engKS6eIK/q/ZgkTC2zaYXaOdaJoHM/7XaB/L
X-Google-Smtp-Source: AGHT+IEH0ZITXe2UCv0cCHd5aHLEsR7t11euWOBqlLR/sVZ1A0ADj29+NfF1nQB1AvlbSYyoohooEFV9znnGPJZS9rQ=
X-Received: by 2002:ac8:4d51:0:b0:444:ccfc:fd with SMTP id d75a77b69052e-4465def170emr5251491cf.3.1719869529008;
 Mon, 01 Jul 2024 14:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630184912.37335-1-pobrn@protonmail.com>
In-Reply-To: <20240630184912.37335-1-pobrn@protonmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 1 Jul 2024 14:31:28 -0700
Message-ID: <CALmYWFv-y9N2pK-Rq9GY4duHynWCUrwi2BRnoihoNzLHVNvTUg@mail.gmail.com>
Subject: Re: [PATCH v4] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com, 
	david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, 
	hughd@google.com, jorgelo@chromium.org, keescook@chromium.org, 
	skhan@linuxfoundation.org, stable@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Jun 30, 2024 at 11:49=E2=80=AFAM Barnab=C3=A1s P=C5=91cze <pobrn@pr=
otonmail.com> wrote:
>
> `MFD_NOEXEC_SEAL` should remove the executable bits and set `F_SEAL_EXEC`
> to prevent further modifications to the executable bits as per the commen=
t
> in the uapi header file:
>
>   not executable and sealed to prevent changing to executable
>
> However, commit 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EX=
EC")
> that introduced this feature made it so that `MFD_NOEXEC_SEAL` unsets
> `F_SEAL_SEAL`, essentially acting as a superset of `MFD_ALLOW_SEALING`.
>
> Nothing implies that it should be so, and indeed up until the second vers=
ion
> of the of the patchset[0] that introduced `MFD_EXEC` and `MFD_NOEXEC_SEAL=
`,
> `F_SEAL_SEAL` was not removed, however, it was changed in the third revis=
ion
> of the patchset[1] without a clear explanation.
>
> This behaviour is surprising for application developers, there is no
> documentation that would reveal that `MFD_NOEXEC_SEAL` has the additional
> effect of `MFD_ALLOW_SEALING`. Additionally, combined with `vm.memfd_noex=
ec=3D2`
> it has the effect of making all memfds initially sealable.
>
The documentation is in linux main (653c5c75115c), I hope this gives
clarity to the usage of MFD_NOEXEC_SEAL flag to application
developers, furthermore I'm working on man page for memfd_create.

> So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested,
> thereby returning to the pre-Linux 6.3 behaviour of only allowing
> sealing when `MFD_ALLOW_SEALING` is specified.
>
> Now, this is technically a uapi break. However, the damage is expected
> to be minimal. To trigger user visible change, a program has to do the
> following steps:
>
>  - create memfd:
>    - with `MFD_NOEXEC_SEAL`,
>    - without `MFD_ALLOW_SEALING`;
>  - try to add seals / check the seals.
>
> But that seems unlikely to happen intentionally since this change
> essentially reverts the kernel's behaviour to that of Linux <6.3,
> so if a program worked correctly on those older kernels, it will
> likely work correctly after this change.
>
During V3 patch discussion,  I sent my reasoning, but here are summaries:

- As one might have noticed, unlike other flags in memfd_create,
MFD_NOEXEC_SEAL is actually a combination of multiple flags. The idea
is to make it easier to use memfd in the most common way, which is
NOEXEC + F_SEAL_EXEC + MFD_ALLOW_SEALING.

- The new sysctl vm.noexec =3D 1 helps existing applications move to a
more secure way of using memfd. IMO, MFD_ALLOW_SEALING is included by
default because most applications would rather have it than not. In
any case, an app can set F_SEAL_SEAL to disable the sealing.

- MFD_NOEXEC_SEAL has been added for more than one year, multiple
applications and distributions have backported and utilized it.
Altering ABI now presents a degree of risk and may lead to
disruptions.

Best regards,
-Jeff

> I have used Debian Code Search and GitHub to try to find potential
> breakages, and I could only find a single one. dbus-broker's
> memfd_create() wrapper is aware of this implicit `MFD_ALLOW_SEALING`
> behaviour, and tries to work around it[2]. This workaround will
> break. Luckily, this only affects the test suite, it does not affect
> the normal operations of dbus-broker. There is a PR with a fix[3].
>
> I also carried out a smoke test by building a kernel with this change
> and booting an Arch Linux system into GNOME and Plasma sessions.
>
> There was also a previous attempt to address this peculiarity by
> introducing a new flag[4].
>
> [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@google.c=
om/
> [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@google.c=
om/
> [2]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46=
f267d4a8784cb/src/util/misc.c#L114
> [3]: https://github.com/bus1/dbus-broker/pull/366
> [4]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead=
.eu/
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> ---
>
> * v3: https://lore.kernel.org/linux-mm/20240611231409.3899809-1-jeffxu@ch=
romium.org/
> * v2: https://lore.kernel.org/linux-mm/20240524033933.135049-1-jeffxu@goo=
gle.com/
> * v1: https://lore.kernel.org/linux-mm/20240513191544.94754-1-pobrn@proto=
nmail.com/
>
> This fourth version returns to removing the inconsistency as opposed to d=
ocumenting
> its existence, with the same code change as v1 but with a somewhat extend=
ed commit
> message. This is sent because I believe it is worth at least a try; it ca=
n be easily
> reverted if bigger application breakages are discovered than initially im=
agined.
>
> ---
>  mm/memfd.c                                 | 9 ++++-----
>  tools/testing/selftests/memfd/memfd_test.c | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 7d8d3ab3fa37..8b7f6afee21d 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
>
>                 inode->i_mode &=3D ~0111;
>                 file_seals =3D memfd_file_seals_ptr(file);
> -               if (file_seals) {
> -                       *file_seals &=3D ~F_SEAL_SEAL;
> +               if (file_seals)
>                         *file_seals |=3D F_SEAL_EXEC;
> -               }
> -       } else if (flags & MFD_ALLOW_SEALING) {
> -               /* MFD_EXEC and MFD_ALLOW_SEALING are set */
> +       }
> +
> +       if (flags & MFD_ALLOW_SEALING) {
>                 file_seals =3D memfd_file_seals_ptr(file);
>                 if (file_seals)
>                         *file_seals &=3D ~F_SEAL_SEAL;
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/s=
elftests/memfd/memfd_test.c
> index 95af2d78fd31..7b78329f65b6 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
>                             mfd_def_size,
>                             MFD_CLOEXEC | MFD_NOEXEC_SEAL);
>         mfd_assert_mode(fd, 0666);
> -       mfd_assert_has_seals(fd, F_SEAL_EXEC);
> +       mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
>         mfd_fail_chmod(fd, 0777);
>         close(fd);
>  }
> --
> 2.45.2
>
>

