Return-Path: <stable+bounces-107934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC4A04FCD
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 02:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3BE16497E
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C71139D1B;
	Wed,  8 Jan 2025 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VchXqWrO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D753365;
	Wed,  8 Jan 2025 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300519; cv=none; b=GYd8BMugJLIzBsUGelLLyE3Oyv6iARE82LE0/qTOcAsILLVOWdbhnFyeDK0CagdR59Aw6/QRZcae8hbmZ6HR1uBRDuSfAohNpRdqUDhyTPhyqAZ2v+703IPibPAgciOiJPD2gRykWhOcpAv8JnhmCT94vf3A4bQKh3E9yWb0xgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300519; c=relaxed/simple;
	bh=1OpTkAOkRYsdx+nLmJ6j2Gq9MX6VTPli1Ubl0N6KjW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdeYORXtUSsy2GqfvvN/Mk+RiTA8czKAkMgez4lm8E9TQCvwXDxylbJTGxzuzx0Sgmn9DdOp034fCRdbm4OmfCFX/Bi4z0iNvUvrstao3fIPcnNkCEglu/1mlA0rhUaYTI/wowIcWnRwJkyfSrA3rKV1vH5X3+LH0v7duaOtL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VchXqWrO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso10147985a12.0;
        Tue, 07 Jan 2025 17:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736300516; x=1736905316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtIeciZ/g1iJSCmu3k+uHr/ABbWTdxp3oCaqd/WgCmU=;
        b=VchXqWrO6q+be99IC+K3og2k0Xg+S7H8wphBdu6s+s1HTXK3yXj8sF3ie/3ACWOO5s
         WXY9LzS/bk0r+X+holxFEt4vTWEpOhTOn1N03b2RGsQ8OpRLYPUOcyPXdet1kYxp0vx+
         g2lV9rBP2c5W8Ji4Uf4C24L4oukBlvZ+17BDiK2IaCfjV3N4OmCe/qo1oJf+5pZP7ebT
         4Bcs4EU1613iYEZx4nER959ELaHpmScUTuBdgLaHcE0z5uWGYlCszPp4ZbfpWhDUPtGb
         Jfg4EUWmIQOUiJKDr1T0x2L72ulzvboTpFt+yQIIUK/wZ/jNLlhcpBAvvhYRdc2OZT6k
         78ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736300516; x=1736905316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtIeciZ/g1iJSCmu3k+uHr/ABbWTdxp3oCaqd/WgCmU=;
        b=gaBa895ZJEC/EJPHfmiiqIPfkNY6+CZ1amEP9KKzf/5YwyEIL2854pggLU5TJj+vWa
         51GIkRo39UmPVl4KHujV5ywSjwyH4kS+mvTKv51ViSGSZQYht/uqttpDyxMjj2kK5c1f
         S0iITM6q+a2Gi7x8BJKbyA9OtY+UIjSomniT8FjS4JDRVfEGQIMX4wD89qC31+tDh0cg
         DnC9KDmIuvOyxKT9QSwbTVhQgwNDJgCvcaHOjXcjlY1+hMmLRT549olsRk+EYeMonBQG
         JRHjT4HVXrKIpHpk1/4cFpRedd6O06R4taRPC9DOhevMwL2cCgkTLnZ7QDfBSLFjKiRb
         M8BA==
X-Forwarded-Encrypted: i=1; AJvYcCU//vfn0gHS0BtshX1sfKGhieWu8Zx0ot0OqKF2qU+57KUrffbRu0zZL4egutX1SbzD+88jz7DB@vger.kernel.org, AJvYcCUgqIWC1rqokBewXba/Equlex6bf26O0Pg0jsFiArqdm15xkdZ8kdvT+xVHaVV3K/C4Xj/8xKdsqCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2IjCMcD5ZbUZrB+u2VmKb4JI3vt//f4ODto5TTwp9RAf0DNGN
	gZcY5VGXUBHtSQvXBqdsu40zhc/2M+QjOyvcQ525HDuAwvTCIPZHmCfHANd2Qr5iEclVcc9uEDM
	vEjMTfO94xWIZlPk1G/EYmnqupNs=
