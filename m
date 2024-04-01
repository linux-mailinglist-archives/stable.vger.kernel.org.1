Return-Path: <stable+bounces-35487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE228894555
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 21:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC311C21370
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404920DE7;
	Mon,  1 Apr 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vptv/EIu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C151C46
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998749; cv=none; b=AqiiBHckskKOlgwmMHjpYOa9/41oR7sQeRFUxmRYG7opWGdRK07dzBkcWK5aW95SuRE0LU5kJYaLvtxX6iq1ivHTwFn3LDc3wisOG7LkVUiRIFNV5VttMcSv+4m+xrHD3iMen2Zir2HVYOQDsWZiAzpu18gYTUMBa38mlqyqWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998749; c=relaxed/simple;
	bh=lZZgdgpRsCAM7XWp90WoIM3pYzhJNQF6JGgYWb3X5bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxuSxGmoai4m2iwQrKa9jhy83GTh7clwFT2fEs+65di7rfO1Vs2glgS8bhU6FD1kQifqZPBgbD9Y3DJHNoESGwmYb5k3pavIbdxdJBtWcFc8jWRE6BqVbWVEePuwYI+N9m+K6mIKgu9+8JE3APes/ny2tbnC4/XUen1IbW93aO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vptv/EIu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56ca3e11006so2372503a12.3
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711998746; x=1712603546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obzM0IGvE9A6DBXNxjXsovCrfa1fQhH1FBfKC4ISWA4=;
        b=Vptv/EIubwgd09yg//VGFdZ2al7QJR+OyCM1aEzIE/MKlzqEegsgrDG3wO4/+CRi3d
         GXmDyXcDerAOm/R1nmSn/IA36pfuXjX82p3+n0s/9fD7vpsDeoXKAWF97hCcs5BF6Svi
         JBI/tru3sFMFfkY6o1oZdgAngjz6ThBwjb7SkWFNEz+V2sjbZ0G5H/jHi/uQcgi5CF4J
         adXnGxg++dx7gh8S9uLdZji9R5HVPZJK9KA8z7gRMqz2bIpE4o0Dz7zH5W5OXkZBDjE2
         i99eiHjkcrGR9wjSPYn6Iu73sDDoPTKx+2yqZ2IQlCE9G6/N3ZdQZLTC6yVBK2Z1K//P
         UN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998746; x=1712603546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obzM0IGvE9A6DBXNxjXsovCrfa1fQhH1FBfKC4ISWA4=;
        b=iwsWP6l8UAwfzSORQ8P0F1Nd+zC0mAQvmjJDs9rbnrzwMN1ZC/2Ilyv/aMYwy5WR3q
         CLvtU29jfgbXQVlfFqSqOoGXVtO9ERJDqJf8CVso3LWvWz/78cvZjQgjfZWOvpzgs2C7
         XxgNoQljCszCidIKT7pOx4HYV/Xlfd+DXkmtCWiIifEghBdUILNRRZdsf1Kyj9qGJ8TL
         Vd2MVyP/l+q1/BCPgwj9wyZiybp8QEvgI6XEVCwu0I3xVBMryUe8Zz42bI2sMVENAym1
         pHqFJzfi+cDuF+APfUPNUw+CnIktKOMs02CR5RHct+D3FMfZRx4XUn9BAqzUBzvwQegh
         35Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUo91dn0xOCkTY3o0NXnuHZI5XiJUJ/mrsRTI7ppIQgDC0ckimYQBpzrwDNk8DZRm0CZX1L0M3DEKjI89P8eX9dUQhi3RaN
X-Gm-Message-State: AOJu0YyNqkxq/oqnwFVW2P6E6F7o2f3BtDiGbKmdO3HkEVFFEf+GNKE2
	Ld6Q1fVwUZtoDO+BFLkzwBUPHeI6nOiWrY5Y5Pjo7gDGBGoXX6PnZgCHCBeWLn/dfrgXGK2Vc/6
	x0nFZeMz43dJ/q/8EXYgWA4Onb9x1HCYsTr6I
X-Google-Smtp-Source: AGHT+IFrZn3P1g+mO8cYYJQ1aggkfW8cijER2IOdPjsyl9o0cR1x5wATnba0CgmMUUzNstTzMmB5e81d1T6aIF3k/Pw=
X-Received: by 2002:a17:906:cb86:b0:a47:2f8c:7614 with SMTP id
 mf6-20020a170906cb8600b00a472f8c7614mr6155069ejb.43.1711998746014; Mon, 01
 Apr 2024 12:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-bluetooth-fix-len-type-getsockopt_old-v1-1-c6b5448b5374@kernel.org>
In-Reply-To: <20240401-bluetooth-fix-len-type-getsockopt_old-v1-1-c6b5448b5374@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 1 Apr 2024 12:12:13 -0700
Message-ID: <CAFhGd8q7vomqQ27FRi-Bn4Dn0s-Qp_PLWS_jwLUi4TFC0KSbeQ@mail.gmail.com>
Subject: Re: [PATCH bluetooth] Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()
To: Nathan Chancellor <nathan@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com, 
	ndesaulniers@google.com, morbo@google.com, keescook@chromium.org, 
	linux-bluetooth@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:24=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> After an innocuous optimization change in LLVM main (19.0.0), x86_64
