Return-Path: <stable+bounces-111129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5F9A21DD7
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099FA3A58BD
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA278172A;
	Wed, 29 Jan 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="ONEx9ufr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5EB661
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157221; cv=none; b=FS9wp2fIwqgDZ+E0qOApmB1C3cWDibMMXny+ID/wMAKCXl0h2RIJmfABeERWkmvZjjb9TBkogmoH1+vFWDCr003jUf0wQkmBXSZUITUaXVncwxZaBpmCMSFkPnHc2Ehy3mFqqLTE/0c4DjWVQflReT62/8BIEMUNLAJWOFbETj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157221; c=relaxed/simple;
	bh=vTDINCiRBxaekMrOb6BZs/h+YziYyScq3RpLY4pL2KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khnDy3/L4+P15OAPjmVrHq1QKmHGmXEPktqbE/7qGuARzViwRXepnt7YOYPt+rkDVXR5+HUhSzZKUhtojVhx0b8/l8loZ8iJkwJ9BDDM8LkRGZrcn0QDiDjVeJxNWf6iFU7Gqy4+LncTdjmDzDMJa9jHe5CtpNsXcRPNLxc8Q68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=ONEx9ufr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso696254066b.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1738157218; x=1738762018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1AbvNPaQMoifFQQCiC1bN6VMg84HcFyt/hG9Cu0Az8=;
        b=ONEx9ufr487GnZ1ePKcLAp6FvMw2SZnlTKVB69Bt+ompszaml0vZHBgpmRpe+nYowc
         6XjgsvWzcpXgK/LPEjRBO/4Soev8IOuoCypUgBx4avwdokRucZcwEEPJ2JmylJEGVZVN
         +xPOxCbiSw9Q7UFXqS/QgFuY1+1NepCsLSk+p3VMXWsWUYqVRyk/0vXctu9AyyQTM9mY
         g9RthbkqnFKxmrhNB3OZYoDMQAPRn/7rfulmbLcdodNN/7FkYOzAbdW4HgCtdeX2jWYG
         Rgie10mIyMEk/MsQdyT0G6X8itlrTqrRE9pRVBuEjxtAre48rL0FkeUdwoeMCzNXgPZG
         QEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738157218; x=1738762018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1AbvNPaQMoifFQQCiC1bN6VMg84HcFyt/hG9Cu0Az8=;
        b=ERjJyDPhXJfuXzwflxu2TlS/3sA3KBiU0nxZgADCBG+tRVNOxu9WtJtdGTb9k/YEPE
         EUcJdOQ3fORqfmrmnlcZRPwF3XSUAA24Ayf/2Fd/Q8tr9sF6mic91nxBgw6QkdVjkJv6
         QsEKzeTsMJt7GmPKLQfksyOBG7bqLdWeYH6B2mRZZgvcS5canRbiqn0lFS4S2YCAsiwd
         8Ro08m7ByR0GFmXWkalO320os3NO9b8/xVRsyNn8stgyL42R2dkQotbJCy3yDsAMp8ry
         dVPhjdJ5UXx2ErGnBT25EDKJk3uz8Nd0XzPCO3VMSBOM+wjbbW1mmkZUC2FMXWkDDO5+
         Lc2g==
X-Forwarded-Encrypted: i=1; AJvYcCViNKTinsdVQSrYvt/LSsPvu8qOX2wZYiI/jAxIeHjSkAHHSPoLgZC4C60wr5MOiQv4QtDW7nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Omp0qxktpeT97f/s+EQ7Z7KDJqraMLletehM8pASrEPk0nSW
	CjtR+gDKtI/pHHTjdNZpbPGiOUcoVU4HLLJbaIaywjKEwbIbpEadSzEIE3NFX8w=
