Return-Path: <stable+bounces-128145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F175A7AFED
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 23:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE443BAB21
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547D7259CBC;
	Thu,  3 Apr 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kdCzqjTv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B7259CBD;
	Thu,  3 Apr 2025 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709992; cv=none; b=praaa90PreZsCuhgqe1NWm0RqiYHyOkrNPNTIOaxNFTJnGqSBmC/pboF6ZFvRq6i90YgeJ4ReKQFaHoK/U6iF8BnpfW22kT3zKKgvLV723gM8gd6JRdSunsoar9pjQQKruZou52eD0AjJRNMwWobTZMEqSiIuz0peMxRa3R5Mxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709992; c=relaxed/simple;
	bh=EqrX3cvjeRiYPY6y27M2pPrYu3nuvoLp/+5WruydRCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyTZRhWNfHpKxS7q9W2f5psBIKBU7uDIdXwk0xCm/wgh+A6kitXlYSlADgBC3ZaTibN6ZgUZLA7zpA8Bs97vgy1rKY7i90ab49aH4Sn/NO28spxgnX9TXHo95rAHs9Bt6k+0tj0xIVBmXt56R1HCuVJBilMsGUcikZSfRIMCdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kdCzqjTv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso6819655e9.0;
        Thu, 03 Apr 2025 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743709988; x=1744314788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6du6KAtTyYabq94pzb2wgfnhQXGYymn0VC+kdziS+Bk=;
        b=kdCzqjTv5KPobFdYYrYUzaCDwir6Qj/FuW+cHs2VVxLOfb/HwYUtisL60uyo1H8Z4S
         a9Fc/J9iwXFyfKTP7VtkMbumgWEVAba0BBrBlFjHYVsNJWxhsxxoLO1cZJchOg9Gk/ST
         jXCbt5YWJD3rvPM5xW4Y1oLRe2gm7kGQsqagCbNJHPVlN28bAnOQYWoZzijoGl72G4KN
         TIsFSrqEB9w7j4QluERje1JP96cjr4OcpfJ1uSPEK60Mp0UJW/quRxQ+3Tw1XGA9/MKQ
         joBRLfG4uO0wedjEKnt3wCTxN4xlif00tIg7e4rsMKqjo84jOXKEcxSnx7GCvf0hzV1M
         rOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709988; x=1744314788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6du6KAtTyYabq94pzb2wgfnhQXGYymn0VC+kdziS+Bk=;
        b=aXvZzG4sebPU99Cd2P4qZzTBr28Tv2tNVNnvIhq3Rmnx6rlJPVo6KVXIgD0wN7Qu9S
         c35NtcV5+WHi2iW90RiRib29453BEnZ8Fn5rNWRMCpYhlWjzFIz6l4N6xSGtpIpZOaKJ
         U2RDh2oddDCl6o6PMam39Tt8fHE+ZMjh8WxezJNHjYPPBzwFFzNtxwsqICLYdmkQoUB5
         P26CENRUzSDJTOYZlgKtdpE+inB8T4l8Rs832IDqafsXSPmSyO/8vEJB+UPzSCDpZgV6
         Y+6AgopbxvUsO7UjriliA9wn0LxMUqs36OELuTR+f+Yc1HMU5EP+dmk9XCpZUgj5c6ky
         ggNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1AsFCFEG4vYMYrcOsEKPVXLQzqesLrAlPbfIA2d7NqL0Gt8Fvd4cdcLSpNUmtd32hYg79xBfDxUeC86s=@vger.kernel.org, AJvYcCV3WQrMhDn8wUOfyKFbdph1Sp62UTswlopnbUmziZcCsJln4NCp9Csj1lGZv8WkSRGpxEnNdFCN@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZ2sWymGv7NUpvi4kpYBwXElR0D61CCO/K4G1II96nkm6I0GX
	hnfCbzOBzdjv7C/Bi0ziLV/Kn9958cQ9ybzz0PQBHoWcCKKt0Ic=
X-Gm-Gg: ASbGncvhyEvAm2js/01HuZ6sgd2DccDqcC0M7NrboxfaFh4ozKQV+lE3TYwyjrxkyy/
	P0OoL7lRpdYMAGJ2nrJb8VAZmLl1f8swRRUUAXN7WYvRfyZqPeBiVKNl3aVXMcFDMqSbgycpt8L
	tFE2GC5pjyNALjLGE/J9/yJgMt7l4+S0WO2LRyQYGbFQkS0kZeekOZYJfJxJKVRv6PYAQPIUxqJ
	CUAOF85IhWFQGX2zwGa6rx59fCtOWHR9laSSHxApxGsruzDTnHumtXNPWRnI1fWccgt/KKKsfoV
	13s5M4CxM0tGbrResLzsqdjm+3kjeo4RsN9ZThGKmZAlYtTr3KgRJLcrd8ksF2MKx88iYOZ3zQ6
	oF5ZxexQlBgt33+E2MvDxOFM=
X-Google-Smtp-Source: AGHT+IGtsE86kbuUK/yEkO0/b3rX2k2QXtMhucX+uUUKI+GteGJnqYOo/i38OP3DqvE8R3eNi180+g==
X-Received: by 2002:a05:600c:4ecc:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-43ecf85f4d2mr3032015e9.12.1743709988208;
        Thu, 03 Apr 2025 12:53:08 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac393.dip0.t-ipconnect.de. [91.42.195.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec169abd7sm30040945e9.18.2025.04.03.12.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 12:53:06 -0700 (PDT)
Message-ID: <22486e30-3b38-4361-a3eb-899103ceaff3@googlemail.com>
Date: Thu, 3 Apr 2025 21:53:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151621.130541515@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.04.2025 um 17:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.1 release.
> There are 21 patches in this series, all will be posted as a response
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

