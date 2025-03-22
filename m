Return-Path: <stable+bounces-125820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF647A6CC40
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D6B188474A
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F21235340;
	Sat, 22 Mar 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="MRW+w1WV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46B23534F
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675407; cv=none; b=fnguql6ye2XwDO0VJO37uijfYW8pYzru9y+djfYmIfj92BkGalQ7WzQIkr9jy5LoDXTrtggWieV34T9c2BdR3MMFLiRCEfyOB6dOTCnycuNB2cPlmHK9FvCLpZz6H4WcsPiokFTJROENIjzY75L6Gn2aa5x2gXNjxAQaGWY1iq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675407; c=relaxed/simple;
	bh=23pANsHNneeXWCHFPR720EsnKizCIuI1/wb/1+/Tu2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWZ6p7BMN5n6AJwJXO8eYjcZUPMlTtTE7ko13hne1D6oOeTtahaGkiJlX6FqMEW+5Cd5alJjShcimMBMGM/e7SDydiRlRokqypTEzMjoyuICw+mXgo7iy2vPfSw5StABTbkAR8NbiKhWEz+T/ejWwiUH0zdPLvCZGDqR3rzn9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=MRW+w1WV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso4031358a12.2
        for <stable@vger.kernel.org>; Sat, 22 Mar 2025 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1742675404; x=1743280204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6cSUgatbqKhRbZTmyK9VSh/Zt9MhUeI55/TCtex2OE=;
        b=MRW+w1WVrF0Mg//g20zfB55EBGp1f4ozxaBHyq3ait8RAcWniB26tDsnxWAfmU0JRD
         i4XxkNxlkzsM3v4RKwKynvhJZ4tAroctlzfgTe5U9XNkCe6wNUf4rWBVo2mtA2r1FLcN
         RQjHPxOMD2ou7qswx7KNP531wFcMsfk/urhoab22xPCS6Mwv/IqKZaCafVrBz9pBmoTV
         +ie+bu+3MmzdTycAdLBkzmwk6DXAfJCcR85apxxRdaUqZ6aiDaamZSnNLEaknYC1qog2
         axSpdmAKaEAcUB1btcBfstjSACSJIIfAnA7Fgno0Uchj8GIrII0qseMM1AIdLxZhABm2
         Fzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675404; x=1743280204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6cSUgatbqKhRbZTmyK9VSh/Zt9MhUeI55/TCtex2OE=;
        b=c96/RDn88lhQsjH6o5w3MH572i4VWdzc4lzBytiKhRiVY9DA8o06yzOzXeQqUGvBrh
         ZvG1auf7UkDTF3Dg6oaSA4RVLeCWSrJizZGFcZcYmyIwALPPsSOTbe3fX/Y8Bn6QkVtL
         DfrV1cJGf1qTJ87qe8KGce4+7sC5j+pQbEPvJWbqqUYuwXyOjj2IdFQ+ZSadPpuU8dHF
         1so2PgILQTgoXMszlZFhIrnsVLkRygBlknCMTHSgreRi08mENeU35LEV3SSv3DcOP6Qq
         R5ktnWXjxglFI9En6yN0o/o1buwFaVxOlcTWJpqfMvGxGSziCw/TrI+yiK+Rihi6jZcl
         yjHA==
X-Forwarded-Encrypted: i=1; AJvYcCWGSmXueYvTjyqmicJiAagtgSiilqr7r1SFkgs3qoP+zp5hoip/2yxtkc0dVg1WSLPJi3iuYks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1QIlxefbGoVmlVa8Kh/TuqYJL1b2Hulk4bHez1pbqO85y3jM
	ZOXhZxM8DYkRI5V8/8fWzMMSjpRpyrFVohlKmGOduLguHsyYNsIVN3VQSl5hxrjtV29hzacmG85
	vu57sNRmzuDnaIPGc7QoJuajA7BVMw8sy5Tcojg==
X-Gm-Gg: ASbGncuRaiZXn/DZzvwxb7AjjcyVj1X5PJBHirK1qfJKv6kolQ7agjeJKlxdLJuzd3f
	KwdTIkhOjhkwjjh0bEZoNgpWNzwslKZsW41Oj36hHTM+MJ9MbAHxQz1YMZy0LpI8ORTNCr554p3
	6enPac4hNFfHReAkCFwMZkfYYVDjo=
X-Google-Smtp-Source: AGHT+IFBIVXZYDtiJpjWV/LcWygCCyM8XLLo2e1nj12IRbPwY/47eV7JcCDI5vBSVRn6rhZYRnytHKUjzgf552Rs/uQ=
X-Received: by 2002:a05:6402:524e:b0:5dc:6e27:e6e8 with SMTP id
 4fb4d7f45d1cf-5ebcd4fa24dmr7390153a12.24.1742675403691; Sat, 22 Mar 2025
 13:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321094916.19098-1-johan+linaro@kernel.org>
