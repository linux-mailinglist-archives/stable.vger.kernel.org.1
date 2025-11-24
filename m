Return-Path: <stable+bounces-196789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890BC823F6
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E753AB74E
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0414F2D7393;
	Mon, 24 Nov 2025 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBqozLPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E62523EAAB;
	Mon, 24 Nov 2025 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011713; cv=none; b=imicSH5OFIq/gjgfO6O3+7Qkamby5sh7fmRCIRzXQ/2/Qf82seyBeGSN9jZWObBQf6LZKwMtxzE7XEME/CZTFxPIKrL4svswCWCQyowAogrocBUs5GeKyu1f+36L5Do05juZ9KvpErAagA41QR5SQp2MqV3qz8/oM7izXb6w1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011713; c=relaxed/simple;
	bh=z2i6xOwTgPt675KWrdd6Uyxx4S+UvK5AI+S6QNfhulw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGwEfqm0p+CeqpPBPNh+uu9DrVnEIUX5ByM9ZEWKF/j5bxyk4IE7fRjEXA5hRu1x61miEC9VqaWtCQavDAezk4QXaKcbZKdsAzIRiLVutgHRE5CzMp5oNOxbqBcDWyA6lusdhuG12cUvnzRw44S4dwL1HH4m6U/fh4Ahos7wNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBqozLPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBBAC4CEF1;
	Mon, 24 Nov 2025 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764011713;
	bh=z2i6xOwTgPt675KWrdd6Uyxx4S+UvK5AI+S6QNfhulw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBqozLPmxlmrLmLwoHPmIeJbzBT1W42aAhoz8uVQkL8oDZCTg8kuX8yPWXV3FTG0r
	 PgyoXBXIdHvDdMDXM+AhptN29OVavW+JwDuvM0UpUC3r6pA3GmAEgNIx2Y2iPZvI+A
	 IYPPI1qMf6hZkzpO27NHwDae9GOCtM/sJngfkQ5/zst9jd1br2E3eA7Tuik6uVAUDW
	 LU+yb148QsISx2EaNbL5pHY9cz3kPg436m5CKY5Di2g82F9CuL298oREj0j/Cz382Q
	 roqgZAHpcOufueqJD6uXZbERw14S3G8nVUwMzHYEjRVjECcLZ38vpBqgJlW1MQYQID
	 gCMg5kwMJl2ig==
Date: Mon, 24 Nov 2025 11:15:12 -0800
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, stable@vger.kernel.org,
	Jochen Sprickerhof <jochen@sprickerhof.de>
Subject: Re: [PATCH] clk: samsung: exynos-clkout: Assign .num before
 accessing .hws
Message-ID: <202511241115.0E974A2C@keescook>
References: <20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org>

On Mon, Nov 24, 2025 at 12:11:06PM -0700, Nathan Chancellor wrote:
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
> 
>   UBSAN: array-index-out-of-bounds in drivers/clk/samsung/clk-exynos-clkout.c:178:18
>   index 0 is out of range for type 'clk_hw *[*]'
> 
> Move the .num initialization to before the first access of .hws[],
> clearing up the warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
> Reported-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> Closes: https://lore.kernel.org/aSIYDN5eyKFKoXKL@eldamar.lan/
> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

