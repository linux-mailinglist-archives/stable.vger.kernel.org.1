Return-Path: <stable+bounces-200119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466CCA6233
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 06:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898D93158C56
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 05:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5A2DF6E3;
	Fri,  5 Dec 2025 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="V7NrCuDG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED362DF141
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764911338; cv=none; b=RKqCFMdh7N8va0EoI2R7/zeKOjZLgJceif5tluHpxWvAoMY/K3UGzmPJANCoJaM+Q4yc2qXS4WePUT5OWQmgKYDNisuMKgSMpPSp4Igj5IJNMNDIqzXUMWftrUQ2D2HLqdPnwLcvIHuCYgKKTR8emGgR6fotmkz7RI12TECkiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764911338; c=relaxed/simple;
	bh=0mosFK9wUrWmPpbImUrx67eiKJ87H4+FqqaRIiZgNIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGhvL7EAsUgY41/n966xwLGCw6pPc6fJNcJDyvnf6nFgcTzIGm1MUDFk1FfhMr+1nzqlj3JkZh+w4TZESSBPIOlA3J0Agni+78XptI+rNPFa0PaRUVs5SM/T158JswrVM9oJbBSkvmU4K5G29lYeKYtx1+IzDCAZeT+HsAm8LlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=V7NrCuDG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so11301045e9.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 21:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1764911335; x=1765516135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQ/QcU+pdySkeU/ShhAyFWrRXwd2eVI/9oBv8X3jXNM=;
        b=V7NrCuDGNGB+6XeX/DoLmFw50NV3+BuP9qxLxMkKP2pUojz3VlrXa8x1/TnhKIcFR1
         oP6V5hLrV2KcvVw2mGD1uWrixPOmswgf6SVTfyxT//IsFaMlCoSLy92ga9v2sYYoddXG
         g3gu/ecnFpV6KZUhnt/yxp9dfrqFUOurt5xm/HAjEtDp61+dQNuIZ2BKFGo9BVvZKLcH
         yZnLECa/VaxlYH0pApf17JHSGLdo4dMJYBb9DsL/56aWBFasluqDCM7SUwAaAv4E3yEL
         lgjG0jzjb5QxSSDoewh1pvHsi+s19+iEMhUvE9hICnkyxWN8g2wFfm3YAGrLdTQZrfDl
         re6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764911335; x=1765516135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQ/QcU+pdySkeU/ShhAyFWrRXwd2eVI/9oBv8X3jXNM=;
        b=VoolfI8Ocvr+EOZYyTr2GRyV8SWdPevAW0PIQfhiA7MHEFqqhEtVuLn12V9WqLbeZW
         Jp+hIh/OwKjyA0tYDA5hNOpnsRRCEI2o+qZSdEQg0Kq7thxgV4qRcxTsPS/BAJywiPvD
         idIBSkcCjfnzrHeoGBNt0ZtpyJWygu7/KkpSTD3yYcV/KF/sROyZyrL/ViYlYeWb6ilY
         r/cxc4qIrbAoT1u561d8TwiSHywTPONP0P6Q9+Ry5OnWiV0eXq41tvq3Wn0bp4jKxb6P
         3F34BR11AVi1Yc3Nsrh5+uixUPPwAQfIETPZ9YQibZjOgyQpi/MMZo/eVsoqsDNxap/9
         paIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1pGblx6mpRqp8naD5lEGLpE9Kf0fP2BXzp7NMIzLe0U5IwooXB1SR5xxGHHPXTVsDfAzYClc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLoM4/oBAnNd/3KtSbWT+AGDWrY8bW4p7NBR4RHdIvDppmuENq
	2MTHFDQE1jZt9poqgmPXbaP9tZyEqpmIs88aQQojMuUWjp3TGpGvGKg=
X-Gm-Gg: ASbGncv6Dkxk7GWkAnrUeeaeP3zon9K2KUd8okGMoVVsrxd6tdX8dgDpQsqoYq6N4Wj
	+zzM6X0LJIpijMMzf/0ORAKdEbwIWv+lJ6viTKaeFCOfl2v4zab7Y44jmG+z8hD6EOlpRSGxPFM
	IpWwTMhHGa8x6gBu2f11UQAAqVCi5Q73atH8zNRPS8Omcm9Zm50NxicQEAM3wBJIFK34QtMeLD1
	6XBAZR+oVJfbCTg9ahQ7RHdPu/2zhQvGaCWriE9NML32IiwJFaOe4PkycwydkzvKsoqb83AvoGP
	meBuQbLr7lAkXJpR5enFmqDl+RUDL0WfkoJG6xD4Egi7IyPmVU3hR2ifZb0fTTUckABAYNQ4460
	6JO6ITfZ5dUULgOyoOg5TMGHUuB3umL64pnHYDXlugliE6bF4+GLjLsj8mwxKaTLUcH2Bdlkdwx
	q/D2VhWf+TGsrJQHnPcxmIfWAa1ogQ36HcL6gniv2ecSF2JiDxMMtN90X9wn27ajZazyAZIekdr
	g==
X-Google-Smtp-Source: AGHT+IFuy+KM+jSzlsBMxRWNLMk24D+Ii3BDvGvDvIPansVEZ/vl5jS5fISZUowndW7O7145yPP0Vw==
X-Received: by 2002:a05:600c:1ca4:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-4792af404d2mr91038825e9.25.1764911334883;
        Thu, 04 Dec 2025 21:08:54 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac20f.dip0.t-ipconnect.de. [91.42.194.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311e7142sm64715515e9.11.2025.12.04.21.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 21:08:54 -0800 (PST)
Message-ID: <36a31d9d-cb38-43db-94d1-d40129ca4bc9@googlemail.com>
Date: Fri, 5 Dec 2025 06:08:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/567] 6.1.159-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251204163841.693429967@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251204163841.693429967@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.12.2025 um 17:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.159 release.
> There are 567 patches in this series, all will be posted as a response
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

