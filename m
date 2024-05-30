Return-Path: <stable+bounces-47701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CDA8D49CE
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 12:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79891C227E6
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA1E17B418;
	Thu, 30 May 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V31vltqg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5901761B1;
	Thu, 30 May 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065687; cv=none; b=BSYlNidHKtpDD9lNr1vZs/zksgH3bcKmO0hr/mRrvR6a3m6UOFH/C09qqcwODHtCnGkNX2LY98XIYxADfV9d9yXmqJmDwbfNek6u+T+6NgRBBZh/CcTX4exfcRkF4tSIuCCnT0s4pFDtnNpur+R3EkcRn9nUSumlGK2iFYmWSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065687; c=relaxed/simple;
	bh=PoXLd/saRGX0CFC9ilNw4jmQaclo+pP1tMe3ZlJmqsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klxLtH0su0uewzpSELROZ3fqhSJnRlQPwwiPpXKeQX0KNBkdXKyAdRqFpCeQszjER09f3j78RrU9D+REVn5FYUi4AC3guQMmtydxUvYoyhEyaiE+lK9+uRgL5w4Gd3NAkPkPwJN24riNFhviQEX4FHFojyueHxmWLXqA9VSxL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V31vltqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8886CC2BBFC;
	Thu, 30 May 2024 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717065686;
	bh=PoXLd/saRGX0CFC9ilNw4jmQaclo+pP1tMe3ZlJmqsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V31vltqgi+C+T2bxRbmCUtqgV4YjrmOlm9GH+DG0YfbvRKIQjwRrTEqlDmp5+icf8
	 l7T4OFJJb5CuS33UbTVdeRxRbplo8n5PvrNOr++dYVdttm4n52i/Vt3SzjD993dMyE
	 tNnz+DbNIHZtwxQ1k0LbKMnO50jJ3IR0DrBFAsvOMH2ge/J54X6NBWT/+6d1XRYSOg
	 1VkLT0tGY+jTASTcjiMXwfOsXRj0LZRbCVLzZ1pSC4y+cyDVbNJOPCFokL901ezqIi
	 zHipGN/ooJM1Ylhfvt5JFqk6+8Jlx8Hgv9K3L8unhqSFZmVVq4GaKIJORfN6gtY+1w
	 mtmEOqDh+xnug==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso53785566b.0;
        Thu, 30 May 2024 03:41:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/8cbd3sVygkjiOhcSHt/J6K/m6l6xW5hI/rLdK6O50tuI4UgOc/TI4MIQ3mJli9kfyTtIoqYRmxE3ik3IxyI8TAerF4i/RZ4Qm0/j5vXj+R+8k3M/4sLTZ4DnuWQtg+ljcjtR
X-Gm-Message-State: AOJu0YwZvZT/CUaRQgmYtYWq2g5CVjUiwved55ShveAW6RPn1xYHmYlh
	HQ2PCxAdA9eZCGqV1ryvAvI1kyBAuP2olKSTHM4s0Nq/+e/ukqUBZ6jmzwA8kCdzNNTljWs+wsy
	DbE+80fmx7v5SMkd7fbQwFZkP9oQ=
X-Google-Smtp-Source: AGHT+IHA7kD5wmQm9SW6UKOcFzhH68w3EPz5XTex9XkYIXHJol0yy8AyvYYkuXpH4xODWkst4xhRalCPUs1dE4ij4pI=
X-Received: by 2002:a17:906:fb0c:b0:a59:ef75:5382 with SMTP id
 a640c23a62f3a-a65e8f6f478mr108011966b.43.1717065685141; Thu, 30 May 2024
 03:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
 <20240522-loongarch-booting-fixes-v3-3-25e77a8fc86e@flygoat.com>
 <CAHirt9hbzVxcKzwnSF_5jpwma+kr-WJHBQjc47ojB95Ph9SnqA@mail.gmail.com> <173627fe-3370-413b-8f9c-50c65892cef9@app.fastmail.com>
In-Reply-To: <173627fe-3370-413b-8f9c-50c65892cef9@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 30 May 2024 18:41:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4tftt3zu-BzpKvZ5vGz3rN4-rkO5uc=h3_T7JJMH4-MA@mail.gmail.com>
Message-ID: <CAAhV-H4tftt3zu-BzpKvZ5vGz3rN4-rkO5uc=h3_T7JJMH4-MA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] LoongArch: Fix entry point in image header
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: WANG Rui <wangrui@loongson.cn>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 5:50=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B45=E6=9C=8830=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=
=E5=8D=886:01=EF=BC=8CWANG Rui=E5=86=99=E9=81=93=EF=BC=9A
> [...]
> >>  /*
> >>   * Put .bss..swapper_pg_dir as the first thing in .bss. This will
> >> @@ -142,6 +143,7 @@ SECTIONS
> >>
> >>  #ifdef CONFIG_EFI_STUB
> >>         /* header symbols */
> >> +       _kernel_entry_phys =3D kernel_entry & TO_PHYS_MASK;
> >
> >  -       _kernel_entry_phys =3D kernel_entry & TO_PHYS_MASK;
> >  +       _kernel_entry_phys =3D ABSOLUTE(kernel_entry & TO_PHYS_MASK);
> >
>
> Thanks Rui!
>
> Huacai, do you mind committing this fix?
I will update this patch in my tree, you needn't do anything.

Huacai

>
> Thanks
> [...]
> >>
> >>
> >
> > - Rui
>
> --
> - Jiaxun

