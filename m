Return-Path: <stable+bounces-185845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7EEBDFCEF
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43DBC4F5C84
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7D33A02C;
	Wed, 15 Oct 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA9u4T8A"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DCC26AA94
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547965; cv=none; b=X6+rHKELiJwEx2RbTmItRzOb6nB29w5HnEpWAz+6WiV3vkZhYdV1l2MAUEIuC9gAH5I+7wiWx/iRmb8eXx3GpwSylO/k/+jt+QhEqmbe/XmZLpuIzI2ZUxt5OecEA+oEarcie26RBeSQgOEsWQrkzKSFq8FBMBG4F1sPUrzRJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547965; c=relaxed/simple;
	bh=ZRj4yj/dKCCw4SWLghqAcuiSwYLPhJ4yuDL64uAxDnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0l3fx7oLnX+rBSTAHrg7cr8enryQYW624kowb8Q2sa015aQYXyUiceJb8GLTzunBK3XlUEEErquCcW1P+fFbIc8tG0C4AT+dG0A/3wUJU/R7pxRDMgw07Xl0Ydj1fRyHtvcIWJiR823xxgmUKJ13bQa7kfW33KROUVu6crUDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA9u4T8A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471076f819bso6022455e9.3
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760547961; x=1761152761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAkTMQSX/DJUiILggSnm+16NO/7qs2Cgt/X+vx3kuHk=;
        b=MA9u4T8ALuAdvYyQht5t0Onkqed/vNRwbUida/LZuV0X6ZKq10kKkA+qw4kCOpHJTB
         CQx3OZJwYkmmOQ9fbfPwuaa6WrLyusvCKrR4GFUVguaLGLMTX3EtvtAoqiwyVuCpPcv8
         HNRgoLxdO7bTylTis/KTTtH1ojqCylndEXCoDQlpnuzhhdOm/iZtpAVZzp9xYNByNAE1
         2WYHeknJSNkbijMxNOvSTw6cB0o6mbh9p7LwHguMGrrxeWkZ+kevkZgfssd4vrAfeQ7+
         2aRyekDSXSjIxAlaIKdkrZTbY+NqbMJzdWrjYWOeFVKnAKzfFpT3MhrRDtpwNjzPFaH+
         jBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547961; x=1761152761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAkTMQSX/DJUiILggSnm+16NO/7qs2Cgt/X+vx3kuHk=;
        b=nBBow5wHc24gUv7eQ0tHSOVmKnFurYa3obO9KkrjBTcSVDjZDjt+xdIaL00bMrj3fW
         mWte6I4ghvAE+E/M6SyRSo6Fjvr5hHW3E74m1fja4+onuCDALjRJgtFikMgshEwJ6v1h
         xSAF0DIx55EUA97mcAMd0bg3UsLU2nqryL6XrfEQqAAq4lI53POh5a5VU1mj2RHNA2kX
         9Awf0Y7Y7NVoXzP+F/ZSC2cgVHVSG084YcsOHDxLTRrTCeVdA5Kc7mxB+ptjIRLlO5go
         cVNVVzslasYo+SM0csH5Gb1x/dTqWq7/Noo1m7dJ3ps4YLJz1vGcm1Ni+dB9/dlV8AcJ
         mJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeqFlpq9PaYDYNXzjpyiueVt9WIrgnL1Gw3+hn2HuQq6vWGhMrtNN/xiTxzwKi7AUZt3wQHC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zyw+B3WQvNFIvTXRFTNyQlm/ckb1BBb94nSpLq9J99Iq/ELF
	kb7D1zbFsVlPs1lwd6xQa+I07tCkPAY8i51MK6kh7VY13/HSFUEKxr+aowwhuAG4jY4HHLQUrVL
	LNqmwxbdCxVnyhyRf7jcCDAPAHuy3FVs=
