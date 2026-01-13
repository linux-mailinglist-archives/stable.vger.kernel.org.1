Return-Path: <stable+bounces-208275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1BD1988E
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 15:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C026730390F1
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19412C0278;
	Tue, 13 Jan 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXkmz2s/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3328CF77
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314953; cv=none; b=JPsHMtzjEPk2Uq9kGuxqMpquqBq32lWXV6Y6ujgQy/TNpVjaHIWdUwv6U7pMZ/Afgvr8jGgbHkRiJ1WCXF85Tvb+tcUKffAVEnv2yW8MbRtJTRx9TKYj1KERDfgGVERYckBYTIPucsFtX0h7xMmF62+H99PCAl8MSui+mLV+CZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314953; c=relaxed/simple;
	bh=C35Q9gEplkEHxqvrleJh01VreoZX5QZKIn5nqUYUGKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHbrn3M0fx50x94e6s8IlMDz3ItsYgwW2yGqbNmNidkbYARJdTl8aUizQwzD6yYTKYTmI34CBei2KUp0SAziEsPUrJTe0KB2PDkuBCnY2DZIZa9VaGaT2U71KV+7VjqmjsVqZSH9+/WwwrtxM6+mYrnqKcbXrtBeHPIK1ybxUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXkmz2s/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c213f7690so5077541a91.2
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768314950; x=1768919750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oSG1flMMfh36IrNc9ewR5ZYBFxhDPNDnEZLwNTNKxSw=;
        b=UXkmz2s/tO0oF3w5iJ5Y28xei1BTRHijWobfXaACzsF7glNc7UMa+J1MYKUfmDsGbD
         BxpaDhyL7dmdwisCAP7m0UEHMHTp0KcRUzWJhxWRPmbpnx2/pOBJTLRBifSI7uDK3sRK
         Y1YsACAJ1jbccOoyfyHLqtERiM2uZL0lm9kVl8OKhj+PlVz6BB1QQeeqbsF2rgrSeOyR
         X2z/3mymY3HkasdUBwE5sgUkBi3Jfni70KfasDVKOViNjv0Nv6+aRNr5kXWqDE6Ca+ka
         H/UQIyh455l+pFs3+sNUNTXAKcCMo6Ird4x0GJ5xH+pEb+fYiIOOdpTwhgIfA2D4190C
         MTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314950; x=1768919750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSG1flMMfh36IrNc9ewR5ZYBFxhDPNDnEZLwNTNKxSw=;
        b=c4TN/aQBrHLt1uJUCgZ+kLdTMzS+GDPR67bvGy83P+1ITt1tRhzJxDteaLUAV/87yG
         tQO7uEaXFCDyfMIw3nYMZhTuwSg5HljfZs24opwgdOyTqZD1By/E2SHFNKhOaR0GH2xh
         KOm7M0oVbUa8Z1ma+3u4Gwu2KU0cx9SCkicOh1YWsnBW64TCrhTPcFaQ43FWzkv56yRX
         cQod9ezPDeBk8A4arv+gfuTMNDSM1dhEKqkDwB7e5/zLYGE20SabgIe0/AWWcl6g7adn
         WPBGRvdf1UKmEhF3qkdaMhpkLr01NoylZxZtNHNZBRz0zjHqHtGawxjN+r+v5KVKgsZK
         OHuA==
X-Forwarded-Encrypted: i=1; AJvYcCXuTJcTAZIFnqSOicF4gRPLkyF/A1xH5uvBFeUMCbEPV5g/aYnvSf+5dmzyXsLnCJkAVw6d3xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/62A1tNquvKPB4lrtoAlacZuzyuapCzmQodMu70DbfGiLF95m
	noxp0eRig8XjtYX+sncWcjLZyzMffLN21ECRDmD0YvpYuEIb8s2N1sYHa0iAegGBjrGCZAxn6MV
	KHGr2pnZ7/Xs3YMlda4vix34/Y46lSpE=
