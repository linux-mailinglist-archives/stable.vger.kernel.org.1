Return-Path: <stable+bounces-118313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBEA3C630
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 18:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D1F1899CBC
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090F213E9E;
	Wed, 19 Feb 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="W1oH3LSn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822101FDE09
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986067; cv=none; b=j78krMhTEucIHur09JmgnCC6EJRb3V1HELsphFaXLncKC5GAUsJfAZ7EMgFhF6mnySG72IjA4a/As+qTBYVN9Y8rWqO0ErW52Zo2mdyRBlcI+Q+mXMUd1HlSTrOAQwpXW6afBo6KeB+RY2zoxYeHR3lSQkh7C3CqBRHs0r1uprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986067; c=relaxed/simple;
	bh=F7/KNztpiz9Tz7FrAFHcJZgfmbJ30wYqJ2aY4YVpE8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD5ciqthLDZ98bg+QkSNPTibDctqIHIh6aTQj3kyS//FJ11FmTOP0ILIbkunHyJb8cX1/6g9e7KZaNAYlTwApSj5tJiyJ1p0JfsWHWuevBdsb0TjoJYyjQFal/s/5eFpCj0K3E3RGnLWGQjVAZKn0JYLqvYnlvzZzNB7quJbODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=W1oH3LSn; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30a303a656aso182701fa.0
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1739986063; x=1740590863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN7htDFfdWYBEBovB41RfScVEwCh90leE1Ry19y0hzg=;
        b=W1oH3LSnnTKvQwx475wifdcrrFuNkYXW08QY8sUcYYfVji9sQWzOnOHcZQaGgNF7UH
         f3jl5bxGMcj8aeldlMUb6ceH0GfBcAPRQTIeDvM8XFBrpkTWss21LRRdtpfyam9DTA8W
         qXzaYYIjkD2whWlGM6mRhm2JRqtTNXi2oyOD9mT5E6+Y7Bb/T/wl8fhx2PlDSm/OCX3Q
         zXUxJVbUvN0IjrscguHgiz3rp44XOoEy9f7vgHXTqga1VnrpHe+nslpZ2N2nN1/UZAXt
         FRvkheco8l/4L1oq6InqGL4FWEgQaBXeCBl39PWiTfoOE8lMyfrxYIj3VdaAOS4VOII4
         ZTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986063; x=1740590863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN7htDFfdWYBEBovB41RfScVEwCh90leE1Ry19y0hzg=;
        b=f7/XovcNtxAlxgqkAGP7xrlE6Uebw2cs/LleOE9mIgNMxbd0d43AlJI8FktPdSfckh
         gCg6aLCo0CAZ5i1Qfr2Ehr2eGtso/LHI53RaerAPiAQHlyfnK6Nz/uli0B4iesWkf9eh
         JobeCD//yFvcGsiimEa+YMHITPJ+NlmOI+mNLGPuNPfX1IeVXPVDEa4I6s0wz5qT+4FD
         E9nrgL9gC+gdX1ZN7vPOQYH9laRLEuBmDrlgKMYL3wvJ8aaasJt9tb+Nh+8j3sYSt89l
         MVu7pVN9MUywzmn6+IvNuppQJTVeDZThaTht9Itg6H9Zd10fUza9ulh5Gv0U8XljYQzA
         qerg==
X-Gm-Message-State: AOJu0YysyDrlpa/qSpy6wDJ4QxQpg3xmvyAFc5nOaspjo6L+lx0hlALg
	j0fOgdoTMyUIygvIQro+lLMPERZOkzLsbLtG5Kg3UY6Mx0ySLlfctn8NfK9XYqcAbtOfheMXKwJ
	wRLsDMnfaCmDICpgN5EgIVb0TZUFt1luUqVNE
X-Gm-Gg: ASbGncvo1IBt+/34D1E2mQa342CVq/HYdAgbyX0NQF3NU733/VVhWEuXPoMXm/J0Q0f
	Z7/FTaZCzkxQk0P7l29KLwKsMasnztjMrLnSO39jn/5NQls30I73YDtAo+5p4uU9KuSEln7g=
X-Google-Smtp-Source: AGHT+IG1mbpg1DUJZPHFFLGCFOHgr+0I1tYczB2jZkUcybESu9VB0EQyeQ6O2FbwMenyBXndXIi7ei09FKVuelV3+hE=
X-Received: by 2002:a05:6512:308f:b0:546:3052:41f3 with SMTP id
 2adb3069b0e04-546305242f4mr1849695e87.3.1739986063447; Wed, 19 Feb 2025
 09:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082652.891560343@linuxfoundation.org> <20250219082714.827798335@linuxfoundation.org>
