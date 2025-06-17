Return-Path: <stable+bounces-153290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0EADD3CF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651DA3BFE6A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90C2DFF0B;
	Tue, 17 Jun 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iThG0tSw"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A82EA14F
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175480; cv=none; b=l90Z5v117EddDJKnSAN0No8wHY/Yf1vpqekQCRT8MFMb1SUA6ZnhkGzDHzvseB7xXeCQk4r5q+WZENmEnd/NsY/t7uXwroUcWBMy7fy2xVfFpD/OkmC4ztZtaBx9yw5kdml6hZihE+RbidLu7cxRbIAxb0IwSjJ9KvKZoG9sVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175480; c=relaxed/simple;
	bh=fqpwgDu9tIXRVxnZoR3WWX4uWE3np+6lMDhU4Nvh04Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF1Yd5eV9ZBerhMLqb9ujGLS9EOamve3r053YUvDmtoM3qlzNcP7njjd7mgd/tz42FBRtdYSjD2FKMtaYts7ZQcRREUydfNP9hncAFO+8/9jMP77DmoMQcQVzw5j0kekngA3hs2IcikiAcMwdgNx+QLnckfjpby0XGDrFvejJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iThG0tSw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b5226e6beso31626971fa.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750175476; x=1750780276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uxke+FoO5x1zZ+D5sgB2thrGNYjyTI3ksZkf3CRZC48=;
        b=iThG0tSwZ0Ie7B7fkSWTL4NsDIKbS9nMQEr08GOURMPZXpVrlrBefrmeE8Xn4W99/J
         4UKr+Vy30FlrRoCNetgMq84WbZ9lwcv0iZBE4rx0r4fioM2orp29wStdYY+sPOoRyiKJ
         jWt7v2kK7R/qx8gghRy/aQoPBDBNRv07qfy49uxcZuot+eyDKnR4CbdEe4ZAmlmuqsU9
         75VGIZ2RjCyaHKomPoKoQxm2jfb64FxQ97UurwA2B/8/FVpuypK6SRZX8Yy+zgwpcZDT
         y5G1l/aOlF8SLcAuvh2Rvs4gHzjs69ipeDrn8lJVQFl5M0ShVlIbDct0oq/5wKYyqIjm
         JC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175476; x=1750780276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uxke+FoO5x1zZ+D5sgB2thrGNYjyTI3ksZkf3CRZC48=;
        b=mFhXjYR5EiG/+JVUmGIqLi0veVCw8ERnYQLbIaQpPfAzaRmgpXBeUT33kFXKsus4fj
         i4dM1KJAQY0PVQ2l/2qesTXk9WxYvViqwPBXSv8Y9u1KDPH1xLkzOwMWhFJMKX2Ksmqs
         5eey7hWng4HT9JfIlWrYMUmyXCPjdixf/DgP6FLPzwvtf4K2JHwzTaEMBdd0mNpsvdzc
         bQfPoSzcVbFUZKyTvoU5Xo+ZfIMbm8CqCdk4MJAaUZmb+EgStJroC20WrCMjosd3Kjco
         GwKlEyCT0Ww67LqHmwOYlWrP6g8Vc3AAoWP51TDXvGgfxZJ+yZzVQaStah+9CxQbXkt5
         ucTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj61bDHU6CNenotTx9JmlfDgXR9GFiogt0sQFq07wQDbx9AVofn+T96RLNdXcHD8kczPBspXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9uGbV3nNEec5NJKvYYmg5P4XSyighE5q9MsXihiZa6uWrK9f
	+/VrSBmYOYlRYf90wnWb4g28nba9uZg0s68EVVuShfqUICB/Cje6q/+YOj2m2r7nRzJCsZN37Yt
	hoo98Tmc1iAgcAvJceA7qHuazM5GTEPA=
X-Gm-Gg: ASbGncsaVtTyDP780Pe3LTxP3gjzZuQylhJAkkuf+w5jWTxLIr4XvS1uXPYX/8xaCi4
	9NGUZwvcneAN0mQVC/7DWTR8gnLxX4+7sp0btRUs81OKMrKhG0iRuvve2hC0CIQOEr+cbZK5dmP
	BOj0y3bYE5170yUtapZAE/8HAIILm9V1rKLtAzmknW5co=
X-Google-Smtp-Source: AGHT+IEGd70kwREPXHozckYMiRB+39FyrZ4CqDrfk0BjDiyvUSjdXv/BFP39U0RbocZwPEoCkqeOLmv+KppQQtwURTY=
X-Received: by 2002:a05:651c:1507:b0:32b:5601:d46c with SMTP id
 38308e7fff4ca-32b5601d858mr25244311fa.18.1750175475410; Tue, 17 Jun 2025
 08:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608145450.7024-1-sergio.collado@gmail.com>
 <20250608145450.7024-2-sergio.collado@gmail.com> <CANiq72mVx258c0rbGDwF1sP_gn0v_L7PPMG1q1XcBF2OQWH9-A@mail.gmail.com>
 <CAA76j93Bj00WmWEQeG3vi6YJtN1at8=fbryvf3-JP_gaBcnQkw@mail.gmail.com> <2025061731-onscreen-lethargic-d2b2@gregkh>
In-Reply-To: <2025061731-onscreen-lethargic-d2b2@gregkh>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Tue, 17 Jun 2025 17:50:38 +0200
X-Gm-Features: AX0GCFsRvqvzj5LMErCs3X03GfqkvCHbIpzyNZvE9s7r6z-M0udc8FGvBfWKD7I
Message-ID: <CAA76j934ogMSGU3K9jmUbbdHFXiEJ7EkG=x=tgYLPN5xbiEKqA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 1/2] Kunit to check the longest symbol length
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

 Should I resend the patch v2 with the full hash? or is it ok as
Miguel already mentioned it?

 commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.

 Either way would be ok for me.

Sergio

On Tue, 17 Jun 2025 at 16:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 08, 2025 at 06:10:13PM +0200, Sergio Gonz=C3=A1lez Collado wr=
ote:
> > Hello,
> >
> >  Thanks for the remarks.
> >
> >  The commit is exactly the same as in the mainline commit.
> >
> >  The upstreamed commit, is mentioned in that way, because when I used
> > the full hash, I was getting this error from scripts/checkpatch.pl:
> >
> > ERROR: Please use git commit description style 'commit <12+ chars of
> > sha1> ("<title line>")' - ie: 'commit 0123456789ab ("commit
> > description")'
>
> No need to run checkpatch on stuff you are backporting to stable, as it
> should follow the same style as what ever is in Linus's tree.
>
> We need/want the full hash here.
>
> thanks,
>
> greg k-h

