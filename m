Return-Path: <stable+bounces-116358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5010BA3556F
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 04:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1205616DD47
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 03:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6A22CCC5;
	Fri, 14 Feb 2025 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ezLKQzjY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151A86334;
	Fri, 14 Feb 2025 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505171; cv=none; b=EiDpAXPbUnepNYiC6PDCy7sUm0RpqJoBcl5q+ALBHLJPfIeeCPzyOw2oURhtn3YVeQkHsrKN1o/Vpc1mHZ7bUVDjlpkZKhuoPMD5acSdV81Ym+j5ABicHRHKPNJGiUauMUFLzacBh3KYTlwt86RGAM31oHKUAwaoTbclu8iDMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505171; c=relaxed/simple;
	bh=Rs2j6gfwxMYn37DhzP1+0JgF/bStoQ+oF9AGaTTN5Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2HKveK1srmV3tMfiqJiBbN0fqeR2a33Oh9Sui4ypuugfdEy6+R5CHYQqFS699YS1Q4NMOSvqklgcjsoRFGioDFF01UjhhAY5whjyk/nsGlDeWdR3MCIgOGj6OOcBRZZZNkTX1qE2xJI9OSmtv1d8Yg8J2qDG/9iDc0HL0uxVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ezLKQzjY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4395a06cf43so10141105e9.2;
        Thu, 13 Feb 2025 19:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739505168; x=1740109968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGTgsvQRtLrU16wvAkbEa6kMfXqNaErqcnGKNV8MsW8=;
        b=ezLKQzjYpcqgfeYywJyUzDnSQBxogKw1odHPNiKbtRYWoOdkvPrqpVrKBApj+OzqZ1
         wmkKwfz1je4mQJ3++QwsIi4zyS89msVU1slWdFCd7a/ZtIrA0zpa52zQhdyNX7EpG/dM
         t2IwTVd+LHca2RpuvhAgvYenegmtxx0yMFK52IzdJUYD97ThxU4GN/ApZGUVKRRYJPLR
         sK0MJzVFkT9smd1OUP4SN/nj4iRpZHw2qgoLsaZOXqMW1rJM6U/gE4TEvVFryZsid4al
         zRmiqhPtUEcZqNLsHprbg36nMGjctYroD/LBHPhZT3LDV0AX0cbefQM97oCbRZfUZV/B
         d11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739505168; x=1740109968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGTgsvQRtLrU16wvAkbEa6kMfXqNaErqcnGKNV8MsW8=;
        b=cXu0BVzNHio7GJ6PBJL7ZkzFoMCL6hoQb1RDT+QrC1u9TDlM6PQSZCAeQeZ8khCslM
         b9bIJkagGEK9ZSuw0Y/BLVxqvLQnSjSUgrEXFmno3Ygs3rKDASixdORI3h/cftok3iaJ
         dV/DINr/+r55H/UQhHK8sqKQK+0GNu6WPcL7GXSGSr2wldYPLH3+i4WExUVAMyPmr2Vb
         VL6jOsOvtG8nVugk/ItTVZDnkF9DVPkA49ffDBSafwc7/swaJ5y5vH0NHAeXGASekH/J
         z0IL6LwNwOm72orCSighiVQVtl1RFBzZoShiYldpFFUjo4VGnjVr3bUS/DYIApBXbk4u
         dE8A==
X-Forwarded-Encrypted: i=1; AJvYcCVcR/Y/xUQn5fERaBwSKdajpjEy/+VS9njp01DSUijsa+FbjPf+EMvrn14V18MFTekUuTdbO3YchC7Oaaw=@vger.kernel.org, AJvYcCX3ElXnFPsZ3hbpCtvyVg5/9cxHlgonlbNeFO4+EOvAGb0C+C8ooxs1EMC2TBbD9CYBe821dCg6@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOkwg9ZIpCyhtS1IzefWL/8qRNztMunIEhloP86ApwjsRkZwh
	HzO2ddoCoA6rGBUgtjKQUJ9MoEilT3qNyzhgTdEeqUTGo6+cm18=
X-Gm-Gg: ASbGncuYx7dEJNmgpPmff46uZdPc/TRFy9f5WONSpqqvoda5wdBMm9eaFnpCBw8E4bI
	rjB/Tgl/yEgad9k07+kBh+wWpFfdqJetk2ePYYNRyaJwv8fEvxmvF0y8ATyiK/ESkoFd0YenZLA
	ic47YQHmXaCzusjCcIB07x9zGohAzjeRps0yZBbGfP+vCbq8xC1dskN3itaPnFHU3N6DPTbIZmj
	Zebf9xosKevTp+tlAx6KmRxuisWneTHacy3N/Nm8g2QV/Lh8fizui+yrYhqmq05Tz3kp2kN/svR
	DxUbc4fj7qBfQlKyjZA8ltGlx+fHTU2nkL/kc6bQV8gygGAcivoCms4+z2jORdI5cqFf
X-Google-Smtp-Source: AGHT+IHnuZCZZN3hYCYtZNp8eBMnru/Soke5PXNSGlagpibSv/+mbMRJgyuZcAKim0m1e8spt/YyVQ==
X-Received: by 2002:adf:e752:0:b0:38e:53e7:da50 with SMTP id ffacd0b85a97d-38f244e9028mr5242524f8f.30.1739505168074;
        Thu, 13 Feb 2025 19:52:48 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4779.dip0.t-ipconnect.de. [91.43.71.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4118sm3582837f8f.18.2025.02.13.19.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 19:52:46 -0800 (PST)
Message-ID: <85123df4-8339-455e-87aa-65570d39dab5@googlemail.com>
Date: Fri, 14 Feb 2025 04:52:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142440.609878115@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.02.2025 um 15:22 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
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

