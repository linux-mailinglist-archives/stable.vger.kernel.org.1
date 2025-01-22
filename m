Return-Path: <stable+bounces-110194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9DA194AF
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 16:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA3163232
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284D2144B1;
	Wed, 22 Jan 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S1rnwkEK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C689214226;
	Wed, 22 Jan 2025 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558464; cv=none; b=dImubD2hY2rSrr7+4n0BgzJeqqo+GxfKxCPqmiKQy0xTTQct38sbZ/NZsiOJ3SWRBHfgaWtpz7Iga0Y9ZTOlEUtdlYmgPiv5cdL1i4SSC73X57mM73pIPZTRKY6VapdseC7aC/h+3e0q4KSxkxtND2v6oBPYYfL1IfGMm0ufaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558464; c=relaxed/simple;
	bh=DHP2J8XZ0Yw8nMyu9kCS/XAFXBvYiIwgCfWQx3cVQgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXWNnVD4bsCp5jcYHTde8pm3wdkk69QmSJhLXLlbnIa5apCWWhMPDJTAbzhwCMGkFkSlO0eEbmxEwJUu8PoZVq1ZXqdUNDslAY+cgnTIMHj5+FglUnf9LryZj1VOXZL62oC95CmihUQgJreV11gqm5NdEiHjPDVaChwQgb9HXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S1rnwkEK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43626213fffso6649335e9.1;
        Wed, 22 Jan 2025 07:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1737558461; x=1738163261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MaTimNfRI0T0HB8tXAjuRGpTIWGEQknAsF8nU3K8A8k=;
        b=S1rnwkEKZjQ8DSEWSYvmoYReW6ZoDTkLik5zJKa4zZOgF86/Sb0U6cu6DoddQb+c5H
         bbTEmsx4VJaIiHLa6Lx038oCONT4SFqNVf2h4sViildF3EfzR5IF48dvOhrhCHXRxWI6
         rZV1pj9qCunikPV2EMWDcDzZldvmV0C8yZNTnIeC/bGFMThQkBBzbMh/chhEgBzymrGA
         xFiMQecEcnMYNxuM83yB1SCTOkStL+Rw7mYuM4TZFnlANqz9AhvA50PVSoJOtZ+K6hUt
         plP7tFxkGPn6hfdi9YJauiEMw2js2HQmbslPrrl6bS1nfOFNilnZ+NfhAuTHB+S1+myB
         yQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737558461; x=1738163261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaTimNfRI0T0HB8tXAjuRGpTIWGEQknAsF8nU3K8A8k=;
        b=EUH/Gje7OVg4Ue9O7rOeaKZBFpi1fWEODAcL0CZoKZ7tEMz6TkyOHQrF8Y4QGavuNj
         u/Udz3mICCCBnwkQ24CkkDNffrl3v2i2qYKWMLOHwQk5u5SxvniFijocY0/siYdE7kFe
         QoMyQTDab/pfBOOKMUFY3trHYpOJBJJnsWZ1PTj8NUQT19yH/p8iBAs6sGV6FGN8h417
         hNkCVSICVT5lAkzQgODAfaUoa2YcSl/CIQFviSEhirS3CaTYG7d+9CxuamQ70NIEUdzW
         LpgY7Zrh6p0iDpagCLF3fpHARPGFnhbRn3edmAedbyRLv5GrVs/PXx3VNOuLh04v7Im8
         Jjew==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZXOIxcgsSbNBS7STwWMYiaW0nfBQLJQP9Psf5EpGyhzD3Fo3Wfc3viftQhjDFYlgFJRII+k4@vger.kernel.org, AJvYcCW6oE6G25hr0DIFM0DDnKcoF3S3/zhxjkT4LCZytYKW+YZj27ulh3P9g1L9PfhZ4W4j0g/bZyi7b/PwCDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyflFszAnG10FyJGFTs0zsciYmYBKdR7kwX/kvbvXG5ZuYc8P
	cq1TmVAqMrOvvJDpqjhp5mf9+OlKfj61TCNaUW4nBQ4/OtZwNJM=
X-Gm-Gg: ASbGncsT0YptWKCCytJ7VDaWuLJrSAegPs64vDrbw9hkW9ALMtqwZxOs7+1ljHZeH+B
	RPJevSW4uYIj8dgbjCMBlDi0wn1os9q5e494qKVnORpI+eNR7um4uarfddWWZeGPnFsrGkjSEJ/
	J8n/9M4EESHJCWSZh2xaEav62mA6WXdCBHHgrviojFeRpgTwknjnUNRP+xlsYFOam9T+uAXppg6
	Y0+dLAwGmRAf5uYwFBbxcQHdg3Ao7IzEStDHiflmEhs5EN4I/aUhSEWdTPJu49OuNQ0ZXpOqke1
	mR95cdxXIbtoAnh6hXuc13/OEr8RqleBec4YVr65PX1k0x0=
X-Google-Smtp-Source: AGHT+IEIKbkIRLYp5myGXq8eDJly5JbN6mshFFEn98fe+1seNHprdQpW0B6bkbLl70rpHC3nMxfmrQ==
X-Received: by 2002:a05:6000:2c1:b0:38a:4df5:a08 with SMTP id ffacd0b85a97d-38bec542ba4mr25939146f8f.22.1737558461113;
        Wed, 22 Jan 2025 07:07:41 -0800 (PST)
Received: from [192.168.1.3] (p5b2b407b.dip0.t-ipconnect.de. [91.43.64.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275556sm16821801f8f.72.2025.01.22.07.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 07:07:40 -0800 (PST)
Message-ID: <573e476b-de65-41a1-8c66-d5f8ae61637d@googlemail.com>
Date: Wed, 22 Jan 2025 16:07:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/64] 6.1.127-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250122073827.056636718@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250122073827.056636718@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.01.2025 um 09:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.127 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


rc2 fixes the -rc1 build error for me, thanks! Builds, boots and works on my 2-socket Ivy 
Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

