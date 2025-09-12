Return-Path: <stable+bounces-179318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860ECB53FC9
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 03:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41488169F73
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5E313BC0C;
	Fri, 12 Sep 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dCLCoZ0C"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CC76026
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640085; cv=none; b=YhhBiO0YwD5H+BNglicFW4qUm9vGNj0I1DXHlh36HsyP6SjkG6Fx1w8ZxpAQsCPoewHvaJGf260szlPQapexkFVgJ/S/HA8pn6lK7SzSHxJtwCEGXM6lHlIuj2H6C5XN0jx8Qgany0vkovjOKoYWbe+s1V2nXQitA1jyC14/Q0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640085; c=relaxed/simple;
	bh=Xa0YEpz+3VPo1Hi6V+S19t8JxtGYU5nJ3wnyT2oaneo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bq0CNu4q8LBun8IPEP9MKF1Pm1vXwfTnkan7j8f/Yg9KwA+GFZHvgbWSzi/auzNUxKvqXLo0D7mvA5OifRGd6qjX9pMucWcVoO/461Y0F85n+6BBw8/QAlE23KXNrhKzdS/TVVpCZl/TyXrzMgsbcq+k4F8MPGv6TDC1JpW1MtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dCLCoZ0C; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce534a91so508908fac.0
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 18:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757640082; x=1758244882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNvn8dwm9/jQPmmYOQXAYSn+9iI7uf/gD/WC7z1WFd0=;
        b=dCLCoZ0CHYFlRTIp1Tp8FynzOhdJE5IL5HB4omBIzrOfMxy8nycuRlSMGoCAcgK0Js
         EHnXc0mkWhDfdHDaDqc8DJHlJ/AumuElk7qaVpk6sgM8tqGGZTIAtKKHEWGb82sZbwTQ
         eB/8kgNQ3CsLtMgfrQ+Tg5xjYiPJxufSYDSQr7W7Z5RInDQNxc8ecoMppPzvHcXYrGr+
         AZ8o5JkyoL04kvVY0avUKk2XRNRDlNtAMaNaCO+0UlvtMkrTaI5B3RZ9+Bf3WXZ/gmlZ
         PzRDzPYb66BRJ6l3NVj6q8UTCrnPoudoUUxjL5zFhYUy/0ZSz4oKN5Ch/qImYDwTComD
         CHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757640082; x=1758244882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNvn8dwm9/jQPmmYOQXAYSn+9iI7uf/gD/WC7z1WFd0=;
        b=bZYrZtvIMfDkwgLwnKajnB/JvSGKeWQMBjs9XsevMUtIJoSm4givAjbGiuxQtqA6Rf
         rrmlNPmaCxx2EKv0H9Sv7++O+4C3s/AjExryP1WH4vtMmcwhQ9ssiPlEzpOGDro7aEKu
         0b32t/1FVSKk3KFrptRA+EGm/TAWij/SsZ6RTadnbIGfeiKDjyvY4nigRjWLpK+hZH6R
         K4FtrTWL14OLHAoZaxOeAix56uRdtQRlD1DfGwsW0GBOPvqNkL8F2he3/kXZNoKtffbn
         Sgl9sIyUUC24ZRGoswW31upDtCMc+klELzmzxg0+wtg6LdYXLmNLCaC6ves3MiXSiGS5
         BS4g==
X-Forwarded-Encrypted: i=1; AJvYcCWVny5C4o04RWiHGm+GNoHTVPObDY6fmpAH2KGTtPse+sLMy/xiqWkXVzN+2h8tgR3wdmfipLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkO1A2El9ZiOVDC/V063dqY81mjhk8MbU4KX8SrUHZwraJzvJt
	NMRbotYIWUJeKMAk2Be5vP9Il+Q5B0VcGAqSkWzB78LFZ6TU7NvcMKbWGJq0LBUA8a8T2d+RBbv
	SsgowSS1Mgss64NGa05EYYu9gzPMw4xUwgn7jbVA6dA==
