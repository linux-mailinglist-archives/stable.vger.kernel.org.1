Return-Path: <stable+bounces-96699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D069E2121
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C0168F55
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CA1F706C;
	Tue,  3 Dec 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qcgRW6FX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433851F7547
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238335; cv=none; b=qLlbUECZTYacZV+gxn1hdes/IBMLRn+Tgl33Xo2bVBCY/4tBr9Sq7/VMmYooJ7GksHUBdH9Q+6vj1bAwoADLVsOxb3aDFXlj2B/ZRW8+QaqNx5dqaYzHmZr6uaEC5GKN4pRnJOYuYlSqUYVv7B9M+LIMk/DfQXK3UMrqWZy43bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238335; c=relaxed/simple;
	bh=+uMifMZiAcMA3nATNagPBAOmW0eThPHsSBWPDm8brnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTNvvw3XD1SQfM1JIKeW+rqWbHzl+CmZE2sbTm+ZIkHiGyh0hKGrSMEiFZEXjJsPwP0dLE+Q5fZWVBxI/VkwU52eaW01cWTNPA4mbNXJjTDbSPCkLloA3tpwmG74+vtECk3rxJ/l7mG2KiMEQGguhEVnv4pgtzHelGKQtUHiuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qcgRW6FX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so58016731fa.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 07:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733238331; x=1733843131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtbEhhKoiTh0qiQnRaAPey6dwf1k7ZRMkRrGbgxGB18=;
        b=qcgRW6FXOmVZqr/7ItfiiT4o+GpW9CiMQGqeLHaYy5YYDiPs3QPRDA70zm1++WBCA6
         3n9M9QdGjwcDsvL76n9/3+Atcz4d8pOltWtz5KD1tS37jJBAnnPAn/y7lPePup+TUgj8
         zF8X7lIVE6tjEsyRbn5vLvq993MELPmScUvGpwcLtmjE96jrOnDF9heHTg26BBGxmVEu
         buyF1DiadpMX7BnYI208GatUBSzHWTDR1Ser8GUrhDrm5sVeRxBTYpiKcJuAh+BmeUWB
         yWl8dVGbpipppX/1YBo1Geluupu86ofHQiJI0z0sbDYPZidH9CUAc39HGh84BgClzFsP
         8gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238331; x=1733843131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtbEhhKoiTh0qiQnRaAPey6dwf1k7ZRMkRrGbgxGB18=;
        b=n/Y54VrQGqzHzAhuPv22sDmcxRt5CzPAhkRChxZ8wQnz2VeW8rx/aNGq1gVZyZ8G9H
         Hjs7NziqaZ96mj2E7LGqzhVQ9cFDjZgrffAPsq+22ghCB1zEXMQQRrybCP3jkaYvJPAk
         DJyduROVGJnFKMomxXyiH5ii7UnTqGcRsl942Tc7gdVeWy7mhWqzubfflUC4N93mPLvH
         b6xNpw61jNyHviQJ9eHwF3YL97v2632mCo2d4TggrlKOsQzkx6Oe31jdK4dGMhxdTwvD
         qrVmDtrYL5kVY1Rz1WIqyDENMTV4KU5cNKdF2V7DXR48C84XWne/z/mtGJEnKDbjpMZa
         VYig==
X-Forwarded-Encrypted: i=1; AJvYcCXYWy07Dojol4FTQMUZJ4bSsp44Sl0S8cho63Kul2yIJW5br1RhU7MVeAzaQyfatT05y7Si0yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVr5t9TlTVTzLzXlhKvZ8C8dcjZ16z2A5R1fZYxGI67G2Aoycw
	6hziEDG+OPW1UeOrt4pqV/1FaxEei36BQf1AkPm1nlkHlhqVU6c4Ro+LIjImRgAlGke694O/wG4
	1tpSZeeoBs4bUdhbKp5+NVdTFNKYpjubhYFYGpw==
X-Gm-Gg: ASbGnctZbzM8PLy7bHHosS7StoBtR9IBEKpt4jzAgpXHgf5AuyRgzzGPRAmfjA37kwn
	O3+cA5CYLHbIoXLdCd+SSjVreXiA+v2I=
X-Google-Smtp-Source: AGHT+IFXcMRum6Fgpn/fpkHjlbTye37au8KaG1skCplnVjgk7auCVG9uYkhWXukENlDICE2p3O83N7kw41MOt8qO7js=
X-Received: by 2002:a05:6512:2804:b0:53e:1b6a:60f5 with SMTP id
 2adb3069b0e04-53e1b6a61d3mr623994e87.29.1733238329662; Tue, 03 Dec 2024
 07:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-2-c5901d2dd45c@linaro.org> <b3e5184d-19bc-45ed-92e3-a751842839b3@linaro.org>
In-Reply-To: <b3e5184d-19bc-45ed-92e3-a751842839b3@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Dec 2024 16:05:18 +0100
Message-ID: <CAMRc=Mc+hKeAwyvm_aaWe_r07iXuBMy0hRQrXSQjpy0irKzvMw@mail.gmail.com>
Subject: Re: [PATCH 2/9] crypto: qce - unregister previously registered algos
 in error path
To: neil.armstrong@linaro.org
Cc: Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stanimir Varbanov <svarbanov@mm-sol.com>, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:55=E2=80=AFPM <neil.armstrong@linaro.org> wrote:
>
> On 03/12/2024 10:19, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > If we encounter an error when registering alorithms with the crypto
> > framework, we just bail out and don't unregister the ones we
> > successfully registered in prior iterations of the loop.
> >
> > Add code that goes back over the algos and unregisters them before
> > returning an error from qce_register_algs().
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >   drivers/crypto/qce/core.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> > index 58ea93220f015..848e5e802b92b 100644
> > --- a/drivers/crypto/qce/core.c
> > +++ b/drivers/crypto/qce/core.c
> > @@ -51,16 +51,19 @@ static void qce_unregister_algs(struct qce_device *=
qce)
> >   static int qce_register_algs(struct qce_device *qce)
> >   {
> >       const struct qce_algo_ops *ops;
> > -     int i, ret =3D -ENODEV;
> > +     int i, j, ret =3D -ENODEV;
> >
> >       for (i =3D 0; i < ARRAY_SIZE(qce_ops); i++) {
> >               ops =3D qce_ops[i];
> >               ret =3D ops->register_algs(qce);
> > -             if (ret)
> > -                     break;
> > +             if (ret) {
> > +                     for (j =3D i - 1; j >=3D 0; j--)
> > +                             ops->unregister_algs(qce);
> > +                     return ret;
> > +             }
> >       }
> >
> > -     return ret;
> > +     return 0;
> >   }
> >
> >   static int qce_handle_request(struct crypto_async_request *async_req)
> >
>
> Perhaps you can also use the devm trick here aswell ?
>

I wanted to keep this one brief for backporting but I also think that
scheduling a separate action here for every algo would be a bit
overkill. This is quite concise so I'd keep it this way.

Bart

