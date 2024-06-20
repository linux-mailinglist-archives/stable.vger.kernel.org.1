Return-Path: <stable+bounces-54771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B90C9112BD
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 22:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE40C283774
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA051B5811;
	Thu, 20 Jun 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h5BQGbeA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584D171A5;
	Thu, 20 Jun 2024 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914110; cv=none; b=dVhlU8JTPwPLO9/XuUom4cW4Sd0WiDNcwO6rzeOCQBcv0Q1pUe6S+hSdxmi0SBKFndjhRGB21ly6MccR9nEdzbu8o25cO4uzMyI4BArqyfgWD9ksW5MCCJcKW+1dN203tL2qO55gyAMvkJZ4hqn/ejNFGrjNKksPqlhNqnTGfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914110; c=relaxed/simple;
	bh=Tvkj/bdqoUYFP45H7hKuk7ko3rQMOyR47jiutyyYlAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdCNwVMPBuSB+Bhcqy35o+NuNxSCPCpqRD3Gk6LKgom1Kd3Nmlhj8XAFUTETyuYaeot7Wycp7AszyTv5HPsEQOXCdZob3jjIg42gO52i0AV3u60agJuzTpT0URnb/YHN3DUP0xq1Lu7RvlyM9RlAmZXmCmr0XPzPcTIE3wnN3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=h5BQGbeA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so11489745e9.0;
        Thu, 20 Jun 2024 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718914107; x=1719518907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSP2iZb0HD34JmgOauzqp/IgCVs+s6ZTjWtbkH5tDoM=;
        b=h5BQGbeA7CDdGsHgNxVI0kyJPpFjiADUApcIrFQKitcAMCToijJJU7Wvh2NhLKEWOZ
         +TOQtVNZONQhmJWW2PnEjm8NuQKhUgYdzR6UtvMUfnwtt6fz0zEx2xNUx5mQ7JT1p6bq
         lE1DC5lvvs/oCm4fxJ2hoNgbGkLZgyl6AMJ0n6fapqtKf8M4UBoR/EthaZkispkwKT6A
         dn11FZl4NJcffpLG/RBKnVqsIY81991q9rGczPdfCfSmy5d8BjvbU9pXsnmc/keMl0PN
         /rMZ7+lDWLdYUj3KBmHDpRaVWJP1YBacIz9oXNjhHmbiQnYcBqqDjxdM5k8r7O0dosjL
         7oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718914107; x=1719518907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSP2iZb0HD34JmgOauzqp/IgCVs+s6ZTjWtbkH5tDoM=;
        b=SAY3YEIu+oLwIhKDPvR/V9TicarE1mbi0nWhchbqDzxSWIWTf437zrS870J3NXz6Dt
         fQxHVLAut9qGqBju/OnINE5KifAOA0RD3gxn1ru8YqDbiXSsUac/auqHUy+XPRhXLn3u
         IL8b9MXqvJ709vqC3LmDDyYIj4/NdvufPa8kXzuRDQnPXB9NUOASyEiwBep1D0VfOKWH
         5AXQw21r2LJ4e3C0Aj8k1/Lq/GMZ+1Gmnjr2rp1C5laFG3Yl+f0ephub8XD5MnUQjXO0
         0lNOIMX/Bk3M/e9qbA9E6hL9mSPMdy5NL+pTKI0o+dPyRbMEfJ7XJX4tYnZoL0oazn70
         fxrg==
X-Forwarded-Encrypted: i=1; AJvYcCVXXZtqQ+2NRsrCz4ahFk75+BOEN+eKNm20bvD8I1DnV3j7EViJb3Gsy+vfdzdBN4aCJvnL1UiSWr66mGtIzDTkl+66QjD0+LBK3vc8SgfHyAxcWnase/ykVrl4QWHLr/fmwcI1
X-Gm-Message-State: AOJu0Yx+4Xk+KCrBtgS3sdHaMYCu6M1NTDZ4ICJ4B2o/E7ENaCJf5S03
	0+dZ4o0fyLVM5ajtkRVL8jX/jNIOWVCMXlJPM+cFG5HBAJHN7qQ=
X-Google-Smtp-Source: AGHT+IFDvmwHPF6ya/h6SYBajHbwSiLRGoU7GuFsO6xAFGn3zo4AHPt8ASzx/yBQGuzkl6D8kmXYEw==
X-Received: by 2002:a05:600c:310a:b0:41a:b30e:42a3 with SMTP id 5b1f17b1804b1-4247529bd84mr44026355e9.37.1718914107381;
        Thu, 20 Jun 2024 13:08:27 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4f33.dip0.t-ipconnect.de. [91.43.79.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b636bsm39436615e9.6.2024.06.20.13.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 13:08:26 -0700 (PDT)
Message-ID: <7796cc17-a5ee-4586-8508-4229103ca1f4@googlemail.com>
Date: Thu, 20 Jun 2024 22:08:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240619125556.491243678@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.06.2024 um 14:54 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


Built and booted successfully, I don't see any regressions nor any scary or suspicious 
dmesg outout, running for an hour now. Built on dual socket Ivy Bridge Xeon E5-2697 v2.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

Still no goal in Spain vs Italy... 🙄

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

