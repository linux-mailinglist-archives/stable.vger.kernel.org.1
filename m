Return-Path: <stable+bounces-185844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A873BDFCBC
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 19:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BB01A21323
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A3233A01A;
	Wed, 15 Oct 2025 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax1dUAgF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA18B33A012
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547705; cv=none; b=b3s2JF5mhYrnaAMBtn+oCNrhEos9ivhpZvH4nRIafzuaiUQni/Oqlnmc3JF00IOl5WZdj++k9OAoFF30sPHH568bRsCqDuGhFDcQjosHQeuaWBvj2tbRvqFHL0tVSqMGu44wjgfwyT41hzBeGQc82wnoobBB5MH98EIWOAwvJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547705; c=relaxed/simple;
	bh=wZR6LntXfylrJ2V1qOt0fxUP8eztdGw15uvAPV9vivY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxw6mtlWZmzNv3DdCUaLZz2QB+3Fgby9pcj+r4SxmpXJ/phaZDUwNZr1ppg5dHWYOdU0qnga1PVbfnlheMy3WsFz6bpmbooiWUWOfnCUWqZIl9Hz+ysAbMoNjaGS2mCmYdlXCWVQ8tEIePYVowI4KMzKZMI0TwedQzySoszEf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax1dUAgF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso42772265e9.0
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760547702; x=1761152502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaW+UC1rq0W26plsE3XiljyBBYTy7XtdEOWVsRu/CF4=;
        b=ax1dUAgF/U95+L6xAJK5KBZWQK/+0ySfcT2o8X9wXDCjvW7IbS12nuLwyzqL6OdeMy
         9VlFIQ8yirXBY4oMf7rfCM465B5DNd3Wk7SvB4crbpSZS8Ap+rSZSNmFo3yKz5fqrOyI
         D1+VsUDts+DomVczXAEV+yNrvsyoKh9Yd81+5tM3vTNCGiL3Ppdcp/hx7GpmrsqzQZPB
         A2wGQ3eRAUG+Z9oFN6rcVV8s9eGtuRoiDTxoeylzfvvfWi9OetQoskSyAD8s4/0vW3Nn
         dmUjcVqMiBYf3uhdTTXiaFDTRp7bJpAT1SWqGscDG/EUVGwS5fbbfDLnVAUYrfINcLpD
         DceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547702; x=1761152502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaW+UC1rq0W26plsE3XiljyBBYTy7XtdEOWVsRu/CF4=;
        b=Qi5TkWYzvGgxx19B4+7mxWtACLL2qEDxccod7HGqBKANk1Cnxv2ObVr4H2LRdo8Oz0
         SJogcxDPzrQy/dNdviHy6LGnPjwWgM4iqxP5fqgi2PUqP9szM4T+2XO0iG6FHqVNM6Ey
         wN3R2BdZHvvoFKpgHN2UenEBu4EA5K2ajdrCvj1SGt+Mp6j6RYhxM34i9Vvvtfgqn5ov
         7aC0fNKKNMayjyC4VGn/UKm45E8rTHN71MfqQJeDFy8HBbVP6zBjAcfdUGgtxlZUWq8y
         4WHfVtQa/LKwo0xXgCZIQCbhpcTKG+wIPsnivHCG1QgD491SYbqdaDuvW6xmv/ZgsOTR
         t96g==
X-Forwarded-Encrypted: i=1; AJvYcCVo9asbzwMtntRwU5i9KXu4NbYd5NnROFkeEtlpojQNW/sA5Zc9f0dXxffNvlq0ErtSI1lcxgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOc7Hs9XyxuSEkyQP+7ul9+TTFneqLMYgd2Ya/RW4PHPN8BaKh
	Glj2G+NMfFMoYS7+QjCU073UhotdtSYKpF3a0mHuZAJ5J9QsHknEBvjb8s37wdGxuML4Ic1BNBt
	zHwgCTAVguYyLOpDvHIwEG9uuJoNKe4o=
X-Gm-Gg: ASbGncspww94d9UA/BQp9NKIlEI9OhH70QJNuTnpbJC3hPq3FwV2xQ74k/dCpCzkJc1
	uMc5r7hWUUMEdXv3efxJKxfxQEIFpvzb8ZNaL9JdJ0GEdTZIkLIyM1FfFdXMilNoLF6w9ZZAWU3
	JSFQgDlbvasGqNuwL3h23w0JYYiBgF0xHJ/EMUg5JKxaFvm0WuZy2f901/qNSwmm1aJLh3oQnEU
	K46nrAe3arE5SZnL3+iau1qt+bW0uXv8IU/BWUYWyvnkpqio95ZPuxXNLyg
