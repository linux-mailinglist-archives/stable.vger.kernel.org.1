Return-Path: <stable+bounces-87583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D800A9A6DFF
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1264D1C21434
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFF12DD90;
	Mon, 21 Oct 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="WrFeqS+Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EE126C1D
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524108; cv=none; b=elvlaYxQROIsy97qu3FW7DlS8Qz/Fk5oIPIOBJuz88PMJ7AAON7m2U+tYhKByBeDEqCBq1qnJ+ni/+oyVQu9X5B2JfG+ZsnrtP7MjkOVN0eAgGSJvZGaAYuintaEYQOr7VfICUzqHR2g0Zl6XGq4O5wJQxvdt9rbbR87vTUrlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524108; c=relaxed/simple;
	bh=PWJXLI/zc9+YfPp0JQp12zzhzEBvi/Lb9IqoZrMgbPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8nS230ZNgwBhywXp54V0tzDF2Qwlmo7L+QWHberqGUBr0BD64l+RVRGwWRjkx9npOFbcvGQwf3Un9Sjcs5qLBiVzDSz7sO/QiCGukul4lLsFcL4cZWoMMyTXukRPW4Sp3olahHule9HmpoBqYzWHmE7G8/Mb/Z8QMq9pXeRSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=WrFeqS+Y; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53a0c160b94so2798753e87.2
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1729524104; x=1730128904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LJXhrYQrk3gwAFgilc+sphvRBz6z5yynh7/PAYChQI=;
        b=WrFeqS+Ysiuhw7Eo/UpXWMqXdXbx/SsjTo0ysaERqcoXnajWcqZGzKA3Z/hH8Fswfe
         5vje7pCj4mj8Mv++qf9y499PRavdJwrXDVP5V5GeWNMykN6c2jYViMIvKH9IfWd9nccL
         eNhmmoGDxHfQqwMcRBHlyWZCKRjyUFuNSQKKzNtXpqnj3RKDNIwWVfdfQbIy8Tg9ebgl
         bymHK1HfcGKPBrpzgqyYkQ5+BXZQNQ1kAWAYOMEWBGUc0IRYcgtdJ0qh40SRZ8Z3EBmi
         EvBeULylkA7d5baT2RGQvFQqXzAOe2OxC8tIVNdH4eQI9ueDTLmh+FE6X1YSnjFIEaSy
         UpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524104; x=1730128904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LJXhrYQrk3gwAFgilc+sphvRBz6z5yynh7/PAYChQI=;
        b=h6qaW0wfIV5XK34X7hZ63JcZS8Dy7+V9IlJmqKIoRjKME+pOG8WFdybWy9m6MNkFRT
         LcmlGTZDK5T0m4Zy1kAjPBT9rjLgseWp3BikeGEqjO6gN9LGN7i3PT/Tp5JH1EtjSOrw
         z329RO8zg49pcAHMwTK/GeLC90ncU+oyOaDEugwx3yoHNJ/yoGjhT7nSbrtlljJhf1d3
         BuPDpwJXlNKvhqeDXuTMz3jjeBwNfBHvUB0XdE0CFSKq3CbNa1mt4KRVNW293hzgkAtL
         D4xdyC2o5AsoZp9FBCHoltMu8mzCamrTMwqfoI0h5TdfQZl0unIeJ7NU4Zdubcwdqsnw
         f3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4O7Cl5cFAtA6DdAQxVMD+lWzgDMvV6LbtVuazKv7cLpKuv+ZGz/Oba/UHfgCm2INLeFwSm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEVDtxvgd8WBz9Elk0di65BO2uMPt+cprxZSRymRF20fbq4Gc
	w/1Z5rNMlxOpUvW8TFVu70weM5liqoJkF0rmnGQtkjDmPqMSx3MKfeEkLWDMCBj2xOCKG70udO3
	FRXwbI2h8epHTxb8stBaEpv+cvpBsQ4UPQfk4
X-Google-Smtp-Source: AGHT+IFXYdf/1S8sUivCEKQLffjqH0HbVL7pn9283MDgZzq8osSfS/mtwn0YAPg2ee14WNWmqyFbTcTg/tuCM+FRyAI=
X-Received: by 2002:a05:6512:31c1:b0:535:6cde:5c4d with SMTP id
 2adb3069b0e04-53a1520bfaemr7096304e87.3.1729524103994; Mon, 21 Oct 2024
 08:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com> <20241021-tidss-irq-fix-v1-1-82ddaec94e4a@ideasonboard.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-1-82ddaec94e4a@ideasonboard.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Mon, 21 Oct 2024 11:21:32 -0400
Message-ID: <CADL8D3ZcvynQCGLCcbK=U9-2WB758abLcKaNkTtXN8Y7s=dyqQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/tidss: Fix issue in irq handling causing
 irq-flood issue
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Bin Liu <b-liu@ti.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:08=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
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
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Co-developed-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Co-developed-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

I assume a reviewed by doesn't make sense since I co-developed this
patch but adding my tested by, hopefully, that makes sense.

Tested an equivalent patch for several weeks.
Tested-by: Jonathan Cormier <jcormier@criticallink.com>
>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 1ad711f8d2a8..f81111067578 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -780,24 +780,20 @@ static
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
> --
> 2.43.0
>

