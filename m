Return-Path: <stable+bounces-196601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D819C7D436
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 17:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0DB3A943F
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C827B359;
	Sat, 22 Nov 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXsEmhWD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7520DD51
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830666; cv=none; b=s51utTfEeZJ1/e9xCxi9wmf1WfWLhuHSss1w9XUWwZLVbd2k09Ji1KBh6e8RljSvoeAup5gVqdbx2D0EMq4e5v+fwPuMI/aUloaP6MdKPMBO1Lz81H586H3qJaK6X9vaXpn+e1zrAoSubnyVPKGz4/2S7LYGjbb2x+2ApjDHdgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830666; c=relaxed/simple;
	bh=fs2lYtrZNV3KZp6UxTLBsAy379d9ku/fF4PuWVPTvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+UpR+ZucftwLhY6vWoFwH8CEJ4w2THHOeNaGawUcY9gVMezPcuVfDXk/5h918vT3hXi/PdcGOJctkhTD59wUuiYtWlQTAjoQ8ICfhBp951bJABS5KrcvSlw7PPnq972aengFSUq25+Qd0tFmpEes/9QMCAuPDDghH4XxyfOdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXsEmhWD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735ce67d1dso476245766b.3
        for <stable@vger.kernel.org>; Sat, 22 Nov 2025 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763830663; x=1764435463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OUGVg+qzpVBZ5O3rUCAbdonkufD8EHD+NzO79QMHoU=;
        b=fXsEmhWD2XiLpIH11kDYwnJYjHjdzCYtuIdJotQjZJPcCjQFe2i+CaFzMj8WsDrGf+
         yqlyPgQLfQPwf6osXOmVO8eD2MUMU2i5sRPaAq2gt2DjNp9CYK6yeubPnaebkvigoedE
         Kh58hsXm4cOQJgRLhNlG88jAFbXbATecsJf7vxyL1Qzh78kW/qnxB8hBinD4UKZp5tyQ
         ZXK6wDZ1UV6RJQag1TO6vZHhDUIPpX5PjaDjAopZ6IjMlgfOgbaR9L4A/z04hf0eEInJ
         TruIBMZWjUeJCXQhxuBsMT437hdLgnQ9m9wSt124W4PieCEXJW7qRYCQvRqpbxwp1m4J
         jrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763830663; x=1764435463;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OUGVg+qzpVBZ5O3rUCAbdonkufD8EHD+NzO79QMHoU=;
        b=qljefNRCN+mRhzpBX0r05WwO15goKcPu2P5omNhqADBTuBO5BYoH9/XdYrcfocMo+T
         NsJPcP3rLx/cvfEzsscFNKhQgGjSYEgs+KjAE9bZYa3BxF6UOsYPTN930ddCFaHyrPLi
         RYCdUtrdo333mveAZUa2RPskFo4hIwjlQerj8qtQ71Z3IpjmL7VD3BJdwjqd+OZ9irjM
         +L+qnfisjL/mEupfYtRX34e0yprAw36u/O3bgAB1ujY+E5wX4DTk+m9FhXtV6t6C1hIx
         ze6saT83NkZduZdmPhm/bdOjrR8cmhaOb4VRksWxls7lLjE0QRSRnTl7X3zIfR5vh+dt
         hDsA==
X-Forwarded-Encrypted: i=1; AJvYcCUxkoxyF9ELtk0JCebAv5zLeX4o7kAlslvqFm7PE/cuYVVAKd3SH2aWuWGJ8La0qUK5hqHpcx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wcv1L2MiGiRVnd9IzRkcWWx+32XfSmSbPXGVS70HoXq5aIz0
	we1mob5b8Z2M+rl/XbgWD2gkrVWdfWBlASjMGeMuJQAUyw2j042od03k
