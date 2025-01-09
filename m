Return-Path: <stable+bounces-108082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7E0A07458
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884FA188ADE9
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D011216610;
	Thu,  9 Jan 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ekonyUTi"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708962153FE;
	Thu,  9 Jan 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421166; cv=none; b=H/ykvESeyTRJq63euFsJjB1i1Z8w0aBkekF4rz9Rbkb+tH2oZgCKpmqRq2j/Mt5LVjU5rw3/vQ2huIlNLkWfIicf+70oDKVOb2QyKkbr2prhW4ZYeEUZI/domEO4gcOATAqasypYKKu0dVJcM/MK/LjgeU0S+bWRN/CqNa8KH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421166; c=relaxed/simple;
	bh=haxvYvRohcK0Kj/7lVEpMZ4B0Hxu9JPmmPdR3rjr+HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEs0fv9G9BD6JwoXsOU8tmQ7vvNUgdpPakzgclJGQOYPBd7A2+5L6EvJKFYLOJnznBstjBkBmr7z1cjYPqdX3uz18NfJz5x1jahezdRSLuX2gA+HkYnJ9ZAc6v089WFsBj5duvjMlokBfIUDpvOoSVuvLxG0HHxNbiMpysGwP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ekonyUTi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736421161;
	bh=haxvYvRohcK0Kj/7lVEpMZ4B0Hxu9JPmmPdR3rjr+HE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ekonyUTi6rGkKlzE/MCBrzH/lpCzQX2KBYMb7HMG90ccnbfEL8TYT4NGGC6vXGCor
	 7HxTIooPlUCVU1F92dkwK/BsUrA/nOdau0Rl4PvFn6uwHGIrZWprRe/O6cBhHz2cW5
	 H2JbJv89UfSq+fpYaH+6a9CyliHgmGwn4jn+mgM405jZSy/L8rq/bnjIGl/CbOE3Qa
	 EpTNCV18yX2MMK7yS+d4GoL6t+bT0fyEHb0d9TSD1v9LEeN1ozkVaxPL2pQWRBMYvb
	 ZPCOA1nrQE74nrInt0+jXNgLwV9GdaXT4Cl1nhijvp1XMCmYat0WYufLylS/aIMynz
	 QhDlbPF45jqKw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4084B17E1569;
	Thu,  9 Jan 2025 12:12:41 +0100 (CET)
Message-ID: <31cd9b95-21e0-44a0-9f60-cf84b2b66e6f@collabora.com>
Date: Thu, 9 Jan 2025 12:12:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: mediatek: mt8173: Fix disp-pwm compatible
 string
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 YH Huang <yh.huang@mediatek.com>, stable@vger.kernel.org
References: <20250108083424.2732375-1-wenst@chromium.org>
 <20250108083424.2732375-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250108083424.2732375-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/01/25 09:34, Chen-Yu Tsai ha scritto:
> The MT8173 disp-pwm device should have only one compatible string, based
> on the following DT validation error:
> 
>      arch/arm64/boot/dts/mediatek/mt8173-elm.dtb: pwm@1401e000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	    ['mediatek,mt8173-disp-pwm', 'mediatek,mt6595-disp-pwm'] is too long
> 	    'mediatek,mt8173-disp-pwm' is not one of ['mediatek,mt6795-disp-pwm', 'mediatek,mt8167-disp-pwm']
> 	    'mediatek,mt8173-disp-pwm' is not one of ['mediatek,mt8186-disp-pwm', 'mediatek,mt8188-disp-pwm', 'mediatek,mt8192-disp-pwm', 'mediatek,mt8195-disp-pwm', 'mediatek,mt8365-disp-pwm']
> 	    'mediatek,mt8173-disp-pwm' was expected
> 	    'mediatek,mt8183-disp-pwm' was expected
> 	    from schema $id: http://devicetree.org/schemas/pwm/mediatek,pwm-disp.yaml#
>      arch/arm64/boot/dts/mediatek/mt8173-elm.dtb: pwm@1401f000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	    ['mediatek,mt8173-disp-pwm', 'mediatek,mt6595-disp-pwm'] is too long
> 	    'mediatek,mt8173-disp-pwm' is not one of ['mediatek,mt6795-disp-pwm', 'mediatek,mt8167-disp-pwm']
> 	    'mediatek,mt8173-disp-pwm' is not one of ['mediatek,mt8186-disp-pwm', 'mediatek,mt8188-disp-pwm', 'mediatek,mt8192-disp-pwm', 'mediatek,mt8195-disp-pwm', 'mediatek,mt8365-disp-pwm']
> 	    'mediatek,mt8173-disp-pwm' was expected
> 	    'mediatek,mt8183-disp-pwm' was expected
> 	    from schema $id: http://devicetree.org/schemas/pwm/mediatek,pwm-disp.yaml#
> 
> Drop the extra "mediatek,mt6595-disp-pwm" compatible string.
> 
> Fixes: 61aee9342514 ("arm64: dts: mt8173: add MT8173 display PWM driver support node")
> Cc: YH Huang <yh.huang@mediatek.com>
> Cc: <stable@vger.kernel.org> # v4.5+
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


