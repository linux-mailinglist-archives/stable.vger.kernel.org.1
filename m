Return-Path: <stable+bounces-131989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4895BA82FEA
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301567AA2C9
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C424280A2A;
	Wed,  9 Apr 2025 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f2OwgbzV"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EC27EC95
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224879; cv=none; b=uicIYZS9VWClM/Cn+GibOc2Erbnd33yPifGa7F/3C7z2NAD9icZK88bBH4+CyOyW90micX9mxz8xR34uq6GPDC6ebskmpwhYGeGrabG7/GRWrAV2NC8RdVbNG6Uj5hA+mDt+TDnqnMQ7+7OHb6evci55lAXmS+beedjtMFVVdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224879; c=relaxed/simple;
	bh=BItrTn2IJIH0MdLppMsWlQgxElkb3NvoIdETrPiCE0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWJfl1xBB8k+E+n+WryrhUmyM7h/GexH/45vvWwlYQmjbuA2c2BAtkg4FP1j/XX3nXGVGaRhrzHhvMFO6lTriO4mscdVkpFKyPIT3vVUnqYSPak2KAVB1gYPFU2C92bZGIEoIdaFoYBtUNi+njfnOZNeRGQwfaRYuk3VMBAw79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f2OwgbzV; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b5e49615aso6329139f.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744224877; x=1744829677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7HCUg9+RtKDsPTNL/2WrP5NNIONueuTQQ7XmSzDe9Y=;
        b=f2OwgbzV1zXXF7U1vpHEmCcmt1TFyCwBw9v8Iu01ONlVjzTG/8rioTCvehVDeNjM+R
         57GDnG5RE7/NlvPSDenOeAWRQyBBMdhbhBJvWFCWQ+wbCaFaOVcYOMsZFa7jf5+n4Az7
         sQPwqqr9SHSSqu20pTCxRlC/Coesoruh8i1hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224877; x=1744829677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7HCUg9+RtKDsPTNL/2WrP5NNIONueuTQQ7XmSzDe9Y=;
        b=a/ETI2glqUueob6DstVfjCw3bCXn+71CkGJal2XfCtFpEhw/F3UpM54enNd501R3ZR
         BECj9umz7/qSSEjSkgfljUhuxx/zEQV28EDazmedYWkaGmnve7bnZ+VoCHZ14o+LdZ52
         tvWDTyyZh2HHzuONBdAph2ruJ9f40dlG/yDyIgGnRgIRdV/WYbDngGAJcuyDo5tiIMwt
         eEsltJlQy8wIJQuHN+xcPl2nMKpLezopGZLEiQ5divsZ+fr/wVeBw0tLEKJK+1WEKPcA
         3dThnlxPLKC8M/TveJAwzH2j/T6nSIPvOitFw5fhUGtA/B2NE9qviVMkqKeJrOKCc8mF
         yy7A==
X-Forwarded-Encrypted: i=1; AJvYcCVR6dwhj8KG71LrZwPHgn+K0ULsDkMClyfdHEsXdUSonTp7vEpDRpTmeJB62B9fX/4daX/CCjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRAnvFpbCr2exG31sbA/gTMKNKlYS2t9OONiqDzUaPNC4xVzZ
	CGy/rzd4l6PCjs4V+qxiyJR3e5v4aChJWxNgZxM+owP5eOqS2K4mrbbPHA4bRio=
X-Gm-Gg: ASbGncu8VWuXRKMOu7TDEhwEmdumIJ3OEQU2KIDC4r1WfIXxKA8l/0uP0eYpod8AQlz
	ynZZQcQUWl53nzBkzq0mcgoCrH0D03gMaAunyAIjK/AfcrB9YJEjmUTx2QCkKq5Z4U+Hpox7Cbi
	YIhyKn7yNFm009OUFO2kWy2RETxdeD+BjLny6JBsjQDGUfVdc6fudQyuTqAq9DRtVdUneD6xwL6
	PR4hkf6qiGwSnHdhMqpT9DkaLc62Ju9LFPD5jkoA4wbcVnZhQ2hFZFpg6wN6lhl6ouGJBbkb/Ci
	iVesFyqkcNMsQNIhZXRArnMsCiqFbsEtzUHkMa+AyllMjvzOMNw=
X-Google-Smtp-Source: AGHT+IH5i6yQTBGbz82VtAMEMdTBDeDBWpGhiHzbBDbPeaa1aVN55DG89VDgZRcqxydWuF8KbdUa8A==
X-Received: by 2002:a05:6e02:1522:b0:3d4:6fb7:3a36 with SMTP id e9e14a558f8ab-3d7e478131cmr1913715ab.20.1744224877086;
        Wed, 09 Apr 2025 11:54:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e0271bsm369857173.96.2025.04.09.11.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:54:36 -0700 (PDT)
Message-ID: <51c911d6-a7bd-40e1-97b8-f73d94d2e9ce@linuxfoundation.org>
Date: Wed, 9 Apr 2025 12:54:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/154] 5.4.292-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250408104815.295196624@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250408104815.295196624@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 04:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.292 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.292-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