X-Gm-Gg: ASbGncvzNVU3Yx0Tx6FK8IdYcdi72dzCLSWXsQrcQo+14ho4z0sO//tJ9H7SyL2iTec
	QSoL/bpO9gS8PpofD0UIg9R/AOXNuqgIVpJ7uVe6cMlAwXFfWGoBSehKY90vWaADzNtpER0jdtL
	uH4064h6T+C6jW42t7P6DEew+X5ay4R4C+7jrzGkO5Rn67aapnyGJz0K8BELbO6/4hGn8Ln2K1A
	H8ga3TyeS7ky6Usr5/V3+YTFuzg0MZTDP5uwJ4g/fNjpQkWlJUilwwykfe3WP1z0S6CpT4=
X-Google-Smtp-Source: AGHT+IHI7wNHnTiwaqUhiPR8CydFMYL65NRKSxFd39pyvhc1Mu/mg/YS2k0xCuKgzJyECEHhLkPG2NPYmawpE45EPMs=
X-Received: by 2002:a05:600c:529a:b0:46e:3e25:1626 with SMTP id
 5b1f17b1804b1-46fa9aefe15mr218668285e9.19.1760547960573; Wed, 15 Oct 2025
 10:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251015150026.117587-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251015153556.GC439570@ragnatech.se>
In-Reply-To: <20251015153556.GC439570@ragnatech.se>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 15 Oct 2025 18:05:34 +0100
X-Gm-Features: AS18NWCeZXObMFBnMoScyXIU84ZFuSWIQLCEr-5cctebOmvYCISJdgFwzckySGU
Message-ID: <CA+V-a8vRXN+2CDQu=FkN_teTDLywzGPn_=8obvKC+3tmwYo4hA@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: ravb: Make DBAT entry count configurable per-SoC
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Thank you for the review.

