Return-Path: <stable+bounces-19076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B084CD25
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 15:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32901F21D37
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542817E79F;
	Wed,  7 Feb 2024 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4eLrhBM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FE7D3E6
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317214; cv=none; b=hcoHKWryTP+yVNx/2SA1u1g4lcyTLCetuOk60lDVHOm5tYEcqFcXWJReNOaF0ZUtIS4OZcMoOWXhXwoYBwVkSUKT7ZNXMAlvOeKEzkkJTP+83lul3SsNZ5WZA3U+njm50rqYLtQAJzotwL6sCaoGtEK3GWopeNrrGqu1OW/YH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317214; c=relaxed/simple;
	bh=/+5Ax2hSk99F5O69NYL28HyxqMdfko1Syo5d5CD5HYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtErLy4u0Alu13/TXjNFh8epVb+6c1Rij8PpgP38x/ZL3/orUVoMapJw5ZTFJj5irTFudJ4rvJF6QXvFZOdaDavMEMH6+mwqFDgGakxEFoQ/DnSdedGaZMnwklOYaIAwWNNhj7d2XdpNfXjny4NohJdzt4B7X0YEpNgLr1nDx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4eLrhBM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3864258438so142013566b.0
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707317211; x=1707922011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM9iIW7HjZWB1xD5kJizaiHrI85sdwm4gmOhcZxYsu4=;
        b=I4eLrhBMrfttDYZKG9NvPzqmUrgOCHACMlWNDCmeDUV8wrqearza1+SkqJ/QdFkc49
         yhQlkNqMBsigrqp8XlGnBQbFBpTrYYF5r8JJQcXEpXPgySBo2T/KJOn1CEGnGT/I9h7z
         Sjai5qCjvB7BNu2Ll/O/869oqUiudL7tzyPtAfe7KoMQ4TxA+cV25za9qyf3Qi3QzN/w
         RuCjUQtmBoF1NZIC2iMxZBIwcxro0me1eZXBtWbYGH/6GX6CkNRvJSx86d/3VGcruXO9
         fxzjGe3oqrRaLGWajZLcJ7XExm6ypCrbU3jSYvZAK7NJ2nKv27ip+sYS2zf9w1ujhst7
         TPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317211; x=1707922011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM9iIW7HjZWB1xD5kJizaiHrI85sdwm4gmOhcZxYsu4=;
        b=Jb3KsOkVvni2KDKJ6cOX64q11coHsmuxbbgcNSnxpuCG8Ei02qaDI40JAW6fgJ2n5H
         49DL7z7hJhpgGyjjhS1VyUeuLrNW9WKiEBTvUzPqrX8LjDqkSafMJEnPn3TyL3DPrsuw
         8n6hs7PIRDcR71/aRdVJeL0sOIdDJRGcw+9O/icySVZ1qoXrNSWtIqX4mvsdDh1m8Euy
         QMDC1PolxMy6DX0uSfDxjNrlASqZGkZat8oFASEOFDsRoISVMtTdOtINgJN2LnY0TqRH
         30j99hgDSYcnc7muV3mD6hR0djnwFoci9djGa5DPu9iyt1KTxB+C69eiFiSvewbVFfy2
         KXqw==
X-Forwarded-Encrypted: i=1; AJvYcCWtcbqidsHK235chDalrGaxfxO2DOMYL74UodCGm1Pr2+ez/fKieq/OSXw4t6UebVtZB2nkPHLObEWhdwM6H3SwquLIWOAo
X-Gm-Message-State: AOJu0Yy1hc4kam6qkJfDSWx1AOBWCZ9ERbUsPBSKiFg+FIjpzoomaSsU
	lPxseh50sZ1WZo14aAABj0kK3Gnd1C28hqkTja9DD4SyGqHaAguQPsr0/4zw/SaZCpuRIPHcaEt
	1CWELwtxWxfhotXQkosQPWwRyS8/luDchaj0i