X-Gm-Gg: ASbGnctzGi4s9L7jVEx+E5CGr5Z8XAUzxBjexCUz81Tf9Vrsn1M8v3lYY95S2xmK6Sh
	f753eOWUY3BPZd6GMNgWM168WS9aoxDHLK4dna9xnEtJNdt1M5F70WSvOJ2w8pDCKE0qYB8lGHf
	J3FWvqg08KfMSgM3qD2KByQvKqCa7Bloj3rksZb4xDvrbhd/j2TXH22UuJyDJMjFsRLyyu3bl+k
	3Oki3VLk++7vHtmBaxnoxjZn2bPR2JHslNZ8ac+aNr6r74W5GVya9eT3Kn/IFbK4w3yJTxnwHQU
	jWQTSWOeCBusw389MbDbkhlzejZL+1i4mV/wK6O0GSyBUFMjUw==
X-Google-Smtp-Source: AGHT+IHJI8bqFau56cRcwoE0ggaS89AYsius0QpW1N4tIMlpH+cDPPATglA+S92Nicn+VDCPHuzmMQ==
X-Received: by 2002:a17:906:1853:b0:ab6:dd6b:c337 with SMTP id a640c23a62f3a-ab6dd6bc372mr10177766b.10.1738157216178;
        Wed, 29 Jan 2025 05:26:56 -0800 (PST)
Received: from [192.168.127.42] (ip-89-103-66-201.bb.vodafone.cz. [89.103.66.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbb59sm969084066b.132.2025.01.29.05.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 05:26:55 -0800 (PST)
Message-ID: <91993fed-6398-4362-8c62-87beb9ade32b@sairon.cz>
Date: Wed, 29 Jan 2025 14:27:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION] USB 3 and PCIe broken on rk356x due to missing phy reset
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: FUKAUMI Naoki <naoki@radxa.com>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, regressions@lists.linux.dev
References: <20241230154211.711515682@linuxfoundation.org>
 <20241230154212.527901746@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
In-Reply-To: <20241230154212.527901746@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg, everyone,

unfortunately, this patch introduced a regression on rk356x boards, as 
the current DTS is missing the reset names. This was pointed out in 6.12 
series by Chukun Pan [1], it applies here as well. Real world examples 
of breakages are M.2 NVMe on ODROID-M1S [2] and USB 3 ports on ODROID-M1 
[3]. This patch shouldn't have been applied without the device tree 
change or extra fallback code, as suggested in the discussion for 
Chukun's original commits [4]. Version 6.6.74 is still affected by the bug.

Regards,
Jan

[1] 
https://lore.kernel.org/stable/20241231021010.17792-1-amadeus@jmu.edu.cn/
[2] https://github.com/home-assistant/operating-system/issues/3837
[3] https://github.com/home-assistant/operating-system/issues/3841
[4] https://lore.kernel.org/all/20250103033016.79544-1-amadeus@jmu.edu.cn/

#regzbot introduced: v6.6.68..v6.6.69

On 30. 12. 24 16:42, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Chukun Pan <amadeus@jmu.edu.cn>
> 
> commit fbcbffbac994aca1264e3c14da96ac9bfd90466e upstream.
> 
> Currently, the USB port via combophy on the RK3528/RK3588 SoC is broken.
> 
>    usb usb8-port1: Cannot enable. Maybe the USB cable is bad?
> 
> This is due to the combphy of RK3528/RK3588 SoC has multiple resets, but
> only "phy resets" need assert and deassert, "apb resets" don't need.
> So change the driver to only match the phy resets, which is also what
> the vendor kernel does.
> 
> Fixes: 7160820d742a ("phy: rockchip: add naneng combo phy for RK3568")
> Cc: FUKAUMI Naoki <naoki@radxa.com>
> Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
> Link: https://lore.kernel.org/r/20241122073006.99309-2-amadeus@jmu.edu.cn
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -309,7 +309,7 @@ static int rockchip_combphy_parse_dt(str
>   
>   	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
>   
> -	priv->phy_rst = devm_reset_control_array_get_exclusive(dev);
> +	priv->phy_rst = devm_reset_control_get(dev, "phy");
>   	if (IS_ERR(priv->phy_rst))
>   		return dev_err_probe(dev, PTR_ERR(priv->phy_rst), "failed to get phy reset\n");
>   
> 
> 
> 