X-Gm-Gg: ASbGncv+/VE2Odi+ix8uZDARlApQ1oVLujL28MXbScp7VBwNQYfcA96Bi+PbxLVmBPh
	YPIhQ0J50Tmy9xKWD4BJxY4k2OJkiG28sxmBBsoR4
X-Google-Smtp-Source: AGHT+IEXnftuts1x526l0SGl0TATOqcH25L9RRGplwVNSFmdu0lanacpZyXiDSJEvFIwUT2xqLUCMNMQL0z0fKBwzbA=
X-Received: by 2002:a05:6402:5255:b0:5d9:b8b:e347 with SMTP id
 4fb4d7f45d1cf-5d972e722e6mr767433a12.32.1736300515342; Tue, 07 Jan 2025
 17:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241225060600.3094154-1-zhoubinbin@loongson.cn> <526d7ad1f0b299145ab676900f81ba1a.sboyd@kernel.org>
In-Reply-To: <526d7ad1f0b299145ab676900f81ba1a.sboyd@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 8 Jan 2025 09:41:43 +0800
X-Gm-Features: AbW1kvbB4pWoEyqoFJ8m-ieCyzuHVNQ6r5mSvClgvDTKpIFxRzU6O4GgjR77pm8
Message-ID: <CAMpQs4+i11DVGhdinMrE41HkC8hhD11P0BLeOaK5yW8QXUMX-Q@mail.gmail.com>
Subject: Re: [PATCH] clk: clk-loongson2: Fix the number count of clk provider
To: Stephen Boyd <sboyd@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Michael Turquette <mturquette@baylibre.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, linux-clk@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen:

Thanks for your review.

On Wed, Jan 8, 2025 at 5:25=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> Quoting Binbin Zhou (2024-12-24 22:05:59)
> > Since commit 02fb4f008433 ("clk: clk-loongson2: Fix potential buffer
> > overflow in flexible-array member access"), the clk provider register i=
s
> > failed.
> >
> > The count of `clks_num` is shown below:
> >
> >         for (p =3D data; p->name; p++)
> >                 clks_num++;
> >
> > In fact, `clks_num` represents the number of SoC clocks and should be
> > expressed as the maximum value of the clock binding id in use (p->id + =
1).
> >
> > Now we fix it to avoid the following error when trying to register a cl=
k
> > provider:
> >
> > [ 13.409595] of_clk_hw_onecell_get: invalid index 17
> >
> > Fixes: 02fb4f008433 ("clk: clk-loongson2: Fix potential buffer overflow=
 in flexible-array member access")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
>
> It's common practice to Cc the author of a patch in Fixes. Please do it
> next time.

Oh, sorry it's my fault, I will do it next time.
>
> >  drivers/clk/clk-loongson2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> > index 6bf51d5a49a1..b1b2038acd0b 100644
> > --- a/drivers/clk/clk-loongson2.c
> > +++ b/drivers/clk/clk-loongson2.c
> > @@ -294,7 +294,7 @@ static int loongson2_clk_probe(struct platform_devi=
ce *pdev)
> >                 return -EINVAL;
> >
> >         for (p =3D data; p->name; p++)
> > -               clks_num++;
> > +               clks_num =3D max(clks_num, p->id + 1);
>
> NULL is a valid clk. Either fill the onecell data with -ENOENT error
> pointers, or stop using it and implement a custom version of
> of_clk_hw_onecell_get() that doesn't allow invalid clks to be requested
> from this provider.

Emm...
Just in case, how about setting all items to ERR_PTR(-ENOENT) before
assigning them.
This is shown below:

               while (--clk_num >=3D 0)
                         clp->clk_data.hws[clk_num] =3D ERR_PTR(-ENOENT);
>
> >
> >         clp =3D devm_kzalloc(dev, struct_size(clp, clk_data.hws, clks_n=
um),
> >                            GFP_KERNEL);



--=20
Thanks.
Binbin

