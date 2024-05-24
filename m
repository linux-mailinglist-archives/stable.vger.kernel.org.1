Return-Path: <stable+bounces-46023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353F98CDFEB
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 05:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA2C280CA6
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 03:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173903838F;
	Fri, 24 May 2024 03:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLdv3F8i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00E23769
	for <stable@vger.kernel.org>; Fri, 24 May 2024 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522191; cv=none; b=bv0TY9CzipBG1dU6y1NQsFAP4ttTU+dHQ450R3xTT48L3GC4wupGXYrWLNToHE2NZKBOtcU/WIzPcltbiLhfb3nBmeSoGBll8aQLvRa5ZTp17+Xp1GCEXjSmTbWb47QTeYT9woPJ2IM2WCRHjK8cH81aQvhR78Axm1zW8Lpe+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522191; c=relaxed/simple;
	bh=nSEA/1vFW7rijht1ByiXZxWX/1rbgwYmbzpD+gGfsD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIyC4Yz7UoVULQoDF2hIJcvXag9A1Hp2AGIe5ES+u0lug4BqeR+It7czLZmJGKkA8z4UP1YhoBt55zds6jQfdvDKc9cEkVhmmnGbahfYx8wdiSxF8fh79I97z4lMHIfrkIfWYQRUsCRSVFO/FuN0vSMwBDWzkNGCHLiPS5j823g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLdv3F8i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso9665a12.0
        for <stable@vger.kernel.org>; Thu, 23 May 2024 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716522187; x=1717126987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36fhNvXOea7b3Tf4Od7riH5C3b7gBf7G4V+Hf3bEH/U=;
        b=iLdv3F8iTSMtzA5TjS3f7o6c8rrd952Qv9hP1EA9OCK+4095tEdQh0nK2tMznmVZod
         QGaGqqFjI529iRyOIYtL/EGvfBegENVHNjkXIezAhIBJzHdoWnGBtWH1pxFBqKIxQpG6
         o4UI3vWZ0kPvue6PWcHKlzW4qn2G71hpKMPvClQDnH6trmvt29C5cD7AU+EarZZKF9cO
         wcodhs0hcR4tEP+kBBaw3uaAz/OyWGfHas1zslcfC64MBuHQhlClMAQfLX6u13Nf3qgG
         SFlCB5wKxxEHcfLSGktex4CQGMJvh5cvY+Trd5HRB8JcXCjC0MSzMtsJv/rJX1RDOEft
         zNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716522187; x=1717126987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36fhNvXOea7b3Tf4Od7riH5C3b7gBf7G4V+Hf3bEH/U=;
        b=Edl4EKurU+LwMgks/Pu4coRl+PtzyvZBt3CJAqHfxZE4WguKVfeLvoXAmht52oBKoj
         Iij6ZXD/8fQbhXxIw+0hiIgX2u/gwqE93dklN/nGffe5gPLOpjiCxKcFg4/Q3Zt8hPeU
         AYxZGsvR+2LzOJ6AOKSzT3el7YfSvkb+cQ1DBnqz8jhoknqrIRaa1tf9qyynnktwPXuS
         I/csqObiUxP9DnfS/ddxtfo1DZrX1uICFOTV1zK2KnhY3vKVwUYV9PU4wiXaMOjmhgO4
         YTao9zPSl6rJrynIZq+rhghJeCyH8Uqaxd7HQ/chhBeGLtN3364+QInNzzMt4pVtgj9a
         kFeA==
X-Forwarded-Encrypted: i=1; AJvYcCXaBZk9QF3SL5dmvfTL/0kkzAVIb59hgIRgLdKkfq34vDeefXOUfBQzJeiPIKOhlN8VD3uJToKaXevOD6xZaXN8lULRILze
X-Gm-Message-State: AOJu0YwWEAJ38UT59pjDKgX1Rb6FXcG34n9IQYUsTSePqSuQJveB61Gm
	PtXqV0sauMI1XFb5Xwb5z2DQrvvnMi0vb5RmvJ0SiZiGZ1BCWuyUcFbd5/C9NxxmtHaTd+Yr2OC
	FHaQeYiFYOdRsB/bkQ44DoyWzLNxGeFXMcWRj
X-Google-Smtp-Source: AGHT+IEjJM7nXR383Y7RuODv6qPfDIg6HoQrAoxEtox77JWxz+8VbOtWYdPEiSvkEhf2h7OpL2GpIhnsI+AShbXul7g=
X-Received: by 2002:aa7:d547:0:b0:574:ea5c:fa24 with SMTP id
 4fb4d7f45d1cf-578551d9a15mr51779a12.3.1716522186873; Thu, 23 May 2024
 20:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033933.135049-1-jeffxu@google.com> <20240524033933.135049-3-jeffxu@google.com>
