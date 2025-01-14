Return-Path: <stable+bounces-108644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A406A110F5
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 20:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D2E169BF6
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2221FC7DB;
	Tue, 14 Jan 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKFvN694"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB51C1AAA;
	Tue, 14 Jan 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882081; cv=none; b=pR1ZeQ3jXE1PK/0ZT7GW0iPXjD/9Auq2c6HXH/5nT6iZ4OYccEEBdSc7FhOFYf+7Ufini0bJ8gYaGgEBBSYCnUSPkYSy5AZ6Q7owPTOd7x7PrJMV2O7LPOTtwpodTiWZ8rVC44GceNPg0iYnlwtWEFzYCBZbWBm3nFmBNFs7btE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882081; c=relaxed/simple;
	bh=fP/itInBSG8PSfcdMEyH6RRRAh64VeNM6nFr2iArTJQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=hqg78Nm7oC6tcbXHSe/BdeDDNGa8CUjIHxPmFD2cD4d4RXrt2SsvBK43Dm1QU/ZDr0AKdVjVwhmiEirq63YsPElzL+ujdyinT2Gfd/0/1QN1RY4J3UmD7WYBHItj/GGOJUvYn6T2Bk++B6/SWHY9PaRfiYkdEukfb/TYhEiAYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKFvN694; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F5AC4CEDD;
	Tue, 14 Jan 2025 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736882081;
	bh=fP/itInBSG8PSfcdMEyH6RRRAh64VeNM6nFr2iArTJQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gKFvN6947mTMc7BQGVtT2n7JLSQl8x/liZ+rLXlS/wxlXjvtxIuA3MDupIi2oHDMu
	 /nrmx8hJt2QO1DlsJPCxePLg8tIqBJYhF2B2WCJYgAvgEXufyIpJk0Z9phhzL7EiEi
	 L6nggQrTSRl4gp21VArcMbgPEkmaLYIOB/I1LS0HljtbaCUZawhHMjlYitAQXN7TMU
	 6RVfpJRyQg+95vSzSHq09rgt3I4Q/kk9sijyFxNhDvIHB/1Wug8SVWEKNqlOpT+0vg
	 Mi664/1SNXsSiT5Ip83+vcP2q5zHiJ4j2rpN2cAYFXnNtgYAD27efJIzGMgW5TuHmh
	 LhlfKkbbgEWrg==
Message-ID: <3043dcc07181dea905f97db93a9eb2eb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <82e43d89a9a6791129cf8ea14f4eeb666cd87be4.1736856470.git.zhoubinbin@loongson.cn>
References: <cover.1736856470.git.zhoubinbin@loongson.cn> <82e43d89a9a6791129cf8ea14f4eeb666cd87be4.1736856470.git.zhoubinbin@loongson.cn>
Subject: Re: [PATCH v3 2/2] clk: clk-loongson2: Fix the number count of clk provider
From: Stephen Boyd <sboyd@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-clk@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, Binbin Zhou <zhoubinbin@loongson.cn>, stable@vger.kernel.org, Gustavo A . R . Silva <gustavoars@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>, Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, Michael Turquette <mturquette@baylibre.com>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Tue, 14 Jan 2025 11:14:37 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Binbin Zhou (2025-01-14 05:00:29)
> Since commit 02fb4f008433 ("clk: clk-loongson2: Fix potential buffer
> overflow in flexible-array member access"), the clk provider register is
> failed.
>=20
> The count of `clks_num` is shown below:
>=20
>         for (p =3D data; p->name; p++)
>                 clks_num++;
>=20
> In fact, `clks_num` represents the number of SoC clocks and should be
> expressed as the maximum value of the clock binding id in use (p->id + 1).
>=20
> Now we fix it to avoid the following error when trying to register a clk
> provider:
>=20
> [ 13.409595] of_clk_hw_onecell_get: invalid index 17
>=20
> Cc: stable@vger.kernel.org
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Fixes: 02fb4f008433 ("clk: clk-loongson2: Fix potential buffer overflow i=
n flexible-array member access")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

Applied to clk-fixes

