Return-Path: <stable+bounces-111742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923E0A2350B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBEF1884AE2
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207C1F0E49;
	Thu, 30 Jan 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1LPAwxB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F1194141;
	Thu, 30 Jan 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738268694; cv=none; b=B+qGX4UefQA41LUcYQo3sI5w3qWh3B2bT+tI7fEk5Vls1K+Vji2cTL6BoFx85lY8jJsLq1oc0hBPJtEqSgVIqeGmN353cPHNWeG4XLQyp7VgXI6ugeqnnwH0YrN3woHzT8VCoggazcc90wA80dk8jlBGc6ZUnhu2Hx9HwtugDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738268694; c=relaxed/simple;
	bh=yFI2K7k1DYXfkT8AOWYfMld5LKYdMpO4AcfHcfiC+Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xq/QfHY7dEipCgQ5tvRVRtOD5soX12nqpbcqlMoTiOneEyB6/0EjjmPp782z+9Cheps5xE9T53VXad7Gm+0L6QrdHCoBMxHoO5+ieA6ppvj/upeUO1dCQ+ca7MQ6JIXSD9/n7sd3bbSULYTb8lwdqo5R/nK5maTTIXQC6x57yzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1LPAwxB; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eba0f09c3aso374406b6e.1;
        Thu, 30 Jan 2025 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738268692; x=1738873492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MSZrxWZoTLP5LT/YGVk/BMp7ULLcYj5MlBHfkghYdjk=;
        b=W1LPAwxBLxqwQV5D4Hmg6MBxYWydJFt+iqO+viVHrfZUvpRTogk8ZC//uPIMw3ldHB
         XCO/xTqvlWlKdLhvwhiqq+6HP8M73fNImWIGpIQuWsY0E/tN23GdvDJviOFQa1wcjQF5
         mUxdz+vSCCwt4Nyx1Mw8shnXqVlMYBteeeRO8PkFU/PMM7N+ObVL/y8YmSakSdkhkIDj
         kYFm5MMo1+n5tWTfSAOlULB8CPAUsZQkOAgb4iPgAjIrc9mqIdAYFlLAsl4kiqEPzgs2
         qU0AcrHzRcossyaOhMXW/XHdWewI7G5aPYWl3Cd31AsXO199kYUjFAG3lv3uRYn3GesG
         z5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738268692; x=1738873492;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSZrxWZoTLP5LT/YGVk/BMp7ULLcYj5MlBHfkghYdjk=;
        b=V9H1yE7ll/WpIVd2OlvmjM5oN6x7NU/y7k6Di7YvtDfdjF8ox0yKMdw8UdrDLVKAVP
         1AatUAHrJwUtO33tPPdsKza5u80fIRueUqJMv5I3uxPA6kn1YJNhh5S7FDcMQAldSkpO
         CCjPHwyhv/DcDS6idC5UFFcmEyetreUITz0K/Ja99SzZ0VVWwkeWwWfOOB7fDxsaVTcw
         NAe9OYUQA7w23k/9nSZXxdz4dln4+UzqehJ997MqwNzD4iujULdVLqASf0fIAvAcuP2Y
         +hihhZauTRcR2J80xQKOr5+vLR+aC22gbcMv+Nqom46yOzVr7BVLmnCvwVLZOOb6oBfi
         Y8LA==
X-Forwarded-Encrypted: i=1; AJvYcCVh8odZj5LvyhAkFJc4U5jem2VN6Ca2mm124gxUcGx4pzgvQ/4HaACuRzL3IY57ZSBsafLkvOoWvaLn/JI=@vger.kernel.org, AJvYcCW2yAWA17opyQx8i4OH0QAWbnQJtnwaOucRRw0GvkHKiAIx7ckIldBpq+/PzAejjhaZ/430t8Vi@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXFZzO5jOKdrj3NjuZ1y73VQrBYqOZgG6nrbfI/Uk58ciS4xw
	r0VwExIbgDyqIR9ycRy6KFyer8+Snx7k6ya6tVCYlMPTPVdowSXy
X-Gm-Gg: ASbGncty1raqwIdwaAjcgWs7J9IBtMeOIwWvlM9novEcz9pPSBx2LHC5hjo/F5o9R0O
	BM09zoemTthF4p6d3A0T4iiWVRZuQfQNv86mFJJxiGXM+1eWqSer2+6T0FlSZVayKs/Hjlvw8pV
	XuncptuzaEPoqjmYiEZ9E/9GTlsdeZTikuoBx0WWZ1fNIhpC8oYxytVoJpu8pUx7Hmmm+spCS13
	BkpTw0Hpy7HqXxJu/lp8npZAm7wFUBuYLGbsdbT4eVhR6IZ6QmMo+0gg1oTi7blm+9ceAp3KWlX
	Zy3h7UzNECCw6VuZp083K237J8tEIdhAW5oXrPfDtuo=
X-Google-Smtp-Source: AGHT+IH+wdR8z/my3k+Wtg9bRozw/6mpj2un8CmOp1PD/NwoijSOx6W5JZiGI0j06z7YWKK8abFg5g==
X-Received: by 2002:a05:6808:2f0b:b0:3eb:3b6e:a73c with SMTP id 5614622812f47-3f323a158f2mr6695042b6e.1.1738268691896;
        Thu, 30 Jan 2025 12:24:51 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365be5dsm406349b6e.33.2025.01.30.12.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 12:24:50 -0800 (PST)
Message-ID: <8d436706-d9ee-4a63-8110-a9c2e67c84a2@gmail.com>
Date: Thu, 30 Jan 2025 12:24:47 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/91] 5.4.290-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130140133.662535583@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250130140133.662535583@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 06:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.290 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 14:01:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.290-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

