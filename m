Return-Path: <stable+bounces-69249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E536953B69
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 22:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107D0286FFB
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF801494C7;
	Thu, 15 Aug 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cqbfKnXb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E160813D28F;
	Thu, 15 Aug 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753583; cv=none; b=kjFv1XxhzLhJQq4Wtbt8Ttzljwvo4NXS9TwS/E2tGGJ3sh2PfPI1vKHGXeIT+ruPMpEY4EFNf8Agzu8QJiL8dXDQrEErcSH2bIvH75mX2pAihE6MtqYz5qN7j4M4FLpFV6GpnLqh7BZ2mqWEQWtMUsKOxkPkn/fY/JS6BI/Cew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753583; c=relaxed/simple;
	bh=8s4QR6foH/O7V0kChpXanieVCwaKYV4xvDze0R9On2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkbf8cfCOdui/c+WHTTLp2R06eDxPw3r/NB4PRWDZQxpsVydp+6iU8JL4F0vH9BH2NVHgtFv42pz42P++vUW9NhhNJlUKZxZOysbZgXlgMods1Kdg3MbJo+rIH9NWs9hTC2pqgL3mHT2zetkgi3t9jIJj0lu/gGVrR/Walz3nEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cqbfKnXb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aac70e30dso156578866b.1;
        Thu, 15 Aug 2024 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723753580; x=1724358380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTo9UcDPJTTdaOu1u8gvMy8MXEwpXWrXxp4eqgmQ6bQ=;
        b=cqbfKnXbvxQuFM8azFBipg0LqJtxf1WQMWEQC0QobkAl2VntaJ7d0JjKCtp21+b0aa
         AX0JtBK3l/bXZmCgD+kuyKLo9+fN5y5+wLHczy8U1S/ZT9m+s8D6SymGzeLD4OfPNKcj
         u/MjD+9hU99bwj76PXalV+7cCvanEimdxj6AtnBn5P7RFRz9+0Fraz+ubP5nJP73sc3L
         ud+4OJuGiW06kQGWHwO9V/F3p1KujSySjSpN5aecixDtwZJlCrZWRyE55LEpf+w51Ac3
         GkCHofKDs7Ei0O6/J5TI/+D0v2oJCLn9vvqbl7WQZYLifB5ejRHu6rwe09s1lxFoDurU
         KRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723753580; x=1724358380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTo9UcDPJTTdaOu1u8gvMy8MXEwpXWrXxp4eqgmQ6bQ=;
        b=Al+sJLai+OqatFo/EvAio/wbdZtqCWFbFSEsT4sdCOFbqHK/IU559EDMbDaE4rZ+O3
         cfUPDpfyxIR18WpvjJCbI/UDIcMKrQoGMo44ybaxCQs7IL7SD+XzC7uitrwBAre2qw6E
         KgPuS3eGoNyb1wCWwKJekBvuF+upCeAF0TWNq5MqnfKrNKgmI4ufi6ZUy8sly5MHpgwm
         N77cjvlo55M1vEOdjMjXXkxIKSiMescHsM1AMr/arft3EDhKB2/5YLRUBHIRUG/rgd8F
         UaLYbK4NlFwRLZJd0ptZm3wDaQuRmru8h7BjYFnxIk3SjJGI4pMx79G1h6mKbKF3iWb6
         PiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK4uNGNIV3kBp/ZLR5VcrWo+vzIMajiFO1Vc7Y6P1Tyz+CxP1a2NqYtwcQs1ZdKtBdtq17ByqdbEA5952nHexcj9LQbCusU8Fp/gOKv+yxFi/G4VJblp9daz+lAjOa1CtVl5SL
X-Gm-Message-State: AOJu0YyMPjjQwN3Y1l8OYijUUdJVSY246Hlgs1Kx2cCEip0+CRn8XAYk
	VKj/O8z5LMfsRp3q8ozsUrao7CFlyBpcDau1JYX/WwiKepKkJ9A=
X-Google-Smtp-Source: AGHT+IEgyjIkByZisdAJSl0YucYfm15NU2r0gkdCcr1/zItcwKj20vtzJOTNDSyZQLOhE9+TR6DGAQ==
X-Received: by 2002:a17:907:e2c3:b0:a7a:b1a8:6a2e with SMTP id a640c23a62f3a-a839292ff2bmr46830966b.28.1723753579884;
        Thu, 15 Aug 2024 13:26:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b41e6.dip0.t-ipconnect.de. [91.43.65.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396e0edsm148923866b.222.2024.08.15.13.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 13:26:19 -0700 (PDT)
Message-ID: <aa0a60c9-17e3-4521-9b59-5783d7145325@googlemail.com>
Date: Thu, 15 Aug 2024 22:26:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131831.265729493@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.08.2024 um 15:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

