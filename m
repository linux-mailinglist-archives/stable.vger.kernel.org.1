Return-Path: <stable+bounces-42792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65AE8B797E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5EA283A16
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 14:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7414372C;
	Tue, 30 Apr 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLTaU59C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D95143729;
	Tue, 30 Apr 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487102; cv=none; b=rMxYROda/cpzf7ZloLeNeDfbkGJQsgvTZ2TpQRNU5LUMPRHBiKCN9vcMechS+A0b6UiSUXWdlaCMGPMe0hJhX00XnX72Fk2Wu92loHAkh5tWB9ePmmgoX2EAF6WAejVeJvcHYhzh+TviDNDyv2Z9pOpg06btbDQSiV/ZGLJzoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487102; c=relaxed/simple;
	bh=bzTdtDs6uq6IphADsXZ4QY6nwfgvVlFk/s7vjCxgQdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgOVJtD0boOhadDqgngS/ZBXP7Ol+cgXbijhYpugkUpF2AKB5F/hMqhebn13hvS49PLxCQLUOM8skLsNsI5h9ew44KsGGsL7uuhcuFiZVVN7EgtSnHsUoA8U+ybWCJOrm7LiIUCMB5bhsc1bSTJ2SpVrv9qsVtNV7lU7zF5H12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLTaU59C; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so38982665e9.0;
        Tue, 30 Apr 2024 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714487099; x=1715091899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nswwJp+XtgpDEeEFPSxmDal66v1sosNQopv0aQ+56Mo=;
        b=jLTaU59C4i5gMIinugZzNnMqtJk4MhcEJR8bNUaewYoLluCaHg+gtbE+UKBeEuAE6s
         wtsPLXVfhRbRjjJ9R64wq0sqatrp2+qiWs3GhVEcC8yxgdk8pRUQXMhDc91W0nPrI8Kp
         bgtQ8UbHPptEvjA/ylAP0Qg1F3hbn0T4WbOSdaPpyfIEZyGcZgH4M0yl74NIsTDPvHx5
         liOd5jsMgc92nAROyj/Pqa0TvHeUHvZuEMEv48FM0Prvd6z2XlP8RSkBwlfdn3iGumdJ
         7xAUgv8mdd6dNJRJuRLend8cvs+cNlEXFCQwcSp4svcZI1WyfjN6EdJt2otko7w1eo4v
         gz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487099; x=1715091899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nswwJp+XtgpDEeEFPSxmDal66v1sosNQopv0aQ+56Mo=;
        b=N8XebKcJ8eKIOilKKspOSpmiodHdK7Z62nZ1Hn5S8/fms+VTShjkVJl+TSdtuq5Lfq
         Pq8fRj0/0Lw0tU9kKoyqr1auEdRruM5GQgBuA0rrJ/P8bCPivZnAIIhqLNTikYgKuYAk
         cU2ljbaIa6G7kdhZxM9yN5LuHXDI8HDKirtre0+EBPijQ0nqyyClhsDlqpsdT/Mh+jXo
         9KMxIINjVNnxuJZ9rJmZYdagpKkBfqmh53orEJmaFA83xohUFzfEYgUQu2/xyWIMZ29+
         azziGiJO4jCIAkMcHQnzkmXjBfsKt7cBW/ijpbYvUeBR3uGBBykGiLkkAcVIJxWbwqZZ
         NKPw==
X-Forwarded-Encrypted: i=1; AJvYcCXTQhnbREiq8rIeC7gp0sl1LDljobNbe9XEJaQJHLqyLBclXWGYWIQJCrz6r8cpJ37RU1RUuXnZL/C5oGuJJETD1yMSYVmYp0oKjsamQq4=
X-Gm-Message-State: AOJu0Yzmy0my1NEdFE9KyQJm8AOs9sH5qL4qj3PxGbtvOx6G1dvhCgNe
	IOKS9upwfor9ye05e/UV+qj92Cg6dZj3FAL4VTEyYnsb/ys4Sl/Fw1+THLe9zPM=
X-Google-Smtp-Source: AGHT+IEgkM6JmQK1dD31nUUILleL9TOgcGk86nhHaxDTRpT5KT1hwTLiWes3/Q2exGIa2goEFlhhuA==
X-Received: by 2002:a05:600c:3109:b0:418:5ef3:4a04 with SMTP id g9-20020a05600c310900b004185ef34a04mr3047436wmo.18.1714487098661;
        Tue, 30 Apr 2024 07:24:58 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8c00:20:c41a:2f65:eacd:b1dd? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b0034c61e211a5sm11066547wrt.63.2024.04.30.07.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 07:24:57 -0700 (PDT)
Message-ID: <8ca4ceee-b64d-49ca-8eb8-0dd894181051@gmail.com>
Date: Tue, 30 Apr 2024 16:24:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm64: dts: mediatek: mt7622: drop "reset-names" from
 thermal block" has been added to the 4.19-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, rafal@milecki.pl
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240428112459.2019420-1-sashal@kernel.org>
Content-Language: en-US
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20240428112459.2019420-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/28/24 13:24, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
> 
> to the 4.19-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       arm64-dts-mediatek-mt7622-drop-reset-names-from-ther.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 9628765c4a0eefa9474ef4a0698691a10395a469
> Author: Rafał Miłecki <rafal@milecki.pl>
> Date:   Sun Mar 17 23:10:50 2024 +0100
> 
>      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
>      
>      [ Upstream commit ecb5b0034f5bcc35003b4b965cf50c6e98316e79 ]
>      
>      Binding doesn't specify "reset-names" property and Linux driver also
>      doesn't use it.
>      

I think that's an open discussion item if fixes to DTS checks are valid 
stable backports. From my point of view there is no bug so it shouldn't 
be in stable.

Regards,
Matthias

>      Fix following validation error:
>      arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: thermal@1100b000: Unevaluated properties are not allowed ('reset-names' was unexpected)
>              from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
>      
>      Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
>      Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>      Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>      Link: https://lore.kernel.org/r/20240317221050.18595-5-zajec5@gmail.com
>      Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 76297dac2d459..f8df34ac1e64d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -459,7 +459,6 @@ thermal: thermal@1100b000 {
>   			 <&pericfg CLK_PERI_AUXADC_PD>;
>   		clock-names = "therm", "auxadc";
>   		resets = <&pericfg MT7622_PERI_THERM_SW_RST>;
> -		reset-names = "therm";
>   		mediatek,auxadc = <&auxadc>;
>   		mediatek,apmixedsys = <&apmixedsys>;
>   		nvmem-cells = <&thermal_calibration>;

