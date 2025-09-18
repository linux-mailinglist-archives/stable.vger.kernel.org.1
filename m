Return-Path: <stable+bounces-180490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB06B83430
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 09:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766D97BA3E4
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC354764;
	Thu, 18 Sep 2025 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU5Z1lt4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFC2D8DD1
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179225; cv=none; b=DHfS43XzCExzrAuDNFW7sDAsXwmSUGk0QcQvQmR2zcbtC4ZK6Ui9I9kVxHKi9An8Fat0tufL/AFL5wtE3t+huw10zioTOKRaoBgzDWAawNVqddG2cWxC3J5PvfDclE7H5m2spOaJNP5n8l9urFlfibqMNrkCjcNYyXWy5rQ02sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179225; c=relaxed/simple;
	bh=LIWh9rCdfk9QZIOUNYrRMXALV0xzQlmiVi96oKR3cJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSa/2l+CvNbpJkFryFufAdxsxtwR2fsx2eiGOKhtwOe703E+MV7ZqcGZZ/o/GD2a0ol8L1jb1LDMywVnk3y+zujbMwNc/SZRqFldXVYJy0K2bqv0xvO7tkbDAlCPPTRnLJjukSZBDLosLE0vBuMt81EwV8azM32cMnLYpMSI92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU5Z1lt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24E4C4CEFC
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758179224;
	bh=LIWh9rCdfk9QZIOUNYrRMXALV0xzQlmiVi96oKR3cJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bU5Z1lt47Lq0VkB4KKNYsVyisLJO8FFfkZ/yyMccp/uZss70isryVNw5E/RzHsj0N
	 fvnriXofakA3oKEv2foRfNviHJ+hvfQf9gCHO3WZFrH348D8aWsWn0xo0nv6vVih+U
	 Xs1LgeKSacudQOdjTskJd1nkl59TvgKg/0CBLc309dLM+dMgb3+Tyjxqumq6lVl116
	 FPhC+ZgakWtvYPYsw1iot0fJqSNrnA1LZKzEBHKVdZhrc4elX+wZABZ3aTCBcLZ4NJ
	 b24yJXOtSr3lmAVeNMIO1vyyICfVUTx6vChSh1MKJo6wWi+FSxKTgdefsDve7r7N4k
	 cMsm6qTBjyW9g==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b046f6fb230so125407166b.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 00:07:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtIi6RIIEPRFM+fV01+6QPzxLryltQBf61icmu9bjUrivgMSEkWWnTpeVEVrcy5UI2IjCqPMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRR/dxJt5tD0fRaI5B88IQiaQh+joPW9cX4vD1+hKCoHqxOQFn
	cjMNJ8iIf5SmEZGei5g0zmKg5caO+90IfUn8uSXlaLq/Q7n7vfBJymkX/YLENAkJ6Ku85l8DEAg
	EtLvBYZ0uFQmabkTeBp/QHNIg82LnNzg=
X-Google-Smtp-Source: AGHT+IHDwQed8QlPUnnnh18AjAw4YMW4KXcHgPP/wiHiSdIyFg9qXXASXGDcTOHAySLAH7fyN/psk4mX2ofDkgxKubU=
X-Received: by 2002:a17:906:4a94:b0:b20:a567:8724 with SMTP id
 a640c23a62f3a-b20a567874dmr141766966b.1.1758179223191; Thu, 18 Sep 2025
 00:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145710.2994663-1-lgs201920130244@gmail.com>
In-Reply-To: <20250916145710.2994663-1-lgs201920130244@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Sep 2025 15:06:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6hTFrUO5gTx6FYo89TAouEykTvKpLNkqFfhtsg0PVLiw@mail.gmail.com>
X-Gm-Features: AS18NWC7cWrisYIT52dGDytiHP4tfAEgtfCVPbsy0njCO_2FdgqJJthiylvNoAg
Message-ID: <CAAhV-H6hTFrUO5gTx6FYo89TAouEykTvKpLNkqFfhtsg0PVLiw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: vDSO: check kcalloc() result in init_vdso
To: lgs201920130244@gmail.com
Cc: WANG Xuerui <kernel@xen0n.name>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Guangshuo Li <202321181@mail.sdu.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Sep 16, 2025 at 10:57=E2=80=AFPM <lgs201920130244@gmail.com> wrote:
>
> From: Guangshuo Li <202321181@mail.sdu.edu.cn>
>
> Add a NULL-pointer check after the kcalloc() call in init_vdso(). If
> allocation fails, return -ENOMEM to prevent a possible dereference of
> vdso_info.code_mapping.pages when it is NULL.
>
> Fixes: 2ed119aef60d ("LoongArch: Set correct size for vDSO code mapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <202321181@mail.sdu.edu.cn>
> ---
>  arch/loongarch/kernel/vdso.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
> index 10cf1608c7b3..da7a7922fb24 100644
> --- a/arch/loongarch/kernel/vdso.c
> +++ b/arch/loongarch/kernel/vdso.c
> @@ -53,7 +53,8 @@ static int __init init_vdso(void)
>         vdso_info.size =3D PAGE_ALIGN(vdso_end - vdso_start);
>         vdso_info.code_mapping.pages =3D
>                 kcalloc(vdso_info.size / PAGE_SIZE, sizeof(struct page *)=
, GFP_KERNEL);
> -
> +       if (!vdso_info.code_mapping.pages)
> +               return -ENOMEM;
>         pfn =3D __phys_to_pfn(__pa_symbol(vdso_info.vdso));
>         for (i =3D 0; i < vdso_info.size / PAGE_SIZE; i++)
>                 vdso_info.code_mapping.pages[i] =3D pfn_to_page(pfn + i);
> --
> 2.43.0
>