X-Gm-Gg: ASbGncv95NzUS7cpndszALoKjNMklukghvSrc/GEKGDI9faYSkkE6RAQrzn3zEPPTt3
	FPsO0ERv3Sc1+HtRY2BHYzP2q2dxiyvbFYP0/XKPtYnM7e8fh7Jl8f6LztHZeWUrIopfKryqw/n
	q6NISgIeqDFISmBZbAAdoGO/oeM3hyMokYEsTpndD7sGyZntecBxQLmDylYVLR3+niixHh+KZdZ
	5GLjScx8Fr6YFIfrna2qGldYGI=
X-Google-Smtp-Source: AGHT+IENe4W9BbK++7qiIojSfDqtbC6lEInbLpk22z8JE7+q3Y0xd1PU0fHFZPk4jPzlcQVIVGB2YJM40b6QZIBc6fw=
X-Received: by 2002:a05:6870:c69a:b0:316:9864:8d0b with SMTP id
 586e51a60fabf-32e54575db6mr492849fac.12.1757640081657; Thu, 11 Sep 2025
 18:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912000609.1429966-1-max.kellermann@ionos.com>
In-Reply-To: <20250912000609.1429966-1-max.kellermann@ionos.com>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Fri, 12 Sep 2025 09:21:10 +0800
X-Gm-Features: Ac12FXzZE38Za4CCeCuscUYLW8mPPYr98VRNgPC9wOUJh37TNzG7c12rb6_jwOA
Message-ID: <CAPFOzZujMZg14Ljp-YsgPqqcJhMFnU68e7XOf09pc=jwoTPytA@mail.gmail.com>
Subject: Re: [External] [PATCH] io_uring/io-wq: fix `max_workers` breakage and
 `nr_workers` underflow
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>, 
	Diangang Li <lidiangang@bytedance.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Max Kellermann <max.kellermann@ionos.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=881=
2=E6=97=A5=E5=91=A8=E4=BA=94 08:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Commit 88e6c42e40de ("io_uring/io-wq: add check free worker before
> create new worker") reused the variable `do_create` for something
> else, abusing it for the free worker check.
>
> This caused the value to effectively always be `true` at the time
> `nr_workers < max_workers` was checked, but it should really be
> `false`.  This means the `max_workers` setting was ignored, and worse:
> if the limit had already been reached, incrementing `nr_workers` was
> skipped even though another worker would be created.
>
> When later lots of workers exit, the `nr_workers` field could easily
> underflow, making the problem worse because more and more workers
> would be created without incrementing `nr_workers`.

Thanks, my mistake.
Reviewed-by: Fengnan Chang <changfengnan@bytedance.com>

>
> The simple solution is to use a different variable for the free worker
> check instead of using one variable for two different things.
>
> Cc: stable@vger.kernel.org
> Fixes: 88e6c42e40de ("io_uring/io-wq: add check free worker before create=
 new worker")
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  io_uring/io-wq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
> index 17dfaa0395c4..1d03b2fc4b25 100644
> --- a/io_uring/io-wq.c
> +++ b/io_uring/io-wq.c
> @@ -352,16 +352,16 @@ static void create_worker_cb(struct callback_head *=
cb)
>         struct io_wq *wq;
>
>         struct io_wq_acct *acct;
> -       bool do_create =3D false;
> +       bool activated_free_worker, do_create =3D false;
>
>         worker =3D container_of(cb, struct io_worker, create_work);
>         wq =3D worker->wq;
>         acct =3D worker->acct;
>
>         rcu_read_lock();
> -       do_create =3D !io_acct_activate_free_worker(acct);
> +       activated_free_worker =3D io_acct_activate_free_worker(acct);
>         rcu_read_unlock();
> -       if (!do_create)
> +       if (activated_free_worker)
>                 goto no_need_create;
>
>         raw_spin_lock(&acct->workers_lock);
> --
> 2.47.3
>

