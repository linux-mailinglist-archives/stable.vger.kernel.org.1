Return-Path: <stable+bounces-18892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B417A84B284
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 11:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FDF1C209B8
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500BE4409;
	Tue,  6 Feb 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7qGRSAs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA941DDFC
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215479; cv=none; b=adn3otETIWybNWd2wQSI00RmtwhVlE/SzMBLTtZ8O5LtD3B8jrXg4EHBR72eoEcQ+eOC3pzAcmHUbUcqG5NaSAyUhJV2jTbvE3WWUCkdL+NE4o1JhPMOQg2b9ikvGIymXX0B+NcggVjXKuh7USRziGaMYMu/zb+r6cJhFc2e81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215479; c=relaxed/simple;
	bh=sLPxnJl6On4z7dGAfTxIzz69n4+dJ+EJJhrxmcXYPWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pfi1+JxCnLnt/S18D+VUTY+C0FNBxwVhQ6oiSeQtzDwplGtxtIHIg9a04Jmpt4BRKoCag3c0QJ71eexsde6qJePkXJzMTiDi/cTPlJTBnznBUf5ngHmcUuIm+713iYnKVd7WYASQ6lEQ9IoPXgIkvyeNqKtvAPDXfHlovB0CFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7qGRSAs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a381df83113so51868366b.3
        for <stable@vger.kernel.org>; Tue, 06 Feb 2024 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707215475; x=1707820275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyJeOO1MPwusvT1qEwWipYJ8Xhu38so/v3dEFLAabcU=;
        b=m7qGRSAsGprTwYCekIhFbM7L8RoUJqO2Xs+7Qnnln0EZUQIvhrM3OzYG5cmWmVdZNw
         YBA6oz2ERoOQEnV2kwp+A1v4K1C2d7Na9N20Dlb/RczNDta2wFDg+v20PbjEJPFzc83Y
         ERDjzmYRdVmoV7feSWzC4lrnbllOdl+Rc0PzdlOa+huEaiaLjOUoP3EZ9DBXSoKFGIJJ
         ozuO2hNXKV/1XGoUSi1+ty5J/UIRnT8Py8Y8VAOn6E7UKtavXkyYFuuyvsr32wyWvpD/
         gwkV4Y1dtIq94U/vJhrBYFQT920WlHKbBXO85xpV5QxWi0cVCteFyGZYNadGpLjVDHF9
         J8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215475; x=1707820275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyJeOO1MPwusvT1qEwWipYJ8Xhu38so/v3dEFLAabcU=;
        b=RuEqWmeJFFn8+H2lsdZyphAWrwGhidDSGQvg+hmS/CeHsKJj0syE6DPCx3e9MsfVST
         gELykxSFfFypzAmNgqH9G0tFJ8nqoC4b4dqpYia0IUnZc4GzTZYoyXSi1tP2Oba0X101
         V5NR6eVE7pVP3vgwErBBIopX/EzQlJUOYmysqq4sXoCBYT4yM6VpW9pYiZ6Icw09Hhcc
         VhWW4zi/E6nYQRTT5PQRCRR/p68ZmdRcIIjSGJ7e/Ao1sGlJNzJio8BrC295MW+tlqc4
         V8/Klb3oMUKWgM8lhJj1Qbopj+0AFoqAYn1fCgIzhsJ/ASrh2bAmQsv38QPtb6RK9UPf
         AZGA==
X-Gm-Message-State: AOJu0YxVLn8DQ9fjZYJpp5B43KZeOa95IGB+mYagRpSSQZorSBiOgOXN
	bkQsNhL7FiJZ0GaMyOnbGx1xA0FWx6x4HR0ognxZj05g2ZS7MM7HG0ngL3+bRwH3f5a6o3MGZ2S
	8DFAfw6xcwVxD477uL5wjuq0J7QMwwFUeImcE
X-Google-Smtp-Source: AGHT+IELkC+goHTay/L6aZIeLG35J/aSat3BU8Tyv4DxCEDvedGzdB0WQm8pepzYh11TepbFZVKEL4j6tCyUon48bvA=
X-Received: by 2002:a17:906:bc94:b0:a37:87e1:5929 with SMTP id
 lv20-20020a170906bc9400b00a3787e15929mr1592434ejb.54.1707215475447; Tue, 06
 Feb 2024 02:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206042408.224138-1-joychakr@google.com> <2024020647-submarine-lucid-ea7b@gregkh>
In-Reply-To: <2024020647-submarine-lucid-ea7b@gregkh>
From: Joy Chakraborty <joychakr@google.com>
Date: Tue, 6 Feb 2024 16:01:02 +0530
Message-ID: <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, linux-kernel@vger.kernel.org, manugautam@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 06, 2024 at 04:24:08AM +0000, Joy Chakraborty wrote:
> > reg_read() callback registered with nvmem core expects an integer error
> > as a return value but rmem_read() returns the number of bytes read, as =
a
> > result error checks in nvmem core fail even when they shouldn't.
> >
> > Return 0 on success where number of bytes read match the number of byte=
s
> > requested and a negative error -EINVAL on all other cases.
> >
> > Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nv=
mem")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > ---
> >  drivers/nvmem/rmem.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> > index 752d0bf4445e..a74dfa279ff4 100644
> > --- a/drivers/nvmem/rmem.c
> > +++ b/drivers/nvmem/rmem.c
> > @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int off=
set,
> >
> >       memunmap(addr);
> >
> > -     return count;
> > +     if (count !=3D bytes) {
> > +             dev_err(priv->dev, "Failed read memory (%d)\n", count);
> > +             return -EINVAL;
>
> Why is a "short read" somehow illegal here?  What internal changes need
> to be made now that this has changed?

In my opinion "short read" should be illegal for cases where if the
nvmem core is unable to read the required size of data to fill up a
nvmem cell then data returned might have truncated value.

No internal changes should be made since the registered reg_read() is
called from  __nvmem_reg_read() which eventually passes on the error
code to nvmem_reg_read() whose return code is already checked and
passed to nvmem consumers.
Currently rmem driver is incorrectly passing a positive value for success.

>
> And what will userspace do with this error message in the kernel log?

User space currently is not seeing this error for nvmem device/eeprom
reads due to the following code at nvmem/core.c in
bin_attr_nvmem_read():
"
    rc =3D nvmem_reg_read(nvmem, pos, buf, count);

    if (rc)
        return rc;

    return count;
"
since it expects to return the number of bytes.

Userspace will see a false error with nvmem cell reads from
nvmem_cell_attr_read() in current code, which should be fixed on
returning 0 for success.

> thanks,
>
> greg k-h

Thanks
Joy

