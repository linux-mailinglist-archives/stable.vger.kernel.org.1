Return-Path: <stable+bounces-150735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D2ACCBD0
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A903A7336
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1681E570D;
	Tue,  3 Jun 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVL5SC6z"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD21A256E
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970747; cv=none; b=NwzZgERMemvLMxh6VFB7MAoZXqY3Ux5GgRk1TroCyngos/RKs/YLB1mcapM2Xr69wgXlQSSsXsu+iRxrdtINCWnBjNNtUCnXwNAxw+C5I8MKz9xzvFADbO13aksaLMdMy4P/7e+PX4R5sGogAXWvkeY80ULsAFprdzq8FV0O7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970747; c=relaxed/simple;
	bh=aBZTPoy+j2RvyY9xp9Dng4bIGIWmvFpCRUS3iPsWumc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qP8R0zdA7rs6wxCSdxWx9/us37DqalkOdO6BwjZLZ7QSomJHCZilbZlfGYcDTGz3W0kdk58XmhZrzbYD2ysVUoPHp3ZYUmHPssahi563zZLxd80/ttQ9Hdade46vu+kh+SVYe/WaoYssUEbwOQU0ZgfutqrMCtEyKggiQX5FvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVL5SC6z; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86d074fc24bso133490239f.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748970743; x=1749575543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MwMXq01gJ1aVcg4TMQoAlvogQ3BB/CkVvLj7iIXR30=;
        b=eVL5SC6zU6Rcoa7EShwOPo8Zp94K4PDHtVqb6DlpCyYzVgSlCRDoLOW49Ho4UoTSbq
         LJdE7xe0b3PRsMfDhAN72pLIb+gSE0NObtKM/arYcdvR0++bXar7fMo5sfFnNHIlt9SO
         iIWfS1tI8hW73l5y575Q9bWX7tbTnghtwjTqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970743; x=1749575543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MwMXq01gJ1aVcg4TMQoAlvogQ3BB/CkVvLj7iIXR30=;
        b=ZVz7gI7OZxFmyV/xHKBSXGcsXc7yRXbxzG0UojSkpZsmRDAkg7y+Zzmfj6rGSVfIXt
         FN3Y67DMlltaDCfhYOJGR5ZUsDq5Nlm8VpUifLuvfDAi4Qg6Q4myIqdl+dt626HjwFhF
         JfuEGyzjnbHF2XTFpwG59/PgfY6azrtYk8yBlapBxb71i1SvibN3Odz9nxhS7LOuih8y
         6ThojGH+mRAPfpyxELKXRUtrPTrbYZsraOHoRRwfGzke3qMt3rEwgUsjS3nzflZZYVB5
         gaFHhPP2BTCwRgLX9Y0Z4jUsZtzp0ajwArI7RK9x2Bpcv21RQM1Fo40oNTqaB4jQSfKz
         G3zA==
X-Forwarded-Encrypted: i=1; AJvYcCXbwjyHS+bOl1GacnZaxCVc4WTYWqoEQmqbEN2bXGcfoFAnVIL9tHv4txZcnl8RT7RwOYpSuc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPqP2PorzKQRndSTFYKaClFC5vN98jJRfixqDH14lQKUD0D9N
	JJ9gG+D6yQ2fORnXU13ntLdg9upe4rgtvyAJDd4R3a+KF6qlLBP5tGJdliKoC6SepCM=
X-Gm-Gg: ASbGncsf0+sUytevWRV9itP1lfNOMO6BJGUIu3UdCwrWfXE9wdKqEwDVaEXE+okgbXP
	cs3vO73HFyuIvJuk2xRT/KNXV0sCpj9EM5ezMzwt7Wx1djAoj4zLGDbhZafxyEAq1VFcXgez16k
	5RYrzofuI7gOGtjUdFxgdBkYCHgecx4YrVAk2315vN1vLSTPFpJ4OoSG4KdG8om+6rU0Rd8GOir
	b3w+O4el4LS3pW9agMHH1s4rVCBlRkpz2fI9Htr3m1TaTHIaKt3HLaGeWk/jinW1ZcItN+8tZ/q
	9o4h3Dk42qhqn8cogThbyWry8v9AgIu0f4Im3mWN7CKm8OR55nQuc9SmJh43LQ==
X-Google-Smtp-Source: AGHT+IFqdE/Rv34mnRjjnq3frW36aEbqp6DknO1kuzPgluh1D3x0RxohnU3W0kvIiYd58v8VDK1dDQ==
X-Received: by 2002:a05:6602:2c15:b0:86a:1fce:f1a6 with SMTP id ca18e2360f4ac-86d050945fdmr1683962039f.5.1748970742966;
        Tue, 03 Jun 2025 10:12:22 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7dfe577sm2349735173.11.2025.06.03.10.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 10:12:22 -0700 (PDT)
Message-ID: <afd3f81a-237e-4076-9e35-f478bb1b9844@linuxfoundation.org>
Date: Tue, 3 Jun 2025 11:12:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/325] 6.1.141-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 07:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.141 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.141-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

