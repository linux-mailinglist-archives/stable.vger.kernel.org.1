Return-Path: <stable+bounces-45558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F8C8CBC84
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451911C21887
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21507D3F5;
	Wed, 22 May 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRngYAHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB387B3E5;
	Wed, 22 May 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364772; cv=none; b=q8e0ozLPCA6oVGjjAzXj+YnbjG4qUDVDDsZqKFLY335DXXI1pkV22PSj+GjRroC7KP8e2INO3apHOucVYq5eslLFYGwHXhMrDYnT6noEE/q0e94uKi156DSulH4+/zWIVVqqCKQsa0lUJ9AH8CVE5b40QF8sSngwlW50WLwylGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364772; c=relaxed/simple;
	bh=N3iti17OfcUn8VUy6eLkIktbxGicvZRj9Al44bzEv2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlMqleggI1So6Hn067wewjErGU0ZPvc3eCoDlU0vTLCfs1D7iLNfOp7S9UDdQd0oCeE55OUCabYmADoyV+6NZWxDIbDcf0fQQZuR5mADGbL4ekMuLo0sQZDjuKJ6vnj7CKqhEC26GwGfTAwM8WKFXQ9PbzcXRCwhSpbcua0ncmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRngYAHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181D6C4AF07;
	Wed, 22 May 2024 07:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716364772;
	bh=N3iti17OfcUn8VUy6eLkIktbxGicvZRj9Al44bzEv2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CRngYAHcZfQ5hzbpoEBgQ3EKPTdm3waecrQ9gG5h8nHxFR9DID2XyPLduZ0BvooBH
	 /Hm/pxUjTg37ITiW/ar6AnlUNNVdRuY4Kxz+QzJkjU3i1757Rpy05OKL7wGEP4fpSa
	 arHaxxyhKKJ0AOpSvaHd7+BNHLLBgydDDHqnUG+FKPSSGQmmrgzaMNZGSFwYeSXACw
	 Ib6Cr211xReCGFed2YkWoWu9oQ4A5Dbu2zqKuk3IDfcdmTedF58kFSy/CdWSqiQ34+
	 URCXfo3bwCgXZ1nxB0huvxKNQx868ESVG7XLZvY4Wno6SjICm6mXjaasdl4LpCm5XX
	 XZwts4I4F8JHQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e72224c395so34729081fa.3;
        Wed, 22 May 2024 00:59:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVejOPW7rUtyFHnX7WqUR6bHcY4j0pyHZrYcj+ZyH3izCrDnIqOoUoF76Q2SVsJuJoItBAvzPnYWc3Lm02DwLZ9P6+hQ7fSY5/VXJGN4/W94m+45Xp/MOzOtqSqBjs3FTKE4dD6
X-Gm-Message-State: AOJu0YzEfb59f8KAcPKPFJ6C5XO9xhB6YV81xICl2Gu7DcQIDxbKIUPg
	WZpG84mwmeUAvR2QJeE+0Iuv/JS1uBqyhY4yRG5nUgVroY7PZEKpVE0e8pSXPWB6vPkgUnOMIdA
	jG2rtf/AqV7w1hXsRP5qzx7f39wU=
X-Google-Smtp-Source: AGHT+IHWS9tj8VJIzXsP0D+C/CspjE/XGnPtEd2Ju1GXqpgie5xRBedC6u++vj3ver/nUVV9fv+/hNon0a+ZZbGjn6I=
X-Received: by 2002:ac2:598f:0:b0:51e:1264:8435 with SMTP id
 2adb3069b0e04-526bf35ce18mr590649e87.27.1716364770414; Wed, 22 May 2024
 00:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com> <20240522-loongarch-booting-fixes-v2-4-727edb96e548@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v2-4-727edb96e548@flygoat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 May 2024 15:59:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7b_-QyQUPTCz1zFEz4YjZeB-ta5yAZgPLiNkUXosw-Uw@mail.gmail.com>
Message-ID: <CAAhV-H7b_-QyQUPTCz1zFEz4YjZeB-ta5yAZgPLiNkUXosw-Uw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] LoongArch: Override higher address bits in JUMP_VIRT_ADDR
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jiaxun,

On Wed, May 22, 2024 at 2:30=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> In JUMP_VIRT_ADDR we are performing an or calculation on
> address value directly from pcaddi.
>
> This will only work if we are currently running from direct
> 1:1 mapping addresses or firmware's DMW is configured exactly
> same as kernel. Still, we should not rely on such assumption.
>
> Fix by overriding higher bits in address comes from pcaddi,
> so we can get rid of or operator.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Overriding address with bstrins
> ---
>  arch/loongarch/include/asm/stackframe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/inc=
lude/asm/stackframe.h
> index 45b507a7b06f..51dec8b17d16 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -42,7 +42,7 @@
>         .macro JUMP_VIRT_ADDR temp1 temp2
>         li.d    \temp1, CACHE_BASE
>         pcaddi  \temp2, 0
> -       or      \temp1, \temp1, \temp2
> +       bstrins.d       \temp1, \temp2, (DMW_PABITS - 1), 0
>         jirl    zero, \temp1, 0xc
>         .endm
Can we align the first parameter about the first parameter?

Huacai
>
>
> --
> 2.43.0
>

