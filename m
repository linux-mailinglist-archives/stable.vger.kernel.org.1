Return-Path: <stable+bounces-197681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE4C953F2
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 20:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B653A26FF
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EF2C11E4;
	Sun, 30 Nov 2025 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW8SipWA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6553C17;
	Sun, 30 Nov 2025 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764531276; cv=none; b=B0Y/DOcrAxFYGEqFjKXK4Oa307RRxyb80GUPM4rXrGlIj69jVUUzpii2GKzHYP8HhbsEh4loSln+jd/ViX1i6ZUCvGjr8+dur9DJyuC0V8XdvLVvKofXg3zdaHp9DDtqRKVPaq0V4B2zUqIxIGDBHWcu2Mdfb+ezvgjdVBg4K8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764531276; c=relaxed/simple;
	bh=fDk5Jal1lnccSK3N9WMpugaH0WztpLXYnlHQgtFU4zA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=aSB7bqqJuzVFKARoO8efFRjv0QpbPFFjHfxJNcPvCrw3IYrGsWSh8tFbpuURH/Bhevy8zX/d28re+Jo8x/2NddG/qAd/h4y86W5ZCWcY9s5ZUhzCMN2lII2sAmioV7GYmtNEO5JrGmNysG/VcCBxQK2a5Xq2uL9dhPuf+Y2wG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW8SipWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B7EC4CEF8;
	Sun, 30 Nov 2025 19:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764531276;
	bh=fDk5Jal1lnccSK3N9WMpugaH0WztpLXYnlHQgtFU4zA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hW8SipWAFM+89QshRWlSDcseWRuvJj+jQZUbCa2B18aMOhrANvfUOVuLIpF/EFj0r
	 O4IiNK3mEMvA2d96o51OZMKjcJuM7VNhjDdarUmiBzCaL7dUF00/eDTzBhAciTy3SF
	 HSlc32F59LlvSxNfTdJHZIVv9i6hKv4jHmx13TH8Xz5DHAatiQoqebZ2GJId17yVCW
	 LuUhfthJfOxTSVvT0phgm9L8iWO4IWgLIxdewQwf+l/Ycrk+lB7xfWvhfidGtY5KB3
	 wX3gn2+p9nZzJuwP7yzpmiMnHfX5DvK9/hc9RkGGfDG5t5+q7y1CfG6mA4oY8i3wdM
	 y/mOQoMtaC8xA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org>
References: <20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org>
Subject: Re: [PATCH] clk: samsung: exynos-clkout: Assign .num before accessing .hws
From: Stephen Boyd <sboyd@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Jochen Sprickerhof <jochen@sprickerhof.de>, Nathan Chancellor <nathan@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Gustavo A. R. Silva <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Nathan Chancellor <nathan@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Sun, 30 Nov 2025 11:34:33 -0800
Message-ID: <176453127378.11952.4906451561257794028@lazor>
User-Agent: alot/0.11

Quoting Nathan Chancellor (2025-11-24 11:11:06)
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero. This
> occurs in exynos_clkout_probe() due to .num being assigned after .hws[]
> has been accessed:
>=20
>   UBSAN: array-index-out-of-bounds in drivers/clk/samsung/clk-exynos-clko=
ut.c:178:18
>   index 0 is out of range for type 'clk_hw *[*]'
>=20
> Move the .num initialization to before the first access of .hws[],
> clearing up the warning.
>=20
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __cou=
nted_by")
> Reported-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> Closes: https://lore.kernel.org/aSIYDN5eyKFKoXKL@eldamar.lan/
> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Applied to clk-next

