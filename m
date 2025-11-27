Return-Path: <stable+bounces-197537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DEC9029D
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B80C350D92
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 20:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE090314B7F;
	Thu, 27 Nov 2025 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Nih7IYqi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAFD306D37
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276616; cv=none; b=RFkO+5op1Sc0U701js0Lu2ZzXf4ilQb6k2pbtSQBznvLCYmuZpLH67gxbqdJ1LjEMsSPp11O21o0eYO8DFJv9H6ar2P/5LNp+6itKXP8l+tIXL5cL/TaLV6P4btndHu9Ws6y91eGcPDHLl+nUeOjW9qRCKjpy4REdRHlplQMXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276616; c=relaxed/simple;
	bh=mCeCg4D52988DKNuF//3bxsktZksu3PPAezgHB+YepA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRmqrxrLKF8s5fwuBGCMRp5E2ZPKQvOFBw7LB3JHy5Z3+bqE35ZE8yS8eA8wZnxo7qoXMMT9wHXTpLwrn3Rqyw+29OxCcwzHxagqsydWQH49cC/lmcsV2zm43NCVT/QDfXEPiVZL08x1ZDVpq7evx7U0QvB4gyb7uDpKrMlFEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Nih7IYqi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso720921f8f.1
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 12:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1764276613; x=1764881413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8Xdso/vJUzrnGDGaQ4k94sfnF9stKJvelC7TfngjEY=;
        b=Nih7IYqiub8YAeJbySkEMOE+kx2YyWz5w+Ng8gEwFoZClv9qZAZWi8/BL+ci3fiAdh
         yLpVFqeFF/aCcYK00qwc0qEfcxsJK6iBiuyWk6hMHCKF0IuHtCsufCb7Uergjr9sLfoD
         ej2K47CA+EWZwap7M5Q5VNQVuwbH1xQERHFhYJV/aRwgcvSS5daIayO5lFmMxIFZs1uk
         f78qXju4PFVcu90yTXAwStjKcJWt8wGs9fWyjBrYq3T3YRPYP7oN7LXOi6MmMevuaaN5
         FtIx7uv4VQV/wkc4FyHNCq8MTGgmhudFDqVqL2Cq6Vwh23WA1g/En7BeoOzBkFwapTv7
         H1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276613; x=1764881413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8Xdso/vJUzrnGDGaQ4k94sfnF9stKJvelC7TfngjEY=;
        b=un+CktDzBcq9DKJtBgMHdCHsihIfo+zv+zwirNi+zSRhuo33wqRh/j4zE00pnTkRQJ
         jC8QlpB9jKesD68f9W1K0fRdxktMqn8uB46iM/NwhAL+71imqjSzDeh1FZ50drwxR6Pd
         q5atPg/k1+K98gN5RvCL/ega2L9uC0bx6pNdE2MR/nirS20adYjliwYjdS6KWF/PsRK+
         9qXW0Fw4lTTt7pzd1Uc9NS3/aoQHoskXF49b8jpW2gEQUZpW9budkZbS8Wow+op3MFbq
         L0Nz2JjlsS5wu+tzx7gaYm3VfEoT7fC6wz05B0CyRdYUDp7mURb2KEv7PGteyglI4i8N
         nIzw==
X-Forwarded-Encrypted: i=1; AJvYcCU5oKv6SWJw9a82Po+eArZOi/mXiD7Lsi/IljWQaxGZDA3oPm8fA0egN+s96+5EPbyGHv4g3s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvOGKokFTQ8CcFOMcnT2ZAx/WTXWFdV7u0sc91U+sNYBMwhAO
	va/lg7cLYCBVfE0+E/SPS4lCp7cVpST92MGl3EYcNcMdHlw6CPExBRc=
X-Gm-Gg: ASbGncvrGtdOpc0QZt3C1D01ZM8Tw3ckci5y7ETV5F7fqcwASBHstGcbZ+Y/qW8wvQE
	sMlEwzr6kt28nwB5KiQZSn+AJxw7GF8EZP2QvWzo98WZuwWZD9TLdA2ldgmZ5twufpFW14ZogZB
	h2K3uyY/7hyFKQVn5iS6n/UZYEEBODRJ0WG3FT9hHaIO/p1hEHKQu49EsqP+HVkKSn1oPBvQ6A8
	10B0rD1gBn3R3qxc3KWFn5gQ39e8YyhHXba1oEDeiGeCmg3CcEJJ1z1tUKpvjzJH+/y/f4bzwxP
	vc4uzlQIwQTOzVWei624uFzEZlddk3S0J+vpviAO+BRpo9dX+CkdHND8hF2h8Mxtx8nEsH7InuA
	m346Sw21Vo7a/c2fipcgSvqVS6xfUuWiXXKdfuQeBd1/asXxZH2ePJJ2lBTcUnlZILKmGtC/8VB
	fY4WurvKALiYI3GTCECWu4r9+4k0ntHpTKgOm3w3nW+Jm14mFLYMUuqELSm5I0gJFQygJMEHOnG
	Q==
X-Google-Smtp-Source: AGHT+IFqZufCO58HzmBVCsCFsx6gg27xqeFrFAClvB4ROtH08IZI39LROMTEKx/loElPsGPOmbPwMw==
X-Received: by 2002:a05:6000:2309:b0:42b:2fb5:73c9 with SMTP id ffacd0b85a97d-42cc1d23bdcmr26975766f8f.58.1764276613165;
        Thu, 27 Nov 2025 12:50:13 -0800 (PST)
Received: from [192.168.1.3] (p5b057472.dip0.t-ipconnect.de. [91.5.116.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30b8sm5555753f8f.7.2025.11.27.12.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 12:50:12 -0800 (PST)
Message-ID: <75ad2d09-c09c-4cb9-847a-c5a33f237f40@googlemail.com>
Date: Thu, 27 Nov 2025 21:50:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/113] 6.12.60-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Sebastian Ene <sebastianene@google.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>
References: <20251127150346.125775439@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251127150346.125775439@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.11.2025 um 16:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.60 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

