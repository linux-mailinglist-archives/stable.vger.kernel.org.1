Return-Path: <stable+bounces-108527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF5A0C0BA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810301883C3A
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A70918CC1D;
	Mon, 13 Jan 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmufhQOl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F01B87C6;
	Mon, 13 Jan 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794242; cv=none; b=mYg/pDTjdxBa+em2kz0ARROS7hS6YP/RotR4eIG1gParPtyo1FnGqauzkuc2MxaWoiXGbPjH6Or6Vr+LGOao2TzQJ+bvDFBkJSaR5A61b0+VpcQE9SE1cEXN3/JVM7C5Hr75REe+Js4FSJ8+w+7NY92Y/TUso2kZUSlnP8vdFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794242; c=relaxed/simple;
	bh=LrAZrlPGdxOhIfDptSprsMHoShMe70Xq8DW+GAgdJUQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rq+9bXyFSTFS9LyKUwPqouKcw2ZtOLn9L3yiT0IyQXWm3T/H6KnD2/IL9M3/BKSG+MLG2VP5Vw/Zh+wnZdrUP0lpbB3uQJqAU5jZFNTT1MFT5cwgieuYYwy+wOleZmJ1Dj68RA47FE76821LCr6W8pTKCwSTF+iVj8iFukJMLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmufhQOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900F1C4CED6;
	Mon, 13 Jan 2025 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736794240;
	bh=LrAZrlPGdxOhIfDptSprsMHoShMe70Xq8DW+GAgdJUQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fmufhQOlz06hj3nwkWxe90yISJL1GHNmILa8Cuivr14oDoxVCyJOIRztZ/SRB6Xyg
	 JphpTha5/V/myo4bxpLCR9aKeoHbiFic1EsCL/s5QH14N8gZh02If1aUHILNy0JYIA
	 vjrEdqkLOhfiV9QUexRUld7uNzdGglPK0TDU5fQ74qLmYESTQK36J1p9htgvcF/ZP2
	 wIOvGrmYidc4fNM3KR0UPvVlTETjMK/qvew6FK8O85HUwnYy172bZeptzNtp1u2PSy
	 c7Q9yS4h6pfZGAjLVK0sUBz352Rh5vDj4C3jtVYXy3lVP6Rwymn6wcLn9NMH3BVAwu
	 BwwKvQsj/ZZ6A==
Message-ID: <ba25dfc40e9ae91205d61c838e368490.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250109113004.2473331-1-zhoubinbin@loongson.cn>
References: <20250109113004.2473331-1-zhoubinbin@loongson.cn>
Subject: Re: [PATCH v2] clk: clk-loongson2: Fix the number count of clk provider
From: Stephen Boyd <sboyd@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-clk@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, Binbin Zhou <zhoubinbin@loongson.cn>, stable@vger.kernel.org, Gustavo A . R . Silva <gustavoars@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, Michael Turquette <mturquette@baylibre.com>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Mon, 13 Jan 2025 10:50:38 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Binbin Zhou (2025-01-09 03:30:04)
> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> index 6bf51d5a49a1..9c240a2308f5 100644
> --- a/drivers/clk/clk-loongson2.c
> +++ b/drivers/clk/clk-loongson2.c
> @@ -294,7 +294,7 @@ static int loongson2_clk_probe(struct platform_device=
 *pdev)
>                 return -EINVAL;
> =20
>         for (p =3D data; p->name; p++)
> -               clks_num++;
> +               clks_num =3D max(clks_num, p->id + 1);
> =20
>         clp =3D devm_kzalloc(dev, struct_size(clp, clk_data.hws, clks_num=
),
>                            GFP_KERNEL);
> @@ -309,6 +309,9 @@ static int loongson2_clk_probe(struct platform_device=
 *pdev)
>         clp->clk_data.num =3D clks_num;
>         clp->dev =3D dev;
> =20
> +       /* Avoid returning NULL for unused id */
> +       memset_p((void **)&clp->clk_data.hws, ERR_PTR(-ENOENT), clks_num);

This looks wrong. It's already an array of pointers, i.e. the type is
'struct clk_hw *[]' or 'struct clk_hw **' so we shouldn't need to take
the address of it. Should it be

	memset_p((void **)clkp->clk_data.hws, ERR_PTR(-ENOENT), clks_num);

? It's unfortunate that we have to cast here, but I guess this is the
best way we can indicate that the type should be an array of pointers.

