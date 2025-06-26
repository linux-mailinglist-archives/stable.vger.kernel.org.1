Return-Path: <stable+bounces-158718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F48EAEA9B4
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 00:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9A51896692
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 22:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1BF21ADB9;
	Thu, 26 Jun 2025 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hA+Pb79p"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135121A440;
	Thu, 26 Jun 2025 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977245; cv=none; b=OaM9Z83H8+/4z/WqhKAqNPaBHhZfFLXrIywe1KCMQMbF0Ji7G/QA5OIxvmyxIwYCwzgMnPe7AzIkXY8cr1CvV+nnowzMAxSbHCSfnJnuDZAYbmnDSN7n1/G8NnFMshOas5ZrtHAdhJWrQC6q3Bii114pZo0BO9DaBzvONgloua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977245; c=relaxed/simple;
	bh=Ml11YTIUf72xieq1cUkCUHiMB6pPlDArwfbYfvU7a1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI1OY9SGCuNO9tl4k0I989eXq4moVDs8L4h3OjdiWbbrasKWh8fI38Adyw7MulvMmsZ4cQ6fwBPbSqt+0HWWcF8u3Q64zC0tnaxSMHWx7jim3OfK2KzNPs69NveAb/Z1yg7153QqO2BMvE/Aq1Hb3iC7YgMPcNaYsvk3xAAgtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hA+Pb79p; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a528243636so934306f8f.3;
        Thu, 26 Jun 2025 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750977242; x=1751582042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRr9Ckwsw7SMw3MOv9t/vxBNGytl36tGaFii8n1LWHA=;
        b=hA+Pb79pIcKkLh+mbCYlZACVB9avJcfzMhKFScfEU/ix8Fa6pUYCO9BIg6NQZnbrr8
         WoO5aw8XH0S8ML5RYx9RPwMPGVLWih4wp4Mj7SCKK64+9ScRVRDKjK9Lyhs9qgyCrHqe
         6jheTHSQIkPxrt5ecBAQIA0omjIYZz5hhR19T2IG3xgmNDBhCFKd4gTFDpb0mT4daXLj
         9aeq6tGeaHAdlfKxphN9Y4KnGyyQi8KUVzR20QyyEh9xIlmE1DpZcdiTK6m1CxKa8+BH
         4Fruiu5YifNGgnOZRNqLQ9u2HP/+OCGDhkaI8RnifqX+DCqoPQg6moP5jRt0itLUAn5+
         b6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750977242; x=1751582042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRr9Ckwsw7SMw3MOv9t/vxBNGytl36tGaFii8n1LWHA=;
        b=O+sVcWm+FuBMusZTsSGKdSuYaqlIQxEDNgicqXQCgCRnyqtgopvyYAUwcwQJcm1+TF
         qe1aODsjwElrjKuJavezTZ0+RinsqH6pFHgJhwU2AwUVsFphr3WmAE2V6K3wg9IW7Y4S
         +SlkNxaQb5a5jVpc/P/GSgoCprk72DFEFLoSYRBkoM9DBQPbK4xMrOB1KcI0RUHjC4hF
         ZLwB2wJS113FNVZu8ud6968A5/+aJFKaNqMQz5QzGoVVvtFfR0U2mqsYw3R+dgtUkNmM
         LDTlwIctyDYsPVITNdOvyv7x4GAkWZWonjaAK6VEuAzgI/BWE4AF67NtwB9h9cFLUtUB
         aJuw==
X-Forwarded-Encrypted: i=1; AJvYcCVQfs3RuUKtHAgdIXVr3jDUc4qs6FezuTWTmsTWcD7ZLwReIxC/9RXKnH1gWefj7dUh8B/dFR/EwqQRvwo=@vger.kernel.org, AJvYcCXe4V4ibqEYxEwGg5UqRkEHrhAJcSbUHhEGu/uRv3j/7neus1wiUjLIgWITKXb1rGwEV/aQQACT@vger.kernel.org
X-Gm-Message-State: AOJu0YyHHmPwFT6wA+kgamLwukme5HxgaKA02duniLaI1u8LdZ42UIOS
	Ni//PR8oKZrLo4V25KRwUeMROTIFVL2bzx/C16eNd8QELKWJZ/kl1NQ=
X-Gm-Gg: ASbGncvwymiArnuY1UXG/kIwFqixFOK8kJ423NU4ZSJiAIm+WzxQAmLBc3TGJM7Pz5k
	cxZ5DnfP/MztDhnLTTgORUlVAl0SH5NImJl1sWQD5yqqwmrOjoQgMj6u1XqcIG7RFrFSrqGh9jo
	9Rrjf/Vf7GoMxRFcZoucmQjExCMZv+0bJP3AkzxFh4Z3rdPMpdM3IBecHvwgnp2MEs9rjk8JriW
	LgJhxTFEcXAR+UQxPuCoAzZPd6w0AVMUP4yZRB2nvUIPIbtjBpl6ilb6VsdBlVwRUjQMGjulaIT
	BZYtw0dp2jp+aqvYeDZRpbj7Mhd4s1yv8LhfKWVkg/UWZyyMkoObsLgOo43VQrLax6nJPM3Rni3
	AnCqlH63xoUHBqHYZ9B+k5NKK0ozYaCcnWY/j+Dvt
X-Google-Smtp-Source: AGHT+IHE3mEWCOk2D7NMvKDWFa3ExDj855vpBsW8qfc7kytidjqXCeSA1XBf8xHQ9zw2M4DUiOWsUg==
X-Received: by 2002:a5d:64e3:0:b0:3a8:6260:142c with SMTP id ffacd0b85a97d-3a90bba866cmr1146249f8f.59.1750977241795;
        Thu, 26 Jun 2025 15:34:01 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac2b0.dip0.t-ipconnect.de. [91.42.194.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fb20esm1026644f8f.36.2025.06.26.15.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 15:34:01 -0700 (PDT)
Message-ID: <0614617f-be49-4771-8bd1-1b227e6d11df@googlemail.com>
Date: Fri, 27 Jun 2025 00:33:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/589] 6.15.4-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250626105243.160967269@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250626105243.160967269@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.06.2025 um 12:55 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

rc3 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No 
dmesg oddities or regressions found.

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

