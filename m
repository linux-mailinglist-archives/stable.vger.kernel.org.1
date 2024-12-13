Return-Path: <stable+bounces-104140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839499F12EE
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EB21639AC
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806161EB9FD;
	Fri, 13 Dec 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDfFApdg"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289B1E47D6
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108670; cv=none; b=XkiERgM2/Up1AicVO/AW3yASGs1tkIQrLDWdPyPCVxSvlfYgvRo2PZ6Os7rJZPHbEYQC/E/tanMVfAjxPgiITF/7fOW9DnlA/7AKJZtBsNwab/3eEjWFXqlqSTNlokV5Xyr7qh9AGT8+BF7SKt9KlOgehBXgOilP08Mo5TnT3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108670; c=relaxed/simple;
	bh=hRLG0gI9ivXr3ITGqvUNSsdsw1nIY6Mm8YSBj0Szrdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Quss9qMNK5VrQtcEDiPwFT3klreqFcvD+c2J3sm4qQb8Q9nCH3mF1bMBYLXjDZLPUb+80j/VGikwQHqXQ7U5hennRIJ6jxlD7W8/1ss/qphQHTp3Ojz/KPUNEuXzyBsZRtmRMORpGpgjNVc/qQj0wqQT2RfA3oD5lil9Ur6sH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDfFApdg; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e61f3902so116578739f.0
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734108667; x=1734713467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/gquvUXG51k/jNV9egwVeYSE5g1NZe8U3pZAMe+4fs=;
        b=dDfFApdgNsRg+y4fjnE+KmM8Kf2Wbbz7Ei80HAD4cijLjpkgnp0AS2OUquRqcC+Of/
         Dvy6OtHMz8pgAEMMYpPVa+m3P8hA8Hz5FlpQJEs3vAjNlibMhiuyaZN7t0LwDHhGBgH6
         nb1zcZ6rVEhzhtyewgCCsbfzHKUGZGfbXGZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108667; x=1734713467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/gquvUXG51k/jNV9egwVeYSE5g1NZe8U3pZAMe+4fs=;
        b=sthpCvAxrgVZge+92BkgHIeposUvmwIdB1csi4htbKVLmdBTWwnoe2XPaFPYadznJV
         8XzsBcESv0knpX1lkkgNhMffieV68inQ22vKeipdn1imBVac/ZolEhhjmLW95O1sye1O
         ZD1G424uVrokGniaCH6Eytg7DI+mnHgb/QDq+nMerFsSGtImanAiitv4GfZZr1LeA+bw
         0rfJhYpRrf57ue7yIi5ayd3DCLkBwEf58PX1PsxHPEhpk4TIxuNOIExuE370a1KI2AzE
         kqIEvtBZ0INhOf2v45zV83acFzrAdEClI1pdk+BtWnUqo0sY2QL7Rum3oKOHIdui9L75
         I9tA==
X-Forwarded-Encrypted: i=1; AJvYcCXmU8y2eJKfS1KWHgq4Kx55qFfGNDi+GEJxToQDzoey7Pxn75T4eWFziM106efMbJkoC7u8NUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWoDjD7AAASfbGSGrtEnUwFPBwlO0fqkT0N/cBcRogPzBai5S6
	W+E245/WDSn3P9HHBFLNu262NlzstT+2UU+Ji48ggMvZ709zoCY3hDeYf4/Jeq8=
X-Gm-Gg: ASbGnctzVdAr+WYpeaT4h6wS83UMiu6J2K5PNg6Ft4u3yoLINjKd1OxUo/4NX08kclP
	vIDi4gKlYzYUvB8KvWZ7CneNQrkxDdYgTECMGvoKr5DIbGoaB0ktQzTOF+3TauGvq5Mqmi1NbLq
	qjHMZ33dYvfY+g8onougUz5zRyxL5UUrfxY/wSLexIRs8IscwoZpblBhfy1KsPz2wjWS+mazo6J
	4dP2harOysZEUBCXKuRIRC+1NL2vdaDnTfudBV/FoPQReHsBI+KISHv/gRhbmjc1paq
X-Google-Smtp-Source: AGHT+IG/k5V0zKRAZttbV2EkDVjn7pZoWJlVYqbCK3kD7y+Vax1tiYeztlcHHj03iaiKaDYPjNOHtQ==
X-Received: by 2002:a05:6602:27c6:b0:841:984b:47d2 with SMTP id ca18e2360f4ac-844e88eb5b8mr418899839f.14.1734108666844;
        Fri, 13 Dec 2024 08:51:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844738d4e38sm485853439f.18.2024.12.13.08.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 08:51:06 -0800 (PST)
Message-ID: <2a1860e2-8715-4052-9743-63fa8b766f55@linuxfoundation.org>
Date: Fri, 13 Dec 2024 09:51:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/356] 6.6.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 07:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.66 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.66-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

