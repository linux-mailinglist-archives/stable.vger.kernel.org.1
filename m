Return-Path: <stable+bounces-7841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB389817E5B
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 01:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4561F23761
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 00:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2538D256A;
	Tue, 19 Dec 2023 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMtS6Hbv"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4A1FAA
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b70c2422a8so43824539f.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 16:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702944223; x=1703549023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3nxwhiECCoWLgEtzUzPDkiqRnO0Qsuov5ea33tjs5E=;
        b=GMtS6Hbv48xGpbekIFF1emYziLWPoXgT6B8aTyUz3hRk9nbtZElTX6xNbAnTCZveB8
         aQXGa1qyJox/b28dMY5/Kh3mHtoeZHpSO+9QGUT3vaPgttDMlSJaDLf+OMWjmbSv0iW2
         GbgdZVWKt4OU0IELthnp2uc1DL7bV67aj89ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944223; x=1703549023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3nxwhiECCoWLgEtzUzPDkiqRnO0Qsuov5ea33tjs5E=;
        b=j44/60Tc/dRjcJIKvCWUOa+IXPbUhCvYaqobxFSltPle0RgBhvMcxc+4tTAiVO6GEM
         9QTQJ+yh5uePfde9yhcY/+hY0RNamhT0BjQGhmWQp91/FwEmE8bUb0Kt/KkjbF3lIZ1F
         mWOR3DOELO+QP8eAd302leb9AQkUUZgey1LHCChOZg8pnuZDPMFez+KKr0YtPS7PEqLc
         cMXOO64wqHNbKzqUlbmiuOn+HU9VL6HzauqeCbYJdcFNofnLfQ9G/92KE5SF3CLhaz2x
         mowakM/tPaCPeL+qjvpGThN9yDwdijR2p4G4D2ASN+JSB+Y1U486e45GSOION8rdkSav
         uyfQ==
X-Gm-Message-State: AOJu0YyY2s/XSQwQaKyMLKKF32AMbu3Jgnhoa8vvccegF/xZNE6hprIe
	8mP3xeTvKSPRTHX/WciFKSfvwg==
X-Google-Smtp-Source: AGHT+IFF7dtbONQfvQN/BeK24S0HT6I7PY6oVRGpq+yc0rUFEEh5AEK39tn43qgOOUaUAacaXLzkUA==
X-Received: by 2002:a6b:c996:0:b0:7b7:dc6b:ee33 with SMTP id z144-20020a6bc996000000b007b7dc6bee33mr2882373iof.0.1702944223605;
        Mon, 18 Dec 2023 16:03:43 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f24-20020a5d8618000000b007b7ad8d8c64sm1927157iol.48.2023.12.18.16.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 16:03:43 -0800 (PST)
Message-ID: <f9d0ca9a-7f64-4f5d-b829-9e6e96016a55@linuxfoundation.org>
Date: Mon, 18 Dec 2023 17:03:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/40] 5.4.265-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231218135042.748715259@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231218135042.748715259@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 06:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.265 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.265-rc1.gz
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


