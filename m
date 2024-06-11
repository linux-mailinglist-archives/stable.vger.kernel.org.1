Return-Path: <stable+bounces-50181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6D904771
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 01:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE2A286C78
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 23:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00B154BFF;
	Tue, 11 Jun 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1xfI8EO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883A23774
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147080; cv=none; b=MaPH2wh6Ea7JoTWIDDNjVwiKInwcHU3DMmJ1cvN9lfm2g/F4eJtyAtRj1i+eIUNqxJaVUTqTj+htOLSr1Z2wcC2RiA3Bk4p2ycNyvYQZ2URAKPpSvbDOoYCZzBszJSZhIsu3PD0ZZZ6IWsILLvUpNXUeSBVccADwRomdJe0aaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147080; c=relaxed/simple;
	bh=T8OozrZR+1vkIaOz0Hl0kOkEndiy3BvvGmc+cmCPeVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1LuO0Ycj0AhBNm1l50QkH1Hmob6f2gXwIHGKl27CPX5ULc/dQqyaPmeywFwoMfsyqcyayOpnoYIfobx7SxWVg9AOEoFm5aLgblfqWaV9h4cJOTS1HvOE6f1OdQ7f3pOPvqFEXkwNFMnO3VkhoJMCHWvhxW6MY7EOhE66fOc5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1xfI8EO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso7009a12.0
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718147077; x=1718751877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtbvaoMsCJ9k1mz6SgmK+4gae6eOunhj2wDuCSNJ/mk=;
        b=X1xfI8EOfeGhBs02hzzC/mvZhmC3X2sHmvVhnuQ9nm7ZA5CFPkfzuDse7x/9/TA7UC
         rZUnvbxdprr/kKExu9m2gqwyBa2IT9sxDlkWw9Lsk0guRkjn3zaxgjp2l6RsRCVQ97SK
         3KWhIvrRvDW5jfbCccjjidi+u0X5um3Wqdtls1rOCNOEo6hgjAadPDgO1RiwFH5Wi36F
         bIdSikjwMczp770rK1Hv8N3/0ntZm7cBS6a9bBYPfwklOQ6918z2zUqkUrhVESATQRg5
         e3jJd5lUMwV2AhQIwDecd57iK94Nx6BJs4jzHHBpHUr9dcB9MHtjKH+5w4c2+W66U6V/
         cq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718147077; x=1718751877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtbvaoMsCJ9k1mz6SgmK+4gae6eOunhj2wDuCSNJ/mk=;
        b=KxJWgP0q1ZdVc1c1gr13uBUgHNn77+Sl0Ik+/svD+KdQIYRfMH5ANeN8dDw1wo3x/I
         OiGnOpCMEX5kMvPRqXN4NIDUCfhCgJoipJ97fcp8vmVK5T8NCNN8Jf6JdbJnKy6AUJFY
         x7Y87/jjghpcHTJg+y+Y2DhhPIb3q6pBf6ccyfQ32ViEjX11oeUQvuOscfg9rA/FEWL4
         jLF+KOR8+vtswp8XeXaDn55abfEb6X9lbPAV0qtlDgaunoZL2Xb6ThNo2J7mkCs6Y7FM
         tsLPv4rLnWA/q9Uz+sn0GU9trtXQET7KwCpMT8+F+OLHQC7cP+d8qZB+5QSIg71EdDZ7
         zHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY8nq/exY5b3f2ewfKBGqAul4/RPkOJZo3oGtSoCo1W2H849X4Ene8a7/XbXoSxg6GkrS5ay+gPZ6rvCHit0B+n09vCh5M
X-Gm-Message-State: AOJu0YzfCFsNoToQ4SlKISh3CPmiVTYuMQnOCjSD0smQJZNqPp47vx/j
	U/HGFzQRLe8o1llhe1pWaxSr+vML/Li55DcijMhqJKEHJ3xpgY6QZrqT61CuNEnY5DUj9iLRz7/
	7QDPkVIycNqIYLLwN/1KjUXfpdkFQ4BWUjSJf