X-Gm-Gg: AY/fxX5Vfj8MdeSRvRKrEEsOH+H3d7i/D55prKD19WxZksOafeoGVFClxbuEazmiRk6
	bHNBlwKhguM5WjwkWz0fdtqnZYIYSVDNXbOJEEwGNWR7R+vUJ++j3tjQAl/0+zhfN7QCDuKMxXA
	5j+J4HInz5aRL86VMcZbUpx9dKYjMbIjammeW5WBQulGAZQcXUScWhjnTLLTdEhtG0gnwbqAQe8
	qI+bsLvrq9CiF52n1XrgcoNrZVS536ekc7Rgdvgg7uIwKJSdcnexgN9l3b+nt+VS+wX
X-Google-Smtp-Source: AGHT+IHT+/65AwG7pbeaD+hwDIeJFQVVT8OcPnsbknIVCNlEW+jBEIRg6vXSDBwDn6VbTK0XAMZHrcwQrDSLxvGIXR4=
X-Received: by 2002:a17:90b:264a:b0:341:3ea2:b625 with SMTP id
 98e67ed59e1d1-34f68b661eamr23258771a91.12.1768314949735; Tue, 13 Jan 2026
 06:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113065409.32171-1-xjdeng@buaa.edu.cn> <20260113084352.72itrloj5w7qb5o3@hu-mojha-hyd.qualcomm.com>
In-Reply-To: <20260113084352.72itrloj5w7qb5o3@hu-mojha-hyd.qualcomm.com>
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Tue, 13 Jan 2026 22:35:38 +0800
X-Gm-Features: AZwV_QilNtsaInykWQuPTQNCtpY0ZlBqP2RfpYd9nDByrVVow35WCZNPQxZXsrw
Message-ID: <CAK+ZN9oMpc9nh08vK1j1XDfhs8w=sQngmJ6rPOqa9QZwjTioUQ@mail.gmail.com>
Subject: Re: [PATCH v3] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, I will do that.
PATCH v4 is released now.

Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=88=
13=E6=97=A5=E5=91=A8=E4=BA=8C 16:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jan 13, 2026 at 02:54:09PM +0800, Xingjing Deng wrote:
> > In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
> > reserved memory to the configured VMIDs, but its return value was not
> > checked.
> >
> > Fail the probe if the SCM call fails to avoid continuing with an
> > unexpected/incorrect memory permission configuration
> >
> > Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool access =
to the DSP")
> > Cc: stable@vger.kernel.org # 6.11-rc1
> > Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
> >
> > ---
> >
> > v3:
> > - Add missing linux-kernel@vger.kernel.org to cc list.
> > - Standarlize changelog placement/format.
> >
> > v2:
> > - Add Fixes: and Cc: stable tags.
> >
> > Link: https://lore.kernel.org/linux-arm-msm/20260113063618.e2ke47gy3hnf=
i67e@hu-mojha-hyd.qualcomm.com/T/#t
> > Link: https://lore.kernel.org/linux-arm-msm/20260113022550.4029635-1-xj=
deng@buaa.edu.cn/T/#u
>
> v3:
>  - ...
>  - ..
>  - Links to v2 : https://lore.kernel.org/linux-arm-msm/20260113063618.e2k=
e47gy3hnfi67e@hu-mojha-hyd.qualcomm.com/T/#m84a16b6d0f58e93c1f786ea04550681=
b23e79df4
>
>
> v2:
>  - ..
>  - ..
>  - Link to v1: ...
>
> You could even use b4..
>
>
> >  drivers/misc/fastrpc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index fb3b54e05928..cbb12db110b3 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -2338,8 +2338,13 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devi=
ce *rpdev)
> >               if (!err) {
> >                       src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> >
> > -                     qcom_scm_assign_mem(res.start, resource_size(&res=
), &src_perms,
> > +                     err =3D qcom_scm_assign_mem(res.start, resource_s=
ize(&res), &src_perms,
> >                                   data->vmperms, data->vmcount);
>
> Fix the alignment to previous line '(' like you did for dev_err(), I know=
 this file lacks it,
> but that does not mean we should repeat it.
>
>
> > +                     if (err) {
> > +                             dev_err(rdev, "Failed to assign memory ph=
ys 0x%llx size 0x%llx err %d",
> > +                                     res.start, resource_size(&res), e=
rr);
> > +                             goto err_free_data;
> > +                     }
> >               }
>
> With the above change.
>
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>
> >
> >       }
> > --
> > 2.25.1
> >
>
> --
> -Mukesh Ojha

