Return-Path: <stable+bounces-61896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3FF93D71B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355D42860B8
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF517D354;
	Fri, 26 Jul 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JAIyH58G"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A917CA0A
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011908; cv=none; b=J41S7+w6dwzOqc4K546ar8lU4LbfNi/52ZRqKGjLf9ytsqYItt827ZE5CWQatPa/M57jKDZee/D/5R2Qy/KjiMCiopG9OLXM5Bl25IxWk5e+VpHlvoN2sEC/txpQmmcfG/8K1wAwtAIxQ9vANDYvkz5oww1dKeSz8thDRTFu3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011908; c=relaxed/simple;
	bh=liR4FpGObaLr3N9VLnvUf9D0SqRb/BnbBXVDeZQV/Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtyKcmJ0MLi7xKxwQkmQa+jS52kTGXJmtBrSISmbJoMcS+am2sHNxcl9+Fea7wcHBLOTxV9iXYIsiAy+WVVAYVQ37L+TjZrLp2+/ClI2IMsEwar4HevfYHwrDWnBo31LSnE9XVpKNcCB3wmUvg1rKCOtdQzs156CXy4Xanl39lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JAIyH58G; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f861f36a8so8298039f.0
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722011905; x=1722616705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoDlS+0StE2fDyQgsc9/rzf13+hWCe0NS+x2HBh4HKY=;
        b=JAIyH58GOBwqHjcukZc98vEsRE2T36v9N/fRMOhBLL+4lU1eUlZSTAAMbC/XUVZu5z
         4pwjKoD9CwK1U93RZ1crUisAl3gGMQPJDcnZil5hP0BmXTdtmfIWISruU29mBBxOlSsr
         QRp7050vm+50CdsmBL75/g+4Huobki16Yt2+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011905; x=1722616705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoDlS+0StE2fDyQgsc9/rzf13+hWCe0NS+x2HBh4HKY=;
        b=OkOWd5wEhpGOhQVjzNKGp517VPcpBYaoP4oTB8ptbp7tF1KyocnU+37dU6faXYp0Ck
         6qg/d6RFD/Z8asEHt2cOPT+gzYmdM9w6ALrNrW4TUmtwN/lOys5PhG6gpMxkowpsicyW
         1mSXx/HBvUTFBmA5M6F35SbdR6wt7jJYCSSB/j3HM4FkEBunfzn/4eaIszvp2Z0tdj8V
         H5vvGzHW/iOFIVehWim7oNKBvxYJFtzdTlqm03SagmgyUyZdrpY7e5ocCt+VK8VykK9q
         GWhFmuYpg3lCCIc3sesv9QwOd75Jkjg+wWDzXVOiaDa9BX9hTyh1UDcx1W1U4tKRAtL1
         WViw==
X-Forwarded-Encrypted: i=1; AJvYcCUXQhwBx2af/Xih6/Ajbi96AmYFHOmqvT6bn9znUvqyi2gAoIHr0ylJhCShR+TgTWG7jYHwluI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCLkE8N1+vnqpbr5CQxkQVfPlgzKoNRMnWiQMYKRObaKoywtq
	3H3Zyar6mmx+nPrEG8UZoFSqezryb6cP13pxIl0QIfAo9qWettuNPrstlqywumU=
X-Google-Smtp-Source: AGHT+IHx3H4hFmIxSitK5dI1fIxrAS0E0Olz8bBvOdpIdj2NyJKD2GwHGGm4gzA5iZEK6sPs9CXNaA==
X-Received: by 2002:a5d:8ac2:0:b0:80a:4582:ceca with SMTP id ca18e2360f4ac-81f7d02e3f2mr420233439f.3.1722011905010;
        Fri, 26 Jul 2024 09:38:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d788b40sm115538939f.29.2024.07.26.09.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:38:24 -0700 (PDT)
Message-ID: <e4d1e0db-9d0b-4563-95ef-b66517d5fe7a@linuxfoundation.org>
Date: Fri, 26 Jul 2024 10:38:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/87] 5.15.164-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.164 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.164-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

