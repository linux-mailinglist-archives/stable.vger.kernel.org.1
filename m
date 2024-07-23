Return-Path: <stable+bounces-60899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0693A5E8
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1AB283588
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6A15887F;
	Tue, 23 Jul 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe3Hf/vm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD6158858;
	Tue, 23 Jul 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759380; cv=none; b=TqQChhcuIXyXU04l1pgOgchqy5rgQQ9nqqnnKX1XTF5UB/2oLU8hICizNQbzYGECvBviGrdJ7nfe/bBgTwZoybnIx57YIy7MGQQ9dJVqF+9vh0DvbxtPZZ5ErEXO7KQT1U2J/9ydxLCzupN8EHGNS8JyGky9fal2xW5MMDdi3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759380; c=relaxed/simple;
	bh=4u5YSN2hcaCst37P8Vgp49+pWvdyei/yGShNl4vfJBg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=R0jBc8jsymu8uErRfvxlXnjW+CKBZzfGP9oQk2uxp2oBp6BH/Qbi4vENDkfWCzD469ZdMD+snGMnKhRjy2GWiLIvYzrmDt/fR8nsTOX7CO+B7Y7yuMcLZRJQcls8sj7sWd8811wGtLEXvqBEKcMAJ21sBh9m7V3MYIHAb0986IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe3Hf/vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD941C4AF0B;
	Tue, 23 Jul 2024 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721759379;
	bh=4u5YSN2hcaCst37P8Vgp49+pWvdyei/yGShNl4vfJBg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Pe3Hf/vmwj+ATt3V8Sc17DFMY+tfBKdMhgY52OvNhy+4pPvcpmo97o+lOCqAzIv31
	 KqUz+IeoU9H9mQMF+D9IIHcZ9BqF/ZoKW8LY38CBoK3Y2cHymnAWhQtLsX2AE2V3A8
	 9K8wQYvkUUBzFy0JTM5zVk8Yf/zC3Y60YOH05HI/UN7NHFtx3uzGQ/MNdcbrLSVB1m
	 uLYNDA9K2dNzVAUZRnkkq1vRGOnrmiks5JWe75jLHzujUCx691qYTaJlDJK+MtH7F+
	 APPCCMNS8fckE2tntkGfH8ZGBFknbhiu417m732BHeKvcnl3BGG5khg/1tEM5Gy52P
	 xfcMYhezitB7Q==
Message-ID: <9f94278d72b54071490e8c08aa9a1dff.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240722063309.60054-1-krzysztof.kozlowski@linaro.org>
References: <20240722063309.60054-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] clk: samsung: fix getting Exynos4 fin_pll rate from external clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Artur Weber <aweber.kernel@gmail.com>, stable@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Tue, 23 Jul 2024 11:29:37 -0700
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-07-21 23:33:09)
> Commit 0dc83ad8bfc9 ("clk: samsung: Don't register clkdev lookup for the
> fixed rate clocks") claimed registering clkdev lookup is not necessary
> anymore, but that was not entirely true: Exynos4210/4212/4412 clock code
> still relied on it to get the clock rate of xxti or xusbxti external
> clocks.
>=20
> Drop that requirement by accessing already registered clk_hw when
> looking up the xxti/xusbxti rate.
>=20
> Reported-by: Artur Weber <aweber.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/6227c1fb-d769-462a-b79b-abcc15d3db8e@=
gmail.com/
> Fixes: 0dc83ad8bfc9 ("clk: samsung: Don't register clkdev lookup for the =
fixed rate clocks")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

