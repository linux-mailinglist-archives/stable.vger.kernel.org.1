Return-Path: <stable+bounces-50129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA77B902F27
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 05:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD781F21866
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 03:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6215B0E2;
	Tue, 11 Jun 2024 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtdLMpoz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A43823DC
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718076796; cv=none; b=kU5ww0c7RgP7z2qEL8Qz/Z6B7izDh4kTxNsz2B0IMFAvQcwU14dsUshjQPplEHu6QF0yCS9hxIE2M2MYj1w7GDY3QlL+2RivvYEAuyZ95EAl2v6WSHDM5Y7JGFu1sRKwjzPeJW5iPMqPAF79hvZthZLstOcE1YgsWfW+YE/Ay0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718076796; c=relaxed/simple;
	bh=sboedjcB+qsri74umYxpcPhwqiTNNKAEpebDcDkD6a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaT+gU502SGCn6Fjgz+UtWCJ5zFw+hGKU5MA9WT1s+NO/+DAmh/w+DWo10qLhWLYnA6vsjr8CO+dfMMx6rd6wFgsdHXBvsGgREInuNJSRzzLp+66WSV493ANygZUFj1CKFrWxlC2MXPixylnoPLnvJxsXQtCyMdYEruYwU38Azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtdLMpoz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so34335e9.0
        for <stable@vger.kernel.org>; Mon, 10 Jun 2024 20:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718076793; x=1718681593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePFKPNMhKZdDDrvKMpPDc1jN82wnN2cdCBgWMIF8/6g=;
        b=TtdLMpozk7lWIYqXrZmvwd7JZSOa2Sa8+xyzAvZyL5OFrDqk1rzAsBlbKON6+w3HYY
         DYi53tHWjEUbb/Vfht1vVYzsO910KHyEu9RSI5kGUN9Kkprnv14yONyy2L6C4Lw5OYbq
         GJZpnYk3OBYSnMtwOhqNuqwWKAq6OU+M6srWsN2LfU+egu+olUMrGmJYvaS6mDA5JdVi
         N3tjuH/LXeCmHMLZR+rioubeuzHfqEgY+dDW02QC1LMHHt/0zX2bbO4JYHDwr/Tgkk8B
         R/CBtqvuYgvg+HDfXBtO+i3/RS1TLeVjB74wb7eOtEZK3b8ik5MAXP2FKaZOGIUBdaYu
         LNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718076793; x=1718681593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePFKPNMhKZdDDrvKMpPDc1jN82wnN2cdCBgWMIF8/6g=;
        b=uGUcNXbWvPbALkQCD22knK6i7LW0yDrkXC0tdkLHC9TVF7Jv+hbBMEuj/6zk5TD8Mh
         P3L/SLSZuxHkbnkzdNM1oEm8KXUS3aNI4soyTK+SE2a/zDg9G718xQ+DdaHGzx8e9d1h
         xY1x2tu1KXgw0fcaiPdowk+oiEo6MNDGTTVrh2AeU5I4XG3c9y1BmMDno//9NeqppEEa
         Nk854/AHjqBDaMGaLt7ThbFnSBjxJbK3FNCWYXMecV59ncaIHArUXa12TO+k9BSF4YUt
         1yCVtzPx5SypThX0LfJLqXCk8RQQxk+oXaFMlLIholvo6T4u8tzaHLoAsvhIka7rH24l
         3Kxw==
X-Forwarded-Encrypted: i=1; AJvYcCVix+bppy5satlMxKyJefZve6rDgITUEsfGNS7idfqOJRN57aIX+wEjjxTbzcAmBxkEzEs7uWttbqOfoc+wQ965sLJ2ghTn
X-Gm-Message-State: AOJu0YzGcP+RQ0UrPHHd7kxcmRIlCLbNUE1I5aWnlZb9dh7WhzAnz5oY
	JQxQwFmoyZZ2Sn1Ckf2JiXTTVobc+GnpD54wNqp0ewgZQbitRC/efod8aLYVAV844X6tDpdGzV3
	NPHHML9Tucz+3Tzx53M7Mql4t/9+r4nqqjY4s
X-Google-Smtp-Source: AGHT+IEUcxp+C1A/Jggd8QcKnMypQqdR9xeaYlLV+2Z4rrd05nHiQ8EugdpV2M6uIdB5pd7qUtCWqPBVtG1WDOnfl0s=
X-Received: by 2002:a05:600c:1f12:b0:421:89d4:2928 with SMTP id
 5b1f17b1804b1-422558cfce1mr474365e9.7.1718076792552; Mon, 10 Jun 2024
 20:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607203543.2151433-1-jeffxu@google.com> <20240607203543.2151433-2-jeffxu@google.com>
 <0988dfae-69d0-4fbf-b145-15f6e853cbcc@infradead.org>
