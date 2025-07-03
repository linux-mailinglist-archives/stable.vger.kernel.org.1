Return-Path: <stable+bounces-160097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE44AF7F0C
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 19:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853763A739A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB704289E3F;
	Thu,  3 Jul 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMKZlWnd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D122CBD8;
	Thu,  3 Jul 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564213; cv=none; b=OQv3RE1aL4OSu4K6yEXY56Qh9PmorGpmVkRClbMmFtaeGXGV71woV1YNtCqliCsPAv0AQTRIgZSR3bGrYRJ76cbhcUW2VPleuovYLfU7Iw73Fz8DJBQV4vDFchhWEs/0t2u8mtP+k/AMQuUO/u2NBpoud7pbvOCc48cZHrmyPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564213; c=relaxed/simple;
	bh=gC5oxC05JYMnHdkqc1iDIhgZs86EWHCHEt5NMMKSsfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqtTnFnmKPo5C+UGZAr68ntJ6TdgtPKiLzTALax5eFBiHH1HnBVI+2mTFfpmbUPvb4T2SgE7hOzoBIHQTU0WIh0erjXy64DELHOa9Mu6cO6boYKpRMTxQIkF21wjErmW6cHRTpIremRXJ5NiWBrvdqoP53zexEKozz/M0hxNGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMKZlWnd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b271f3ae786so122778a12.3;
        Thu, 03 Jul 2025 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751564211; x=1752169011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kfdgrwoaedf860rN7B8LGcaFfwnl4UwNfcpp+jVQ3QU=;
        b=OMKZlWndyrpIJeaGu+kdVEp0260rEWfrGP7NvUiFowtVixaoWMT2IRwPLxCqE7owm1
         MHry6uozESEnsNHgAEA5Xol+R/faBu5XTL99EsREN0nb6/mNuN5CAKkU6OtJGnQttGRQ
         s4k22qD8NElq2Cw+LwFEKJWmnG+pIO9wIskGy6kn5dy4QVwrzmdSlCKOgJFcdK9G+u3k
         oXhG8XZvo4Cwi5bchGd9qk6jPhnL2VEkWD3EEcjBPwIWHNTO2kSBVFA02U+yZSW6zkO/
         h7TTIgBo6df6DaOUX7m8F+p+U5daw6fkH3xwPlCyRwhp3s6VY/g1uUP7rtxjZDbKHy2v
         p6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751564211; x=1752169011;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfdgrwoaedf860rN7B8LGcaFfwnl4UwNfcpp+jVQ3QU=;
        b=nateHVRjq+oNzTsiEW4qSpvtVQqnK2Q7CBtBusKol01gIGwqf58FoQkozJHBL+/za+
         YhLMR+G1Dp16mjmOsFgQhNhGeYVf+sre0O2mkql5XDbiLA/jimEqvZcLep++QKgW3sB6
         /O47Oeg8bSR5lFaUqTkd1pBUD9LbRQ79WR67EjjHiSJhcILWKGkILAiWBfXEuuZI1tHy
         VraiLUUXZpFfcBzJ6I2Xu2FW1irmRLSSjMu69+6YhptNaOJgva0D7wBI7WkTadYbtofB
         20MNrLZaNLSo7mhJXZQqCwGMd/t5frBLsu3n82ahbd+TDIfe5yHmLzlalBLhdDXipaX9
         r1rA==
X-Forwarded-Encrypted: i=1; AJvYcCVDqBoDE8+ptY8shBr1Ul6xfYJb8wRH7z1JUEhQ10yuU693wbMuKQ/tdbtfrcDYaWo6NYEaxqU8c7/s/0w=@vger.kernel.org, AJvYcCX5sBSqmoolOMenaL196bivaOEo7DlBbsjOWaNw3548kK/EzdfdDBBq1cKSFa5Redu6QQE/Ypj7@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjz61XQHT11XbzXAPIayAO8qzHGlvbXj3ZJSrJ7W6j0X36XUt
	UBpP+I04+a/1MHUguWr7RAeKm5hGX1dlQLmGhH2trVcNcX0mRFxUiJrL
X-Gm-Gg: ASbGncvAX9S8O9D+kueQHr5X0yOxezq/Q6WAFlGQJpfXiKD9ErvHlviQHL8AcyE60I7
	znaOZOdslpdRVfM3Fq6qm78nOInZVI2ROn9NjVI1O4culUC+v31mzKsCFMw3d4PPHdTbb059cY2
	38G2gakhb/jIbK7JM1ESabKk62IVgAYU9dxdJ+C1k4Mxk8+FElXnQYah8drmqa/RKwz4kjBfgXr
	sAZDA6iZJn47BykuhekqFw9wPBLvf4gicSnbbZk6cTQv217XCAAkYIyZG8o+lEOfyytt9ZC1gHf
	Tyt/D8vsR27hwCby+keqzX6JGdkEHqkOFUvm6PwjvcbYNIKuv7IMpoHzAWys5MOUk6HnOWarwl1
	w/u5mw/pID/26Ug==
X-Google-Smtp-Source: AGHT+IHwGgt7Bg+h9xyatF0LD1ghP4SHeSyGYJPL0pxhSBY1346SnGty5LqaLn9PN7gN4mJ5k+YUAw==
X-Received: by 2002:a17:90b:2541:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-31a9deae2fcmr5197371a91.9.1751564211338;
        Thu, 03 Jul 2025 10:36:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc4c7c3sm3036573a91.9.2025.07.03.10.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 10:36:50 -0700 (PDT)
Message-ID: <0d727070-5e23-4f28-a45b-70e7e869e037@gmail.com>
Date: Thu, 3 Jul 2025 10:36:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/132] 6.1.143-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703143939.370927276@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.143 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

