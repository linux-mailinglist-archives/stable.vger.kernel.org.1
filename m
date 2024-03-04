Return-Path: <stable+bounces-25923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0F8702BD
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE87F28AD4B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349B33EA6F;
	Mon,  4 Mar 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/OZTe3P"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527F3E47F
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559004; cv=none; b=ErGedwJQvMOchGmNzwYoFrs7F211a0zMrZOL6Ry7lnGQWaQ1ADE6h6argHAI8TfxmsuBN+lvLDdlP7QtPfd3v+pniSt3leon1gaQke2yp9+40VYHdy2RxL8KigAjZ2R2SnCOZCpx9ECs8cMNB3cpySTHKULvXsN0qfJuJYL7zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559004; c=relaxed/simple;
	bh=Kvq+eQLmzuwBXg3/KAnR/i8Z5XbQ5PFh19ze8XW00cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbQCIYRDqAuA7JUFdSG3shz+1MOIl5HsqjpkRHtMcFYcbdk4wP0vKQ7uhceMu7Vk5kb48MZB9XJHott+EAVcjnnM1oG7YS5wF6tH6Tm7dzNJfx9vf3kk1AxMBdfN50FYI2Dwxcc1D8T/0HBPk4hf1cIWBeE12Qo52j6qARdtP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r/OZTe3P; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a0a19c9bb7so3608946eaf.3
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709559000; x=1710163800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e7MvSyz7Z89OuXpqB0EkQOVRxLJ+Jq5zuJtp0kF1KA=;
        b=r/OZTe3PfCJ2y/Yd5bp7Hgi8sUdok2nya2byx8oDkSUPC2M1aYIHxgwx6Ps7hKP03Y
         Y9hPF1yuJ7fcw+DMfnmpauvUROQ8XoH/55D8vDOAONsqayJK2P2H1B2oBI37cVQi+LMO
         VxkhtZxB6JcpOvBPTXJUUCSZ/tWPVpmPZ6IutO30ie4Ei0sCROrQg0GSm4sRrZ5RC74w
         Nf3vHkWlVTChjOFKfjxa91XQxLkQJ7QP52qJUNF3Ko+nUo5+BP06LIEIH2GeoaxRyEsd
         7o6+kPqaTwck8sRoJ4/ny2QJMpyHW29loqyZdTVcLIcSaWRtsXulDpMWhgM/ufEqj85K
         H3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559000; x=1710163800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e7MvSyz7Z89OuXpqB0EkQOVRxLJ+Jq5zuJtp0kF1KA=;
        b=b235t5yHrtcmtUx/lO82G1AC3NSQHxiqdhF7QbNy8WhlhcNmEuQRuX1Ztl8F6duWkJ
         yO7P+JW2/VWbOk1HHnyu+MM1P7UazXxa7R+YPAHzcyKDaYuCM5KUezOCuEwxCFMczkXr
         5sfsyGuncO4xreQqaBOKY/4yczqpmRYJDGRtT7PQ7KNRD7k/XvR5ewxFtBb1HJDdp5PS
         GMQHROJFFB1iZwc/Cz3qWFO6Nh+w1M2GNi+I5kafjj3SLmpklAbAQCWY9CTiGpCmw4ym
         WvuzEtvd+4Qu8VDjkNF2sEuYzydLOM/mGTvXr2d8ir4n0lH0ighwXXi0IZYvZ0WTfQXa
         4TMw==
X-Forwarded-Encrypted: i=1; AJvYcCVPZ6VUK8dHmhJWTNnYAtdmphYhCUv1KCRlRe7mDgdN7zIxFMTCQcJTB7ZV/LjZiaGc2yZEoROxusnEfK++AZ5ZI6rM2IvE
X-Gm-Message-State: AOJu0Ywd71CK9zuew1QwkGyJJKOYGw7Jv4+AZvVeVeDiq2qpYRubnDXn
	Gmj+PAR057ZEa62Q8obwyYKfQRfNN08vFHLd2IR6aanvkVWxJswDA6QrJZTJHr4neodwVhuNymY
	zw5kMxNIw+I492mVl9nuFoSMnVRzC8r51iSMEM8rsuuM+TAJD
X-Google-Smtp-Source: AGHT+IFWKof4pbS0vl916ObLdAYi8NdADtcGYWdAKnMOW9r3+pOIJUpi024cyHkbmZimO/UAKryy7xGAUnICBATSPAI=
X-Received: by 2002:a05:6820:1c8d:b0:5a1:27ad:9b9d with SMTP id
 ct13-20020a0568201c8d00b005a127ad9b9dmr4368315oob.1.1709559000241; Mon, 04
 Mar 2024 05:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301143731.3494455-1-sumit.garg@linaro.org> <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
In-Reply-To: <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Mar 2024 14:29:49 +0100
Message-ID: <CAHUa44HWiWNab1TbQxHVBZOpqbp+XhNGSNoL+pXrv7xJkHShxg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, op-tee@lists.trustedfirmware.org, 
	ilias.apalodimas@linaro.org, jerome.forissier@linaro.org, 
	linux-kernel@vger.kernel.org, mikko.rapeli@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 4, 2024 at 6:45=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> + Arnd
>
> On Fri, 1 Mar 2024 at 20:07, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > The error path while failing to register devices on the TEE bus has a
> > bug leading to kernel panic as follows:
> >
> > [   15.398930] Unable to handle kernel paging request at virtual addres=
s ffff07ed00626d7c
> > [   15.406913] Mem abort info:
> > [   15.409722]   ESR =3D 0x0000000096000005
> > [   15.413490]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [   15.418814]   SET =3D 0, FnV =3D 0
> > [   15.421878]   EA =3D 0, S1PTW =3D 0
> > [   15.425031]   FSC =3D 0x05: level 1 translation fault
> > [   15.429922] Data abort info:
> > [   15.432813]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > [   15.438310]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [   15.443372]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000d9=
e3e000
> > [   15.455413] [ffff07ed00626d7c] pgd=3D1800000bffdf9003, p4d=3D1800000=
bffdf9003, pud=3D0000000000000000
> > [   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> >
> > Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumerati=
on")
> > lead to the introduction of this bug. So fix it appropriately.
> >
> > Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218542
> > Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumerati=
on")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/optee/device.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
>
> Jens, Arnd,
>
> Is there any chance for this fix to make it into v6.8 release?

I'm picking up this and have also just sent it in a pull request for
v6.8. If it makes it into v6.8 remains to be seen.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index 9d2afac96acc..d296c70ddfdc 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -90,13 +90,14 @@ static int optee_register_device(const uuid_t *devi=
ce_uuid, u32 func)
> >         if (rc) {
> >                 pr_err("device registration failed, err: %d\n", rc);
> >                 put_device(&optee_device->dev);
> > +               return rc;
> >         }
> >
> >         if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
> >                 device_create_file(&optee_device->dev,
> >                                    &dev_attr_need_supplicant);
> >
> > -       return rc;
> > +       return 0;
> >  }
> >
> >  static int __optee_enumerate_devices(u32 func)
> > --
> > 2.34.1
> >

