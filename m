Return-Path: <stable+bounces-109226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC125A135E0
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 09:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2095D7A1704
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E612B1D63C8;
	Thu, 16 Jan 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A54Hvi80"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32135944;
	Thu, 16 Jan 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017544; cv=none; b=QlhfnH16sCOVdvbwNoomjAoLWQIiBWySokzSDZRsHUMGKWjAQ15Qm88TBKvQIr/N2V4FP392MVnbBHtik2muGEIpbUN4fbslHSILH0U5MzNIe9DHZWg+5VNi5FMxolPSF/0rGxiUMiYl3SghrRTPPUdw5HpJcadKnnVCI77qB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017544; c=relaxed/simple;
	bh=DuleUejWG0q+WtTiZMiTAG5HKVGnT69fUZwBSvGNOHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uye6TAIBCCBvBRbrGrKXTIDhmBJ99lnXVrvGHs+vd5/cMOA2woE8M3iYnU+CyQCuiLgZTlPtX0u0dDKHze+6SNdDlvXvxze69ezbGFGm5xVymhivQJ/I1xqi1P6/n1Af153g10eafQPEeSyGT0TuRMFENPq89Ay6iHDb6a4mRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A54Hvi80; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53f22fd6887so639963e87.2;
        Thu, 16 Jan 2025 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737017541; x=1737622341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAUtyQ+0uLQvtoh7VA3lKvtKY7elMPWjYH/V5sBZpQ4=;
        b=A54Hvi80RycY7lF/7sanIQl0sja+0vQuz/CwQkG61G4O2HUkb9CcIoCeOYCM+LW6vK
         kX8szEYWF2ULvZU9ZOLycb8hoBJX3JZiT1bn/oiiaM9dLO2OoMEGmshP++fRuyiSZ6Uh
         h2HT7wqB+zYLg26GIqmXkyh+Fd9EArpWqXCkpCbPTmBY1CWB8pBiVIewONrFXDy/Cmg1
         Ja6WIObcTLAR5Qzo+3poobAgCShQMpVzgWBqGzxj8oIb6KtiiXqRBrBUEpANCrarb8+r
         P+xVJm/cG0zppmJ91w2eWgC5J6NDAzmI4sBc2RGd0ckSEJGgJvN0luUPb6Lnr9fqtoNU
         Eg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737017541; x=1737622341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAUtyQ+0uLQvtoh7VA3lKvtKY7elMPWjYH/V5sBZpQ4=;
        b=HdP4nDbB/YhgMBx3TcxAQBeCIb+cCAsmN/dbCDu4KsT99O6YKo5nDgmvqlXyaLuOkp
         YYvPaZX0AyFtsZ034Q1PELbwU99sXUYeu0TqrzrXzWeGyIVd+MiaytStrUVwiEomxSYt
         huTJ6KdEn0gaG+hQOm5JMlnkSayMAVJl4IdKrOHEyIfkXBvQW7q6WoQkmn+2CsYmZzef
         vPQuOA+nYc2l2sGwAr/RMK6nKaN69HKeZrKVu/IDrb6y4zl5nL2oPIr8zfhusRFpH6d9
         rf+nI5/KdQEQ4vmvyLtIDkWvxem0rXYdsyTFT6twsc7ViiZtIX1ieIWhv9AznxekCZm1
         LE6g==
X-Forwarded-Encrypted: i=1; AJvYcCUvAj7Cuyo8DIhJujCrew9iaufctS4F8c41m+UrirqZFXX1aa8a2hJ7tbhenFLFgMUqED3T6V7G@vger.kernel.org, AJvYcCXnVhnlGl3vZd2FbXak6M06/ih6hYzQdtDIgXmXzmBF1ZQy4yCd0o5Y4hSzY9962co1S0BzH+MBpaoanR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyUozsc28Kv/muHXJjmC+SGnAubUvLfWLfRshqMhOu0mPWI3vK
	gLlrZNUAeyq2IO0dTL/rEH60b125vV5Tet7sT1c/cI/0XeIFcs56/Uv8dc4x1RjKRgWT7dLao2Q
	cXV3XZszGT6VSUn+sBHoa9tUMagE=
X-Gm-Gg: ASbGnctetkE6l26wfYn2roT+D1hfZefesvRVZsKzdQba0morJsSncEGP3zhN1WOQUP4
	j1aWLWxVxDDd+OURoIpJbLO2AmYaT85jfI6dthw==
