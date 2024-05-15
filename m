Return-Path: <stable+bounces-45219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0E68C6C3E
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 20:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A830B1C21136
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C63B78B;
	Wed, 15 May 2024 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBK0o4dl"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B71A2C25;
	Wed, 15 May 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798306; cv=none; b=X8L+AimdTIfWjINtWVdf+RwhngvQGzeLptXAWXEVQdrG4piyMblT1KmIz2L5fvTKusEXa4zNClFD/+JJti0Tr3Vna+PYts0khu07POorntPbebJ2TSIqX123NnYFvFUP9CuCUahHlz+c9TjB5rC5iSF+qcNaPyUJYw71agjWn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798306; c=relaxed/simple;
	bh=7UWh35RnOx85WzoHXW3ShB1J7NQ3C/kFXJrXqt1QCuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4hjmxgmMH+PNNMhYHalCDzSowf/RPrEzitUJt/SgTB8xLQZLkWlveIoDBN4Gj+T/h5Q9Z/ZTQbsofreRtOJaudWBZuhL1KW7dSD/6AG7Ud8R/a1cNQ6e7NIZSvh9ubrwukz+rXnmNuRRU8yUBg29XJsHUywTFYaUzTMjc8ZEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBK0o4dl; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47f02dfe3adso2053635137.3;
        Wed, 15 May 2024 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715798304; x=1716403104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXBg9mVwXoRV0q6l8YLggJ0IrqIqcDtLEUB2QLOTEmk=;
        b=MBK0o4dlfb0twrLbaPqOFl7y3/n/qBMqcTZr90NjAQSzpyKh8nY9t0Dv2fmXTYypJb
         s6A4LuDrc8zsLxUnNSSrbsGpel/t2Fdb3sg2mu3mycKOkNKaUzfzRjEmNCccJ3gRm1W0
         bKmQP0gRSboNWkIL73DJywTeiUIfXyjaVmVvFS6mSdJ1X60duNP4nBpGDNKT2TQm4Wdk
         luxGsqr1mIWZGkYD53lKserAb8DwliZZtpe3FmzCpnmvSgyxoP6zQxFnoJgy9ayLrTps
         VObJS/kOvpe0r85erOM+NHdHsEBT1E+UbrejQ134JpbDkVwn6nbmpF1mKAyzrrljXgkS
         W7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715798304; x=1716403104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXBg9mVwXoRV0q6l8YLggJ0IrqIqcDtLEUB2QLOTEmk=;
        b=bHKcIpCSF6bgHOeXBpcrF0ok+xacwAdNsNd52magUua0foV3eGn4USl4Rlr2eFKCye
         oAoH5jjl7VRVcmBc1DMNKK9358B60qQ/1LA21Wk5tULusrx/QXWq6lcCeglRVMMlYuV2
         XA/8jCuBZsm8rU0x0SEYCJxLxzgknrziZIxxRs+ZUoIYIzk+FXXwKHWvDo2rLUw+6w1i
         s0esdDkeCEjwGqtxuXBRQbDrDLNdccXS6YqDhKW1jyRWTYxOBSObAFkf4ZNzUuMtKbZF
         vliNN+bxiyW3KHQmQJjtLtSxqCH+9/KhymuQEbmbdMT7nHbfTUpBrWNdWEFbS12BTkpd
         Epog==
X-Forwarded-Encrypted: i=1; AJvYcCU4rj9mNMaJ+zaOmW0eDl7zayFeyJrTjkJ3rPryeDRENcAB/ZMpmh8NwVbZJPPeBIZZwRD8O0BnL08GDGv6BzFP0794TgsOawqn3Rm2X2jZDDNvx1lvO9XrYwm4nJmu4RwrEEkP
X-Gm-Message-State: AOJu0Yx5dyCoKWU2Yijg1a1HwSmBYQtcn/H07db33li7JMWCmD0SJpU1
	DlheqqWdto7X5l/fCTACWlpD9yUAEPRHYYRGmpxF2AcgO7LhPmP+
X-Google-Smtp-Source: AGHT+IGJ4YpIkrblaSjESWs+y/i264n6Xjtgzn9q8BT5cApsbhZKOZMVFQO86OCAZ/NfNw5zVugNTA==
X-Received: by 2002:a05:6102:c05:b0:47e:facd:5515 with SMTP id ada2fe7eead31-48077e5bd50mr16455856137.35.1715798303447;
        Wed, 15 May 2024 11:38:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6a15f1cd25bsm66747806d6.85.2024.05.15.11.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 11:38:22 -0700 (PDT)
Message-ID: <ac149d9f-50f7-4ce5-9ffa-d1d367e0224d@gmail.com>
Date: Wed, 15 May 2024 11:38:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/340] 6.8.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082517.910544858@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240515082517.910544858@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 01:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 340 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


