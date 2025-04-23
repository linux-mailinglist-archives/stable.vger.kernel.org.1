Return-Path: <stable+bounces-136476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690DBA998A7
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 21:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C811B86923
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBACC28EA76;
	Wed, 23 Apr 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="V3QU37Tz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD325C834;
	Wed, 23 Apr 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436992; cv=none; b=CXvODuqa9O8794QvNz8zENIco2LbA83y932OQ4JjPDVIFNIQvIIyOGY8wL86iX4QWjJSkjQziRTp5krYvxhwthWsl2omfzQzBrN58IJ35ciWSM1CLPsxDgPOpm75gngkNZ4FCk/zJnVxcD7/sGHfYDQQewaUr7WGMmKkq6Ozo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436992; c=relaxed/simple;
	bh=F8Lms9WWcqbi9UKLZVM3A4yA8hdTJR3kmzCK+DkmcwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJT71R8vCV3aozqLgrQ+4sSRXN5H8c/EiFBwChHDkR3pLQPROOJeRxthDL2cTgqlOLdQhgskMITo0KH5vXTLzkHIDzuI4+E7kymW2PESSrCSQDMh1DjPQ4xs12Y+J239ZXHT2+H+VBK95UG2i3+lvrZGV83SdP5fFI+yPXZcrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=V3QU37Tz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso1488485e9.1;
        Wed, 23 Apr 2025 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745436989; x=1746041789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J13/1f/4bpG2OkBxc41bbyLlaHxbEughKpa7FrPZ83o=;
        b=V3QU37TzhticWADYrKgkY1nsiFJqQatyjyNptKiTiNmqbaOGZ+B9jM9sGvz2eG8nvc
         3NtGGfn9U9noTSSX6wfZzslF4ad9mS5Un+BSkb/XmyYJMxcSIytFLT4fesEafyRysJNk
         QzXVl/9m+izTYha2Hn6OKVuxs8Y30Hmhl0QuHLit+S7RfR0OwiVSgRtzSpyrqy4pWeFQ
         BE5heJyXEfJlxVbSrWBkF6elH6cMikRazdLf6RYJ+qr/mS/LPyw3av9Wu+T8fOu7SnaR
         R0qOhla84wDzAeZDFzXCUjj3iPhg6a/QM2nyFDV4EY9xLONDj105DUcIHWxw3HJhS0/Z
         s6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745436989; x=1746041789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J13/1f/4bpG2OkBxc41bbyLlaHxbEughKpa7FrPZ83o=;
        b=pQd3FiL8iDCPB+zfxAzH65OLRl14K33IAZVFMcs6SEjRfMSXxZZNhneDQspiWLSCim
         Flxhz/+Oh0F2dJfLNF2HBEJlcZBW/LLEpcUOjEJ5CH6AJHLADsDT3wc6ZrcWgEhnLj7w
         /oVRCY6iXPypRra5GrKDtfvb9Owi1JyJc3O0G1s2V7u7u4wCBD3ZskWMIIoMJ3sOqJ7h
         Ibos9BKgJBJ5amuwJUAxzr5C4h8Onox1O32eJhAm9RpWAtV/hLNWUOVAWiaBd7yUcwGs
         c/NVky7u5jP06xXYWER5GPHMqhhCpHjTohLCVjY1yB8wCoeVZpi9ohWbBKMenrNr22JI
         6KXA==
X-Forwarded-Encrypted: i=1; AJvYcCV/MTOwprAbjDmDlBDmTu0uH95pqmIlxQcXw3nNRoE+Wmk44AtQGAp3lqKX7ioJEiZmWkJxTuRq@vger.kernel.org, AJvYcCVzkyI8d85XADqfFpHCtz/7up0XwEi2bl9jn3fyrQbdiucmCLD6MXCpZAMsHa+vOdA24v+h00TzZZOU13s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5BOAFAU1nFSo3pz0uEZikFgjMz5P/vvOFeMjgj50WuauA5OL
	dOzPbY0M59im1td+ZoTr9qw0qq5jHDX8lXuoHOhKwC+vhlytWSE=
X-Gm-Gg: ASbGncs7bQln4UPKdPVSWIjEximhP9aHYC2UtdWyKUI+ZPIsoiSUxkFwCNtpS+HOyRd
	oiWlaWgomKSF+72KFJf/6xr1AvoXWA9VFEo40n7aNuIEHVkFhfgdZN2O8Ce3IJG1CEu8nAdvCym
	Esz6vc1FqDjGCSughewazlYag36rjjOfcqntsubhi7nfq9Xd1vFHJyCzIBXsFFlSNQRi6fywQvh
	rte4YCV1YwZaA4ZDD5iPfgQTCIiXhVHk3LtaaefZgJNyr2dntkguQZd0x6+SqfiCzcxyAgOef+t
	p2UJkYq5dmg5cXzCP7fDAa5+VyGhBZbPeEETqo6iF38w2IMMIwS+RNgidyXNBT5B1bP6xymXPxd
	ocArnNKZSaqBhPp87SA==
X-Google-Smtp-Source: AGHT+IHXrAT5Ym8Wfi9Mv5P7WsaXUZaJTk3APhWCaUhtxOeEgA1taGsSqysoypMvC/sD45jNiPBpgQ==
X-Received: by 2002:a05:600c:4e8f:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-4406ab99521mr172733875e9.11.1745436989205;
        Wed, 23 Apr 2025 12:36:29 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac758.dip0.t-ipconnect.de. [91.42.199.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d369f1sm35725315e9.29.2025.04.23.12.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 12:36:28 -0700 (PDT)
Message-ID: <0f058a7b-72ac-49b5-8121-92a189e7b82b@googlemail.com>
Date: Wed, 23 Apr 2025 21:36:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/223] 6.12.25-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142617.120834124@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.04.2025 um 16:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.25 release.
> There are 223 patches in this series, all will be posted as a response
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

