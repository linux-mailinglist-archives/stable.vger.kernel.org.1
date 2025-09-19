Return-Path: <stable+bounces-180657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7AAB89862
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBD318990AE
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE84247299;
	Fri, 19 Sep 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="hoIpC+2C"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B48238D42
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285931; cv=none; b=kdaIxQbSVJHvhzot5R8LBTpB4SRGKzUJtF88MEtgUs2+UMExpQ/CBapFWN6/ikEUVT2t0gNnUricU/F5MUIrPr/CJ4nHa54qTmfV4fD+gLrb8jh4xgg4fxm9ieeBi63/7Y13M/04idYjilcDmBLXf5IkicP/oFKcBbs12T45h50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285931; c=relaxed/simple;
	bh=j1nrrg0RmoSPwnhr33zQNmy3orw+WYtn3PKmfZ0ZitA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pv88P0yDb+9xTwZmLnvtRxuwKi/T/CKoQRXbycac26JZlWcrlSpN3PXx0AVqi/0RXw6EvnYCHiR6bqLoiikM4M9Ng/jDxSaLZTAEd4VoZLMpuHk8SzV84/hlr96LiZHHg1vEGujzvUxfQmWx5bTI2tNcwC91MO5ncP5chOBRHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=hoIpC+2C; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42401f30515so11427065ab.0
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758285929; x=1758890729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzmxpHATkMjGkSRbploj9vHGhBjXSr18jt0vlLNWxVI=;
        b=hoIpC+2CDGfDh2bQX+NgtClGBX9fISR85UaQIDk1AA30oWRFAx++l5RMZpvxF+4i6r
         SH+qzqP6Y5BJONrKYX62TGu7nSuiHgv4o2a/HRIonB5Cybkez6V1a2CG0GolPgaWBnuu
         /ok4UTMvoFwYI8aBMmD8o3abeFFG3IV1Ppy9dprcWec8lCQmbEZTVnw6B7xAc3agjtZh
         FFX666HR/F+5Hxlujo+n2a4tk09wX25lwvYMeC98uLREuZ9FZ27qnFrsW+sgXFkg5EFG
         UF6lzVvBhLm/4nMPiUxQTlS+25v+xH+SAmppgIBtAa7RP5gdZmAXSoQYcp9tfwNDTjEr
         Zp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285929; x=1758890729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzmxpHATkMjGkSRbploj9vHGhBjXSr18jt0vlLNWxVI=;
        b=m+6HluyjfDsyd5SHl8DnDnFfbCX5qYJJ6zSm5llIEjylbZ1oeZ4Ue1MCOWDAEKROrA
         VlV9D0EqAO2ThyN+GjH+pY1XTesfGRsNJVREfLaX1B0OnpKgTi6Jd2Xpvy8O+D/Ka7ff
         8HU4AcGYnlDwz7c7qAlVEMnbrroUzktACDf2ljssZZJa81jnfiBKnKObWnFFY6fri+Os
         M+UWpO6/r8/rMolD/HSz2kzOB1sjRNNrqFz3L51heWHall82GSp0d/AfW7AC5sF3svDh
         8k4Cr1ylwNL87H3axhJVEB/1E0ILyv3jy302FhXc58RBtAQ+uamhDp56X6zucjtqYpNm
         0MTA==
X-Forwarded-Encrypted: i=1; AJvYcCXQknBGOwiYgE3b2lDSt09H2Db2hVvEd1V4+6W72We7KyP+jSO7XmuSn/7eAc6T5GIktUTquNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/j7wE5oUwHu4hQrWhCFzINqQb8xeEJ2okQr27HF3ZBJ8WefT
	mRkNrsSQgCXuHzUpjhJNbPe5qVVJO9qs6aqKFe2SPttKA9Ip06slCCzwXHjO2b+cZuM=
X-Gm-Gg: ASbGncsgb/ifzVd8+tqrhphFc3RxOa+MnfmNnzJ3eiMYV6iTOQbeD/pQEFmcsrdsz4J
	hkdXc1Hbj70Ly0jwocr71or+FwWz0IGJD0AHCJoWHhI28Ih8Q6v8qlRDow3DLwoAoJB8SoNMG9L
	/eTdJmWSUrhwir2p8Th5t2N2isP+PuhRdTESaInf5XIS39JsbVxAAg/aCPaPI/d1+6Zb87H9e69
	H//9kADCONTNMOSuqqOskFqq3SZBBccfSGi5R3N5Rep8yFpI3RsYO1eAPQD7TTzKSPDmZ45ZsED
	IEvcTv64MzcUzY41NnxbksQ0xFi/5ojuRcclI/hAv7b5G7aFuRM7EAoaWtxTR6C8H1B886cjJ9O
	7hfNrVxBPauKtMKtHWWGXI2Yp5mPjDEalGBSuHmYLtq73vvxGKKO0Ob6hY28ddg==
X-Google-Smtp-Source: AGHT+IG8i/FekPaVIyvtRw3Y0kGumJTcRoGw86iT4JN6uhjg6+GmBG475UFLhSqVtvQD0Vy0Pr6cbg==
X-Received: by 2002:a05:6e02:4807:b0:40a:728e:85a8 with SMTP id e9e14a558f8ab-424411d8b1fmr94994315ab.2.1758285928583;
        Fri, 19 Sep 2025 05:45:28 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d53c6e38asm2113770173.60.2025.09.19.05.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 05:45:28 -0700 (PDT)
Message-ID: <4037b00c-5ae4-4874-bb44-56e850bf142d@riscstar.com>
Date: Fri, 19 Sep 2025 07:45:27 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16.y 2/2] dt-bindings: serial: 8250: allow "main" and
 "uart" as clock names
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: stable <stable@kernel.org>, kernel test robot <lkp@intel.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2025091753-raider-wake-9e9d@gregkh>
 <20250917115554.481057-1-sashal@kernel.org>
 <20250917115554.481057-2-sashal@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250917115554.481057-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 6:55 AM, Sasha Levin wrote:
> From: Alex Elder <elder@riscstar.com>
> 
> [ Upstream commit a1b51534b532dd4f0499907865553ee9251bebc3 ]
> 
> There are two compatible strings defined in "8250.yaml" that require
> two clocks to be specified, along with their names:
>    - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
>    - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"
> 
> When only one clock is used, the name is not required.  However there
> are two places that do specify a name:
>    - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
>      compatible serial device is named "main"
>    - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
>      serial device is named "uart"
> 
> In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock
> 'uartclk' and 'reg' for nxp,lpc1850-uart"), Frank Li added the
> restriction that two named clocks be used for the NXP platform
> mentioned above.
> 
> Change that logic, so that an additional condition for (only) the
> SpacemiT platform similarly restricts the two clocks to have the
> names "core" and "bus".
> 
> Finally, add "main" and "uart" as allowed names when a single clock is
> specified.
> 
> Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
> Cc: stable <stable@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/r/20250813031338.2328392-1-elder@riscstar.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This fix looks good.

Acked-by: Alex Elder <elder@riscstar.com>

> ---
>   Documentation/devicetree/bindings/serial/8250.yaml | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index 2766bb6ff2d1b..c1c8bd8e8dde6 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -60,7 +60,12 @@ allOf:
>             items:
>               - const: uartclk
>               - const: reg
> -    else:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,k1-uart
> +    then:
>         properties:
>           clock-names:
>             items:
> @@ -162,6 +167,9 @@ properties:
>       minItems: 1
>       maxItems: 2
>       oneOf:
> +      - enum:
> +          - main
> +          - uart
>         - items:
>             - const: core
>             - const: bus


