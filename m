Return-Path: <stable+bounces-166954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B75B1FA71
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478061896D91
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD98243374;
	Sun, 10 Aug 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE/b6jb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A127462;
	Sun, 10 Aug 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836470; cv=none; b=ZGeH16v70T7xSMRMjzLQZ92VHbdK2QjXQdQBzc/YRAeYxMYvsJvIF3nbXQUiPMbX9qnJZQf/J/rhFGRn2xfVMv8W+2oDOeMT5rY0KkdOTUfUDWduJSAyDrGuvmd7CNxVtx29+FpTOZLV6cEFjvhxlJsY85zaaoIhnAIUF4zSijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836470; c=relaxed/simple;
	bh=Vs6zCVzNYOOBeaFgHyVlLxbYIuRdFhTAig9mwdgEfDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j49ZlWtU6KpHIaq3AMO5KN2BhZhteiaCmph/VSw4uEUvboadsbnPIrziqzvsgqU7x7klrEivcJ7xTIkZKbWsrMlKdb7TozyvF4D2CskyFFx0h9UI626ec0i6kSAU8a78MQKgssmy8OG/jfAVORK5U/b3PvNYgMWwFY63CIKh/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE/b6jb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1BEC4CEF9;
	Sun, 10 Aug 2025 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754836469;
	bh=Vs6zCVzNYOOBeaFgHyVlLxbYIuRdFhTAig9mwdgEfDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bE/b6jb8qYgeLQqPPzjS7lIcQt7MSLTioMwQiWOl4zLFfoQVSokaOMVi0HbJ+q99U
	 1HhhWeTBO/p9pYEfQ2T3irZMpCLD3c/n1e216b7sH8xAJ2NFPo16mtxeFJgNTfBxWV
	 GMeL/6fSnEIR8DXApCWYNRqWkFEuBMtfkVRziWWctxZZEM1xYTbx6/B6aGqH5iX+JQ
	 pqrqutzB0iftz3Xkdg171jGKWT6+wx+8a+/rc5NKdjbJzfpenaOVB/gqHT4/nOAvx8
	 Fy4g+IRIogu8REQOk9flilF1eSzWQLi0zqj6TnbEz4StoUq3nqnZiafwNtHBhkuzVo
	 XcZpRvEquyhHQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso6438182a12.1;
        Sun, 10 Aug 2025 07:34:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfD5ljrnRKseTWUq8Xckk5DbgkCUY5dNVIuD20cFGIXfzF+Hsl5ahdBTY802D+3YCWwYecz3uq@vger.kernel.org, AJvYcCVtUuVrx9n+/xVPdQR6FNkMLxQ/ZNRkhILFcX6sNvNVJu/Pr2ndrQP0n6WFfLk6KmELBLlUnDVEdPZDABs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY58obNyRy41G4WDyHc40dRmfO3l4lAX8xbNk6O+QPu49y3NlZ
	QQYiSmDiPA/fOf73gqyptsSrA7mOHRS6mtizjEjIQJaBdeU3+TuSh3yl8A2LfrG+h0Ic6KWtC7v
	JOcBvm8p0cr6BEtdTiDgjr/tC/axPpAw=
X-Google-Smtp-Source: AGHT+IG4o84/rM7QVQPWh7TEB1TD66BC3/NtSFnHTksgcfeKzFYNg4vkE3t6ZzTFlBzTgE7WDqS1OXBxCK5OvRJhOis=
X-Received: by 2002:a17:906:d542:b0:af9:1ee4:a30c with SMTP id
 a640c23a62f3a-af9c64d3cfbmr962040166b.36.1754836468386; Sun, 10 Aug 2025
 07:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721101343.3283480-1-chenhuacai@loongson.cn>
In-Reply-To: <20250721101343.3283480-1-chenhuacai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 10 Aug 2025 22:34:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4TToP7AY8yMUjikTLChMpMQMB1=HRaMDS7Ern5nf92Fg@mail.gmail.com>
X-Gm-Features: Ac12FXxpVhYI7CqxcRy_NIXh4NRe49UwUMvXTV70a1B4VMSu132CrmAPg_2WB9I
Message-ID: <CAAhV-H4TToP7AY8yMUjikTLChMpMQMB1=HRaMDS7Ern5nf92Fg@mail.gmail.com>
Subject: Re: [PATCH V3] init: Handle bootloader identifier in kernel parameters
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andrew,

Can you take this patch to linux-mm (seems the best tree for it)?

Huacai

On Mon, Jul 21, 2025 at 6:14=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> BootLoader (Grub, LILO, etc) may pass an identifier such as "BOOT_IMAGE=
=3D
> /boot/vmlinuz-x.y.z" to kernel parameters. But these identifiers are not
> recognized by the kernel itself so will be passed to user space. However
> user space init program also doesn't recognized it.
>
> KEXEC/KDUMP (kexec-tools) may also pass an identifier such as "kexec" on
> some architectures.
>
> We cannot change BootLoader's behavior, because this behavior exists for
> many years, and there are already user space programs search BOOT_IMAGE=
=3D
> in /proc/cmdline to obtain the kernel image locations:
>
> https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
> (search getBootOptions)
> https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
> (search getKernelReleaseWithBootOption)
>
> So the the best way is handle (ignore) it by the kernel itself, which
> can avoid such boot warnings (if we use something like init=3D/bin/bash,
> bootloader identifier can even cause a crash):
>
> Kernel command line: BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.x root=3D/dev/sda3 ro=
 console=3Dtty
> Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.x"=
, will be passed to user space.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Update comments and commit messages.
> V3: Document bootloader identifiers.
>
>  init/main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/init/main.c b/init/main.c
> index 225a58279acd..b25e7da5347a 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -545,6 +545,12 @@ static int __init unknown_bootoption(char *param, ch=
ar *val,
>                                      const char *unused, void *arg)
>  {
>         size_t len =3D strlen(param);
> +       /*
> +        * Well-known bootloader identifiers:
> +        * 1. LILO/Grub pass "BOOT_IMAGE=3D...";
> +        * 2. kexec/kdump (kexec-tools) pass "kexec".
> +        */
> +       const char *bootloader[] =3D { "BOOT_IMAGE=3D", "kexec", NULL };
>
>         /* Handle params aliased to sysctls */
>         if (sysctl_is_alias(param))
> @@ -552,6 +558,12 @@ static int __init unknown_bootoption(char *param, ch=
ar *val,
>
>         repair_env_string(param, val);
>
> +       /* Handle bootloader identifier */
> +       for (int i =3D 0; bootloader[i]; i++) {
> +               if (!strncmp(param, bootloader[i], strlen(bootloader[i]))=
)
> +                       return 0;
> +       }
> +
>         /* Handle obsolete-style parameters */
>         if (obsolete_checksetup(param))
>                 return 0;
> --
> 2.47.3
>

