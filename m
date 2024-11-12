Return-Path: <stable+bounces-92815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C1D9C5D8F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62146280F2B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE383206E96;
	Tue, 12 Nov 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lon7fYA+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9E206E7C;
	Tue, 12 Nov 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429616; cv=none; b=BtPfgldxniyMu9OIT7F33eD+Hu+MzV1tbeEEyUAW+rFSylr4001UNTJt2cFGBdCSx0JqYuBVD3JN19hlzDopDwAPA096DsGptmmbozkMn0J5VJgic95cELViM2l9g6z1FMPKzn5ctW+/i5ExkJhlrPK2SJsKMeyqr1umzqK0nGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429616; c=relaxed/simple;
	bh=Fh55GNuQXgg1VZmTeP/m2Sz2nCgxRcYWSJKNcpXwqXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETgukPyC2qRcshFqwx7nMQVmeqltD0NSkDdq6UNhCHDRTe9O01vvJbN608OaRGq0LkfrOdvT+89lZHRgMy+o4XjImFnqfQpYg5zV4m1Hk3CmYv3eyEyIMfsid3W3doAbHLx6Pdii/jd2ayEa+4quu62/yCkPcE6zzHPqwSgGEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lon7fYA+; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a9acafdb745so1161078766b.0;
        Tue, 12 Nov 2024 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731429613; x=1732034413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgKrLRaygLp4YdZFBSjvXM87TChPg+qgqQ9F292H2dc=;
        b=Lon7fYA+jmEqKSl36W9UaYGoddj+AZfCaWG3DUmJGOePb1PhFEvZn/5NxokZ76tPgO
         ZHqFU8naLt5Hnzo2NYKojxgY3TGXd6Kt7452hR09TVSxHL+JUvs6Zas8CVb769mUJnS8
         /a9CRbf2JfeTl4H2hT6aTcO8N1TxZM5CxYCjUL8bV4s8T11jgFinKBtKnpmR0GNd6pLH
         gGEyD10Gp/KqMXYf/i1go9y5RLFs2xXshugjlXvMiEDE5Y4y/sqrEupYYtdcTofBDJsU
         li1eW9KxvNRelyYJCXRdc+rb22kjiV4tPwt35UBJIVGEddNq6igKaQJECNGVyWofynB7
         lGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731429613; x=1732034413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgKrLRaygLp4YdZFBSjvXM87TChPg+qgqQ9F292H2dc=;
        b=dxQCQ9tTH1iG/yZHos6n+x0z1RAl/emoUVAlLhM1vevPfxi89v+271Vw4Taozi1aBZ
         +2MwuyocKNP3NfuRjZNNBpeKSkuQ0a6cFIb8ZXZyQNk5eXFyjKFfcMtr3aKfvJe5c0X7
         Ykc1rbA9nutX4NWV9MsFNFBqQR/b7hStCZ7abJrI/OZ96KJl2u29/QRw+bFYZAbGFfcp
         SG9HGUXUlpvkFqOW5XtgQoDEOB8hKVakN4n6gIncAMpmCN3373OcSw1axah1znwJLUHB
         qypfHPgEZAcjrgTirPXLuEdE1aRA5lWqVlZ6fpWZN0SKriaUF7Z9WmtM0+VLcYtYkcfV
         4ngA==
X-Forwarded-Encrypted: i=1; AJvYcCUKwCPZixC/4eq9PYM6GW/60oH1ckpuKK6D8D6dyiTNoxC2ezA9TS5+U4wgYhxBwr137HMoxAwgeHKxygU=@vger.kernel.org, AJvYcCWCZ2cdKM3kaKqZRRKtg7DIlUS+4RfVclAE2lvvHVZs2OvQVfDWWlx+82TY36PODhMfVXiojzF2@vger.kernel.org
X-Gm-Message-State: AOJu0YwKO5J7v/AsyD836hQh0A93lhD0JP/cMOgxZZVkdz+Er4q3fiqW
	g6V73KkBtowfs0CbKLe3b6eHpQHPEhGSimIJ91DqwGtqzJpaqWKKQmjiLeJ/sIIZbVNeLi3ceWk
	uKgJTojJAJp52RHCF0jtKCOKTJjA=
