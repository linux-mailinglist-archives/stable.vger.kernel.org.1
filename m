Return-Path: <stable+bounces-4771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E4806107
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 22:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B74B2116F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 21:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791786FCCA;
	Tue,  5 Dec 2023 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw2x+qDG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3603D3;
	Tue,  5 Dec 2023 13:48:46 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-423ec1b2982so868741cf.2;
        Tue, 05 Dec 2023 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701812926; x=1702417726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7362aGWQn9YaOD7TDTBsEv+KjpS1wXfDy+Pen8Y6TM=;
        b=Jw2x+qDG1MSrV2arz/aXYLqECe9X7MPjDqeW2/VTYBAg8RRY1kVOLEA+dPFXj/2Tnn
         xAhOlUdpmkFwRrFUkzwL9sf4bAIN90QOu+bA2kqSqL86s/j5sybStsbdlfMo0/nKjGor
         GH7/5QQpJhngO+SCtRP3CX8azDFmUEJ+eDEU+kf0b2xL0i9duiKrT2GIjcwqnJiVRYuS
         aqAnFdwQhHFjyVK7xWdzrmAi5EKv7ZRO5rFqEpZEb8tQ9Q3/iprDgEN10KnFs7WPoHR9
         vn+E3GECptj+UkpBwtrdOfkXwCJa131YtHJvauItuHSiuEy7Nw0fvJ6142ei7nZvBN+H
         9Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701812926; x=1702417726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7362aGWQn9YaOD7TDTBsEv+KjpS1wXfDy+Pen8Y6TM=;
        b=ZOw28sHNyeoJggvZ7xPUMGw2xPeB/JBKNDtVyPME6+jWUPN707rAsnqVw0JM7duRt1
         NslrKH5uznSVZDO3eNiEq8unSCF0GMCAcaP/Tk5kSFyykIkG4t/Sg6vIJXoEz/JW6N+Y
         mD4qnd68i7hLKu1QWMu7/AxyacN3MobTjcBldvldiF718nffnpLoszOxmzHqHYS+Tuv1
         aZfocZR5l1p/jvJiflZrZNDipc/YOhKkSO7FlHjWPGPvctyC2xXOVC+1XJ/YYxxjJvEW
         FQb1lVyscMC8GXFuoB2ohkHkFVnnj8j+UBOfsT0g8eF9nTtMWZCZw63zITRl69NUIXAl
         JgQQ==
X-Gm-Message-State: AOJu0Yw6NFIF4kzn7QzCLPq9toNXc2WR/UYB3Hq6lzsIaptgQIQCAEdz
	TqYmqvlZTYqvBWX9Io1NfAYpJebX8nc=
X-Google-Smtp-Source: AGHT+IHgqtM436SM+/NJ+YT957+k+SdVt9/DktYuKz5Ig7PZNhFVMMRwYCWRVMDK17LdiR3jtfFaLA==
X-Received: by 2002:a05:622a:287:b0:425:4043:7660 with SMTP id z7-20020a05622a028700b0042540437660mr2024910qtw.136.1701812925823;
        Tue, 05 Dec 2023 13:48:45 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w3-20020ac86b03000000b003f6ac526568sm5467981qts.39.2023.12.05.13.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:48:45 -0800 (PST)
Message-ID: <12cf2948-fe16-477d-bae2-39b5cdac527f@gmail.com>
Date: Tue, 5 Dec 2023 13:48:40 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231205183241.636315882@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205183241.636315882@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 11:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc3.gz
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


