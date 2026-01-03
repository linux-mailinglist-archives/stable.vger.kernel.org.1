Return-Path: <stable+bounces-204528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 271DFCEFBC7
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 07:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02FF3300949A
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 06:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9F27467F;
	Sat,  3 Jan 2026 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUO1JMnh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D5270EDF
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767421600; cv=none; b=p4vWn8RY+6bKwzk6JKHi9iaGFV549wrj5io/cQ28go2xMAsRbSKqQdajQ0W2ViTkQ6rFWxuVZpUQ+Vfisvfbal+FpthrO9J7Ig99iWRyZ22zCVtiD2t/p0F2+oc3HZ4ptQz4wDcOIvwN6VCVHjStwl7b5O7RGa1NI+9BfZYC/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767421600; c=relaxed/simple;
	bh=QD4XyFbtYqO8OoXqrboWLQysmvPoH2D2aMqalSm0Juk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJNGuftn8y4mUtbKuCAd3uItASUusOn/NCnmszrJ+qLIGg0nhXbK9mKGaSNhMo7cCugHGW9Ikqef9lJl8ThEmSbiv1MEZTg96BRJP/AAQGRSji2ilxaNEkxlvtfvXXoZX4RFoFhIPECTylUo5ffMn/gDRx4MaCA5ZdRlKWmA0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUO1JMnh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2d56eaaceso1518491885a.0
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 22:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767421598; x=1768026398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzTUqaBjKErhA8u/T2FQL1WG9Tm1uXsr+21laEF71/k=;
        b=RUO1JMnhEkU+cacR3qm2FjPkQjabxqwdMmGJJxGRUxv/R7Tds/eQULoeQ66duDNPLQ
         U6mGlWXcN5ntzThXt6gWAUtEgkkq5IBJNoIa1TfPLZk82a0XXG5xq1F6qRzeowCwqHxN
         B4YsilH9wGFYJAHDzx67Mkn3ZPbVKSfI5PbRq5WqtVDC6XWl6Nr2rc9TmFYrMoLMxsME
         ZCrhWpwx0k6X81pJxHSIc4Hzml4L3ofW8D/uBhELD6RTdnFD17pZlTHGMBEIMkOYvDEl
         5KWJW5edqjd1pJMMIhOfyT53KZ9wfxSiWTdmCLthjqvoOVKM7CHKIXBAuBpbXSvowVGI
         YJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767421598; x=1768026398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzTUqaBjKErhA8u/T2FQL1WG9Tm1uXsr+21laEF71/k=;
        b=fklhkJ1jK1VWNdrNVzg9xZVKe2qcxNlZrV722ZbDVlvn0DemDNN/VQQrwnkFI20812
         OtUaTekupwA2mDOEbgCsB8uoOULaDx9QArMzccCQ/a2sAOBvvREi1JzmZC5/SpMLMhYl
         gOouo2Ix/4fSf+lABGCz7NVngCUZqIVgUkFZa6LdpxiEor5j15ZEdV2vq3czYuF3GwbE
         1R6nf8gLg5VRo28eADyxEwY01BGssjvdYFpcniawHx64jKEsrUQdPnf6EEBrvnkxXcr6
         tjD9SrPjG3zR28z6BblDTny/ggHLMXXqmRNqzU7hq6KPyvFHJqV0l5WEYi4CPpnK4yeB
         m4Ig==
X-Gm-Message-State: AOJu0Yyyznljf9RTAJdzrSn9xxBlb6yTO7KLmym+xSlg9/7PJRIDGbAY
	/Q/CgHBGfvCEO1QqahB+NUuLXsVwqu+PtxAT2ZxsC7BgkYKdH19Zs9VU9hABvI3gsZS/hgb0LeV
	ciE5w6djYLKZe8whEGHLDVdRXPFf8QFX9VPQl
