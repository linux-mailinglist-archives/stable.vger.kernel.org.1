Return-Path: <stable+bounces-194642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFDC54757
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 21:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF0C4EB975
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E002C1581;
	Wed, 12 Nov 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2sJPzY5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66F263C9F
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979254; cv=none; b=Hgx2z3bl8zXl3C/ttQJFPXtRiLtO1CHPxNwz5HzZZP86fINXsb8nqCayqF47JSu8cJou1+xofnw54I9/qXBz8Y9JSocyJ8ov6KUCnZkobIqojsE+6B+a5OeDJ7ehW0L7qn70trupmnyHgekSHMEYWVxDqMkzi8F/kAoxMFcklw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979254; c=relaxed/simple;
	bh=7q1Akm6G1W0g/IxIpcjEst+vGH/xiknusbk3UIlJLfg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZTX0rKYEqh1fAQS0FLtg8dqhVeHyLZvwwJJ/xx6pv5rvjcNni8BgZ6GQ4Kbp2V54NzC1PVIyXC9YtA+1tYoswAz+nLdChn3G7N4EhcTZkpY3RgYflsjGxo+KW3ePeD64Acy2HvomCTRaD3ubwfgLkeA9MEpgbmqN5NYDADTbMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2sJPzY5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so32525b3a.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762979251; x=1763584051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oLIWcbWTGCm6uL0osnPTfQ+TcowsSwsqY0w+FwgzNBQ=;
        b=A2sJPzY5OUDgKQl3ORpGIaZPcEhoj6LpAln9+Di9dF4kONkczSBQHih113qARjoOkX
         566O4GHhuaeLSS6qs9Uc0pdu8Rmvu1rGz9kFjE9AqRBOTIfJ6ax8aLZLpntWMcINi8Ff
         D5V/cBFqWQXOh26geiuCvhyFP5D1KmEFXsw43p/dMwd/A7lZ2m/3rvEbnZ3eJYoVq3KG
         TLEVQ8oisQjbgzNBshcDBM2y219AaFJOyMXm62obVgwnuBKWylMpHsh84qjz5Oef5/Rz
         1uKIAu1C5fCZegns6iFFSQJoRYcGhpiwtdPNNmXmlv8b8zoz38QKjJMhMvwdNi/cNbM4
         qT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762979251; x=1763584051;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLIWcbWTGCm6uL0osnPTfQ+TcowsSwsqY0w+FwgzNBQ=;
        b=vvy3RFaAJPg0TEoIoRJwZb5sTjlPxx/6bFFWuLvK4z4PcvizPdunYofvhYo8axypeY
         61uVjNps8u1ywtX2v/SULq3ZsbI7tXHZ70/ryslwr3idW1De8afvSh55kV8GlZRgslh1
         Kg77WORkKy5GAKUhem5hkljAPnmWeFQ0sCWkCZRWrIDe4EPduEetlfZ/+Zxlc+NfRbGO
         qFnyTducVbRtVaMnxmgbXHP5bhftAnrFz742A2DP2v+7Htg2lGowFEY1gytlXZ6cge8y
         jBZXLp7GVYvz4SsKrqR0mXAS0ED0a/LpCETFB3CP4fD28xIZ/CCoJ9luRcNr3w6mNdSx
         2hQw==
X-Forwarded-Encrypted: i=1; AJvYcCXyevgItGbE9WiRlBelXBjIwkVNkxG65AlgP+NNzGaz0TVo/OzjqJXYw/hhW6qWj9MyTK80B9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Ob3XgUnauIEnjEE56unpeo95soedSE4wIB8UKBAIuMpc/sj3
	jc2WOkbpRXikuYN4f97pl3DSZ78Bmmf+2IIxBl/gF2QLg2dHs/k49wzSNRFd16h+
X-Gm-Gg: ASbGncvrFT0Q17vVYicnh3MnKWLg5UecLgh7B+3gtPqkeEMJ8V7r4MYhPuFjAoe0DeL
	FJTy5gaam0bp9olQ0SQKM0uIK4VfA5bsWEKPim8oUk1uP0j78fqUtK431UE4GodbmUzz//RxXVc
	vfHwNcLlq7jkdzNoWtD5MFwDTsFjBWB/cXZsAGnPtwcTSJ7BtCmeXyQUxOvgkseYV13hmFj4eSs
	EMQg2gBuFhwyiOfCMOs8x+5vur5DbI495KkhAOegjV5VV1fWM2Mhu7ypprV+bVyXdtX53ZyqA5m
	+9FyIFzcdSZFMoMmShOKhJYKhaLkFAU2CSSs/LpT1QHtcVULSVEWhbJinYiLiNv6ZgHRUN2vTWY
	6HBeCjCVsGhQoRptSpjdN66pm8OwTOXBKV/JXnPV0BKjaYgM09C9MXTaW/OUyMi85OVk+hVGSEf
	yezklIheg7BkOQIw4QAT8PFk9+DoQ=
X-Google-Smtp-Source: AGHT+IEqazzqkIX3gYmP/DkKutcz0SRgO/dq+RYXdbMvGVvreBofbtZHJyjGdltxbX5JSPzLOyM0Pw==
X-Received: by 2002:a05:6a00:2e27:b0:7ac:78d6:5f00 with SMTP id d2e1a72fcca58-7b7a59979f8mr5096934b3a.31.1762979251264;
        Wed, 12 Nov 2025 12:27:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm19823767b3a.40.2025.11.12.12.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:27:30 -0800 (PST)
Message-ID: <c3b7ce6f-aa06-432a-bbf6-abe6e1bb552b@gmail.com>
Date: Wed, 12 Nov 2025 12:27:28 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251111012348.571643096@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2025 5:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.58-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTb using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