In-Reply-To: <20250321094916.19098-1-johan+linaro@kernel.org>
From: Steev Klimaszewski <steev@kali.org>
Date: Sat, 22 Mar 2025 15:29:52 -0500
X-Gm-Features: AQ5f1JoCXYzLr6Wcr5GEM3kx8AqnGOONhGWVUVet26agDhGD1qrhlsAqp0-B4Hs
Message-ID: <CAKXuJqjTP9Pr_AFOfNwzzi9F=qOO8zdo7Ga+6-a8x1ihsN4SpA@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: fix ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>, 
	Clayton Craft <clayton@craftyguy.net>, Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Fri, Mar 21, 2025 at 4:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
>
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expec=
ted 1492
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expec=
ted 1484
>
> which based on a quick look at the driver seemed to indicate some kind
> of ring-buffer corruption.
>
> Miaoqing Pan tracked it down to the host seeing the updated destination
> ring head pointer before the updated descriptor, and the error handling
> for that in turn leaves the ring buffer in an inconsistent state.
>
> Add the missing memory barrier to make sure that the descriptor is read
> after the head pointer to address the root cause of the corruption while
> fixing up the error handling in case there are ever any (ordering) bugs
> on the device side.
>
> Note that the READ_ONCE() are only needed to avoid compiler mischief in
> case the ring-buffer helpers are ever inlined.
>
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LIT=
E-3.6510.41
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218623
> Link: https://lore.kernel.org/20250310010217.3845141-3-quic_miaoqing@quic=
inc.com
> Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Cc: stable@vger.kernel.org      # 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/ce.c  | 11 +++++------
>  drivers/net/wireless/ath/ath11k/hal.c |  4 ++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/=
ath/ath11k/ce.c
> index e66e86bdec20..9d8efec46508 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.c
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -393,11 +393,10 @@ static int ath11k_ce_completed_recv_next(struct ath=
11k_ce_pipe *pipe,
>                 goto err;
>         }
>
> +       /* Make sure descriptor is read after the head pointer. */
> +       dma_rmb();
> +
>         *nbytes =3D ath11k_hal_ce_dst_status_get_length(desc);
> -       if (*nbytes =3D=3D 0) {
> -               ret =3D -EIO;
> -               goto err;
> -       }
>
>         *skb =3D pipe->dest_ring->skb[sw_index];
>         pipe->dest_ring->skb[sw_index] =3D NULL;
> @@ -430,8 +429,8 @@ static void ath11k_ce_recv_process_cb(struct ath11k_c=
e_pipe *pipe)
>                 dma_unmap_single(ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
>                                  max_nbytes, DMA_FROM_DEVICE);
>
> -               if (unlikely(max_nbytes < nbytes)) {
> -                       ath11k_warn(ab, "rxed more than expected (nbytes =
%d, max %d)",
> +               if (unlikely(max_nbytes < nbytes || nbytes =3D=3D 0)) {
> +                       ath11k_warn(ab, "unexpected rx length (nbytes %d,=
 max %d)",
>                                     nbytes, max_nbytes);
>                         dev_kfree_skb_any(skb);
>                         continue;
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless=
/ath/ath11k/hal.c
> index 61f4b6dd5380..8cb1505a5a0c 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -599,7 +599,7 @@ u32 ath11k_hal_ce_dst_status_get_length(void *buf)
>         struct hal_ce_srng_dst_status_desc *desc =3D buf;
>         u32 len;
>
> -       len =3D FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, desc->flags);
> +       len =3D FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, READ_ONCE(des=
c->flags));
>         desc->flags &=3D ~HAL_CE_DST_STATUS_DESC_FLAGS_LEN;
>
>         return len;
> @@ -829,7 +829,7 @@ void ath11k_hal_srng_access_begin(struct ath11k_base =
*ab, struct hal_srng *srng)
>                 srng->u.src_ring.cached_tp =3D
>                         *(volatile u32 *)srng->u.src_ring.tp_addr;
>         } else {
> -               srng->u.dst_ring.cached_hp =3D *srng->u.dst_ring.hp_addr;
> +               srng->u.dst_ring.cached_hp =3D READ_ONCE(*srng->u.dst_rin=
g.hp_addr);
>
>                 /* Try to prefetch the next descriptor in the ring */
>                 if (srng->flags & HAL_SRNG_FLAGS_CACHED)
> --
> 2.48.1
>

Like the others, I was seeing this message multiple times a day, and
on a not so rare occasion it would also take the wifi device offline,
with this patch applied, I do not see that at all here.

Tested-by: Steev Klimaszewski <steev@kali.org>

