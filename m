Return-Path: <stable+bounces-54767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8CC911199
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBB9288556
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090321B3F0E;
	Thu, 20 Jun 2024 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lTl2EQ8x"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEE1B3F2F;
	Thu, 20 Jun 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909854; cv=none; b=WUZEu2GdZJPQQrN/A9ORqM/W3+EK59F7KFJpUlZBx3BelgX59rhGoPYq8AKL+65pbD3LeRVXqrY3dRWqhdXUqlMvXm1ZOHhorHux/x4FI56HgM+4G04jR0iO+Bl1XaGTRJpbut+Kgg+Yz+VkER1gv6mqpdOvhObRQx2e0x6S4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909854; c=relaxed/simple;
	bh=WmnGzckqoS9EvXVeI4BC5/GdFfAZx+Tc5RYpLkbmGV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LG6nqlVT0T2lFt15hr/srY7nhV5oLtgCZxnnmw+arlv7UH+P/AHpP58AaKlEw/YVui8Ix9fGrXmlUP6HwlRY/6V/iR3W4nmHdWDk3rhCsXwLXSXObnmKFjnQQNQnZe+jgF3Ifci2FSuCr2gN5aAS6IE5l2sdjxYqtpsMIJMcQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lTl2EQ8x; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe785b234so12821821fa.1;
        Thu, 20 Jun 2024 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718909851; x=1719514651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSdNIerYh7HBDFHCUKiEp5OmK1zvusg/xzfllJOo6rE=;
        b=lTl2EQ8xcADdOa2hvVQl2rKNeqotUYcPA6yLoEtQGuoWDjczkebeOecxYE94pwPHhA
         9uiDE8G/Ejua1nH9ZJus+jIKg33C55MAJGINmW+RiagrBjUPRQGPzv8gAr4JzCRYyyay
         OdtCTwJhDEU6WBc3UVDNB/mViej0DWnoRcMQu6v7e01GrQ0P9IzFT3H09ge4w4GwiwSr
         F9z0ZSV2Lq1xmMF/55cCtaZF8ZVeMuH8WJe6cnANpLkWgEJGkJMbiGty9sE9TPNj+TTb
         jujdo5iLvVdNL4BsUZne+SpM4dM0aItXdmJBP0EniyEOamDDbAzlKg2EarLGxUJJGFMN
         YURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909851; x=1719514651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSdNIerYh7HBDFHCUKiEp5OmK1zvusg/xzfllJOo6rE=;
        b=Gqr+nsmeiIsxOyYxlQlB+wDaQ7W71ykuIKgvsOb6NBV/7HrUdws0Lhmx0r2gCYkXaz
         cbu2mbbHcwT0RNOkEvpMW729/vSyXLXmWO9KTeMlWVJLyanNf2T2xM5Dq7OlkszsLWtD
         lMc+lFAIsGr6tLfOel5HuIIPTnYBKkk0fKi2deyogIR6kfkumVmitUaJIIVcVr+mw5Np
         PSFQiRUkDsfGOVMwRZTWSLPrSmfxiDUJVIfM+wWcNaOJMD5761s3zBiQ8G6fv5Phwehk
         sRVLun571V0U5O4xo/pGgyF/vdlDF3IPQp+bxz9TPJw3Oii2Y4pXlMIGy5nC87qOInM0
         IRJw==
X-Forwarded-Encrypted: i=1; AJvYcCVuzM0DH3+uFznj/p5NxX3TmjAkUdC7nxdXQEOeGXAAlEgw8m9r0JE7zV/RiqCl0xm1NdHwutWCtx3ojWxLAJuMrVjQDALnIbitsKSC8O3pJoImg24RJqwbKtvws0+xqNDvrMOr
X-Gm-Message-State: AOJu0YzW7gVZjAndQEiYxpWSbBiCkDcHO9s6LqG+Iy79XIYgJEBuSljT
	A1FTwGKtcopXoyKG0GLT/ZvLpu3NT01ePZqjvwoz3ldhmKoWckg=
X-Google-Smtp-Source: AGHT+IGgy8JPQj0MTXMmRfzDcTg+RoUYxrxtvDj1FYjjaBOAkLKPSQdJH6gnOc+yypSYQhY+T18Qvw==
X-Received: by 2002:a2e:9984:0:b0:2ec:2779:32bc with SMTP id 38308e7fff4ca-2ec3cfe9a30mr40320801fa.42.1718909851071;
        Thu, 20 Jun 2024 11:57:31 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4f33.dip0.t-ipconnect.de. [91.43.79.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743890dsm10021703a12.83.2024.06.20.11.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:57:30 -0700 (PDT)
Message-ID: <9f8953ab-c075-4bf8-afbc-350574765214@googlemail.com>
Date: Thu, 20 Jun 2024 20:57:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/267] 6.6.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240619125606.345939659@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.06.2024 um 14:52 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.35 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

What can you do between two soccer matches? Build and test an -rc kernel... ;-)

Built and booted successfully, works without regressions (built another kernel with it as 
load test, using 48 threads), no dmesg oddities. Dual socket Ivy Bridge Xeon E5-2697 v2.

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