In-Reply-To: <20240524033933.135049-3-jeffxu@google.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 23 May 2024 20:42:27 -0700
Message-ID: <CALmYWFs8e4r390v5pepxZ4H6E=x_21jG1vjVYici5pgt5rTGxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memfd:add MEMFD_NOEXEC_SEAL documentation
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, cyphar@cyphar.com, dmitry.torokhov@gmail.com, 
	dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, 
	keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pobrn@protonmail.com, 
	skhan@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aleksa

On Thu, May 23, 2024 at 8:39=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> Add documentation for MFD_NOEXEC_SEAL and MFD_EXEC
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  Documentation/userspace-api/index.rst      |  1 +
>  Documentation/userspace-api/mfd_noexec.rst | 90 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/userspace-api/mfd_noexec.rst
>
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/usersp=
ace-api/index.rst
> index 5926115ec0ed..8a251d71fa6e 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -32,6 +32,7 @@ Security-related interfaces
>     seccomp_filter
>     landlock
>     lsm
> +   mfd_noexec
>     spec_ctrl
>     tee
>
> diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation/u=
serspace-api/mfd_noexec.rst
> new file mode 100644
> index 000000000000..6f11ad86b076
> --- /dev/null
> +++ b/Documentation/userspace-api/mfd_noexec.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Introduction of non executable mfd
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +:Author:
> +    Daniel Verkamp <dverkamp@chromium.org>
> +    Jeff Xu <jeffxu@google.com>
> +
> +:Contributor:
> +       Aleksa Sarai <cyphar@cyphar.com>
> +       Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> +       David Rheinsberg <david@readahead.eu>
> +
> +Since Linux introduced the memfd feature, memfd have always had their
> +execute bit set, and the memfd_create() syscall doesn't allow setting
> +it differently.
> +
> +However, in a secure by default system, such as ChromeOS, (where all
> +executables should come from the rootfs, which is protected by Verified
> +boot), this executable nature of memfd opens a door for NoExec bypass
> +and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug [=
1]: cros_vm
> +process created a memfd to share the content with an external process,
> +however the memfd is overwritten and used for executing arbitrary code
> +and root escalation. [2] lists more VRP in this kind.
> +
> +On the other hand, executable memfd has its legit use, runc uses memfd=
=E2=80=99s
> +seal and executable feature to copy the contents of the binary then
> +execute them, for such system, we need a solution to differentiate runc'=
s
> +use of  executable memfds and an attacker's [3].
> +
> +To address those above.
> + - Let memfd_create() set X bit at creation time.
> + - Let memfd be sealed for modifying X bit when NX is set.
> + - A new pid namespace sysctl: vm.memfd_noexec to help applications to
> +   migrating and enforcing non-executable MFD.
> +
> +User API
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +``int memfd_create(const char *name, unsigned int flags)``
> +
> +``MFD_NOEXEC_SEAL``
> +       When MFD_NOEXEC_SEAL bit is set in the ``flags``, memfd is create=
d
> +       with NX. F_SEAL_EXEC is set and the memfd can't be modified to
> +       add X later.
> +       This is the most common case for the application to use memfd.
> +
> +``MFD_EXEC``
> +       When MFD_EXEC bit is set in the ``flags``, memfd is created with =
X.
> +
> +Note:
> +       ``MFD_NOEXEC_SEAL`` and ``MFD_EXEC`` doesn't change the sealable
> +       characteristic of memfd, which is controlled by ``MFD_ALLOW_SEALI=
NG``.
> +
> +
> +Sysctl:
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +``pid namespaced sysctl vm.memfd_noexec``
> +
> +The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> +
> + - 0: MEMFD_NOEXEC_SCOPE_EXEC
> +       memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +       MFD_EXEC was set.
> +
> + - 1: MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> +       memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +       MFD_NOEXEC_SEAL was set.
> +
> + - 2: MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
> +       memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> +
> +The sysctl allows finer control of memfd_create for old-software that
> +doesn't set the executable bit, for example, a container with
> +vm.memfd_noexec=3D1 means the old-software will create non-executable me=
mfd
> +by default while new-software can create executable memfd by setting
> +MFD_EXEC.
> +
> +The value of memfd_noexec is passed to child namespace at creation time,
> +in addition, the setting is hierarchical, i.e. during memfd_create,
> +we will search from current ns to root ns and use the most restrictive
> +setting.
> +

Can you please help to review the sysctl part to check if  I captured
your change correctly ?

Thanks
-Jeff


> +Reference:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +[1] https://crbug.com/1305267
> +
> +[2] https://bugs.chromium.org/p/chromium/issues/list?q=3Dtype%3Dbug-secu=
rity%20memfd%20escalation&can=3D1
> +
> +[3] https://lwn.net/Articles/781013/
> --
> 2.45.1.288.g0e0cd299f1-goog
>