> allmodconfig (which enables CONFIG_KCSAN / -fsanitize=3Dthread) fails to
> build due to the checks in check_copy_size():
>
>   In file included from net/bluetooth/sco.c:27:
>   In file included from include/linux/module.h:13:
>   In file included from include/linux/stat.h:19:
>   In file included from include/linux/time.h:60:
>   In file included from include/linux/time32.h:13:
>   In file included from include/linux/timex.h:67:
>   In file included from arch/x86/include/asm/timex.h:6:
>   In file included from arch/x86/include/asm/tsc.h:10:
>   In file included from arch/x86/include/asm/msr.h:15:
>   In file included from include/linux/percpu.h:7:
>   In file included from include/linux/smp.h:118:
>   include/linux/thread_info.h:244:4: error: call to '__bad_copy_from' dec=
lared with 'error' attribute: copy source size is too small
>     244 |                         __bad_copy_from();
>         |                         ^
>
> The same exact error occurs in l2cap_sock.c. The copy_to_user()
> statements that are failing come from l2cap_sock_getsockopt_old() and
> sco_sock_getsockopt_old(). This does not occur with GCC with or without
> KCSAN or Clang without KCSAN enabled.
>
> len is defined as an 'int' because it is assigned from
> '__user int *optlen'. However, it is clamped against the result of
> sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
> platforms). This is done with min_t() because min() requires compatible
> types, which results in both len and the result of sizeof() being casted
> to 'unsigned int', meaning len changes signs and the result of sizeof()
> is truncated. From there, len is passed to copy_to_user(), which has a
> third parameter type of 'unsigned long', so it is widened and changes
> signs again. This excessive casting in combination with the KCSAN
> instrumentation causes LLVM to fail to eliminate the __bad_copy_from()
> call, failing the build.
>
> The official recommendation from LLVM developers is to consistently use
> long types for all size variables to avoid the unnecessary casting in
> the first place. Change the type of len to size_t in both
> l2cap_sock_getsockopt_old() and sco_sock_getsockopt_old(). This clears
> up the error while allowing min_t() to be replaced with min(), resulting
> in simpler code with no casts and fewer implicit conversions. While len
> is a different type than optlen now, it should result in no functional
> change because the result of sizeof() will clamp all values of optlen in
> the same manner as before.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2007
> Link: https://github.com/llvm/llvm-project/issues/85647
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  net/bluetooth/l2cap_sock.c | 7 ++++---
>  net/bluetooth/sco.c        | 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 4287aa6cc988..81193427bf05 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -439,7 +439,8 @@ static int l2cap_sock_getsockopt_old(struct socket *s=
ock, int optname,
>         struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
>         struct l2cap_options opts;
>         struct l2cap_conninfo cinfo;
> -       int len, err =3D 0;
> +       int err =3D 0;
> +       size_t len;
>         u32 opt;
>
>         BT_DBG("sk %p", sk);
> @@ -486,7 +487,7 @@ static int l2cap_sock_getsockopt_old(struct socket *s=
ock, int optname,
>
>                 BT_DBG("mode 0x%2.2x", chan->mode);
>
> -               len =3D min_t(unsigned int, len, sizeof(opts));
> +               len =3D min(len, sizeof(opts));
>                 if (copy_to_user(optval, (char *) &opts, len))
>                         err =3D -EFAULT;
>
> @@ -536,7 +537,7 @@ static int l2cap_sock_getsockopt_old(struct socket *s=
ock, int optname,
>                 cinfo.hci_handle =3D chan->conn->hcon->handle;
>                 memcpy(cinfo.dev_class, chan->conn->hcon->dev_class, 3);
>
> -               len =3D min_t(unsigned int, len, sizeof(cinfo));
> +               len =3D min(len, sizeof(cinfo));
>                 if (copy_to_user(optval, (char *) &cinfo, len))
>                         err =3D -EFAULT;
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 43daf965a01e..9a72d7f1946c 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -967,7 +967,8 @@ static int sco_sock_getsockopt_old(struct socket *soc=
k, int optname,
>         struct sock *sk =3D sock->sk;
>         struct sco_options opts;
>         struct sco_conninfo cinfo;
> -       int len, err =3D 0;
> +       int err =3D 0;
> +       size_t len;
>
>         BT_DBG("sk %p", sk);
>
> @@ -989,7 +990,7 @@ static int sco_sock_getsockopt_old(struct socket *soc=
k, int optname,
>
>                 BT_DBG("mtu %u", opts.mtu);
>
> -               len =3D min_t(unsigned int, len, sizeof(opts));
> +               len =3D min(len, sizeof(opts));
>                 if (copy_to_user(optval, (char *)&opts, len))
>                         err =3D -EFAULT;
>
> @@ -1007,7 +1008,7 @@ static int sco_sock_getsockopt_old(struct socket *s=
ock, int optname,
>                 cinfo.hci_handle =3D sco_pi(sk)->conn->hcon->handle;
>                 memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class=
, 3);
>
> -               len =3D min_t(unsigned int, len, sizeof(cinfo));
> +               len =3D min(len, sizeof(cinfo));
>                 if (copy_to_user(optval, (char *)&cinfo, len))
>                         err =3D -EFAULT;
>
>
> ---
> base-commit: 7835fcfd132eb88b87e8eb901f88436f63ab60f7
> change-id: 20240401-bluetooth-fix-len-type-getsockopt_old-73c4a8e60444
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

