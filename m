Return-Path: <stable+bounces-108029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B7A06539
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E97D16814C
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F142036EC;
	Wed,  8 Jan 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDThVKO2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91541202F99;
	Wed,  8 Jan 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364022; cv=none; b=eoc9wUMr+hgYUUoSy/g//8ZQk5HTe6krzFaBmAcmfr/pb7mlzIjxe7iKlJzVFNb7+D/JNWGVWdRkAzZSjwidIXv4TxqPiDEsVm6fZF658J/J1JcSxel1Wne4xxKGoEeCXu+bSgTQI85cIzJDoxlLml804t19lf84E9l/Oe6kEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364022; c=relaxed/simple;
	bh=6n5JVGnvfYos+KjSNpqOEMgxeJWVOgfXFvyKcI5tpZ8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=UzALAAVp4riULh+oI/YpZ+gUNSDuZntCejuxw5BffttOU5jjz2mJkaN2Rv7o6A/N7xIB2Il2+VomYcKbDYavUpoA+Nm/JJUvwSVbqZx0DCW7aID+K6S0Q0u4cWRGmEH7eXd3NVQ3Udzec4ZICXc73r5r0/29dkImQns1AFCR1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDThVKO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4CDC4CED3;
	Wed,  8 Jan 2025 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364022;
	bh=6n5JVGnvfYos+KjSNpqOEMgxeJWVOgfXFvyKcI5tpZ8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EDThVKO2P+4PqO5WBaY90UnVABwi/yjv8zmTCFDfRaqZw2Ee3U+IbxK8Kf05N+MKX
	 yrGcCNA/s/Wlp/XxQK/Xyr+KBj9YyH2+H32EnW+ruIA2yajEsA85dXO6Oogg88KKd9
	 z0LglYXaVIc3BxHP1f9DzhKDPEOvgxb2csVwvpscA7don3Y1JIISbquzBGGwg3vHHG
	 NoVzkC26uoyd8ViHL+V0IHrB48k9y77uLpuIx48I0ZN463IbAmPFX4paYvRxGnmaug
	 BAGcB7VraLBSOp7UOl6OoJoOGyN3QwZQQ3CTBSs1fLBk+l59uP/6iKeTE1fe69EUIA
	 uJcM4bdogUAYg==
Message-ID: <0757e78b02165aca65465d4e96eb6e92.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMpQs4+i11DVGhdinMrE41HkC8hhD11P0BLeOaK5yW8QXUMX-Q@mail.gmail.com>
References: <20241225060600.3094154-1-zhoubinbin@loongson.cn> <526d7ad1f0b299145ab676900f81ba1a.sboyd@kernel.org> <CAMpQs4+i11DVGhdinMrE41HkC8hhD11P0BLeOaK5yW8QXUMX-Q@mail.gmail.com>
Subject: Re: [PATCH] clk: clk-loongson2: Fix the number count of clk provider
From: Stephen Boyd <sboyd@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, Michael Turquette <mturquette@baylibre.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, Gustavo A. R. Silva <gustavoars@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, linux-clk@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, stable@vger.kernel.org
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 08 Jan 2025 11:20:19 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Binbin Zhou (2025-01-07 17:41:43)
> On Wed, Jan 8, 2025 at 5:25=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wr=
ote:
> > Quoting Binbin Zhou (2024-12-24 22:05:59)
> > > diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> > > index 6bf51d5a49a1..b1b2038acd0b 100644
> > > --- a/drivers/clk/clk-loongson2.c
> > > +++ b/drivers/clk/clk-loongson2.c
> > > @@ -294,7 +294,7 @@ static int loongson2_clk_probe(struct platform_de=
vice *pdev)
> > >                 return -EINVAL;
> > >
> > >         for (p =3D data; p->name; p++)
> > > -               clks_num++;
> > > +               clks_num =3D max(clks_num, p->id + 1);
> >
> > NULL is a valid clk. Either fill the onecell data with -ENOENT error
> > pointers, or stop using it and implement a custom version of
> > of_clk_hw_onecell_get() that doesn't allow invalid clks to be requested
> > from this provider.
>=20
> Emm...
> Just in case, how about setting all items to ERR_PTR(-ENOENT) before
> assigning them.
> This is shown below:
>=20
>                while (--clk_num >=3D 0)
>                          clp->clk_data.hws[clk_num] =3D ERR_PTR(-ENOENT);

Or something like:

	memset_p(&clk->clk_data.hws, ERR_PTR(-ENOENT), clk_num);

