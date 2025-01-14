Return-Path: <stable+bounces-108591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C61AA10722
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 13:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7C53A7216
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06022DC5D;
	Tue, 14 Jan 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRRCVYCC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91027236A85;
	Tue, 14 Jan 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859198; cv=none; b=UibDOVLgsPnJaZlv+RP7P28iZ9owptW3keoPQWRAXBLYI+XNBBi6osdYGjsn9medL4Re8QhTh/PmhFzCzLZxB5dv4klieOQctBuIykYhUauGqgq9bLrdxlWlZcYr1aHDUq926LLx64GhiK1I8syNNp3eX20gWv+dpqPvImRpDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859198; c=relaxed/simple;
	bh=c4/hILBrFjjcIwY2WJ+4Y19FRIoTpjKzIsfIQB+t6GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcjEoEBH4KHIp6t2Udge4cV4SdarCE62ualMGojc/1EPb19Mr5msItEzHAh4FwCa4nhuj1pAASqLB9nXjXuTfuUsAeQohAglpfyfHcIImlM1ISRTZ8n+PhshpGgAh0aU2P3iwW9mD69/q+swst0V0szF5NbnIIMNfr1ate8VSvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRRCVYCC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso7712864a12.0;
        Tue, 14 Jan 2025 04:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736859195; x=1737463995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58YRhhAWOxecN/NnS0PaSbopKQHlTjf7bl863HnP150=;
        b=VRRCVYCCe6E7qCBJ4TSTEl02T0tNYDcdLP9I6bebQfVg7tnaflrogL40c2XwZP1Jev
         N5lelpwXHwTf8TeHpUlCIbh4V3J8Ay8yydm/w7bBmq/WldyAd7hwxbe/hmupRiKnUh1Y
         ijiQaDTAnRttny+VFxhtqIwfDh3yRzeAVFznHL35jjVuEWmgbsFnZFpw25a1BVGSPon/
         WI0eHGFI12LB9Xk0dP128SiIOOCNUQOi6yo1gDP4nYOMDbKF04QesCuqPlOr/f88h8+u
         mwiXK2RAjV08UcFX7UadImof39R6Wz1YTjTdsIbJkiTbZgvcf6hoY0bi6Lti5BhDtHVW
         S7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736859195; x=1737463995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58YRhhAWOxecN/NnS0PaSbopKQHlTjf7bl863HnP150=;
        b=ke/3mfi93yuKKfOp2tL3H74mQsBszOTamCMVKtfEV05vYZMIvMwVkpDexekFvw4FUH
         VEGxgh6hv5yECcmfgcHXzap1QAZF8m+9MUmDMxidLZgrfPhPElR15zMl1HhQcopDOxJZ
         LBcCT/ZiFiZGQaHIFIiZu3Dst3qO75KA8eG6iYCDP4AVzppU62wkQhQ1SSCiQ7QMFYGs
         ghjBbbLTX7l3u4rhH3xzX2/ENz+HFozpbwTskBr9ojecG5zhqMle7KXVvERKnIbQbdw7
         dRlDnnED2ooFwcyXjo89HiP+hwI27l4BSVtIzPbtNG5XFPyl5n95l9e+mbTMclL72QTu
         bZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQVBGPIQU+EH6xjEW/Pp+BisMszx0K72eXGCqlMUjtfjniB/nwkxUzXrFaiFrLTowTjbvDFN42Uo=@vger.kernel.org, AJvYcCWNqX6t0EERtHYReKpU5ZfYE5gozSeCPPISH+bqgReBRTlWV98u+7ISBz06K9/UX//cON/rBrf/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyio0I83P+HF3eHeEDw+88kcR2w9tkk4FmQUYu7n0VaktkQGj+5
	Dn+PKH2F3tCYVHr5oialdIa38zJux4QtFnEc90uNqA/X5LOsiiyKCBQG5zyRglnygvqVAUNoYVv
	+4n/QQbrJuBhnArUi1UpAxx2nwxg=
X-Gm-Gg: ASbGnctAADi0UpXxiQlsra5W46qamzrHKykO4UdM5UKLMYyOxKYYWq/VesoGdZfLFoD
	QKzlJjQ4pXLTKsuo6opKGLuCSndWPIKgi4z2K
X-Google-Smtp-Source: AGHT+IFAeT9rGs81+ma7oWrKwp7nETfmX0fYNUxmNBFROFMZRbXo6MVJ9ClUknjW12+94gVEobaY+33Njkg+dB2ZDoE=
X-Received: by 2002:a05:6402:530f:b0:5d1:2377:5af3 with SMTP id
 4fb4d7f45d1cf-5d972e00027mr56882740a12.5.1736859194633; Tue, 14 Jan 2025
 04:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109113004.2473331-1-zhoubinbin@loongson.cn> <ba25dfc40e9ae91205d61c838e368490.sboyd@kernel.org>
In-Reply-To: <ba25dfc40e9ae91205d61c838e368490.sboyd@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 14 Jan 2025 20:53:02 +0800
X-Gm-Features: AbW1kva3LJGk4s8ei_nQCIk6VVREFoQwacKX90JhAswxvfIX_CoApACaTyLPiaE
Message-ID: <CAMpQs4JixuJOQyK1wXBX+Y_j27Cng0wBiX3NBpHmD_7byUtzmA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: clk-loongson2: Fix the number count of clk provider
To: Stephen Boyd <sboyd@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Michael Turquette <mturquette@baylibre.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-clk@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, stable@vger.kernel.org, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:50=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Binbin Zhou (2025-01-09 03:30:04)
> > diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> > index 6bf51d5a49a1..9c240a2308f5 100644
> > --- a/drivers/clk/clk-loongson2.c
> > +++ b/drivers/clk/clk-loongson2.c
> > @@ -294,7 +294,7 @@ static int loongson2_clk_probe(struct platform_devi=
ce *pdev)
> >                 return -EINVAL;
> >
> >         for (p =3D data; p->name; p++)
> > -               clks_num++;
> > +               clks_num =3D max(clks_num, p->id + 1);
> >
> >         clp =3D devm_kzalloc(dev, struct_size(clp, clk_data.hws, clks_n=
um),
> >                            GFP_KERNEL);
> > @@ -309,6 +309,9 @@ static int loongson2_clk_probe(struct platform_devi=
ce *pdev)
> >         clp->clk_data.num =3D clks_num;
> >         clp->dev =3D dev;
> >
> > +       /* Avoid returning NULL for unused id */
> > +       memset_p((void **)&clp->clk_data.hws, ERR_PTR(-ENOENT), clks_nu=
m);
>
> This looks wrong. It's already an array of pointers, i.e. the type is
> 'struct clk_hw *[]' or 'struct clk_hw **' so we shouldn't need to take
> the address of it. Should it be
>
>         memset_p((void **)clkp->clk_data.hws, ERR_PTR(-ENOENT), clks_num)=
;

I'm very sorry, it was a cheap clerical error and I'll fix it right away.
>
> ? It's unfortunate that we have to cast here, but I guess this is the
> best way we can indicate that the type should be an array of pointers.

--=20
Thanks.
Binbin