X-Google-Smtp-Source: AGHT+IH5q1G3vp7aIr9j+CFjigJLEQjjsDRUdRuc/pR1f5LEo5EYFqYYYI4jZqNguXo6x33gVKJAo9u1xzKoFN4WqTc=
X-Received: by 2002:a05:6000:2389:b0:3fd:eb15:77a with SMTP id
 ffacd0b85a97d-42666ac2da4mr17608172f8f.6.1760547700123; Wed, 15 Oct 2025
 10:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251015150026.117587-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251015155622.GE439570@ragnatech.se>
In-Reply-To: <20251015155622.GE439570@ragnatech.se>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 15 Oct 2025 18:01:13 +0100
X-Gm-Features: AS18NWCWlXKzJu_T8GRmOVtHfDBm-KRfIcMNJ-tWiuVV4eOyaIOISimJkQVzUdE
Message-ID: <CA+V-a8vudn0=kSnaAT4qDCcRtVShmS+n2A4GOQH2iogYizUBzw@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: ravb: Enforce descriptor type ordering to
 prevent early DMA start
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

On Wed, Oct 15, 2025 at 4:56=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
>
> Hi Prabhakar,
>
> Thanks for your work.
>
> On 2025-10-15 16:00:26 +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Ensure TX descriptor type fields are written in a safe order so the DMA
> > engine does not begin processing a chain before all descriptors are
> > fully initialised.
> >
> > For multi-descriptor transmissions the driver writes DT_FEND into the
> > last descriptor and DT_FSTART into the first. The DMA engine starts
> > processing when it sees DT_FSTART. If the compiler or CPU reorders the
> > writes and publishes DT_FSTART before DT_FEND, the DMA can start early
> > and process an incomplete chain, leading to corrupted transmissions or
> > DMA errors.
> >
> > Fix this by writing DT_FEND before the dma_wmb() barrier, executing
> > dma_wmb() immediately before DT_FSTART (or DT_FSINGLE in the single
> > descriptor case), and then adding a wmb() after the type updates to
> > ensure CPU-side ordering before ringing the hardware doorbell.
> >
> > On an RZ/G2L platform running an RT kernel, this reordering hazard was
> > observed as TX stalls and timeouts:
> >
> >   [  372.968431] NETDEV WATCHDOG: end0 (ravb): transmit queue 0 timed o=
ut
> >   [  372.968494] WARNING: CPU: 0 PID: 10 at net/sched/sch_generic.c:467=
 dev_watchdog+0x4a4/0x4ac
> >   [  373.969291] ravb 11c20000.ethernet end0: transmit timed out, statu=
s 00000000, resetting...
> >
> > This change enforces the required ordering and prevents the DMA engine
> > from observing DT_FSTART before the rest of the descriptor chain is
> > valid.
> >
> > Fixes: 2f45d1902acf ("ravb: minimize TX data copying")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/net/ethernet/renesas/ravb_main.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/eth=
ernet/renesas/ravb_main.c
> > index a200e205825a..2a995fa9bfff 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -2211,15 +2211,19 @@ static netdev_tx_t ravb_start_xmit(struct sk_bu=
ff *skb, struct net_device *ndev)
> >
> >               skb_tx_timestamp(skb);
> >       }
> > -     /* Descriptor type must be set after all the above writes */
> > -     dma_wmb();
> > +
> > +     /* For multi-descriptors set DT_FEND before calling dma_wmb() */
> >       if (num_tx_desc > 1) {
> >               desc->die_dt =3D DT_FEND;
> >               desc--;
> > -             desc->die_dt =3D DT_FSTART;
> > -     } else {
> > -             desc->die_dt =3D DT_FSINGLE;
> >       }
> > +
> > +     /* Descriptor type must be set after all the above writes */
> > +     dma_wmb();
> > +     desc->die_dt =3D (num_tx_desc > 1) ? DT_FSTART : DT_FSINGLE;
>
> IMHO it's ugly to evaluate num_tx_desc twice. I would rather just open
> code the full steps in each branch of the if above. It would make it
> easier to read and understand.
>
I did this just to avoid compiler optimizations. With the previous
similar code on 5.10 CIP RT it was observed that the compiler
optimized code in such a way that the DT_FSTART was written first
before DT_FEND while the DMA was active because of which we ran into
DMA issues causing QEF errors.

> > +
> > +     /* Ensure data is written to RAM before initiating DMA transfer *=
/
> > +     wmb();
>
> All of this looks a bit odd, why not just do a single dma_wmb() or wmb()
> before ringing the doorbell? Maybe I'm missing something obvious?
>
This wmb() was mainly added to ensure all the descriptor data is in
RAM. The HW manual for RZ/G1/2, R-Car Gen1/2 and RZ/G2L family
mentions that we need to read back the last written descriptor before
triggering the DMA. Please let me know if you think this can be
handled differently.

Cheers,
Prabhakar

> >       ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
> >
> >       priv->cur_tx[q] +=3D num_tx_desc;
> > --
> > 2.43.0
> >
>
> --
> Kind Regards,
> Niklas S=C3=B6derlund

