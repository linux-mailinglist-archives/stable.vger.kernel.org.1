Return-Path: <stable+bounces-50393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4EC906431
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E851F2463E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 06:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982B137774;
	Thu, 13 Jun 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXEuLiE/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F863137763
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260683; cv=none; b=FQEsqwD4fD51l0ytktHAU/pJ06+wloTq7Z4rmxg+iHocDSfAkxoqsq8+pnfbgIgf9l7F/zOMeEuo8sk5SCIzHX8mSGrJH5HrX2wCwXgD9H7f42LWGK1fppB33y5T9FMFdGYjbyINX44N9yOy7LLJ8IeaDXFZYLX+3NBqj/VK9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260683; c=relaxed/simple;
	bh=D4H9WEaybswir/ij5ZUvHUvZ3BrEX8LaPweXhA6txCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFIpw5vm16mcwMOnx71KVs4uPggZ8nNNqyCmiChtHurLwdxxEBaEYrk599HajvEW5B8HetvtLrtPHPPt/P3l5HQVnCVbEE9mgGh+uchM3ChmBwro/aAZzDF+DJH54/IHSwKcXQuCirA+1Ar3JUeMKghDb1jNYiPc79XOJ8OKuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AXEuLiE/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so548950a12.0
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718260680; x=1718865480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSxaLeoUF2GB1Ynl8GPq9r0Ie6ml6kc6+0f2KJsgPRI=;
        b=AXEuLiE/uoqR6/G8TRtZ7Fthaw3ew+CCyLh8U8snXL54+PPjXidFKllyGOk7zlkgZv
         Haxg+yCqc3teH9EoVzDJ4UO8uo0NqPtiml+p7ejaZwi4HfAXFWlCUwXIk38Ff/bbbQfe
         8Lvi91ngAvc941Ec8M2eHQGb0wQPivU7s1rT/uXMbXeGDoJk4QMiYWynOk5bsCUHedrK
         RSD2ANuTVd8505LC25cyLVVKv65xOKW9GFm+sQ5J8TNsSHV97HZOyziPVx8CqjDAMvg2
         zrbzDWCRuFDRaYKR47rbc20qvsC22ZAfdWsGEDYZHzyy1RVo3fTtOPcdjoH74/IsGHkq
         9LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718260680; x=1718865480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSxaLeoUF2GB1Ynl8GPq9r0Ie6ml6kc6+0f2KJsgPRI=;
        b=m7SYRDpKY47KdRdj6qbzKch6b0/aZj932APJCWiuA+Bmfi4HGJFVUvO/pYQRecKq5J
         NPcPfPxUg+7xDaG73jEcAixwwAgTSkkwckmV556MZZ9TCWsoEkVLY1BFnm7QKSl9wqm7
         cdLB0XMaRBBgBr+hZ8SYfzIlhdgdBPbBg1u6izEWH8S3trzjx/5SWKZUHDjCzbUPASXZ
         J3cOs0Sxn1qLlZPY6nbDvhgibV1t4kDPFMf+2IG0xEwcKWgnP0O80ym1yo1VrHaaop0S
         9Zk60JqiRf8YLsz6ZJ7rccvvHwxL0GFaPn+u2xaZh19W0OSNIggBwScuW8A+pNxQMtOF
         +Rug==
X-Forwarded-Encrypted: i=1; AJvYcCXphVkQyZDYl/BgEeBl+VTSWZcuOw6LNm1m+Jx+8p9iHmxFZD+Co3SYfnfhouJSpiXTEIPoxvpDhql0zOLNvW/PWlbfrHaN
X-Gm-Message-State: AOJu0YxkzkjHz91AJDRiahJ3ZYG4zdOzCyyL0veQYjhQf113iNV8/YnP
	mUnYEIwJr55G0fTyYntzDgdUgCmC4LDrYbJrtaQXmr7dxytBmV16gWYQ/Wi6JxhO7DosyVAtw1L
	3XBM5xAPjtHN+iIA9n5Zj5dTUDWhRR/cx1ZM/A0pV/jWd19BnPddi
X-Google-Smtp-Source: AGHT+IEqcKmqMMras1IdQ4mwQeBPhF+tSokCQR7CyHJU0B0QtGnxu+D8T/n28pxb8A+jM+mpThteZ/Rdl1GC9K4JyBE=
X-Received: by 2002:a17:907:e91:b0:a68:fb0c:b294 with SMTP id
 a640c23a62f3a-a6f47d622d0mr247392466b.77.1718260680210; Wed, 12 Jun 2024
 23:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612180554.1328409-1-joychakr@google.com> <f0dbf963-bfd9-4a0b-8284-d141999da184@moroto.mountain>
In-Reply-To: <f0dbf963-bfd9-4a0b-8284-d141999da184@moroto.mountain>
From: Joy Chakraborty <joychakr@google.com>
Date: Thu, 13 Jun 2024 12:07:46 +0530
Message-ID: <CAOSNQF1AiD5rcpJr=c8Dov=j-g4=xOZXViX+Xibu_kBA=2rzgA@mail.gmail.com>
Subject: Re: [PATCH] rtc: abx80x: Fix return value of nvmem callback on read
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sean Anderson <sean.anderson@seco.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:48=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Wed, Jun 12, 2024 at 06:05:54PM +0000, Joy Chakraborty wrote:
> > Read callbacks registered with nvmem core expect 0 to be returned on
> > success and a negative value to be returned on failure.
> >
> > abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
> > returns the number of bytes read on success as per its api description,
> > this return value is handled as an error and returned to nvmem even on
> > success.
> >
> > Fix to handle all possible values that would be returned by
> > i2c_smbus_read_i2c_block_data().
> >
> > Fixes: e90ff8ede777 ("rtc: abx80x: Add nvmem support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > ---
> >  drivers/rtc/rtc-abx80x.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > index fde2b8054c2e..0f5847d1ca2a 100644
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> > @@ -711,9 +711,16 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *p=
riv, unsigned int offset,
> >               else
> >                       ret =3D i2c_smbus_read_i2c_block_data(priv->clien=
t, reg,
> >                                                           len, val);
> > -             if (ret)
> > +             if (ret < 0)
> >                       return ret;
> >
> > +             if (!write) {
> > +                     if (ret)
> > +                             len =3D ret;
> > +                     else
> > +                             return -EIO;
> > +             }
>
> I guess this is the conservative approach.  Ie.  Don't break things
> which aren't already broken.  But I suspect the correct approach is to
> say:
>
>         if (ret !=3D len)
>                 return -EIO;
>
> Ah well.  Being conservative is good.  It probably doesn't ever happen
> in real life so it probably doesn't matter either way.
>
> I don't really like the if (write) follow by and if (!write)...  It
> would add more lines, but improve readability if we just duplicate the
> code a big:
>
>         if (write) {
>                 ret =3D write();
>                 if (ret)
>                         return ret;
>         } else {
>                 ret =3D read();
>                 if (ret <=3D 0)
>                         return ret ?: -EIO;
>                 len =3D ret;
>         }
>

Sure, I'll do this in a follow up patch.

Thanks
Joy
> regards,
> dan carpenter
>