X-Gm-Gg: ASbGnctUVBq48UtaP8PA6vbZfCKzG0Ix+a6Gw6mJ8l5d4PUwnDSKTx3cbBgcV6SGlr0
	WQXcc38p7lYQ2cPtiTShjwga6mx3p1oNwzbY7z3djYy/VyzZeRcswOh49RIbfBXjsFGmrQQu5AA
	7dV90fw/iObT8K8yUsfyhmbb6oxdhYEekO2b8rX3ARdp6ODYp0+PTaFsuTNo72xrhxO5oG95gII
	Oj6KSOWLm+mmXo70F7TcW/rW9SgV65JRBsPskUxJXu/QMN6yN2AbQ8vFTkpyP+q3d0kBfBu4m/6
	UOv7qJjTTPiQfSytKa9WwoBdm3YUk5JSnLQGU9cuLFHZuo/WOr7ED5IqKNPB2jD+h4CaHOac6ID
	VWKwKB2YqgGlHtBROj/7IKA2QWONvZIxkZv1ceJWAToGlNqlGlKO97uUZQFgInapOcr4E4HdlM/
	H016H9WYP6atmPIAix
X-Google-Smtp-Source: AGHT+IGQR2K+8oB9rl4LdszDdgZ1zAbDRGTLWKw8HJ6tmpfxZcxiuNPJ2kqkhKPL+e7MCjq3lfauqA==
X-Received: by 2002:a17:906:f58f:b0:b76:26bc:f95f with SMTP id a640c23a62f3a-b7671244c1amr573051266b.0.1763830662444;
        Sat, 22 Nov 2025 08:57:42 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7654ff3987sm782530866b.48.2025.11.22.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 08:57:41 -0800 (PST)
Date: Sat, 22 Nov 2025 19:57:41 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, piotr.oniszczuk@gmail.com,
	rtl8821cerfe2@gmail.com, stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Message-ID: <aSHrhbt29k6GJB8e@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	piotr.oniszczuk@gmail.com, rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724004815.7043-1-pkshih@realtek.com>

Hi,

This patch was recently backported to stable kernels (v6.12.58) and it broke
wlan on PinePhone, that uses 8723cs SDIO chip. The same problem
appears of course on latest 6.18-rc6. Reverting this change resolves
the problem.

```
$ sudo dmesg | grep -i rtw88
[   24.940551] rtw88_8723cs mmc1:0001:1: WOW Firmware version 11.0.0, H2C version 0
[   24.953085] rtw88_8723cs mmc1:0001:1: Firmware version 11.0.0, H2C version 0
[   24.955892] rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
[   24.973135] rtw88_8723cs mmc1:0001:1: sdio write8 failed (0x1c): -110
[   24.980673] rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
...
[   25.446691] rtw88_8723cs mmc1:0001:1: sdio read8 failed (0x100): -110
[   25.453569] rtw88_8723cs mmc1:0001:1: mac power on failed
[   25.459077] rtw88_8723cs mmc1:0001:1: failed to power on mac
[   25.464841] rtw88_8723cs mmc1:0001:1: failed to setup chip efuse info
[   25.464856] rtw88_8723cs mmc1:0001:1: failed to setup chip information
[   25.478341] rtw88_8723cs mmc1:0001:1: probe with driver rtw88_8723cs failed with error -114
```

On 25-07-24 08:48, Ping-Ke Shih wrote:
> The register REG_SYS_CFG1 is used to determine chip basic information
> as arguments of following flows, such as download firmware and load PHY
> parameters, so driver read the value early (before power-on).
> 
> However, the direct IO is disallowed before power-on, or it causes wrong
> values, which driver recognizes a chip as a wrong type RF_1T1R, but
> actually RF_2T2R, causing driver warns:
> 
>   rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
> 
> Fix it by using indirect IO before power-on.
> 
> Reported-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com/T/#t
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
> index cc2d4fef3587..99d7c629eac6 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -144,6 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rtwdev, u32 addr,
>  
>  static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
>  {
> +	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags) &&
> +	    !rtw_sdio_is_bus_addr(addr))
> +		return false;
> +
>  	return !rtw_sdio_is_sdio30_supported(rtwdev) ||
>  		rtw_sdio_is_bus_addr(addr);
>  }
> -- 
> 2.25.1
> 

-- 
Best regards,
Andrey Skvortsov

