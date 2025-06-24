Return-Path: <stable+bounces-158435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DD2AE6D2A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23591BC0A5D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98014223316;
	Tue, 24 Jun 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HKrWAUH4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E54AEE2;
	Tue, 24 Jun 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784448; cv=none; b=ny53XUoXHy/7lemz0ox+YA+mqmbQAPDWOL4SGNRSGqv072WcaVRBBjnVddYlWXNr7PWYOqxGtaT7drt+76hp3fKBQa8C+EbgFeJPlzdcwQTUeo3u74dRMwG3MvBHU1rPIl3P8GaskhY959cWjn+djkDl6ZTjaQnRFq8MrnDSLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784448; c=relaxed/simple;
	bh=rMmIIm4TINIxOqut0X/Io6lixllqSqzkHQn2mUnABFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtILmgNEzDIIlldrpjyrwDKEyR5NssOSku1a/mkzJhU0PqwktFYsfEREdY5LogXWeHmUCoyeWQrgYypx3WHwQjyLc+D5W6UkBr7JpvSiWap2kdZeICxeo1j+oWXjCYvgLYHW6sgtkTfFp6ARl90Dqi+DiQZhn50T1D4yp/aN3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HKrWAUH4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so56877f8f.0;
        Tue, 24 Jun 2025 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750784445; x=1751389245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te/STPrSTRQW9WE5N0wxDGPRRy2utQtxA+HuKmrb5X8=;
        b=HKrWAUH4uBO8KqGhhDJRixugpBOJ/DgzzTXUOKU+D2VRa/67+G+uW90LcsGn6ERMfX
         2lnTOKNeq2T/sqk2grUbkD4G1UirU/F1KsB0MaNrnkGWqLfIdwO4upZLI9zWtJaI212l
         Ga8XjrkWIYzyZejhlUjgUS3YCbUoUXO1WlbG4pTtyQpwGtCQFcljo5SnQd1MlWTWHIp5
         c9WLzZo5wQWkTtoFe0Rsfq6oOOPmHkgkyim+B9BE45j5d6xrZZRpQZqMJJ8UdfvgN/G3
         0sMzqNmcwQocL+UGOid0jTPZOnUroSfVY8vBVTsoaJVHSMDXrWUG0415efeSGHQq/0Ez
         kWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784445; x=1751389245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=te/STPrSTRQW9WE5N0wxDGPRRy2utQtxA+HuKmrb5X8=;
        b=MxcszboN9TSpH5OfcG7Y2s5mgB9w0wHUNlXZl3rgmap2UP16x2Q+vTnLCzz99SNZ4N
         aF9GOF1/qpbXYs77rR6mMHV2qHbOU5OG+q58xlXCUSgOqhZ/Ct2slvK41QXcdhFWYxeq
         riruwOG/swOqvb0fYDj6kLeI7IlZ4PaOxwZHx0TMUJI0apuOklwqEkUXnEvNpmqoJDfO
         Ksmaz7YQDmZgH0FpN28rqh4Yku5zOtGaJwsuVFK86RwkVy6QRnYS5rXV8ff4PceBHJnK
         Ul5GuWaY7/J1g4RQOdNEfeTMLXgexloUe/H72B67aIeSvoA0z2vsUdJUAA19/WQaWAqZ
         MKqA==
X-Forwarded-Encrypted: i=1; AJvYcCWpdoACWH5xh65xIl3VASOQxUwutkmyqWgGA64TgM0xnXEFyQb6MprGUyi826+SryGJpo5sFoFe@vger.kernel.org, AJvYcCWziNWGiN+Aq9yB2kFAjvKlzxZz/RffyT1Rm0Ulc4eEyhBRbNGE4+1n4IFmk8G5Ea8WxBYoSZrrpGEe17o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0rxHpAcn6RW5wrtmX46N9pK1ez7yc5d65SNFdYPzLZckMuwzo
	HQn11Z934+jExPkV4DHpI1DvTWPX1U7bRrSW/O1tBKQ9QoAdY4N/YLM=
X-Gm-Gg: ASbGncs5K1Ogf+rRr0uBO2+6W554aXvyOKHNzgNqq9040f7XkIhuN4VI2UAf9mKPBn7
	QRNJE82dMJ6NZ7zPpFOR/tmo7QQ/34EYt6UkI7tFfrdq9OYoLUOAtbtFGB2WmiG0Fvte+l3h9On
	o7dLdK9xbVXFSr1Ox3X9Ddok50T5Z0OGrkkrQXKVtPWfuE0Avj3jNch2oNpanyvPInDXoOE3joi
	vpJWYxlQxeLWJqNtOsgw4DVSTQDHh+zQnpCuzBxSo3vWLcquea8mnO32KgsRkNRlFM3+MSEJKRF
	G1kfMUSYPprjKAVk08WBV4rDHRQ6uiesfVbyxIn1r5F2JoVfOdEf/s0EPIx0TDCXmCfzVJNIvNg
	x+pyTy0ItMuW/WPCbx/g3JKfSz5Agkjzyd8lFT1k=
X-Google-Smtp-Source: AGHT+IFUfVerv6+pnCu+sN8dHX/BLfNsI8/p8b9WCDAx95/po6UN9b2bRri9xUJSyTn8llRJAFZcgw==
X-Received: by 2002:a5d:588d:0:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a6e71b86f6mr3784089f8f.4.1750784444740;
        Tue, 24 Jun 2025 10:00:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd47.dip0.t-ipconnect.de. [91.42.205.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e811039csm2338554f8f.89.2025.06.24.10.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 10:00:44 -0700 (PDT)
Message-ID: <1010f821-c1fd-4096-9f69-49a91336eb56@googlemail.com>
Date: Tue, 24 Jun 2025 19:00:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/507] 6.1.142-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250624123036.124991422@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250624123036.124991422@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.06.2025 um 14:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.142 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
server. No dmesg oddities or regressions found.

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