X-Google-Smtp-Source: AGHT+IGIJEs3b4nVQ+XCokKeptQYXIP66wVTDYCQxFkmqQBnlc+C3z0gcSGRO9hqtyBT+VZVapa4wwHBMpUt3Pry/L8=
X-Received: by 2002:a05:6402:38a:b0:57c:ab3f:d200 with SMTP id
 4fb4d7f45d1cf-57cab3fd29amr7343a12.0.1718147075504; Tue, 11 Jun 2024 16:04:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611034903.3456796-1-jeffxu@chromium.org> <20240611034903.3456796-2-jeffxu@chromium.org>
 <595b6353-6da6-432b-96b4-42c4e3ec1146@infradead.org>
In-Reply-To: <595b6353-6da6-432b-96b4-42c4e3ec1146@infradead.org>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 11 Jun 2024 16:03:56 -0700
Message-ID: <CALmYWFvxAvG1ZmbmZf=VedTdwEq8Yz36Xp8o9rhw=Wfae1ei8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
To: Randy Dunlap <rdunlap@infradead.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, cyphar@cyphar.com, 
	david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, 
	hughd@google.com, jorgelo@chromium.org, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pobrn@protonmail.com, skhan@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:41=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 6/10/24 8:49 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for memfd_create flags: MFD_NOEXEC_SEAL
> > and MFD_EXEC
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >
> > ---
> >  Documentation/userspace-api/index.rst      |  1 +
> >  Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >  create mode 100644 Documentation/userspace-api/mfd_noexec.rst
> >
> > diff --git a/Documentation/userspace-api/index.rst b/Documentation/user=
space-api/index.rst
> > index 5926115ec0ed..8a251d71fa6e 100644
> > --- a/Documentation/userspace-api/index.rst
> > +++ b/Documentation/userspace-api/index.rst
> > @@ -32,6 +32,7 @@ Security-related interfaces
> >     seccomp_filter
> >     landlock
> >     lsm
> > +   mfd_noexec
> >     spec_ctrl
> >     tee
> >
> > diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation=
/userspace-api/mfd_noexec.rst
> > new file mode 100644
> > index 000000000000..ec6e3560fbff
> > --- /dev/null
> > +++ b/Documentation/userspace-api/mfd_noexec.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Introduction of non executable mfd
>
> Missed:
>                    non-executable
>
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +:Author:
> > +    Daniel Verkamp <dverkamp@chromium.org>
> > +    Jeff Xu <jeffxu@chromium.org>
> > +
> > +:Contributor:
> > +     Aleksa Sarai <cyphar@cyphar.com>
> > +
> > +Since Linux introduced the memfd feature, memfds have always had their
> > +execute bit set, and the memfd_create() syscall doesn't allow setting
> > +it differently.
> > +
> > +However, in a secure-by-default system, such as ChromeOS, (where all
> > +executables should come from the rootfs, which is protected by verifie=
d
> > +boot), this executable nature of memfd opens a door for NoExec bypass
> > +and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug=
 [1]: cros_vm
> > +process created a memfd to share the content with an external process,
> > +however the memfd is overwritten and used for executing arbitrary code
> > +and root escalation. [2] lists more VRP of this kind.
> > +
> > +On the other hand, executable memfd has its legit use: runc uses memfd=
=E2=80=99s
> > +seal and executable feature to copy the contents of the binary then
> > +execute them. For such a system, we need a solution to differentiate r=
unc's
> > +use of executable memfds and an attacker's [3].
> > +
> > +To address those above:
> > + - Let memfd_create() set X bit at creation time.
> > + - Let memfd be sealed for modifying X bit when NX is set.
> > + - Add a new pid namespace sysctl: vm.memfd_noexec to help application=
s to
>
>                                                          help application=
s in
>
> > +   migrating and enforcing non-executable MFD.
> > +
> > +User API
> > +=3D=3D=3D=3D=3D=3D=3D=3D
>
> The rest looks good. Thanks.
>
Thanks for your review!

> --
> ~Randy

