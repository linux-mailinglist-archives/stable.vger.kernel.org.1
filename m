Return-Path: <stable+bounces-114918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65AA30E3A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3081626ED
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674E24C675;
	Tue, 11 Feb 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cpj4GfBA"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302826BDA1;
	Tue, 11 Feb 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284250; cv=none; b=JClBS3rzVrPJkndk9Rf9xRneC9besriuWGYdzdBQ7ppmq7kztehkVAo5arzhu+VILw756/8sr5coU3NSmuDbFqWYPFtMdT7bSIK9HF1oWk8rgEEGGOnskY3x6CvB/8PEeMWqzHwOy8hkQFacsmDOsTud+aiPd0CymzcEgXIL/k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284250; c=relaxed/simple;
	bh=tbjejdOouQ6QCsqtz77VNBHHu2oCAUL9pu87VbKonQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhzSJGRmuJv0COK8MogF1uuBTF0O8KRjI/3TyG6/pXHm3qazZ0RSTTWb+g/O9Kv4MFwNpMDrOm5nHpi0U9n/5cErFKOw2FcWANtpw0pohCfEmegKO1WuqYnQ7h2Eb6D6QRGv7eFIMfH453I+kk423YcoVr/i4ZHsyw4jlYt3A1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cpj4GfBA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739284246;
	bh=tbjejdOouQ6QCsqtz77VNBHHu2oCAUL9pu87VbKonQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cpj4GfBArV/d+/vj523v6D8xuOowB6481kI4EOBzfLzYPJFUOo3fboXCd7xUwJkqK
	 4EWkZ6iXu1Qoflc+N0T6g6OEqN9DbAFgtSCV19eGUId+fy6YtuK7VxhJADupJtzHRs
	 GHtv3tK4zMxd8yilOuOSkuXqksXQPEr8dDbuRLjZ92M3y9veHdZKB5XlK6WlTbtG8s
	 SftwxK6M2ZFN5c5NywRyuT7oI2Bnm5+KThQDPrsI/pRvGh5SktlRjWjWdRECGlJ7pw
	 BbJYr6cKkAF6o+k18eUTShluGHpb95XHJOPcPG2sPiXm8DClYHtFzs7Fw98qC170du
	 K1rjmsawSlQDw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D32C617E0EAD;
	Tue, 11 Feb 2025 15:30:45 +0100 (CET)
Message-ID: <6350446a-f253-4702-b1da-02e2915a3d30@collabora.com>
Date: Tue, 11 Feb 2025 15:30:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8188: Assign apll1 clock as
 parent to avoid hang
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Fei Shao <fshao@chromium.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?=
 <Trevor.Wu@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20250207-mt8188-afe-fix-hang-disabled-apll1-clk-v2-1-a636d844c272@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250207-mt8188-afe-fix-hang-disabled-apll1-clk-v2-1-a636d844c272@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/02/25 18:41, Nícolas F. R. A. Prado ha scritto:
> Certain registers in the AFE IO space require the apll1 clock to be
> enabled in order to be read, otherwise the machine hangs (registers like
> 0x280, 0x410 (AFE_GAIN1_CON0) and 0x830 (AFE_CONN0_5)). During AFE
> driver probe, when initializing the regmap for the AFE IO space those
> registers are read, resulting in a hang during boot.
> 
> This has been observed on the Genio 700 EVK, Genio 510 EVK and
> MT8188-Geralt-Ciri Chromebook, all of which are based on the MT8188 SoC.
> 
> Assign CLK_TOP_APLL1_D4 as the parent for CLK_TOP_A1SYS_HP, which is
> enabled during register read and write, to make sure the apll1 is
> enabled during register operations and prevent the MT8188 machines from
> hanging during boot.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4dbec3a59a71 ("arm64: dts: mediatek: mt8188: Add audio support")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Changes in v2:
> - Changed patch from explicitly enabling apll1 clock in the driver to
>    assigning apll1_d4 as the parent for the a1sys_hp clock in the
>    mt8188.dtsi
> - Link to v1: https://lore.kernel.org/r/20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com
> ---
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 5d78f51c6183c15018986df2c76e6fdc1f9f43b4..6352c9bd436550dce66435f23653ebcb43ccf0cd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1392,7 +1392,7 @@ afe: audio-controller@10b10000 {
>   			compatible = "mediatek,mt8188-afe";
>   			reg = <0 0x10b10000 0 0x10000>;
>   			assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP>;
> -			assigned-clock-parents =  <&clk26m>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_APLL1_D4>;
>   			clocks = <&clk26m>,
>   				 <&apmixedsys CLK_APMIXED_APLL1>,
>   				 <&apmixedsys CLK_APMIXED_APLL2>,
> 
> ---
> base-commit: ed58d103e6da15a442ff87567898768dc3a66987
> change-id: 20241203-mt8188-afe-fix-hang-disabled-apll1-clk-b3c11782cbaf
> 
> Best regards,



