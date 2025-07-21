Return-Path: <stable+bounces-163542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A2FB0C100
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 12:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14FF18C21E9
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFC28DB68;
	Mon, 21 Jul 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikC/TM3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8D28D8F5;
	Mon, 21 Jul 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092669; cv=none; b=EdjHIU5i4NG9mxtglcoWQk23ciGoNtHhc8K7YMgo2uxvu5VZCEVby3QTb2CPQEQQV9oBHcTQEfNqXuzSzWU/CxCOS7vy2bkqbUtfyuySYfl8JTDlsRF46TOFv4AglQ2T3Lob5n5luv1AFUFmKNX6/hL45nyMMdOGQpcyYjWVpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092669; c=relaxed/simple;
	bh=VyUtJcOfBhsCPbxOvmt2mP41Jze99E8f+PefufWh6Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCGN+zLONG7ggaNDdGKHwBwfJVvLKr2ge0JnDW9DVWHGuiKpGZmhDGpFuIpfiEk/A4XRr5DL8ybJqme+rzjUHX+IKrXWgcyL0NEBMpXMoq66dLJctu98hJXkc2O3YWLlEphP32ED7U5QF3jJP6/eIO8BE6w1kRCT4vk9diUTRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikC/TM3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F0DC4CEF1;
	Mon, 21 Jul 2025 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753092668;
	bh=VyUtJcOfBhsCPbxOvmt2mP41Jze99E8f+PefufWh6Ws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ikC/TM3m6kqj8wv+6FfC//nAiqfpwcXBBntEPSFmvvpPuiZ7WJiaiW79+w5o/nT6L
	 16eLaVhVCeYpkytn1GZ4/3zOVjyrz8x8xMHcvqZbrj8jYFp46jq61uC2wjbku8yPIS
	 8wGVKiNuB1qqSVyawpQLsSOV3qgNKuqvfp6Nf26QZnD1Og9dwa/IT6CDwMjRcahAor
	 xnejPYqt8gYlDlaej8yDEien1cwhc3mt+m7GRgsKxTqDMSsSJ7cmKEB2Ql22b4a9CJ
	 Zm/PG0EQuZxeAZxjmAcn0NBlDbQfIlL8afaOMkWoZaKRwpAGbk6BMQnScRfjxia3/I
	 kdz+i4yWJDw/w==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-612bc52ac2bso6564867a12.2;
        Mon, 21 Jul 2025 03:11:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAgLkhYVQo4RpoMeb8UuEjDCdqUtrRb2Q/HaSEbk1hzm2D7TU9ow5NtSsKGjwQW8mb1yU+ZqRhh1n4iN4=@vger.kernel.org, AJvYcCUiRxWW1X3e61HpZwUBm2SJTN8M7eMJbTTR+bkqUqhMh8qQxeHZXnmwSBpVjzUyyJsB/Pt/i2Mx@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgBQmJTwstJAFNqQbup00NQKCT/l7aoewQa9OMo2qPI1dQ9tx
	S2aJEpamPhRykoNzyTO4vRhTzHDd3QFov7kKjI7TX3PIljlZj8pb9tP9sLdkPsYlbgAXV/+l60C
	Hsyr2lLf2kEJ4wf8vApaW5STDJK4tIsU=
X-Google-Smtp-Source: AGHT+IEvoNhqTAmjDSGVH8ezp7mUro7GEZ0mQjc6O5ZHHcN1eyv9VMoMXmctu75NA+vUW0IeI+G+NpPWG2UCCbOb9Go=
X-Received: by 2002:a05:6402:34c6:b0:612:dbb9:9cba with SMTP id
 4fb4d7f45d1cf-612dbb99fcdmr9007336a12.11.1753092667388; Mon, 21 Jul 2025
 03:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720105509.2914898-1-chenhuacai@loongson.cn> <2025072056-gambling-ranger-5b0f@gregkh>
In-Reply-To: <2025072056-gambling-ranger-5b0f@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 21 Jul 2025 18:10:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5nHBuXao1NGgSyD5CJzFHg6Vf0s+Fr3TadH01KjsMDSw@mail.gmail.com>
X-Gm-Features: Ac12FXwmWWDis-x1Ej9FMfBbbdalzOX_DkigL6tsfidKQFsiJq8tVEPHRRLzDTo
Message-ID: <CAAhV-H5nHBuXao1NGgSyD5CJzFHg6Vf0s+Fr3TadH01KjsMDSw@mail.gmail.com>
Subject: Re: [PATCH V2] init: Handle bootloader identifier in kernel parameters
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 7:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Jul 20, 2025 at 06:55:09PM +0800, Huacai Chen wrote:
> > BootLoader (Grub, LILO, etc) may pass an identifier such as "BOOT_IMAGE=
=3D
> > /boot/vmlinuz-x.y.z" to kernel parameters. But these identifiers are no=
t
> > recognized by the kernel itself so will be passed to user space. Howeve=
r
> > user space init program also doesn't recognized it.
> >
> > KEXEC may also pass an identifier such as "kexec" on some architectures=
.
> >
> > We cannot change BootLoader's behavior, because this behavior exists fo=
r
> > many years, and there are already user space programs search BOOT_IMAGE=
=3D
> > in /proc/cmdline to obtain the kernel image locations:
> >
> > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
> > (search getBootOptions)
> > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
> > (search getKernelReleaseWithBootOption)
> >
> > So the the best way is handle (ignore) it by the kernel itself, which
> > can avoid such boot warnings (if we use something like init=3D/bin/bash=
,
> > bootloader identifier can even cause a crash):
> >
> > Kernel command line: BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.x root=3D/dev/sda3 =
ro console=3Dtty
> > Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.=
x", will be passed to user space.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Update comments and commit messages.
> >
> >  init/main.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 225a58279acd..c53863e5ad82 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -545,6 +545,7 @@ static int __init unknown_bootoption(char *param, c=
har *val,
> >                                    const char *unused, void *arg)
> >  {
> >       size_t len =3D strlen(param);
> > +     const char *bootloader[] =3D { "BOOT_IMAGE=3D", "kexec", NULL };
>
> Where is this magic set of values now documented?  Each of these need to
> be strongly documented as to why we are ignoring them and who is adding
> them and why they can't be fixed for whatever reason.
OK, will do.

Huacai
>
> thanks,
>
> greg k-h

