Return-Path: <stable+bounces-160225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC41AF9BA2
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 22:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC7B3A6AAE
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508020B81B;
	Fri,  4 Jul 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNqyguPl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BC145346;
	Fri,  4 Jul 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660264; cv=none; b=OtaLG2OqPA8GLXWAghyHhdlB/a0qqN7A4NVXmlPz3YOlCjOiggk+LrlOZQmcu+xxCNqlmOLEGhPotkQE7AeV/4FJNhHKX+mExmwYlj+Jfc/CZO1OQVk3Xl/ek6piukiqi2ZXIf6slUxtrb7HMUTBBugkhUOCA7ZShBMPx/J1giQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660264; c=relaxed/simple;
	bh=ToSSYeda+QvMFhFJXYbRjh6o30tOZEKbemwVCqAxu2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nt/rH25hWz2TgPZVGrvLoslQ6tD5vLScMwpO1nhMvgyxvXIq3QoDQUCAzJtwqUo8bNUNHHbN1h3KuOwaVBLrI1CwAoPIEY/RHjVJq5TfkQterDZruDS4T+4OgUDrjnwfPx71vbDxNcVOgDIn2knI3NJ2ktEtfm/PwLuDAwcXSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNqyguPl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so2342310a12.3;
        Fri, 04 Jul 2025 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660261; x=1752265061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NcNlVgWf+PG2kdLWT+gkGkxQYjH5Ivc/a0PUOrXHeO8=;
        b=bNqyguPl0xrE1jzVA7rq5YcxgyWlEQf2RtB+mjVSLcuqZB8QVzbfpL/fFoM7moqWaX
         mw8hDQj9LlJzu9RLWTH3gOnNUxfJyBqWqg+hOPeSK84+zIakS7+ZxUlwa36m/ZkrSItT
         3tfa0ezzUdR0Ip3zHg/dGhvCBDcdP2YpSJ8yPx3npfRY4C00yMSaDb4rOStnuY0dqdwr
         3tvOdJO6m1Dt5eqSnB033i+ZnqxK4ZV7v/vrHrb6Ub/wjwko4Nx0DWHzW56q46yGWBlo
         jzEf1HMRUv9LOUhpOK9bbaMoIgx0AOF9/52DhuiXs59PXo2Su6A+U4NgagQYypKIKQ0E
         N2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660261; x=1752265061;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcNlVgWf+PG2kdLWT+gkGkxQYjH5Ivc/a0PUOrXHeO8=;
        b=vXBCx69gNrQJx7wTWtG7Mb09BE5mjz97PTcHkIIcEa9E4I3gziVgr9XQcVrunvDbL2
         e5bQCxxdMWoI8g90i6L5vNlC2BHemI254WLBg2qguHJs2nj0pF2KitTDcd4YOHHZW6av
         4CGnq1l/n2X5Nvtzs/yZowFPWoSDq42ZVGo1CAkr3WltbbQyUqOs/onAoXTLkBr2uyLw
         En7GBdxFdSP7JoQui5cg6fgoOc7s0Fjq/N40Ud3bQQ3QENjyacAPEvfULxsPrAYKVVBT
         7t+xwYrsatZ7sC5LX3JQgD8KF4DJszIpStKgbQbc+BdDwH3rSOMm7/UYOQIlJBTEO5M0
         D3tw==
X-Forwarded-Encrypted: i=1; AJvYcCUKh+zR/XcwYYIb5Ju9tqD9hotTT9lYQEQJwTf7qs+EtEF1x4Q9HIbatF7eE4tessCZYl5E77hx@vger.kernel.org, AJvYcCUV4GME6p7yKyxLp0J9tIQtOotbrEJPKoxXdFQcP+L4eBP5bOJbUNSPpyIRGun4b1SzcoBHP+fQ+19vfxs=@vger.kernel.org, AJvYcCUmZ9d0SzoM8ytScq6zTsALBDmb/sStjB8kdFfcpbyhaTpjh8sIEveGgfp3EZ9ODx0wiogBOAV0@vger.kernel.org
X-Gm-Message-State: AOJu0YznPwzc46byVTZBg+4Hj/NCpRMDXG7dYrIAgj7frzRe5ZEAuAeg
	QqeJ7/9YVKPICGN9cpWMv11VY4O2qgT4tOK1cptEFM4CwPtdW4xu5kRo