X-Google-Smtp-Source: AGHT+IFyZS+87fmpcf+H1SnVXiGeifiadi7tt3T0qo6oS9P89a816YleSLXYnt4w29SL3RY4vdG+Lys4yCbp7XDgOqE=
X-Received: by 2002:a17:907:7759:b0:a38:1711:ee61 with SMTP id
 kx25-20020a170907775900b00a381711ee61mr6175816ejc.19.1707317211142; Wed, 07
 Feb 2024 06:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <1ecb3744-7baf-4bdd-a01c-8c87fa0a42b3@linaro.org>
 <CAOSNQF2TpA1QXKQBEZXsjXojGcfRKZDjCtLhRUGwLPVfhNWmgA@mail.gmail.com> <feff8e48-c974-447a-99bb-21d5beda1dd1@linaro.org>
In-Reply-To: <feff8e48-c974-447a-99bb-21d5beda1dd1@linaro.org>
From: Joy Chakraborty <joychakr@google.com>
Date: Wed, 7 Feb 2024 20:16:37 +0530
Message-ID: <CAOSNQF0akup9owP6EC0Q7eSrfdsr-sr1bhArF+YQAiAxfRJaVQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:00=E2=80=AFPM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 07/02/2024 06:35, Joy Chakraborty wrote:
> > On Wed, Feb 7, 2024 at 4:06=E2=80=AFAM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >>
> >>
> >> On 06/02/2024 04:24, Joy Chakraborty wrote:
> >>> reg_read() callback registered with nvmem core expects an integer err=
or
> >>> as a return value but rmem_read() returns the number of bytes read, a=
s a
> >>> result error checks in nvmem core fail even when they shouldn't.
> >>>
> >>> Return 0 on success where number of bytes read match the number of by=
tes
> >>> requested and a negative error -EINVAL on all other cases.
> >>>
> >>> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as =
nvmem")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> >>> ---
> >>>    drivers/nvmem/rmem.c | 7 ++++++-
> >>>    1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> >>> index 752d0bf4445e..a74dfa279ff4 100644
> >>> --- a/drivers/nvmem/rmem.c
> >>> +++ b/drivers/nvmem/rmem.c
> >>> @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int o=
ffset,
> >>>
> >>>        memunmap(addr);
> >>>
> >>> -     return count;
> >>> +     if (count !=3D bytes) {
> >>
> >> How can this fail unless the values set in priv->mem->size is incorrec=
t
> >>
> >
> > That should be correct since it would be fetched from the reserved
> > memory definition in the device tree.
> >
> >> Only case I see this failing with short reads is when offset cross the
> >> boundary of priv->mem->size.
> >>
> >>
> >> can you provide more details on the failure usecase, may be with actua=
l
> >> values of offsets, bytes and priv->mem->size?
> >>
> >
> > This could very well happen if a fixed-layout defined for the reserved
> > memory has a cell which defines an offset and size greater than the
> > actual size of the reserved mem.
>
> No that should just be blocked from core layer, atleast which is what is
> checked bin_attr_nvmem_read(), if checks are missing in other places
> then that needs fixing.
>

Sure.

>
> > For E.g. if the device tree node is as follows
> > reserved-memory {
> >      #address-cells =3D <1>;
> >      #size-cells =3D <1>;
> >      ranges;
> >      nvmem@1000 {
> >          compatible =3D "nvmem-rmem";
> >          reg =3D <0x1000 0x400>;
> >          no-map;
> >          nvmem-layout {
> >              compatible =3D "fixed-layout";
> >              #address-cells =3D <1>;
> >              #size-cells =3D <1>;
> >              calibration@13ff {
> >                  reg =3D <0x13ff 0x2>;
>
> this is out of range, core should just err out.
>

Cells are currently unchecked, I can fix that in a different patch.

> --srini
>
> >              };
> >          };
> >      };
> > };
> > If we try to read the cell "calibration" which crosses the boundary of
> > the reserved memory then it will lead to a short read.
> > Though, one might argue that the protection against such cell
> > definition should be there during fixed-layout parsing in core itself
> > but that is not there now and would not be a fix.
> >
> > What I am trying to fix here is not exactly short reads but how the
> > return value of rmem_read() is treated by the nvmem core, where it
> > treats a non-zero return from read as an error currently. Hence
> > returning the number of bytes read leads to false failures if we try
> > to read a cell.
> >
> >
> >>
> >>> +             dev_err(priv->dev, "Failed read memory (%d)\n", count);
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>
> >>> +     return 0;
> >>
> >> thanks,
> >> srini
> >>
> >>>    }
> >>>
> >>>    static int rmem_probe(struct platform_device *pdev)

Thanks
Joy