X-Gm-Gg: AY/fxX4wKCo9ZmMKEO4dEcFPbvus0Xm6/8lVwu8GBpcdlCVpzv78uhAKPqHXMGcnTZ6
	FMqEq0MyuqncX4R0Wy+0xYsYC3I6ZIeS7tO6B1F4wnAlqW2zDxNtoiPT7oRvREMUVkum+2XeKbe
	Qh8c8HbT3JpezhAsAt8dzNUEHP0qlGyBmWhD/Ti6Vm8mbx1GBMvr/QybMapOm+1wfI6QOuFTsiD
	lu6N5pb5fEdy3h/AXfb/jO+fUPEvgTXNXLs1dnGcD910rg4vTRVtm37ahuUEjAFP1rHLVHffq4e
	JcBJQQ==
X-Google-Smtp-Source: AGHT+IFaFIehM2CiM0gmEG+Na4SL0ej+sq5nHRE9bjtces3Vvr/kIlKB517060xRFmaeovwiWR7P9Cdthu4SqyN5SNo=
X-Received: by 2002:ac8:6711:0:b0:4f1:b93d:fb5a with SMTP id
 d75a77b69052e-4f4b43de5dbmr429908471cf.7.1767421597647; Fri, 02 Jan 2026
 22:26:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229160724.139406961@linuxfoundation.org> <20251229160726.283681845@linuxfoundation.org>
 <CANubcdVnWRkJ8x7zLGKih+uY0D0cE8jGmF_dx7+iDb5sgBWtQg@mail.gmail.com> <2026010240-certify-refined-7c02@gregkh>
In-Reply-To: <2026010240-certify-refined-7c02@gregkh>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 3 Jan 2026 14:26:01 +0800
X-Gm-Features: AQt7F2p8hjCipjPSAJOhW80ofQZTg3x6YsPGRswI1qiJ6xQA2TC8ouImzh3I8jY
Message-ID: <CANubcdW2z9AEdML4sV9XEXFeDUUzbt20istLuZ9s=zUoPvjDLQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 052/430] gfs2: Fix use of bio_chain
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Andreas Gruenbacher <agruenba@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B41=E6=
=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 14:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Dec 31, 2025 at 07:54:45PM +0800, Stephen Zhang wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B41=
2=E6=9C=8830=E6=97=A5=E5=91=A8=E4=BA=8C 00:16=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > 6.18-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Andreas Gruenbacher <agruenba@redhat.com>
> > >
> > > [ Upstream commit 8a157e0a0aa5143b5d94201508c0ca1bb8cfb941 ]
> > >
> > > In gfs2_chain_bio(), the call to bio_chain() has its arguments swappe=
d.
> > > The result is leaked bios and incorrect synchronization (only the las=
t
> > > bio will actually be waited for).  This code is only used during moun=
t
> > > and filesystem thaw, so the bug normally won't be noticeable.
> > >
> > > Reported-by: Stephen Zhang <starzhangzsd@gmail.com>
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  fs/gfs2/lops.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> > > index 9c8c305a75c46..914d03f6c4e82 100644
> > > --- a/fs/gfs2/lops.c
> > > +++ b/fs/gfs2/lops.c
> > > @@ -487,7 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *pre=
v, unsigned int nr_iovecs)
> > >         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP=
_NOIO);
> > >         bio_clone_blkg_association(new, prev);
> > >         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> > > -       bio_chain(new, prev);
> > > +       bio_chain(prev, new);
> > >         submit_bio(prev);
> > >         return new;
> > >  }
> > > --
> >
> > Hi Greg,
> >
> > I believe this patch should be excluded from the stable series. Please
> > refer to the discussion in the linked thread, which clarifies the reaso=
ning:
> >
> > https://lore.kernel.org/gfs2/tencent_B55495E8E88EEE66CC2C7A1E6FBC2FC16C=
0A@qq.com/T/#mad18b8492e01daa939c7d958200802c9603b6c73
>
> What exactly is the reasoning?  Why not just take these submitted
> patches when they hit Linus's tree as well?
>

My understanding is that this patch didn't actually fix anything and
instead introduced a new bug by mistake. Since it was merged, a
second patch had to be submitted to revert/correct the original "fix."

Therefore, for the stable series, the appropriate action is to simply
drop this incorrect fix.

Thanks,
Shida

> thanks,
>
> greg k-h