In-Reply-To: <20250219082714.827798335@linuxfoundation.org>
From: Jon Cormier <jcormier@criticallink.com>
Date: Wed, 19 Feb 2025 12:27:31 -0500
X-Gm-Features: AWEUYZnAcpsPmpoLeipbzFcfh4YnbuLCBX35WtDaimque7oJeRUKfINrBSQ0cGo
Message-ID: <CADL8D3Y-xe8hO30mV4obU68rK1G2FeOr_nS6VsmP349HJWMphA@mail.gmail.com>
Subject: Re: [PATCH 6.1 556/578] drm/tidss: Fix issue in irq handling causing
 irq-flood issue
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Bin Liu <b-liu@ti.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.

Looks good to me
>
>
> ------------------
>
> From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>
> commit 44b6730ab53ef04944fbaf6da0e77397531517b7 upstream.
>
> It has been observed that sometimes DSS will trigger an interrupt and
> the top level interrupt (DISPC_IRQSTATUS) is not zero, but the VP and
> VID level interrupt-statuses are zero.
>
> As the top level irqstatus is supposed to tell whether we have VP/VID
> interrupts, the thinking of the driver authors was that this particular
> case could never happen. Thus the driver only clears the DISPC_IRQSTATUS
> bits which has corresponding interrupts in VP/VID status. So when this
> issue happens, the driver will not clear DISPC_IRQSTATUS, and we get an
> interrupt flood.
>
> It is unclear why the issue happens. It could be a race issue in the
> driver, but no such race has been found. It could also be an issue with
> the HW. However a similar case can be easily triggered by manually
> writing to DISPC_IRQSTATUS_RAW. This will forcibly set a bit in the
> DISPC_IRQSTATUS and trigger an interrupt, and as the driver never clears
> the bit, we get an interrupt flood.
>
> To fix the issue, always clear DISPC_IRQSTATUS. The concern with this
> solution is that if the top level irqstatus is the one that triggers the
> interrupt, always clearing DISPC_IRQSTATUS might leave some interrupts
> unhandled if VP/VID interrupt statuses have bits set. However, testing
> shows that if any of the irqstatuses is set (i.e. even if
> DISPC_IRQSTATUS =3D=3D 0, but a VID irqstatus has a bit set), we will get=
 an
> interrupt.
>
> Co-developed-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Co-developed-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")
> Cc: stable@vger.kernel.org
> Tested-by: Jonathan Cormier <jcormier@criticallink.com>
> Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20241021-tidss-irq-fi=
x-v1-1-82ddaec94e4a@ideasonboard.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -679,24 +679,20 @@ static
>  void dispc_k3_clear_irqstatus(struct dispc_device *dispc, dispc_irq_t cl=
earmask)
>  {
>         unsigned int i;
> -       u32 top_clear =3D 0;
>
>         for (i =3D 0; i < dispc->feat->num_vps; ++i) {
> -               if (clearmask & DSS_IRQ_VP_MASK(i)) {
> +               if (clearmask & DSS_IRQ_VP_MASK(i))
>                         dispc_k3_vp_write_irqstatus(dispc, i, clearmask);
> -                       top_clear |=3D BIT(i);
> -               }
>         }
>         for (i =3D 0; i < dispc->feat->num_planes; ++i) {
> -               if (clearmask & DSS_IRQ_PLANE_MASK(i)) {
> +               if (clearmask & DSS_IRQ_PLANE_MASK(i))
>                         dispc_k3_vid_write_irqstatus(dispc, i, clearmask)=
;
> -                       top_clear |=3D BIT(4 + i);
> -               }
>         }
>         if (dispc->feat->subrev =3D=3D DISPC_K2G)
>                 return;
>
> -       dispc_write(dispc, DISPC_IRQSTATUS, top_clear);
> +       /* always clear the top level irqstatus */
> +       dispc_write(dispc, DISPC_IRQSTATUS, dispc_read(dispc, DISPC_IRQST=
ATUS));
>
>         /* Flush posted writes */
>         dispc_read(dispc, DISPC_IRQSTATUS);
>
>


--=20
Jonathan Cormier
Senior Software Engineer

Voice:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

