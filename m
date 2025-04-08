Return-Path: <stable+bounces-131862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B1A8185A
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AB43A9FA2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3120A5EE;
	Tue,  8 Apr 2025 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8pg1enP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32822192F5;
	Tue,  8 Apr 2025 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744150674; cv=none; b=f67WxK50DRtHuiTMDk9jVFpBP0XljP2FtAPiRkrQy5LE4y8MRKi/DJ7yHtQA0+IWlbZdddY4q3tKyYD1tuIaUPFytUyNtjXccaM18leB4hHosEoV45D+zFLmlSgdAz3iuNGuzWadXCCXoij60f7d5nj6+bpYOazrqTjZe4T5gGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744150674; c=relaxed/simple;
	bh=Nwjf3Ev35BkoU+AzDwIZ0WwCQBVCuBSmXYeBwJpr8Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOuZKRdHjPUX4gmeK1G9HIl+NCq1kmDoYt13CrVxYJVNrOlgbBupPu3U9yKWw5iRchIK68zwp5lnQdE+hp6K0sBG4LLju4mAlL2UFDwpITAq6ZCjcQAGxyIPnhgiWZvHAUOLVAipatGwnLwLgG19/U6eGUs6q1bO/Vhk4p1yXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8pg1enP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c40235c34so1455548a34.3;
        Tue, 08 Apr 2025 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744150672; x=1744755472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nrJxgcRdNJNP/+MuT/tR4TERrIQfumnETWNEPiiQMHo=;
        b=L8pg1enPBZmqOtRM/A3ydad0T7iw5n+HeFxCq+7VhPPVVDU44tzxK+yoPSqx0vCwe+
         aWRlb1GOr9SsTTGyvjwPyVXd4lXqlOVu1lUa0+6RcrmO5xglyByLeUGRavTGvwJGopR/
         boRFDcQQrPvvItv0UjwPLH4hOzuFsk/v5ZYLkSluk+YiVMx4XokjqkemZlImvLVx3xq/
         lecJS+wHbIukv5yFb4EFB2ZeOaMAm0bGAPwmOEydGbzw6ZuZFF11b6KCgh2u3DpVRqdQ
         pKw48He2nyyTmhX97S0td5ODrgSdPC0OSjUjf7Ci0BoypPqAJx533pCpGyQGOMPaUmOM
         Fl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744150672; x=1744755472;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrJxgcRdNJNP/+MuT/tR4TERrIQfumnETWNEPiiQMHo=;
        b=AEgrRHbQ56pAvHkroVTpsQ9eTABuPctkVL50URT45QiK+eYV3/wQW9oaQe25a+zeU0
         O67YmA6XtWsYUb2A6c169Lzl+8ejqFI8es2awXiJnDQijbLkXENJxPqxYkvT+1lYVHzl
         GqdsrMo2Q0oQf08MI9/FEIIbLPeS0/L1Sc/6HpV2EFUSUsqWOuvqPoIscTcj2UcwZYQ6
         shXI+c+jGFQavyja1mPr52nuvbJfNajKq9HsdwYN1vUeRLvSoAXr6fGyIzn2x7BTpJFN
         BQO26zzh7kVFwvvko5mDUfONqaOkY+KkJVkunxDKOv/c1Cz3asXRGUtgTNzlUK9LNuFN
         +J2A==
X-Forwarded-Encrypted: i=1; AJvYcCVWHgJ7PTG8M0tJKcrC/zC/jyQeI/XtLst8zayB6zg0Ey/S7exckUK/SGFKEwhdKoNpBKtS1Jfe@vger.kernel.org, AJvYcCXbhwFn/NPDNXO24r4TxCL5SbIHVnRUzI/AcToG6zpB6t2rUwYI4YqEx6K6Fis/psaP/rf89Z+qRv7Azbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AWgIFFg8eX8LE7mkXz/XlPmxOS163A9W0zAb0vtk5CQymEY/
	svOzXlkrIoyFCRhWw8hhyNb5d9xC7ZPAd2BBvZIQmWZd31mQebLF
X-Gm-Gg: ASbGncupO4plhAWdbasEsWIpXmRd1IRinzLbe0kuxA/d6GOmEYI8L40C+aLPH97lG2+
	EqdxFXp4yh8dcHb3RtNrgGiRcmWtK6GztWKkVI2VOTTR8SItsfIjwQswrlajYULVPfvju40U7tg
	ttBUdd2fTCMPd9oJBNoc9iOjPBL1O5r2kEU8QfLtQ6FZsbQbSpd+XPbvg/3s1Z0hh0rYd+6vKST
	YHyeDI9XzYt1TxkPGamBX6YhkG/pn5y3tw1+YX1pVYJccfEYJJ1RgQJ97dh4+0PER5qXVwNFXk1
	oXCuuro5WJgRivVh72rgo8ya4bNYdCOzQz65uuTpw5IxG1zSJQmd8ziAsf6s6ahzsdxx5Q+C
X-Google-Smtp-Source: AGHT+IEG4A0Abyx5pR9YcuoHJpVVNCOI3DLsM+x3b/91o/c0Ejpuune4Kav4/IPb5oC1yCuocKQEJw==
X-Received: by 2002:a05:6830:6119:b0:72b:a61c:cbb2 with SMTP id 46e09a7af769-72e71ad3826mr181773a34.10.1744150671853;
        Tue, 08 Apr 2025 15:17:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e6515bfc2sm615047a34.12.2025.04.08.15.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:17:51 -0700 (PDT)
Message-ID: <763c56b4-68f8-406f-8222-e00051dbe41a@gmail.com>
Date: Tue, 8 Apr 2025 15:17:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/268] 6.6.87-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104828.499967190@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 03:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.87 release.
> There are 268 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.87-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

