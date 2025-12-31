Return-Path: <stable+bounces-204336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5738CEBE13
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 12:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3B54301B2E3
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622B31A54A;
	Wed, 31 Dec 2025 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRaix12B"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1A313278
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182125; cv=none; b=U3C9zIzaCT7zQg6yGMxnFuceyIBd3XZy8eB15CbYFp1BT7+VBw6KWaxONuTBXWBOcXm3iANbi5Si8SqS9Tjq+FLc3pfmL/7KaGK6OING3NQoPJoouqUCgtJwsxBwxVqFGHBCpJOkeLP/o8XVqDToffFoMYPGNt7gPOMoRfYgxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182125; c=relaxed/simple;
	bh=N3R0iLPZCN8oy/x63B5VdEnB5ZvOWFcuCSuFzDxjd5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nl55CI02t3yjVkiB90n1TD6zg6aGN/xvVZ4i1/7kT1dg9WhX/P/VVQPIHsqxga7o8LRC6Fd6XPp8Z80GasQnYQeduKuAijuRJRg10Oi//zbVocn7BIYwN+hjduUvETHn/+LiJfZeURWWImLaZHgl0mA8fVBd24m4JFzBM5RLPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRaix12B; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4f34c5f2f98so119525301cf.1
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 03:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767182122; x=1767786922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swz2J2a/Uvz7GnbU1XB2xGVGkNfU6LCVp1sNpOikUcs=;
        b=bRaix12BrNZSAZVR0kSXiFJ9nhcqHvSKzSyaErQ0Ip30h017XxL4XZdL0lohZzqaVc
         jB4L3qOr7pGSMANIZw/gTu0hBUKymNn35Hk2xvJIzuxwjrfcch7XKSvTfUYDtNelyZTA
         tJuOW411CZlugA3ySN98xJ+GJaT0925TP4OUIe6PfTkFSp463Ph1U06Cm8e4Di7xdD9y
         vpU3GShCCgASmdjKVw5Ql/hiJq7gwsCsKevqNhx/0tBG7qmDUnBM43sS8zkPi3/SCD0D
         sjBuhkrxDFdtnnlTzdxY+WLNNWM2NhLx/b1mutdde/vBbmvo55L7sMJA7+JpMLFaBx4n
         hwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182122; x=1767786922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=swz2J2a/Uvz7GnbU1XB2xGVGkNfU6LCVp1sNpOikUcs=;
        b=V/VCnwvzh8Cc62mL8dR2/w7MljJ3gleXyRDkx+ZgMhD8JblgAUMVOl0uSCgNve4NuU
         qYv5Az850XkhaedTxYRic++fJ48ClGGLSLXUR5omMv4XDZ/KZ61+RuZadFmUKWVwOr/U
         HaTWNTiq4TyZFXjm0sfnaD4lKGt/Ko3BcVLKtN0ExZi87pVCIrHRbT8LTWBUoV7XJvoL
         +aEdZkRQPubOqfaUIaF63ceQ8O7Cbfh/P7wCL81w7ZyfQXevBf744dj3jiqz9wFQ3bkD
         Oz62w81N5BCVVQlZyHok3VvYs/AmdOfvr1J32HB27Cx5y7rGc9vRvgICY+M/cilSogCC
         YV1Q==
X-Gm-Message-State: AOJu0YxFVCKYBKc8JHyHgjd3DzAozn+zUoqmTMbhP0SiVxYJM5/xywxw
	7PM5V2DRDVfHULmdcp9B2MGVStFfKcBThYUGNitiqEkilq3CEDw8a5Cn2Vuz3YSJkc8ixsb5cwQ
	erZkSAaC13pUDea92zLTGJ+U9exPCgRminQ==
X-Gm-Gg: AY/fxX7yRcaE9bi6zotNpL6TMmCr49V3AHdXzWF/3pSfr0cCdF7jhf/lOhSV0SlgxMf
	+m89JTxUGZLDsJ/ZNzuWyuSps1AFwxZapDG7A7ihHEyFutK5b+YF2hWPHDP0bSVf0ymPbVabr10
	HSESmpn5CXwZ6AT9IDyLAhiPoshfvxjv3Oqu6lGns/OQi6/KR7bddIU7CI5Z51Zd+xIKF9tzy8+
	J9iWGFX+OokDaAdufDH4SM4wadZCv/UrU3Gcw7Cagu1KN+YHCSS8YpNT2V7KPIBQY5yXvA=
X-Google-Smtp-Source: AGHT+IFSuOTcv/Uh/apazb+bOJuHLdM9Q6TSJGWkd1oEWKleP+mW23X2bKU7OmiDGmvR/RzBi9zk+nAmClTjQmrHgOY=
X-Received: by 2002:a05:622a:4017:b0:4ec:f697:2c00 with SMTP id
 d75a77b69052e-4f4abd8cb3cmr518033781cf.42.1767182122009; Wed, 31 Dec 2025
 03:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229160724.139406961@linuxfoundation.org> <20251229160726.283681845@linuxfoundation.org>
In-Reply-To: <20251229160726.283681845@linuxfoundation.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Wed, 31 Dec 2025 19:54:45 +0800
X-Gm-Features: AQt7F2q870pijWoytKiNxUv66GsO0vxRiMRdawQxP41fpdIBzi8BjzcfnQb7-Xc
Message-ID: <CANubcdVnWRkJ8x7zLGKih+uY0D0cE8jGmF_dx7+iDb5sgBWtQg@mail.gmail.com>
Subject: Re: [PATCH 6.18 052/430] gfs2: Fix use of bio_chain
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Andreas Gruenbacher <agruenba@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B412=E6=
=9C=8830=E6=97=A5=E5=91=A8=E4=BA=8C 00:16=E5=86=99=E9=81=93=EF=BC=9A
>
> 6.18-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Andreas Gruenbacher <agruenba@redhat.com>
>
> [ Upstream commit 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941 ]
>
> In gfs2_chain_bio(), the call to bio_chain() has its arguments swapped.
> The result is leaked bios and incorrect synchronization (only the last
> bio will actually be waited for).  This code is only used during mount
> and filesystem thaw, so the bug normally won't be noticeable.
>
> Reported-by: Stephen Zhang <starzhangzsd@gmail.com>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/gfs2/lops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 9c8c305a75c46..914d03f6c4e82 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -487,7 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, u=
nsigned int nr_iovecs)
>         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOI=
O);
>         bio_clone_blkg_association(new, prev);
>         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> -       bio_chain(new, prev);
> +       bio_chain(prev, new);
>         submit_bio(prev);
>         return new;
>  }
> --

Hi Greg,

I believe this patch should be excluded from the stable series. Please
refer to the discussion in the linked thread, which clarifies the reasoning=
:

https://lore.kernel.org/gfs2/tencent_B55495E8E88EEE66CC2C7A1E6FBC2FC16C0A@q=
q.com/T/#mad18b8492e01daa939c7d958200802c9603b6c73

Thanks,
Shida

> 2.51.0
>
>
>