In-Reply-To: <0988dfae-69d0-4fbf-b145-15f6e853cbcc@infradead.org>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 10 Jun 2024 20:32:34 -0700
Message-ID: <CALmYWFvuRsTZSx3E1BhnwxHL3Qn-wQF9th2JkXwpFcO9at_9vw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
To: Randy Dunlap <rdunlap@infradead.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, cyphar@cyphar.com, 
	david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, 
	hughd@google.com, jorgelo@chromium.org, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pobrn@protonmail.com, skhan@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jun 10, 2024 at 7:20=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi--
>
> On 6/7/24 1:35 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for memfd_create flags: FMD_NOEXEC_SEAL
>
> s/FMD/MFD/
>
> > and MFD_EXEC
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
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
> > index 000000000000..0d2c840f37e1
> > --- /dev/null
> > +++ b/Documentation/userspace-api/mfd_noexec.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Introduction of non executable mfd
>
>                    non-executable mfd
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
> > +Since Linux introduced the memfd feature, memfd have always had their
>
>                                              memfds
> i.e., plural
>
> > +execute bit set, and the memfd_create() syscall doesn't allow setting
> > +it differently.
> > +
> > +However, in a secure by default system, such as ChromeOS, (where all
>
>                  secure-by-default
>
> > +executables should come from the rootfs, which is protected by Verifie=
d
> > +boot), this executable nature of memfd opens a door for NoExec bypass
> > +and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug=
 [1]: cros_vm
> > +process created a memfd to share the content with an external process,
> > +however the memfd is overwritten and used for executing arbitrary code
> > +and root escalation. [2] lists more VRP in this kind.
>
>                                            of this kind.
>
> > +
> > +On the other hand, executable memfd has its legit use, runc uses memfd=
=E2=80=99s
>
>                                                      use:
>
> > +seal and executable feature to copy the contents of the binary then
> > +execute them, for such system, we need a solution to differentiate run=
c's
>
>            them. For such a system,
>
> > +use of  executable memfds and an attacker's [3].
> > +
> > +To address those above.
>
>                     above:
>
> > + - Let memfd_create() set X bit at creation time.
> > + - Let memfd be sealed for modifying X bit when NX is set.
> > + - A new pid namespace sysctl: vm.memfd_noexec to help applications to
>
>     - Add a new                                           applications in
>
> > +   migrating and enforcing non-executable MFD.
> > +
> > +User API
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +``int memfd_create(const char *name, unsigned int flags)``
> > +
> > +``MFD_NOEXEC_SEAL``
> > +     When MFD_NOEXEC_SEAL bit is set in the ``flags``, memfd is create=
d
> > +     with NX. F_SEAL_EXEC is set and the memfd can't be modified to
> > +     add X later. MFD_ALLOW_SEALING is also implied.
> > +     This is the most common case for the application to use memfd.
> > +
> > +``MFD_EXEC``
> > +     When MFD_EXEC bit is set in the ``flags``, memfd is created with =
X.
> > +
> > +Note:
> > +     ``MFD_NOEXEC_SEAL`` implies ``MFD_ALLOW_SEALING``. In case that
> > +     app doesn't want sealing, it can add F_SEAL_SEAL after creation.
>
>         an app
>
> > +
> > +
> > +Sysctl:
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +``pid namespaced sysctl vm.memfd_noexec``
> > +
> > +The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> > +
> > + - 0: MEMFD_NOEXEC_SCOPE_EXEC
> > +     memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> > +     MFD_EXEC was set.
> > +
> > + - 1: MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> > +     memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> > +     MFD_NOEXEC_SEAL was set.
> > +
> > + - 2: MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
> > +     memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> > +
> > +The sysctl allows finer control of memfd_create for old-software that
>
>                                                        old software
>
> > +doesn't set the executable bit, for example, a container with
>
>                               bit;
>
> > +vm.memfd_noexec=3D1 means the old-software will create non-executable =
memfd
>
>                                old software
>
> > +by default while new-software can create executable memfd by setting
>
>                     new software
>
> > +MFD_EXEC.
> > +
> > +The value of vm.memfd_noexec is passed to child namespace at creation
> > +time, in addition, the setting is hierarchical, i.e. during memfd_crea=
te,
>
>    time. In addition,
>
Updated in V2.
Thanks!
-Jeff

> > +we will search from current ns to root ns and use the most restrictive
> > +setting.
> > +
> > +[1] https://crbug.com/1305267
> > +
> > +[2] https://bugs.chromium.org/p/chromium/issues/list?q=3Dtype%3Dbug-se=
curity%20memfd%20escalation&can=3D1
> > +
> > +[3] https://lwn.net/Articles/781013/
>
> --
> ~Randy

