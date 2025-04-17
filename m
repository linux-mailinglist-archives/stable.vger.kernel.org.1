Return-Path: <stable+bounces-134506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D9FA92D62
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 00:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA094A2474
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 22:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE711991DD;
	Thu, 17 Apr 2025 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bWKAMCIU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B91A5BBB;
	Thu, 17 Apr 2025 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929938; cv=none; b=kQ8Mgy9yqtCz00o7AGdflP8sNJ73wmNuMxaycCGJkM4RgZ2lZxQTuAy7a2DpRTR2ZAOccms/aXsd27ckMBvbsUAukVO79XhkzopRZeu3G+VKBajiIyHDNJAGfZSbNbkHs5Z4IYxjKPZsfABPdVClG9mPgGvzcYG4QL3JCNNU0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929938; c=relaxed/simple;
	bh=EGnAWq3PAIQZybaAJOEJZx3CT6TXDduyQI2GFDKbAQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXcqVYuCNiXXf6eyzd7/c78aTDApGj/8C60q0Co/7VSJyvbRd0YpkjPwk82Mfw4bUZuvg2532x5KuGTUX64hphvTHGobNxcw0eArairTYyvcU8sbUo5/93W2UKguEURP05o6DbyKDPDZOBX4VlgODr8PBUkiA2TJPajvDg9NTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bWKAMCIU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so13381365e9.3;
        Thu, 17 Apr 2025 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744929935; x=1745534735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ck/BCeGd5u3fGI1syuC0GfqN57I10Eknap5ds8LXTfk=;
        b=bWKAMCIUHSyewLhzKd/0hZWwZ0QIx93rALzlGtuzr3Tp+RD1bL94WT6JDv5D9pyUY5
         yDPQMFoRQcpk4G1446WxexLMQQDxsuyfqf7/mlardrMR5lHkOg/AJG5JZ22hzloydPDf
         Pfk+IsvExZXgKmg3U114YODsUJlYljm9PcMRy0OAonKqDbWmbPo5XDrr/En5/26EK+KB
         1QunqQz7OspM5Ao1SUg9Iy5HxBccNP9TA2oyYedya02X20i2d8nSg+fG0gKg09tMK9zf
         stxO3ZcmiEHyEamxOZrYTG8u22NZ8uR8hyRxYEyazS8pbbjHXcFye+QOp6BDKuUX3ZX4
         W9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744929935; x=1745534735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck/BCeGd5u3fGI1syuC0GfqN57I10Eknap5ds8LXTfk=;
        b=v2iJwu+fcbC5iYjl0MgvxSnD7FNh2LeSXPigceJ/LcZPmvuUS5r38oHdaQKkYSSYoW
         lYjiHyqV/2Ljc9i82tJtAbnf82geDG1JlfaU+xr6eX1h7ghU31g09IHqgc3Z+YaZojIQ
         JINes4/N4d4/g0WAYm/SDJ+E6JiHCvHxOW/ltDbMOMbCvvMAyRvUMMHwFrQd93NLJJ/J
         31sC9YlLnhY5nRW+qyyrTMQZMvIj3/5Y3EdOL7cJcruqumjRPat1luxeXEvrkfzscliK
         Nbve+cE7170ekDHLWjPuaxYnB0zLFqKXLNMyVAueacOowC2UaWtw+8u/txX6BIkGJ1fV
         aCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVToYSa3o22bsdedxza+dauChshdXWzruASyuQZOR1jFHfTzk1NPq5EaYDvvs2GbhrYwQuP/KVz@vger.kernel.org, AJvYcCXpaq6GX9upjEBC16wJyoNVi2ezSIddk5Fg5UI61j0ND2uiPWClpBP6jIuRM382MNO5XpZvDTXTPVWwCCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77G9oXZeJhZi8iUQGZh4aTMHUijA2j6Woy/7p5bXuWK+QlXqg
	j8OjN9CVRDnEUs6yfBgie5zI2kcMSyQzv13R6Fk2Fh4LZHdU8XnE4zXY
X-Gm-Gg: ASbGncsQipZ6s29dK8hqaRBcUIAtQfqAmF/7In6Zlam849IBzbJ9spMK9gK6cV00KkP
	leEKj4XzmyW/56O0HvfnR0BV/nNIyBr+XSAO9cQ1mhFSeQAMsHnXN6AK03gUXhWPyF1UlNUdIVF
	0ui1yC/xiWADita7PzltmHXagSjzMt9tiHAlkXnwi5so5mYRLrESfHVXFLNrLuYHTKZbhwdBMhA
	01NF9tYUaiRnqk6oj8k0nAFRjWgGPR8Dy9CmcwSXv1hlOnzTI3YGoF+xzwJRkJCVIVCYdYzwg8X
	lddQiO0BWJxcVZtQpcnCiabW9I6jPScQlCfL6NXJN/xsZVpiTCLgc+geJYa5wy7VQOl24XHEIA9
	LRoVbBWKf6F0e+OLHkfuYJfi/XHFN
X-Google-Smtp-Source: AGHT+IH0hKr8nGCFTX0glH2QV5NFxX9UnibsOOHGq2Ivr66QNfElAZtEL8q24lXa60FNV8FA5rfqWA==
X-Received: by 2002:a05:600c:358b:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-4406ac17329mr5447455e9.30.1744929934978;
        Thu, 17 Apr 2025 15:45:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b057cb5.dip0.t-ipconnect.de. [91.5.124.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa433104sm945242f8f.29.2025.04.17.15.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 15:45:34 -0700 (PDT)
Message-ID: <63fa6d57-d8b4-4518-a5f6-8072869992f5@googlemail.com>
Date: Fri, 18 Apr 2025 00:45:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/393] 6.12.24-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250417175107.546547190@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.04.2025 um 19:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.24 release.
> There are 393 patches in this series, all will be posted as a response
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

