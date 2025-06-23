Return-Path: <stable+bounces-156169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB5AAE4E51
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0804417D39A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71814658D;
	Mon, 23 Jun 2025 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TBzLc+5s"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3F4409;
	Mon, 23 Jun 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711538; cv=none; b=J/29SFw5rc3HAgzkvzlEqdUTJv+gc8Aib48RakebCpsd0Crw4fRlXFYVLDyWUcQ2WApTWchppjBZW/45+Wq7XBB9At6KD8WV4D7weXy1iDsKYlsFVvG+winf8N1WQPHEHaDcmPvu6tmvNFeD2BQSdFfsHxkUflqODJNJsxBmTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711538; c=relaxed/simple;
	bh=nJOfIgX2j7I2He+le6ibzRaeN8icl02bpC/vkM2ViWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnaXh6UNaFdpMr7ZR0orLHFvsh4+mOSekQQAZykw6n8FPGAuWvB4m7MSHL1m4IKcx3764UJtHw22tXEE4jFiW1rjrdBu+v4NHhbK2n2ShTlthLLEED7wKOZubcnbIG5NLPubQ2WFXLWzHUUHgj9yTwlbwWiedkE3cMbsKGrB+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TBzLc+5s; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d7b50815so36310045e9.2;
        Mon, 23 Jun 2025 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750711535; x=1751316335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOG7zqQvApgpVEilf4HIPlQCZTxX/a/I3OsuQlR1qAo=;
        b=TBzLc+5snXl6XiW+nABRSNbnoQ4rTQIwflv9ApHTGSFUdeIkmpKGhcVltI/1kqA7Mp
         4V4VmGCKwozAB/N7ihg6QATnITut4gXe/DdHwtsRS/j3iUbO+iu9+gie/8KeNFaXD8q5
         TD17mB+Yj6UsF6Rx0DCDQszvDMnit+VSSj7WXxTZ31VWWvt78PrAQEjmtj6L4fsrepDP
         Tfs38k9zXyzLyLFDQEZGfZAe+RaGFKZB80XmrvM9vJf/QGQp8sFbm7Fndl54x0jdnfK9
         IRRLYc0ICoi9UB05hlcPCEfOgaVBP5d24QWlLAumKrZdPXhcr0ZxDBwjsQ1p6sBbrZsL
         6jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750711535; x=1751316335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOG7zqQvApgpVEilf4HIPlQCZTxX/a/I3OsuQlR1qAo=;
        b=OR7+zwyQ4i/E+kUDYh4yL/KuattppWQMyF1hnzuUy4Dck88NXdO+oeEixeHhEveyq3
         9+RbeNeDYmOHxw0KjH+RM1jXXX/A4nXI+NCgpH4UbFc3lFHRBUwt8MS71qI2jLAEIkQ3
         ORwGCyBswHDhD2ZJN81e2uZObUP3dmbfdA9eLtim5om9M93j0+/bYI99kwVa5aypFeSm
         dwfocwoswNKEWNid288O6kTOfIZ7peL4/XyRbOxA3Q3sdGpKviNy5KR+wjy6XYHJuv10
         HCTanjFgQDNqUNg/nj/HkHLg231wePQ8OhJKqjTAoWTxPrqcC7BDs70EOAmZkCygdzDk
         WCew==
X-Forwarded-Encrypted: i=1; AJvYcCU2QdG1rQhG1gNXsnaIFcXtjJfWnhX24gnoCWGsUMY1JPy2Aoz1cgMPpjHVsAq0hvDquvDd5roE@vger.kernel.org, AJvYcCUpwK01QiCUudIvvY7L2dZIB+xuXLsI0Ggtf7J6m6GnbbI8FB1y2O9D9wiu5zTVSpb5athqVcusLe3MnVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxciozd9fb8uGhgzE+NsqNVKBh5x6I2cF89zcxQNp07SN5DtqvV
	l9Pz6cHb+4i+UN632h3UKFfgHUOZBF/JucIZpdVl9eyXiDCMJ2eNw98=
X-Gm-Gg: ASbGnctuDWkLLJK5N50IyDa3E1p5n3CvTz7lE4axO6YW7kgjYD1Hq9oVjNCs96Mzv16
	UDVKsRHLXl8LoFRpaPu3mQOAyP0n72v3YuffaIlqNnJ+usb0YyvhhcaL83Vs7HY1nSqZSsxc6CG
	wm1eRcur3kh5mInLgp/+uBE/k016i/rhX1ys9hDxghDhSUaJWZ1XvrG90Voua9+jCqxO/wpz7oE
	m0rUNQ6Dh3PQwfQvOWE74E6H10pnFz50eQPHetp64AHs2AQ91P9j4VvcrpdfsCM8gQmzzx7j4/J
	qKbcfwGsqw3/Xf0+MpNtRT6aOFFZ/V4I0RbPzWKHoSzkMLZLffS5QDyIHt1bqL7rfas/PTWrGf6
	SUU9QjR9Q9Pj09SLojF5GPl0uC/1wOEs9MFvYxxIO
X-Google-Smtp-Source: AGHT+IFAgt/Ra61XB211TVnlOI33e0YkZh3jnGT9FfvUN02IX6xMf6NIS4BltWT50lcUvlaFjvqL2A==
X-Received: by 2002:a5d:5f4e:0:b0:3a4:f6bc:d6f1 with SMTP id ffacd0b85a97d-3a6d128db11mr13461052f8f.14.1750711534542;
        Mon, 23 Jun 2025 13:45:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac778.dip0.t-ipconnect.de. [91.42.199.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805d342sm103224f8f.21.2025.06.23.13.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 13:45:33 -0700 (PDT)
Message-ID: <2f3fe45f-28f8-4ff2-bfa9-4769eb1415dc@googlemail.com>
Date: Mon, 23 Jun 2025 22:45:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/592] 6.15.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130700.210182694@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.06.2025 um 14:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 592 patches in this series, all will be posted as a response
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

