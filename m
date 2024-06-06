Return-Path: <stable+bounces-48288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF798FE518
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2D1F239A1
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159A3195381;
	Thu,  6 Jun 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xfhWE7cG"
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD516726C;
	Thu,  6 Jun 2024 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672677; cv=none; b=l2P0z4bIF6+wvBUeqwRbv1gE+nhJ3vHHgMHH3ItHF0ygk6b45IrqUGsxLCiIZlm3jD+AiY3FsQuYWu4oFLOdYQvWoJ+GYf8Rms0SySXiHKxkaxkwOJuZaJ4EWosD01QCPuPIEMfAecPCic1MXAYuL2vxa3W3A7PhKy7Y35Hbjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672677; c=relaxed/simple;
	bh=VJsGuflgVuhkEcQET0ZB89PBSUmSGzHB3ghc2Wmgec8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBGXQc+F30mUdtAksbD2xXuwXeTk2H83Yz0dclmfJsUPrUpPrHFep/t0gv4ub/aeDTS383+eriQuduKuaadKPDuKGyLm5uKNoAYyaDboLWh5wvgFX8sbwBuN/Eg7VLhC/11j+KWsOGW8KOZMI8nBd47LdhMw40mXmR9fmTX1j8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xfhWE7cG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717672674;
	bh=VJsGuflgVuhkEcQET0ZB89PBSUmSGzHB3ghc2Wmgec8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xfhWE7cGqHJp6FaBCB/mR3Fq6vVXwZyKdvV85SdYhY1sF1PXdIL02BTKb0a+LJUgK
	 Io6nQXNsqONsLSuB2gPLWMiAUf2YO9Kj5mgN7xDqTCWpyS7mFiivEj1uiH8bSweep6
	 nqG77iq2rRCdiZpTOVS7ay3m77Epewd4Q4LeM3sIWs0Afixnmm88p1k/z+jkckd+Ij
	 yLT0U3J+LpIavfvnUfd8QRmypC4Hwk2BcDFpjxStQ4LGfMn2kA3hb2I/Q+QfkhJZss
	 1XP6Y4ezRjZ2xv5aEJTI4y/8gIAktDsyhVBDbZTSGeWk9Ixb/iA37vlWjwqIPmZSAd
	 +AmLnTxeMx6ug==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DF855378061A;
	Thu,  6 Jun 2024 11:17:53 +0000 (UTC)
Message-ID: <53ca5125-53d7-446a-aeb4-a506549be1f4@collabora.com>
Date: Thu, 6 Jun 2024 13:17:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10/5.15/6.1] clk: mediatek: Add memory allocation fail
 handling in clk_mt2712_top_init_early()
To: Aleksandr Mishin <amishin@t-argos.ru>, Weiyi Lu <weiyi.lu@mediatek.com>,
 stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sasha Levin <sashal@kernel.org>, Markus Schneider-Pargmann
 <msp@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lvc-project@linuxtesting.org
References: <20240606110955.35313-1-amishin@t-argos.ru>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240606110955.35313-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/06/24 13:09, Aleksandr Mishin ha scritto:
> No upstream commit exists for this commit.
> 
> The issue was introduced with commit e2f744a82d72 ("clk: mediatek:
> Add MT2712 clock support")
> 
> In case of memory allocation fail in clk_mt2712_top_init_early()
> 'top_clk_data' will be set to NULL and later dereferenced without check.
> Fix this bug by adding NULL-return check.
> 
> Upstream branch code has been significantly refactored and can't be
> backported directly.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 

...the fixes tag is still missing.

Regards,
Angelo

> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/clk/mediatek/clk-mt2712.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> index a0f0c9ed48d1..1830bae661dc 100644
> --- a/drivers/clk/mediatek/clk-mt2712.c
> +++ b/drivers/clk/mediatek/clk-mt2712.c
> @@ -1277,6 +1277,11 @@ static void clk_mt2712_top_init_early(struct device_node *node)
>   
>   	if (!top_clk_data) {
>   		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> +		if (!top_clk_data) {
> +			pr_err("%s(): could not register clock provider: %d\n",
> +				__func__, -ENOMEM);
> +			return;
> +		}
>   
>   		for (i = 0; i < CLK_TOP_NR_CLK; i++)
>   			top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);



