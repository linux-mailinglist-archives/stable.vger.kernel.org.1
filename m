Return-Path: <stable+bounces-12275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35537832B67
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 15:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8440FB20A7D
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCBF52F93;
	Fri, 19 Jan 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2U4i9d/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E452F6F
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675135; cv=none; b=WXjoOiBlCc2Zq34LySeiY4K1BN1KktVQFQTtmTGs8e6HQZak7UdbToBWDwzUA9uXzPtJtxfV0aPRSk0pNK7B1VlxuxFJmN0c7Os1OcUklBmuqYpisT2AAsjZonnHK5ccmkoHpRWnHuPDiZsY9VaIOIKuBSMURjwUWtJYRmNUbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675135; c=relaxed/simple;
	bh=bpeSFU/D5a9imiB0v5RukAPjfNL/+DOaB1Ph7Mw3YOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bg3a1kBR59qCbs0VO1dwns/L9cE8kleIuxi6/3++crUHhCV4L9JOFvI0PcYvjBsiysRqjy9YcnmcTLMIoTQQnhSfuTxb0aTDXtBVdbGzfFqVsttTBOvo7GP3Cg1RGvXnB1p5C5KnaCKzNvb/Efq8dgMVjWc03sMeUUpGQNEy5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2U4i9d/; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-203ae9903a6so473041fac.0
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 06:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705675132; x=1706279932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmm/nAqf1mxeb/ePw174BwMXvzBXD3KAiTlzBYxndrE=;
        b=a2U4i9d/C1VNG/DbXc9TTGxIne3AA7b8hgtUYc3zIYs3dKaxtDPkfLcLNzQPApluZP
         8csWcORTVSjE25l9K2e/HYD2QxFMG8BJM+yrFfRlL+jCdVlHzXWeeZCDqwLPby8SD72q
         2XGIBmBeSqt1Hvm6wWMLGf8qbqL6sBWPBzk+ACrqfNgFkA1taRWcN5oKIHk+ttU7J9lA
         jjdYwto9Vyo8KXd9VVeIaSG1opGpXnr4dlqaCJr2qXtK8zt6QcL2BwQpZH02NsoOShbC
         Iq8TVv2QDuqzPDgppYfQIMTBe863SeKeYTpAQlJbOK1qRWU5MyTX1WIH08rDgp8weLSz
         OwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705675132; x=1706279932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmm/nAqf1mxeb/ePw174BwMXvzBXD3KAiTlzBYxndrE=;
        b=Q12yA9j6G/rvLD4miDm1iRN2cIvRtGBPFEdDKss35wRHGO/tzk1SxynLjlxIMAGOiQ
         1a7VfMMpxUVHi9zbPz7F6Kv5LIR64N1qhELhGa8H0HF9EtzKB5RmJfSpr75xmGGuRIDl
         S8/IgE95nWx0KOtiDhby0vPrMHkMIClhsKOyl+c5b5L44uvGmejQTrVtikVKfNiVk8Od
         MDccqSkYubgQIkyrypWd8bR1OK2iO3EIGYLXpabL/APba9FHZXtqAFfub4fcyt+cr0J3
         Esns0twDy7LIaNIkVk8EoL+dnPCTgh2DsaG1jympBfyli9mqIpRwrPUZ3+Q1QQQbFxUg
         ekVQ==
X-Gm-Message-State: AOJu0Yy9Xs6rY3X6o74arfWgfVGc75q3NNBN/rmgSASkvlKiPW6hk/jT
	sUzjEO5Sf2zU450CHHcH9u99uQfEoZ3Ex6Jb1tPGqf4yPLWvqJX5OVA8X2xVxDuU687d59R9Wg6
	0/q6gRhTlJup/foprWGDfERgj2ac=
X-Google-Smtp-Source: AGHT+IHldIW2TxR1GeACuCnJQpPWtqtzyzyCYj/UP+1e5Fvo4ivyRbO0ndTFuhLE/yqB2PB4XS4obH8nfT2JSiEvc/M=
X-Received: by 2002:a05:6870:5693:b0:210:7f14:e5c1 with SMTP id
 p19-20020a056870569300b002107f14e5c1mr2324345oao.35.1705675132370; Fri, 19
 Jan 2024 06:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118185402.919396-1-friedrich.vock@gmx.de> <c3d81197-a2a6-4884-832c-d0b8459340aa@amd.com>
