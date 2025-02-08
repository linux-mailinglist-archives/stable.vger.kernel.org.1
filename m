Return-Path: <stable+bounces-114361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D903BA2D32D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 03:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E37816C90B
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 02:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539514B06C;
	Sat,  8 Feb 2025 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i6v4X9G4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A42130A7D;
	Sat,  8 Feb 2025 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738982626; cv=none; b=BR31Gyv8No8LztKPv5+dbkDpnV7LFs8NO91mGRHd6Oph7OPhYgZqEKWcpgq8XS7JNPeSn27hEzZbE3ksHCuDUjI4zkUdfMyEDmBuQIONGH3SYe8DNwGdAIf4v0BpfJPJgRl11yz5AzjbC5BDrYwiUgTGbX6KCLooElG/c91lvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738982626; c=relaxed/simple;
	bh=1yRZEVogkK7XQDQbmp2eIIgRmMSs3XbAGXlfU20Jpt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0FZrBf6fi7zRMNY2Zjjm801pv/MfbDtPbxOKH/7zL1eBoXPlVZ7ZPb16NggOSfrcTW3n7VXee90MirWVdb3SxN5YxmfPTA+hQvjKM+MSTjou2/OEzfS1yjlLQEeIexe44QTK1xo660iyZ54q13/bYfLVvDDnC2tl+v3qnqBgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=i6v4X9G4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436249df846so18165215e9.3;
        Fri, 07 Feb 2025 18:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738982623; x=1739587423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Q96w3VhI1OyM0iRg0iyUAghNaFOtqrMksaCmsOLmiE=;
        b=i6v4X9G4gF1qmtIAFAxOzVIeeIUnKUmSIo3yKjBG2Q1Y/331lBbj4XHhVhL8ircw8Z
         MKZm1EtpsMSsFt0iwoHd3Wwu0sIEFWDLmHPx+IgibpIJm7sTCz8jULTGrlSC+HA7V6NW
         uue1Bu1Lrf3Kpo1z65mPGDU3+4hWNO4k6TCOsUJtr9HCdYB2S3/LE90DNNhe1swFN3Hh
         lngRf4MTkhP8nIPCkLyc6eTmhbu59NtNsWdXuVnMpKl/r+Tj/w1qXETOcZ9fjn4EhT72
         HDAdEpXXqDnz91c7mZwe7x/tCMYQDVnqNCEbT0NrnAEt5qv4Aacuv4eoHjiPw2wNRPRS
         NU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738982623; x=1739587423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Q96w3VhI1OyM0iRg0iyUAghNaFOtqrMksaCmsOLmiE=;
        b=dfRdN4qTC/PcX2/11bhT9uN9nWK64oYTujJYVar+viryCHVa3BZywx4ZdZNjNeo25o
         Zgz049OekaEBmdaR72kpxgmlrhjvlZQB0z+2xEQTkRFVyMuSewTeAf4O82Y9bEGa8v6G
         MRDbn5MpHh8Ufb/ozeaPSEL75R91n8TV7HO6MDq+MAiMsfC2Ly7K/qebt6z0xg8GzJTD
         Od+A98nRrIq6JObgkML0dHUadDZo7s9rs6+actA0KS9b3DKngkz8AQkjem7cBV3dS4zH
         9CYb0LF8Xzw+zd6tStpj9o05eAVYS04cmGrgNidUux1PDHB/4vdAwrihNtEeEy8pZSvL
         Wljg==
X-Forwarded-Encrypted: i=1; AJvYcCU8yS/nuRVl6HVSAQcFmkEBVLJ7qGNK0Nci49JXVjtL+JAI2pggTniVFSOYOm6TiCNJy6gh40g2Q5jCnPY=@vger.kernel.org, AJvYcCUuhgNDeBhHbyus6SKFDkLlqwqHq7ZaYseBg7nis4ykmwRHYBlk3FemiiSfC1AqALq4D9IJ6V1B@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GfVoHbZPqZT2raMLwVIcanKXXMKsDIKAVC3EdI5hydyTlfSW
	ybf5CaqpKBJg9Z1DCGSi3xa3O0j+z7fEnHyiIaOM0Dkq3oF4tC0=
X-Gm-Gg: ASbGnctvhLFSuiXYIVQOxOuJkfteqSpvIXOEVjFg8rhGwuyTqGdoI1hwsY+3wHKT722
	p/FoVxkGDT2KSl80VEOKb9MIGN0NpYu2VsUeaMNXCrm6knS+VXpdyvetiLLUXLOassMe3+9qeq1
	6Jd+UXd2Bo+lY6p86Qih9X0gaUY6CB12ufT9fGyBg0D9f71v71we0AhiJWkBTPhgC2UIjP/djJ+
	ArFrRME9EHyNVwJu02dBVJmKCnj5d2Cg0HAJy7pFvqrrOBYsg9eWvm3CXPG08q4IADAcFQMZNhh
	HnthZA6tlEIeX+1w9uxv+/oC1MuNYvg6FFhWmUdt/Chm3HGGIYD/AKt9jUKBc+yQZODo
X-Google-Smtp-Source: AGHT+IH2AAb7mKYtGgCklY/ZnYB6GdOFP0u3p7Xp7Xg+7rObcCTVDk9IjDCBVs8nQ0emmciHy27c0w==
X-Received: by 2002:a05:600c:5492:b0:438:a214:52f4 with SMTP id 5b1f17b1804b1-439249c3836mr36026495e9.25.1738982622819;
        Fri, 07 Feb 2025 18:43:42 -0800 (PST)
Received: from [192.168.1.3] (p5b0574a7.dip0.t-ipconnect.de. [91.5.116.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfc87desm70748545e9.25.2025.02.07.18.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 18:43:41 -0800 (PST)
Message-ID: <201f2658-68bf-44b1-9092-7b8119e91f9b@googlemail.com>
Date: Sat, 8 Feb 2025 03:43:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/583] 6.12.13-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250206160711.563887287@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250206160711.563887287@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.02.2025 um 17:11 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.13 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