On Wed, Oct 15, 2025 at 4:36=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
>
> Hi Prabhakar,
>
> Thanks for your work.
>
> On 2025-10-15 16:00:24 +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The number of CDARq (Current Descriptor Address Register) registers is =
not
> > fixed to 22 across all SoC variants. For example, the GBETH implementat=
ion
> > uses only two entries. Hardcoding the value leads to incorrect resource
> > allocation on such platforms.
> >
> > Pass the DBAT entry count through the per-SoC hardware info struct and =
use
> > it during probe instead of relying on a fixed constant. This ensures
> > correct descriptor table sizing and initialization across different SoC=
s.
> >
> > Fixes: feab85c7ccea ("ravb: Add support for RZ/G2L SoC")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> I have not verified with documentation the setting of 2 for
> gbeth_hw_info. But the change itself is good.
>
> > ---
> >  drivers/net/ethernet/renesas/ravb.h      | 2 +-
> >  drivers/net/ethernet/renesas/ravb_main.c | 9 +++++++--
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet=
/renesas/ravb.h
> > index 7b48060c250b..d65cd83ddd16 100644
> > --- a/drivers/net/ethernet/renesas/ravb.h
> > +++ b/drivers/net/ethernet/renesas/ravb.h
> > @@ -1017,7 +1017,6 @@ enum CSR2_BIT {
> >  #define CSR2_CSUM_ENABLE (CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4 | \
> >                         CSR2_RTCP6 | CSR2_RUDP6 | CSR2_RICMP6)
> >
> > -#define DBAT_ENTRY_NUM       22
> >  #define RX_QUEUE_OFFSET      4
> >  #define NUM_RX_QUEUE 2
> >  #define NUM_TX_QUEUE 2
> > @@ -1062,6 +1061,7 @@ struct ravb_hw_info {
> >       u32 rx_max_frame_size;
> >       u32 rx_buffer_size;
> >       u32 rx_desc_size;
> > +     u32 dbat_entry_num;
>
> I have been wondering for some time if we shall not start to document
> these fields as they always take so much time to get back to what each
> of them represent. How do you feel about starting a header?
>
> /**
>  * dbat_entry_num: Describe me here.
>  */
>
I agree, let's take this separately into a different patch as it will
make things easier to backport. What do you think?

Cheers,
Prabhakar

> Without, but preferably with, this added.
>
> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se=
>
>
> >       unsigned aligned_tx: 1;
> >       unsigned coalesce_irqs:1;       /* Needs software IRQ coalescing =
*/
> >
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/eth=
ernet/renesas/ravb_main.c
> > index 9d3bd65b85ff..69d382e8757d 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -2694,6 +2694,7 @@ static const struct ravb_hw_info ravb_gen2_hw_inf=
o =3D {
> >       .rx_buffer_size =3D SZ_2K +
> >                         SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
> >       .rx_desc_size =3D sizeof(struct ravb_ex_rx_desc),
> > +     .dbat_entry_num =3D 22,
> >       .aligned_tx =3D 1,
> >       .gptp =3D 1,
> >       .nc_queues =3D 1,
> > @@ -2717,6 +2718,7 @@ static const struct ravb_hw_info ravb_gen3_hw_inf=
o =3D {
> >       .rx_buffer_size =3D SZ_2K +
> >                         SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
> >       .rx_desc_size =3D sizeof(struct ravb_ex_rx_desc),
> > +     .dbat_entry_num =3D 22,
> >       .internal_delay =3D 1,
> >       .tx_counters =3D 1,
> >       .multi_irqs =3D 1,
> > @@ -2743,6 +2745,7 @@ static const struct ravb_hw_info ravb_gen4_hw_inf=
o =3D {
> >       .rx_buffer_size =3D SZ_2K +
> >                         SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
> >       .rx_desc_size =3D sizeof(struct ravb_ex_rx_desc),
> > +     .dbat_entry_num =3D 22,
> >       .internal_delay =3D 1,
> >       .tx_counters =3D 1,
> >       .multi_irqs =3D 1,
> > @@ -2769,6 +2772,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_in=
fo =3D {
> >       .rx_buffer_size =3D SZ_2K +
> >                         SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
> >       .rx_desc_size =3D sizeof(struct ravb_ex_rx_desc),
> > +     .dbat_entry_num =3D 22,
> >       .multi_irqs =3D 1,
> >       .err_mgmt_irqs =3D 1,
> >       .gptp =3D 1,
> > @@ -2794,6 +2798,7 @@ static const struct ravb_hw_info gbeth_hw_info =
=3D {
> >       .rx_max_frame_size =3D SZ_8K,
> >       .rx_buffer_size =3D SZ_2K,
> >       .rx_desc_size =3D sizeof(struct ravb_rx_desc),
> > +     .dbat_entry_num =3D 2,
> >       .aligned_tx =3D 1,
> >       .coalesce_irqs =3D 1,
> >       .tx_counters =3D 1,
> > @@ -3025,7 +3030,7 @@ static int ravb_probe(struct platform_device *pde=
v)
> >       ravb_parse_delay_mode(np, ndev);
> >
> >       /* Allocate descriptor base address table */
> > -     priv->desc_bat_size =3D sizeof(struct ravb_desc) * DBAT_ENTRY_NUM=
;
> > +     priv->desc_bat_size =3D sizeof(struct ravb_desc) * info->dbat_ent=
ry_num;
> >       priv->desc_bat =3D dma_alloc_coherent(ndev->dev.parent, priv->des=
c_bat_size,
> >                                           &priv->desc_bat_dma, GFP_KERN=
EL);
> >       if (!priv->desc_bat) {
> > @@ -3035,7 +3040,7 @@ static int ravb_probe(struct platform_device *pde=
v)
> >               error =3D -ENOMEM;
> >               goto out_rpm_put;
> >       }
> > -     for (q =3D RAVB_BE; q < DBAT_ENTRY_NUM; q++)
> > +     for (q =3D RAVB_BE; q < info->dbat_entry_num; q++)
> >               priv->desc_bat[q].die_dt =3D DT_EOS;
> >
> >       /* Initialise HW timestamp list */
> > --
> > 2.43.0
> >
>
> --
> Kind Regards,
> Niklas S=C3=B6derlund

