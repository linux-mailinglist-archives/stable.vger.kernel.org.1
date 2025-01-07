Return-Path: <stable+bounces-107835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E8A03EE4
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ECA3A1733
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC891E049F;
	Tue,  7 Jan 2025 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dlr7bC68"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743C8C1E;
	Tue,  7 Jan 2025 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252097; cv=none; b=HNFuFd39lnw9P/DXsGXAru4o5MVnRjpDATsxsbDc1P1rQJjEUDEht7XY+hXRms74G+4Vu0i+0xhF5wMZWf0jtKek+1I8EbNQZoTdfJi9ffPzp+7C3lq0jl47BJtEGoloHFnkNj5iTPUXjoHOCO5KbWSmpNqbYPgb6DsQQfAEjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252097; c=relaxed/simple;
	bh=rhdZ7OGyC7Ood7ZMdwK/jY/Cve9yhiV6qZLyfcQwRhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spNZNpO2XYQrVCzqVckNe/0qdbLjRaj2oovjkmUDMT61EY06czVTSH+Sb/F53lYSVPyFY6k5KLkNBOoLhrLYKsD+aDQ+TqhWW5De9mout874rcyUZAzHmQrMnKslnliThzmR0DzznYR3bam7/LrDLMiOM8YCkgSeKs1tZ8Rx/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dlr7bC68; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736252092;
	bh=rhdZ7OGyC7Ood7ZMdwK/jY/Cve9yhiV6qZLyfcQwRhE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dlr7bC68M19b4kKjKNgfKoIm81gHCu5tM61jLwSddjDBUw1qUMNzSegR3dIqimwOk
	 iWYii9OBuNqm5Ku7ptwWDY81jjoVj63I+7YA/UIQbtTPFNtyhDcMR06cBMe2G8R3qS
	 UBpQ+u7ueR7OSzJzozljlLHbkqi4r8zRwanHVMkaWogKCT65Uy8qrUKn+BisIA2alk
	 oVGNPWY2NYe89bdZhkXOIpPSDVYHsZ3s+NI1U/BqylxWaip0U2QEB5ihEo896XQJm5
	 XiBs+VVhNI+ETFKx20eTS2vvxE3t6MsbOV0BAtk9XkhkNuIrpbdGBHaLZgtKFoA0P7
	 fCfdTqOKaR9WQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 40EEA17E156C;
	Tue,  7 Jan 2025 13:14:52 +0100 (CET)
Message-ID: <675ce53f-14fd-4a6b-9480-9d936faf3f53@collabora.com>
Date: Tue, 7 Jan 2025 13:14:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: mediatek: mtk-devapc: Fix leaking IO map on
 error paths
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Neal Liu <neal.liu@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20250104142012.115974-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250104142012.115974-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/01/25 15:20, Krzysztof Kozlowski ha scritto:
> Error paths of mtk_devapc_probe() should unmap the memory.  Reported by
> Smatch:
> 
>    drivers/soc/mediatek/mtk-devapc.c:292 mtk_devapc_probe() warn: 'ctx->infra_base' from of_iomap() not released on lines: 277,281,286.
> 
> Fixes: 0890beb22618 ("soc: mediatek: add mt6779 devapc driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Please disregard the previous email;

This series was applied to branch v6.13-next/soc instead.

Cheers,
Angelo