X-Google-Smtp-Source: AGHT+IERCbAaD0M5Y9SM85jk5clNOfZT04do4722yH5mwwpZJo2wuqBSFTzAaWO0/vEKFrZEjdW9aDQ5LPy5SvtlMwA=
X-Received: by 2002:a05:6512:15a3:b0:542:2f5a:5f52 with SMTP id
 2adb3069b0e04-542845b9037mr9528748e87.13.1737017540615; Thu, 16 Jan 2025
 00:52:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214091327.4716-1-ubizjak@gmail.com> <25eb1e35-83b0-46f4-9a9c-138c89665e05@amd.com>
 <65a1d19e-e793-4371-a33d-e2374908d7f8@amd.com>
In-Reply-To: <65a1d19e-e793-4371-a33d-e2374908d7f8@amd.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 16 Jan 2025 09:52:09 +0100
X-Gm-Features: AbW1kvbmNHUA99Y_rC7F59MIS_A75PDQtUYNHaYZC64fWzu8F9D0ufvUl_rINoE
Message-ID: <CAFULd4YKGnOwumpUeW5Yyr-G+BmC=LUSVbFWg74GC9a628VN5w@mail.gmail.com>
Subject: Re: [PATCH v2] mailbox: zynqmp: Remove invalid __percpu annotation in zynqmp_ipi_probe()
To: tanmay.shah@amd.com
Cc: Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:47=E2=80=AFPM Tanmay Shah <tanmay.shah@amd.com> w=
rote:
>
> Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>

Is there anything else expected from me to move this patch forward?

Uros.

>
> On 12/16/24 1:16 AM, Michal Simek wrote:
> >
> >
> > On 12/14/24 10:12, Uros Bizjak wrote:
> >> struct zynqmp_ipi_pdata __percpu *pdata is not a per-cpu variable,
> >> so it should not be annotated with __percpu annotation.
> >>
> >> Remove invalid __percpu annotation to fix several
> >>
> >> zynqmp-ipi-mailbox.c:920:15: warning: incorrect type in assignment
> >> (different address spaces)
> >> zynqmp-ipi-mailbox.c:920:15:    expected struct zynqmp_ipi_pdata
> >> [noderef] __percpu *pdata
> >> zynqmp-ipi-mailbox.c:920:15:    got void *
> >> zynqmp-ipi-mailbox.c:927:56: warning: incorrect type in argument 3
> >> (different address spaces)
> >> zynqmp-ipi-mailbox.c:927:56:    expected unsigned int [usertype]
> >> *out_value
> >> zynqmp-ipi-mailbox.c:927:56:    got unsigned int [noderef] __percpu *
> >> ...
> >>
> >> and several
> >>
> >> drivers/mailbox/zynqmp-ipi-mailbox.c:924:9: warning: dereference of
> >> noderef expression
> >> ...
> >>
> >> sparse warnings.
> >>
> >> There were no changes in the resulting object file.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
> >> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> >> Cc: Michal Simek <michal.simek@amd.com>
> >> Cc: Tanmay Shah <tanmay.shah@amd.com>
> >> ---
> >> v2: - Fix typo in commit message
> >>      - Add Fixes and Cc: stable.
> >> ---
> >>   drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/
> >> zynqmp-ipi-mailbox.c
> >> index aa5249da59b2..0c143beaafda 100644
> >> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> >> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> >> @@ -905,7 +905,7 @@ static int zynqmp_ipi_probe(struct platform_device
> >> *pdev)
> >>   {
> >>       struct device *dev =3D &pdev->dev;
> >>       struct device_node *nc, *np =3D pdev->dev.of_node;
> >> -    struct zynqmp_ipi_pdata __percpu *pdata;
> >> +    struct zynqmp_ipi_pdata *pdata;
> >>       struct of_phandle_args out_irq;
> >>       struct zynqmp_ipi_mbox *mbox;
> >>       int num_mboxes, ret =3D -EINVAL;
> >
> > Tanmay: Please take a look
> >
> > I think this patch is correct. Pdata structure is allocated only once
> > not for every CPU and marking here is not correct. Information from
> > zynqmp_ipi_pdata are likely fixed and the same for every CPU. Only IRQ
> > handling is done per cpu basis but that's it.
> >
> > Reviewed-by: Michal Simek <michal.simek@amd.com>
> >
> > Thanks,
> > Michal
> >
>

