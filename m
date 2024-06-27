Return-Path: <stable+bounces-55976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1591ABCE
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746971C21AEA
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6173146D74;
	Thu, 27 Jun 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI5FgBqB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B751922CD;
	Thu, 27 Jun 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503350; cv=none; b=d58KIVza4GXzDqMEtkZZSv8VYT0kkDVPRUmA+GznVH/w5Q1eHmjWp0BIyIPfa5jMoJ85sQlNHQeesIwt4C/JM1ZIXvDCKr7nzCBbdaeAjCNhCBMgqWTscsfzEn+DDPnBZMANMJAl7YlZDTu7dHe3uqUAIYm8wLahvyAeTHNtj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503350; c=relaxed/simple;
	bh=nqL74ax75pWruU5MiHx4Tv8OQ6oYMWOlYMX7W+QBVFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt9ByiONmeb4U0kKvE9A2haM4t1oIwpFsdDvuxseXxCNpfBQMfsE/VAaqKdrJsh4bSK/LN1WvEjdQitnHR3BGAOZo9eAks2/fhZGTLp4Kg5MIUAlQrCNzC57ar/pVuVERTTOka6WSJvCBYoYpSgpzSuDkxLtxPgZg2IU3/+0KKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI5FgBqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20102C4AF09;
	Thu, 27 Jun 2024 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719503349;
	bh=nqL74ax75pWruU5MiHx4Tv8OQ6oYMWOlYMX7W+QBVFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BI5FgBqBMP5FKrncNAqqVJtPra5024pG9hl1ijpvcDJsIekV5rUj0JzgScOCtjGC0
	 5laD6fVdBlHLEWeUuyxwrn5ksk2coCoascyolx4NC/vAs2HdZYYUX2Tv3zXt5dOaAQ
	 g/vYRl+eXkTjNFPKvtDcIYixM1jrPHLfIUMPyB2m1Ode7rOdm3OD58I/UQIe0IaEAx
	 ymg23fV285rs5Hl6J7aozM0aLhJacvWpFe12agHVX2mUOGrszB/FCd9Ho9S+dm3Six
	 oeDjIwOnBBsruFY6DBWptVbcNlbLNQLkM0mQ0YVcnu/0VArqVybhhlCIMursp1Uq8L
	 qa9g4uHyogXtQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so2026007a12.3;
        Thu, 27 Jun 2024 08:49:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAaRjnA2rRDtvYFjyWg+3CBDee8eAXg7PBKEwiYWtkGiFm0SVzz+0JOA0Eh5TitELpJsNAVeBaJdKGRWsfNTkrmxBjjApGQHOL+AQ1oh+UeZKIMskO3z7RwjsdwuHFx0FyAkw3
X-Gm-Message-State: AOJu0YxanCn9JBI7G+FMMOo9syctf8LJWSwmcW6h48Mb4lrCs37/TZaE
	XJzhlyp6l+4iY8RueoD2ySVPkAg8SdlizxNgKqE8HQoKFt/3Yzlw1w0Z0ZDojse8JjXu4l0T6eG
	Fr0meekAftio9bQZnxI0Q8jfW5GE=
X-Google-Smtp-Source: AGHT+IGMJMc5MnM5ZGkcUNODngcS4Rbq5bn55PsQgrJaAUmsDOl1dWXQyEwf2gvEQISuwOi9m+9gihIbKE4DI1b6frU=
X-Received: by 2002:a17:906:d509:b0:a6f:5192:6f4d with SMTP id
 a640c23a62f3a-a7242c4dfd3mr701399466b.8.1719503347692; Thu, 27 Jun 2024
 08:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627103205.27914-2-CoelacanthusHex@gmail.com>
 <87o77mpjgd.fsf@all.your.base.are.belong.to.us> <6b8e1e79-5a2e-416c-8fee-878b3f5568a0@gmail.com>
In-Reply-To: <6b8e1e79-5a2e-416c-8fee-878b3f5568a0@gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Thu, 27 Jun 2024 17:48:55 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNhV2d53G-ZPDXUkSTP-AzhqXs54XZuCiYjR=06A1+oq_A@mail.gmail.com>
Message-ID: <CAJ+HfNhV2d53G-ZPDXUkSTP-AzhqXs54XZuCiYjR=06A1+oq_A@mail.gmail.com>
Subject: Re: [PATCH] riscv: entry: always initialize regs->a0 to -ENOSYS
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	"Dmitry V . Levin" <ldv@strace.io>, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Felix Yan <felixonmars@archlinux.org>, 
	Ruizhe Pan <c141028@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jun 2024 at 16:29, Celeste Liu <coelacanthushex@gmail.com> wrote=
:
>
> On 2024-06-27 22:08, Bj=C3=B6rn T=C3=B6pel wrote:
>
> > Celeste Liu <coelacanthushex@gmail.com> writes:
> >
> >> Otherwise when the tracer changes syscall number to -1, the kernel fai=
ls
> >> to initialize a0 with -ENOSYS and subsequently fails to return the err=
or
> >> code of the failed syscall to userspace. For example, it will break
> >> strace syscall tampering.
> >>
> >> Fixes: 52449c17bdd1 ("riscv: entry: set a0 =3D -ENOSYS only when sysca=
ll !=3D -1")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> >
> > Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Patch v2 has been sent.

For future patches; You don't need to respin a patch to add tags. The
tooling will pick up the tags automatically.

