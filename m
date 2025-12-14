Return-Path: <stable+bounces-200957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48289CBB5BF
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 02:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14AAD300BBB4
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 01:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DE12E1EF8;
	Sun, 14 Dec 2025 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzKELoP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CD2E1C63
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765675432; cv=none; b=jAlI5lol0Yz7OGcYriJlkAnJcvBJPiA8/f1PLZsjUZ6NS0qcaD0VFfLxEdvnMTN4Ug1P8BRkRzYJK9i1DFiL7iQ5GPhJJVt83nl0K1gF1YKrh7OckhrYwXNYHs2CUruqn9vJ4uOEEZF9FvIpsmt3k2kXgJw3WHOKJ4q3qulQzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765675432; c=relaxed/simple;
	bh=GiyI2wrxHNxbI6dYeRsPW1sazjsvEU0Uazlgs5PB2bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVZBK+NAl+UrnTHqlto9FnzSxHcQdW/rcBhOKIeqz/XfVQwJ0WRP/pJQqH7P9PZyKiaU2hW/QL+PZS2GRuKvLaqaIV1CbukwkPco9F42YX+VpBz4JaFjHjprDPk0G06lKKFhvjJCFqAo/mwWmkNBF0cfY6bpY+mg47hVN8Ifmps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzKELoP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D35C2BCB2
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765675432;
	bh=GiyI2wrxHNxbI6dYeRsPW1sazjsvEU0Uazlgs5PB2bo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OzKELoP3xHH7u1ijLkX3bZC6R/MoqPpQ+9roenpeCXcGYD0LhfZoprBRQyhbwZHFl
	 NbnK/vQ2qBqT0UYRLYidHP+NCWedgvMGRCJAE2X1b9IlmL6SjgEv+0hZRvlB5KRsU4
	 y/WLeHw2jaOe0g3dR9alFrcoLT+Z0btG+ATGv3tTyCepGr+smnBSNDeORP2mOg0eVg
	 K6R7K0y2ecL+nW7+dG5n+IdagJu+8iWLNaJj9iGg8zM18MIq3mr1MQsTKJ7Hn6X1dY
	 VnqOMLdnZewDSE7piUOWmjecxD0VmE6AGBbR0AEcRXNnn5BfoktH3VNhX+4X2tMCjn
	 /X3K1gq8qXuKA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7697e8b01aso449201266b.2
        for <stable@vger.kernel.org>; Sat, 13 Dec 2025 17:23:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkwBnvK+dy6OIKiNg/5+y15UiS91Q4fsON5y/cNGYvIufV11BKcCu4Kv/pF9/1fpYF7RiJe6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxne6JsBdgN1SOVYzzooU0bHPPWqoQ/cy9LQi5Lr+erCiRrFhgb
	e802vhW03BZn6K/1g55FZw+aTbRVcLHvvaesN9pdSSPAp37xqUIz46du65LR4oqu/bMnEFdYcvZ
	1Un6cBe8sTyS1N4PHJF4D1SGPliGRlKc=
X-Google-Smtp-Source: AGHT+IFjIQS/7W0XyLT8qXY9tC3vgaxbp8f0nrh+HrLnWZv5ZI+yPJY2JQMQw+URLnV7MzMIgLyLz4bmDVFpi2hpCIc=
X-Received: by 2002:a17:907:7fa3:b0:b7c:fe7c:e37f with SMTP id
 a640c23a62f3a-b7d23a540d3mr734991266b.18.1765675430495; Sat, 13 Dec 2025
 17:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072948.125620687@linuxfoundation.org> <35e3347a-198f-4143-b094-2d0feb8d6d50@roeck-us.net>
In-Reply-To: <35e3347a-198f-4143-b094-2d0feb8d6d50@roeck-us.net>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 14 Dec 2025 09:24:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4tiTBqd7mUphq58KdUtvro9HPxZmComr6ku1Mcw6=+9g@mail.gmail.com>
X-Gm-Features: AQt7F2qPiIAWNB6dRD6h_fQatP_E57R9qswZPlB9b3pbQHt0xF0aw_U5cacdOVs
Message-ID: <CAAhV-H4tiTBqd7mUphq58KdUtvro9HPxZmComr6ku1Mcw6=+9g@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 12:31=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 12/9/25 23:29, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.12.62 release.
> > There are 49 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 12 Dec 2025 07:29:38 +0000.
> > Anything received after that time might be too late.
> >
> ...
> > Huacai Chen <chenhuacai@kernel.org>
> >      LoongArch: Mask all interrupts during kexec/kdump
> >
>
> This results in:
>
> Building loongarch:defconfig ... failed
> --------------
> Error log:
> arch/loongarch/kernel/machine_kexec.c: In function 'machine_crash_shutdow=
n':
> arch/loongarch/kernel/machine_kexec.c:252:9: error: implicit declaration =
of function 'machine_kexec_mask_interrupts' [-Wimplicit-function-declaratio=
n]
>    252 |         machine_kexec_mask_interrupts();
>
> ... because  there is no loongarch specific version of machine_kexec_mask=
_interrupts()
> in v6.12.y, and the function was generalized only with commit bad6722e478=
f5 ("kexec:
> Consolidate machine_kexec_mask_interrupts() implementation") in v6.14.
https://lore.kernel.org/loongarch/20251213094950.1068951-1-chenhuacai@loong=
son.cn/T/#u

Huacai
>
> Guenter
>

