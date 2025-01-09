Return-Path: <stable+bounces-108052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A6EA06BD9
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 04:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761EF3A6A03
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 03:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6113AD1C;
	Thu,  9 Jan 2025 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYy9DMMz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFFDDDC;
	Thu,  9 Jan 2025 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736392019; cv=none; b=nHM4iCSa+G5U6fNHDwph1r3GjLzKjxoCoof9wiv3rouwkHHZjVZ1DA/HYsB3r/DC7Po3tdy4cQj3k3jRDEDnsJZYe3Totbl9ay83P3RP6q7CS1hVIjDH/+GJt/nrs3Ui2QLjhTizlNyuBV9XIx5V0PdmK5W7eHuV8oO8rSw7yO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736392019; c=relaxed/simple;
	bh=j0oUpGZRketH66aLGlOqEratqE7lE81u3b79GqES3KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOTZRI/VVEHQVrr6PYWnx5ZAJrx3Moy3GGQfqauYuAmxguLRGvGBkiLzURZEG+pA/qScy0wfJ6Yhs77eiKbE5zoJUoDU4kBNb4/TJ/SvkVfStZleiJi1O7uE72hS2bqPwQVBGu4N00tfgQYItXflmkjfHip5vYZ6tcUZUHvm8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYy9DMMz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso591320a12.0;
        Wed, 08 Jan 2025 19:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736392016; x=1736996816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcvguVZbOYQiUlHNff8pHH80HFCIQo3zkHLK6WxRevg=;
        b=FYy9DMMzXtlfLdXsDKRiMRlBhUqAWjdpasalQlZb+iQTFqE1/XKaHAC0w7vPoxY5EC
         0qO+KaXhlkMvjCmMJKE81ms8VipkawEbQ2PKJK0+htIxP4MNqxyEprQe2hE6mA+QwL5a
         h/fsEXJBjZhO/NoaIagPe5pitcwlZUU0HNI627lwl6dbvMiBsSULUlgisS3WseUNQsei
         6Yihp7pWvhrbOotRZllXfQJs1j9nvF0wbrBoliklRCaCnf9j0BB566YceK745dTmPlSk
         fAa3ok4mG8nfT2F73Q5IJfjsAMb/GtK8+hQKC9v/SJnN9DtZ4GLDCQ7dZcUvu9zA/DF0
         /mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736392016; x=1736996816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcvguVZbOYQiUlHNff8pHH80HFCIQo3zkHLK6WxRevg=;
        b=sCQVEmfvzV2kdJtEuzK4IZGkAkJhF4So5TQBNv+mnlp4rvXNC8iN+51wqmAlCE1o4G
         NDLDdYqkeSyNtI17GjCh2eegSsKq+KZ3P7LDIL6ffS6p9TNZQLfULRM1ZuTV05Jtfzku
         eqGFKTBk7oFc9eByZVWcizV6fsZuby+G4T/YA+3v9v0nUIKNW3F5OOWQa4GZ5pFbgxge
         RBEmQPRbK7/XGyzfzfLEv1SrHPnMp84a2cYPlsq5JsmX63/hPemNlt9GgvjlO7D5+j52
         ffi0bv87LDyl3KpnOsl5YFzv0UoPqrakmBrgn7H8uaDIj+194AvW6UocwkQKATRaIYPO
         4PtA==
X-Forwarded-Encrypted: i=1; AJvYcCU9z81rsn4HmVays93Hvv+bF8Ykxez0gEAoHxAEWr9NXqhOcfU6vZZPt3NPVEEq4jbr5lOd1iHm@vger.kernel.org, AJvYcCUklQH+vhGtPfCFalf7yIZltyWA3jqdVIUNutUJAeh+MIn5hBrZ9yAYb4CWmpK7q861nIAzUEBzQp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDI8km+8CsM2tYh/8TZTNuYrwHanf0nHWTXJRvEUKvqW7krwmJ
	sdVsS6RmtMkAD/dd6DNxunc0i8niWjbutdbZKLS2O++/8HGgDtf8VO4uYGUcQ1FLn3P0Ch2XM8f
	KrjsnOZVfWAGWLMzLpOxrzv9Q2YI=
X-Gm-Gg: ASbGncuJMhIuyYyVZoyT1DdzhgeQmHqn2ksesY5PABFKk7DYlKgncWiHQyIO7T0DnJo
	m83YAhx60R+ZFfves/dfS0j9VsyP1lTja8/4=
X-Google-Smtp-Source: AGHT+IGfqqtzl5vrGSo7HJcvcyDWUl65drgIH6Vv3pEl7FUmKO18JawV8JUiNayrLTBBFixjVFqVA3LHLEdBoEk5SxU=
X-Received: by 2002:a05:6402:13c6:b0:5d2:7270:6124 with SMTP id
 4fb4d7f45d1cf-5d972e484a3mr4167328a12.23.1736392016040; Wed, 08 Jan 2025
 19:06:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241225060600.3094154-1-zhoubinbin@loongson.cn>
 <526d7ad1f0b299145ab676900f81ba1a.sboyd@kernel.org> <CAMpQs4+i11DVGhdinMrE41HkC8hhD11P0BLeOaK5yW8QXUMX-Q@mail.gmail.com>
 <0757e78b02165aca65465d4e96eb6e92.sboyd@kernel.org>
In-Reply-To: <0757e78b02165aca65465d4e96eb6e92.sboyd@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 9 Jan 2025 11:06:43 +0800
X-Gm-Features: AbW1kvb-fi80aY0XoQiHcrnDQm4aLOeDclKMtkIp68GA6Jq64FhC6QCWI27RyFE
Message-ID: <CAMpQs4+pcqCUxXyg64_bzdi=3K-kb4mvKG7vM-yqcaoWO=TiLA@mail.gmail.com>
Subject: Re: [PATCH] clk: clk-loongson2: Fix the number count of clk provider
To: Stephen Boyd <sboyd@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Michael Turquette <mturquette@baylibre.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, linux-clk@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen:

Thanks for your comments.

On Thu, Jan 9, 2025 at 3:20=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> Quoting Binbin Zhou (2025-01-07 17:41:43)
> > On Wed, Jan 8, 2025 at 5:25=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> =
wrote:
> > > Quoting Binbin Zhou (2024-12-24 22:05:59)
> > > > diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson=
2.c
> > > > index 6bf51d5a49a1..b1b2038acd0b 100644
> > > > --- a/drivers/clk/clk-loongson2.c
> > > > +++ b/drivers/clk/clk-loongson2.c
> > > > @@ -294,7 +294,7 @@ static int loongson2_clk_probe(struct platform_=
device *pdev)
> > > >                 return -EINVAL;
> > > >
> > > >         for (p =3D data; p->name; p++)
> > > > -               clks_num++;
> > > > +               clks_num =3D max(clks_num, p->id + 1);
> > >
> > > NULL is a valid clk. Either fill the onecell data with -ENOENT error
> > > pointers, or stop using it and implement a custom version of
> > > of_clk_hw_onecell_get() that doesn't allow invalid clks to be request=
ed
> > > from this provider.
> >
> > Emm...
> > Just in case, how about setting all items to ERR_PTR(-ENOENT) before
> > assigning them.
> > This is shown below:
> >
> >                while (--clk_num >=3D 0)
> >                          clp->clk_data.hws[clk_num] =3D ERR_PTR(-ENOENT=
);
>
> Or something like:
>
>         memset_p(&clk->clk_data.hws, ERR_PTR(-ENOENT), clk_num);

Indeed, it looks better and cleaner.
I'll update in V2 soon.

--
Thanks.
Binbin