X-Google-Smtp-Source: AGHT+IFKZB3qF0WiDxSzlI536HsuldQu8qtceIZJbDqSweQSva1pTDBHk8mdPWoQK6X/F2O5PZo+t12Riep7SXfeBTM=
X-Received: by 2002:a17:907:86a0:b0:a9a:3c94:23c4 with SMTP id
 a640c23a62f3a-a9eeff98261mr1586182666b.22.1731429612822; Tue, 12 Nov 2024
 08:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018081539.1358921-1-chenqiuji666@gmail.com> <026951f9-05af-4ee4-85d2-30236292f7f8@arm.com>
In-Reply-To: <026951f9-05af-4ee4-85d2-30236292f7f8@arm.com>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Wed, 13 Nov 2024 00:40:01 +0800
Message-ID: <CANgpojVTqXc0OurTWS3b9A6naDtN7Js48r8gaoAp1QAoHvm0GA@mail.gmail.com>
Subject: Re: [PATCH] amba: Fix atomicity violation in amba_match()
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, sumit.garg@linaro.org, 
	gregkh@linuxfoundation.org, andi.shyti@kernel.org, krzk@kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We have addressed the concurrency issue in the match driver interface
at a higher level, as detailed in the
[https://lore.kernel.org/all/20241112163041.40083-1-chenqiuji666@gmail.com/=
].
Due to the widespread nature of the issue, it is more appropriate to
resolve it by adding a lock at the higher level.

If this patch is merged with the lock added at the lower level, it
could potentially lead to a deadlock issue. Therefore, I kindly ask
that you do not merge this patch. I sincerely apologize for the
inconvenience caused and thank you for your understanding.

Regards,
Qiu-ji Chen

On Fri, Oct 18, 2024 at 5:39=E2=80=AFPM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
>
> On 18/10/2024 09:15, Qiu-ji Chen wrote:
> > Atomicity violation occurs during consecutive reads of
> > pcdev->driver_override. Consider a scenario: after pvdev->driver_overri=
de
> > passes the if statement, due to possible concurrency,
> > pvdev->driver_override may change. This leads to pvdev->driver_override
> > passing the condition with an old value, but entering the
> > return !strcmp(pcdev->driver_override, drv->name); statement with a new
> > value. This causes the function to return an unexpected result.
> > Since pvdev->driver_override is a string that is modified byte by byte,
> > without considering atomicity, data races may cause a partially modifie=
d
> > pvdev->driver_override to enter both the condition and return statement=
s,
> > resulting in an error.
> >
> > To fix this, we suggest protecting all reads of pvdev->driver_override
> > with a lock, and storing the result of the strcmp() function in a new
> > variable retval. This ensures that pvdev->driver_override does not chan=
ge
> > during the entire operation, allowing the function to return the expect=
ed
> > result.
> >
> > This possible bug is found by an experimental static analysis tool
> > developed by our team. This tool analyzes the locking APIs
> > to extract function pairs that can be concurrently executed, and then
> > analyzes the instructions in the paired functions to identify possible
> > concurrency bugs including data races and atomicity violations.
> >
> > Fixes: 5150a8f07f6c ("amba: reorder functions")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> > ---
> >   drivers/amba/bus.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 34bc880ca20b..e310f4f83b27 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -209,6 +209,7 @@ static int amba_match(struct device *dev, const str=
uct device_driver *drv)
> >   {
> >       struct amba_device *pcdev =3D to_amba_device(dev);
> >       const struct amba_driver *pcdrv =3D to_amba_driver(drv);
> > +     int retval;
> >
> >       mutex_lock(&pcdev->periphid_lock);
> >       if (!pcdev->periphid) {
> > @@ -230,8 +231,14 @@ static int amba_match(struct device *dev, const st=
ruct device_driver *drv)
> >       mutex_unlock(&pcdev->periphid_lock);
> >
> >       /* When driver_override is set, only bind to the matching driver =
*/
> > -     if (pcdev->driver_override)
> > -             return !strcmp(pcdev->driver_override, drv->name);
> > +
> > +     device_lock(dev);
> > +     if (pcdev->driver_override) {
> > +             retval =3D !strcmp(pcdev->driver_override, drv->name);
> > +             device_unlock(dev);
> > +             return retval;
> > +     }
> > +     device_unlock(dev);
> >
> >       return amba_lookup(pcdrv->id_table, pcdev) !=3D NULL;
> >   }
>
>
> Looks correct to me
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
>

