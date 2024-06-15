Return-Path: <stable+bounces-52257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F4909597
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 04:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F63E1F231E4
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DE68C0B;
	Sat, 15 Jun 2024 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q5U14ZSW"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172819D890
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417529; cv=none; b=hSCX0q+PGlD//rd5Y9LLsfql+Uoyht3D0dF4MkkQrwVDOaplg27QXcES9HOh2mLeXeD+D65W3fOx3s0NCWrF+/513EcFyhuFQMByjWJzIElOswUDaNJiKiew7vQIJO/xknCfKu4XWfING6TbnbkrfC8lt1S2h1/Am0H31FjCfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417529; c=relaxed/simple;
	bh=0HlJM+hydr0oOrnUYCARKSFLYrf+PRSlAOvsNC1aidQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JR67PvU+cyegEkdvoKXOfTI6x+Zk7tWkYGLhMoPRKukn9tWZhLqZejrQTesxtCNkmp7OoF/WrmijlhYDHaaDs67ydb+uQE3JsM/ms5BsCEVz7fwMDehUAPjrJfQc5ZrMjxwq+PIs2Mk9rx8zH8d+Tc5q9wZzyRWsVOmqoKVMDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q5U14ZSW; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7ead7e95c91so10591139f.3
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 19:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417526; x=1719022326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=repXjSvFkNzm82fDUnLA+bN+roCNKUGFQOpyhe9n1Ls=;
        b=Q5U14ZSWOkmhZQY51QFytuuye4GDC48CnWomK7xc98uC823EUW1yEHETTtPN/TwqrF
         FW4nAbioiSBgSbc018qf0HxC1hTfmLVXNE6I8KDY4yGiKR38FURrXZJ8yZXOL4smw2Jy
         hnwBiUK/Y2YmxfAYo0vcy0GgrsFg6L6Rx5Wyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417526; x=1719022326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=repXjSvFkNzm82fDUnLA+bN+roCNKUGFQOpyhe9n1Ls=;
        b=gwoTZx/zGehwG6zxU6Vno+CQq+oSCN44SUWyiCGA5o//zdrxCZwzK/3PyvmDMrYW2c
         Nga0ODHvjf7jURMcVeclTK8dLQaEHQ4yLTmz4O98PlSvU5FTNyR8IJA5Mw3cxPUrBSDe
         X8WBmztETaEiN+kfk672Kxnw4blDRUrjWHwW4opp6bYJkBq1IbLxgt4Kij8ZPs9Dxjed
         /qPdiiVSrriywQ5/XYMV6O8IotgaLpxaYygdySXAv66pnaPa3yosev6V0AQ7+OORlG0J
         FbmZScr/z1k7DRC142nJHsVCWOboYeRTMHXMU3PmUGz81NKW2MKwWaR0UeiRHM18tQ+A
         QW6A==
X-Forwarded-Encrypted: i=1; AJvYcCVr2OPlfrOKLrREOxnkm9DxGnbSNZKIqTKaATkRowayPQjG9+GjHB1SgtRkc0mt5fhVdf2r5BBA0BVknlrzKfbmJ/eVqnT4
X-Gm-Message-State: AOJu0Yytk6IRGfug1zYQv3FGyI9POnsa1eqMGh4unjk6ZSNGOEe/MkSE
	nRyTf1BCSc8SEw2ZLbJOuUd5iXI3niF9XxTdnzPaAA6jj6LBehkfze4jGdeuLfU8SoR89Zir75y
	D
X-Google-Smtp-Source: AGHT+IHV8vX1HkLcPFfAI9zvZrPEKUy4/PtHR2mGaJiFDLaW2MBRlldZ5Yh18Yt6TmCd9T7bkLfjmA==
X-Received: by 2002:a5e:cb42:0:b0:7e1:b4c8:774d with SMTP id ca18e2360f4ac-7ebeaef21e8mr435884239f.0.1718417526041;
        Fri, 14 Jun 2024 19:12:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a1f7ecsm1226095173.122.2024.06.14.19.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:12:05 -0700 (PDT)
Message-ID: <d97e4128-7463-4583-88a0-bb7d2945036c@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:12:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/202] 5.4.278-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.278 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.278-rc1.gz
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