In-Reply-To: <c3d81197-a2a6-4884-832c-d0b8459340aa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jan 2024 09:38:40 -0500
Message-ID: <CADnq5_O6U8DSGJOUk9_sfL2bEUGgLej-nLsVH_ep-2BKZL_Bng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org, 
	Joshua Ashton <joshua@froggi.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:11=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 18.01.24 um 19:54 schrieb Friedrich Vock:
> > Allows us to detect subsequent IH ring buffer overflows as well.
> >
> > Cc: Joshua Ashton <joshua@froggi.es>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: stable@vger.kernel.org
> >
> > Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> > ---
> > v2: Reset CLEAR_OVERFLOW bit immediately after setting it
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 2 ++
> >   drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 6 ++++++
> >   drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 6 ++++++
> >   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 8 ++++++++
> >   drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/si_ih.c      | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 7 +++++++
> >   11 files changed, 71 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ih.h
> > index 508f02eb0cf8..6041ec727f06 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > @@ -69,6 +69,8 @@ struct amdgpu_ih_ring {
> >       unsigned                rptr;
> >       struct amdgpu_ih_regs   ih_regs;
> >
> > +     bool overflow;
> > +
>
> That flag isn't needed any more in this patch as far as I can see.

It's used in patch 2.

Alex

>
> Regards,
> Christian.
>
> >       /* For waiting on IH processing at checkpoint. */
> >       wait_queue_head_t wait_process;
> >       uint64_t                processed_timestamp;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/=
amdgpu/cik_ih.c
> > index 6f7c031dd197..bbadf2e530b8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> > @@ -204,6 +204,13 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *a=
dev,
> >               tmp =3D RREG32(mmIH_RB_CNTL);
> >               tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> >               WREG32(mmIH_RB_CNTL, tmp);
> > +
> > +             /* Unset the CLEAR_OVERFLOW bit immediately so new overfl=
ows
> > +              * can be detected.
> > +              */
> > +             tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> > +             WREG32(mmIH_RB_CNTL, tmp);
> > +             ih->overflow =3D true;
> >       }
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/cz_ih.c
> > index b8c47e0cf37a..e5c4ed44bad9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> > @@ -216,6 +216,12 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *ad=
ev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32(mmIH_RB_CNTL, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +     ih->overflow =3D true;
> >
> >   out:
> >       return (wptr & ih->ptr_mask);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/=
amd/amdgpu/iceland_ih.c
> > index aecad530b10a..075e5c1a5549 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> > @@ -215,6 +215,12 @@ static u32 iceland_ih_get_wptr(struct amdgpu_devic=
e *adev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32(mmIH_RB_CNTL, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +     ih->overflow =3D true;
> >
> >   out:
> >       return (wptr & ih->ptr_mask);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/ih_v6_0.c
> > index d9ed7332d805..d0a5a08edd55 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > @@ -418,6 +418,13 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *=
adev,
> >       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd=
/amdgpu/ih_v6_1.c
> > index 8fb05eae340a..6bf4f210ef74 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> > @@ -418,6 +418,14 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *=
adev,
> >       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> > +
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/a=
md/amdgpu/navi10_ih.c
> > index e64b33115848..cdbe7d01490e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > @@ -442,6 +442,13 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device=
 *adev,
> >       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/si_ih.c
> > index 9a24f17a5750..398fbc296cac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> > @@ -119,6 +119,13 @@ static u32 si_ih_get_wptr(struct amdgpu_device *ad=
ev,
> >               tmp =3D RREG32(IH_RB_CNTL);
> >               tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> >               WREG32(IH_RB_CNTL, tmp);
> > +
> > +             /* Unset the CLEAR_OVERFLOW bit immediately so new overfl=
ows
> > +              * can be detected.
> > +              */
> > +             tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> > +             WREG32(IH_RB_CNTL, tmp);
> > +             ih->overflow =3D true;
> >       }
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/am=
d/amdgpu/tonga_ih.c
> > index 917707bba7f3..1d1e064be7d8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> > @@ -219,6 +219,13 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device =
*adev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32(mmIH_RB_CNTL, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +     ih->overflow =3D true;
> > +
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/a=
md/amdgpu/vega10_ih.c
> > index d364c6dd152c..619087a4c4ae 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > @@ -373,6 +373,13 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device=
 *adev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> > +
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/a=
md/amdgpu/vega20_ih.c
> > index ddfc6941f9d5..f42f8e5dbe23 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > @@ -421,6 +421,13 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device=
 *adev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> > +
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > --
> > 2.43.0
> >
>

