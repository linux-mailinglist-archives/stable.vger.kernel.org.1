Return-Path: <stable+bounces-48286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500628FE4C5
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F8FB24697
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B419538C;
	Thu,  6 Jun 2024 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="coLYoUY/"
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AC2E639;
	Thu,  6 Jun 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671364; cv=none; b=BJZHTxGLDpzUJ3zevS8WN6L6OYNJ4ZMN5B2tzh7mw2BlkDH49EcJ3nLiaM/7MClz5Lc8KuqZ10Bzv5I7cb4ozeFLkbKtORfxxa2OdHYJnendn3+Ep4f0UxkcdiP/qyKFZuaeEpX+sEzrZW8qDOJMq8+PDCqQQaR9DVH0DYPxmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671364; c=relaxed/simple;
	bh=YgzEeSRn9SjAt09HXi0BbwcLxwl/BddzUZDCbdf390Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+vEGfW7jPllxyuYtN3b1xvMaWBSSW1z1JvQPdcu7V7TENkDVQbK5zX52oEsoqWyfFSmJJqyk6w9QXIa0XZCHJx8aqUD73APKoIYCLo3jekP924dJCqFdNB8RUmlCGESP87U1DO3UK66obPlmxRiHGMVXo4TeIfUCCBbp08+iWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=coLYoUY/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717671359;
	bh=YgzEeSRn9SjAt09HXi0BbwcLxwl/BddzUZDCbdf390Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=coLYoUY//s6wa9jmOGWFcJFmosndgvzmNXIMsqq9uXubkcn9Y1qJ0Q3Z54G0FGq8K
	 gC8CWJ+K/bcyFPUO8lGMxg0HkqTaa5Q9uuYSZ2nZz4osYQvM+vsUIjoncFnfsH/fpq
	 8yJKrhqg4PQ/fPAQwsugMQLJCSITrYhQZ+hOtGR61zKVYBp04JgvyIozX4yEHZ0g4C
	 mCdZFludSE6yxpSnpFOhfP2WQmeKC30KpTQo3YSFLd8dIHOhnnUqPJUl2sYg//vJkU
	 mSK+ExpYi1wQlHdMFZGr+kFGQgxhFqax5RkLoFzfjQ58vK8qMwtiS/cNVkhgnRMXJo
	 mP5N6WKI7TCfw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B29EB3780627;
	Thu,  6 Jun 2024 10:55:58 +0000 (UTC)
Message-ID: <07664707-6482-4b17-91fd-251cf73cbee9@collabora.com>
Date: Thu, 6 Jun 2024 12:55:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10/5.15/6.1] clk: mediatek: mt8183: Add memory
To: Aleksandr Mishin <amishin@t-argos.ru>, Weiyi Lu <weiyi.lu@mediatek.com>,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sasha Levin <sashal@kernel.org>, Markus Schneider-Pargmann
 <msp@baylibre.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240606103402.23912-1-amishin@t-argos.ru>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240606103402.23912-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/06/24 12:34, Aleksandr Mishin ha scritto:
> No upstream commit exists for this commit.
> 
> The issue was introduced with commit c93d059a8045 ("clk: mediatek: mt8183:
> Register 13MHz clock earlier for clocksource")
> 
> In case of memory allocation fail in clk_mt8183_top_init_early()
> 'top_clk_data' will be set to NULL and later dereferenced without check.
> Fix this bug by adding NULL-return check.
> 
> Upstream branch code has been significantly refactored and can't be
> backported directly.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 

There's no fixes tag, and the commit title shall be fixed, you're not
"adding memory".

Please fix - after which, it kind of makes sense to add this to stable.

Cheers,
Angelo

> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/clk/mediatek/clk-mt8183.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 78620244144e..8377a877d9e3 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -1185,6 +1185,11 @@ static void clk_mt8183_top_init_early(struct device_node *node)
>   	int i;
>   
>   	top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> +	if (!top_clk_data) {
> +		pr_err("%s(): could not register clock provider: %d\n",
> +			__func__, -ENOMEM);
> +		return;
> +	}
>   
>   	for (i = 0; i < CLK_TOP_NR_CLK; i++)
>   		top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);