X-Gm-Gg: ASbGnctmQJGpDYQ9amilnkQH/DzSE8A5DDmo03bncRqyByvW1SHL3eRVH1Vu41/xo5m
	hZAM5Ur0IgtOF0PQWcNdw658ReQFQuZHzF8FjYi2WDplaNSGqP7mYyaUc42j8K+9eFFYgQd+d9k
	kdgrgEn6DVkYZavJEkroTqF9Il3l2nD9W2+fbf9bSOAeMJ68iXJcqoj8QUAguJ014Esa6JrU1b+
	TvstyAeSvcgEpe/ewA6Z61jXbAHwStTLfTuSnIIMCxdPaV6zTIl98lGmDBqERs4x+/IRS5Vf+rH
	/gxKx7FA+LGE9GQtHBp21inIUszMOpkpHP12BNVAiQIPge98Qp0OxIcws6hOQm2pmFBvKek3rNL
	u+m460rpRSujlGrRyBee5CVclrCKFu+Vn7GjpsvC366vmQaZ+S+jlMhyWoMJaNpvjLdeiuYbmfc
	L50Il8kDKY080fR/TDhrbiLccHsbYxQumWiJxf
X-Google-Smtp-Source: AGHT+IFSIskvmIhHXw4zIijBIXv/T/NVh58YZFyd5CYdip6AxgaDFxcLpextRGQE/hA/eaElTXlVgQ==
X-Received: by 2002:a05:6402:2354:b0:609:7e19:f10f with SMTP id 4fb4d7f45d1cf-60fd1f8af77mr3569937a12.0.1751660260953;
        Fri, 04 Jul 2025 13:17:40 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:7a00:656d:a8a8:c9d6:8d1d? (p200300ea8f2f7a00656da8a8c9d68d1d.dip0.t-ipconnect.de. [2003:ea:8f2f:7a00:656d:a8a8:c9d6:8d1d])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c791bsm1809126a12.42.2025.07.04.13.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 13:17:40 -0700 (PDT)
Message-ID: <0310186d-dfc5-406f-8cd1-c393a7c620e8@gmail.com>
Date: Fri, 4 Jul 2025 22:18:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: realtek: Reset after clock enable
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.07.2025 19:48, Sebastian Reichel wrote:
> On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
> stability (e.g. link loss, or not capable of transceiving packages)
> after new board revisions switched from a dedicated crystal to providing
> the 25 MHz PHY input clock from the SoC instead.
> 
> This board is using a RTL8211F PHY, which is connected to an always-on
> regulator. Unfortunately the datasheet does not explicitly mention the
> power-up sequence regarding the clock, but it seems to assume that the
> clock is always-on (i.e. dedicated crystal).
> 
> By doing an explicit reset after enabling the clock, the issue on the
> boards could no longer be observed.
> 
Is the SoC clock always on after boot? Or may it be disabled e.g.
during system suspend? Then you would have to do the PHY reset also
on resume from suspend.

> Cc: stable@vger.kernel.org
> Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY clock")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index c3dcb62574303374666b46a454cd4e10de455d24..3a783f0c3b4f2a4f6aa63a16ad309e3471b0932a 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -231,6 +231,10 @@ static int rtl821x_probe(struct phy_device *phydev)
>  		return dev_err_probe(dev, PTR_ERR(priv->clk),
>  				     "failed to get phy clock\n");
>  
> +	/* enabling the clock might produce glitches, so hard-reset the PHY */
> +	phy_device_reset(phydev, 1);
> +	phy_device_reset(phydev, 0);
> +
>  	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
>  	if (ret < 0)
>  		return ret;
> 
> ---
> base-commit: 4c06e63b92038fadb566b652ec3ec04e228931e8
> change-id: 20250704-phy-realtek-clock-fix-6cd393e8cb2a
> 
> Best regards,


