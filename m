Return-Path: <stable+bounces-192602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D798EC3AE5A
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 13:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6033AABF2
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 12:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A532AABA;
	Thu,  6 Nov 2025 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2dYhB1K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A92E889C
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432054; cv=none; b=cPlFQXqwT4oiyi8oK4PBu+hJruP60KaBYyLybiWkE7J+0ZPnATf62Q+3ayaivuNLTo/xGufCAztQyWUj2VaaVWmTZ6gxcLGQj0CaOnExu+Pbdu3zfRauWCusJISP8v0AE1yZjtB0Jw/cFALt6mZLw4uH/9pwdrPNB7sItG1BwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432054; c=relaxed/simple;
	bh=h15G83qRa4EAlnHQG3eauAt/XjCuhxcVME6Tt6DsaLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sm+jPaRp4XuM4SpzS42T+tzLa99nVLYqmdVfYO6nbTkTcgrXi/Dl3N371bP4ql3OSrzuWzgMQEOD6hKJx96e7kXwfP94e6qF0oGmowu5nFzuMtuD0bKDKN/KqMWnw7EIt0+I8hlwHLqyFESKEHPKPoG38tzPb7iAD2CNFGMv/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2dYhB1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EB8C113D0
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762432053;
	bh=h15G83qRa4EAlnHQG3eauAt/XjCuhxcVME6Tt6DsaLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k2dYhB1K2S2KLa8iUV50fg2MFBq7wA2ZfpanHvhfpwHRVQ9n/LMk6tGjDeHtJB/CS
	 UFBjCMLKPYm3aXwaSxh0ozuMBUJc4Qj5WLwOrzYph+L0JSr8HScp80XXg9SBR42e36
	 ZLOqoUiCwGW/839WRGxtMV0U9kitug9zFvQJNiBcIBq+O074P6cligl5zWNrMd78AM
	 AnfP9vCvgX2K06At9ZXSWe+WpJLSRYK2P1bGc/2BmBjE7HTWtuWKlKdh48AOr4+Eyp
	 AzCOg34iSPeXp3GAs409Thvp5Sq7w0vR1Spfair0TObsC+NZW48jZ446Ms59/AwyaP
	 pal9poSOuIN8A==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso1350791a12.0
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 04:27:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHHA6B8OcFCr7P+0C3nnZ2WLZqyhnm/SXARwjUEHNP/UdIsISDL+PXSVVVTSHZOrfxdRyHoI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweoz7GvJ85wwTfY5neIPNyfAM9NBdW59iwUkHcKFN4V03afM7M
	ZpoCR9ayUPNPApprdL/VnJzMfkHShMbZDdQJrbLISYOOtXRilejFp25MSi1AqwCVEa47yYLFjm/
	7jeLVJ9svqB8knnL9v24iHJTRwEYbmP8=
X-Google-Smtp-Source: AGHT+IEZZdegMLed88oyF+xMFLhFB3ojId3saCkwcGgWhzckz3M9Qn6iyj5VHe4SZj8gMTln6hEHl5t7IkJBu0oPkbA=
X-Received: by 2002:a17:907:7f9f:b0:b6c:38d9:6935 with SMTP id
 a640c23a62f3a-b72652b9d65mr674490566b.24.1762432052335; Thu, 06 Nov 2025
 04:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014095055.1159534-1-maobibo@loongson.cn>
In-Reply-To: <20251014095055.1159534-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Nov 2025 20:27:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6iTmb6d86RL9XXY9oOzLcZeAcbdMp2xhEcsRPhtWNQPw@mail.gmail.com>
X-Gm-Features: AWmQ_bnkLxapQogJm3u5CicP5EyTvoaZ13lG_jWf5avDm4sWjmvplRrsuwi9ojo
Message-ID: <CAAhV-H6iTmb6d86RL9XXY9oOzLcZeAcbdMp2xhEcsRPhtWNQPw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Fix max supported vCPUs set with eiointc
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Oct 14, 2025 at 5:51=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> VM fails to boot with 256 vCPUs, the detailed command is
> qemu-system-loongarch64 -smp 256 and there is error reported as follows:
>   KVM_LOONGARCH_EXTIOI_INIT_NUM_CPU failed: Invalid argument
>
> There is typo issue in function kvm_eiointc_ctrl_access() when set
> max supported vCPUs.
>
> Cc: stable@vger.kernel.org
> Fixes: 47256c4c8b1b ("LoongArch: KVM: Avoid copy_*_user() with lock hold =
in kvm_eiointc_ctrl_access()")
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/intc/eiointc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index c32333695381..a1cc116b4dac 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -439,7 +439,7 @@ static int kvm_eiointc_ctrl_access(struct kvm_device =
*dev,
>         spin_lock_irqsave(&s->lock, flags);
>         switch (type) {
>         case KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_NUM_CPU:
> -               if (val >=3D EIOINTC_ROUTE_MAX_VCPUS)
> +               if (val > EIOINTC_ROUTE_MAX_VCPUS)
>                         ret =3D -EINVAL;
>                 else
>                         s->num_cpu =3D val;
>
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> --
> 2.39.3
>

