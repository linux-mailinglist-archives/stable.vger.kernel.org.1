Return-Path: <stable+bounces-61300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F32B93B38A
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408401C233D8
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388815B135;
	Wed, 24 Jul 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJBsegpZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4B15B132
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834619; cv=none; b=Q3WNZeWb2FVNwKuTl6+sDNkbwj8o+O5OrQI/Gi2zIwWdOCiB1rgMw0N8pgeR0fH79yW3nbXdhyhbydBhDnH88w6YMCX3i487AAZY8wLVScrJPetmP4Erm0ge++wSQzKfPqIqx8ISntPnne6YPIiHde1+FF1T62VgmnCn4HGPXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834619; c=relaxed/simple;
	bh=CHwhPKFP37wEpm/ioN5s8uvmJdD/vQ3tGPOtk/Tlpfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dk58lGJIgFBKe5ZT1T9byhWUswtIC104CP31OB6nvZjAtt7eb2e8CUZXWqpMjLdUEwxHkpLJHvjye4qYi73NzjVpo7P5TCG6UKNVBzJ6Ci5Qof6dZOvHCgSiFPIHKMvVgaKT4z5RAdkXr4yXLvGjZa8kVAEx0dxMfKnlE5APobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJBsegpZ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-805f8db779cso38771939f.2
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721834617; x=1722439417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+2nty6cjNc6kUit4UjMRd4RIDNniOKhIQiJ55zs9FY=;
        b=JJBsegpZX8BEzOyNqh5eAazcHwUOssJn/oF59KsBMteL4JA+/Jg8WYJLRuRsMsvpOr
         vZBcjq5mFmYt7t2vfxjRc2rFnHCiluUd3a/29E+8xYX+w/d5EEvGfgNXWHxyIGYLhopF
         YfQsXnSi8PA82r/HZQrt22Wsn40OSCRyCysHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834617; x=1722439417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+2nty6cjNc6kUit4UjMRd4RIDNniOKhIQiJ55zs9FY=;
        b=bJwwW4xpsRGsQKNYrptnP4R3gJao4Qc0z/eaPOE9zD+vrEeGDD0gYmWIyHNnprNUDM
         eHHRe9qktViR2hFu3dreC+liZBTLgprFAvwemVeLoXs4vJui3fHIs3ZHhliyDz0DoxU6
         bmXLi/KhpOnvPWXClqIA08s0c1ixmgyIbRrF40HD8StP3ninrH8IPOKGr22Zk7DmBnkg
         SQnJQBINKMfXQVbZrOdnyWjBlJtq4l6ftKF3YUVq2Zb3Gznmb/cLobD8ZJEaVXM2cqWI
         RF1RnVrESbumbufRWT8snVRWGGZ2auXeJ5hbGgM5BLYfvqdntoDR+YWAjLbxtw8cLZX+
         71wA==
X-Forwarded-Encrypted: i=1; AJvYcCWsTzXMUYGfCCZUB+UuAyU7QiyNfkN92S0PcEdG6xh+oMQYKCKIILhwww+UlB1lSliRjDoWliA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZALSBsX02upttxTREkOpSuE2SgBR5KexC/sZ8RbEKmtmrR0v
	1nzPBKxpdNTpnRAKyZg9m2oW6d631li7KUj2g5DJPTmBuTSX2Uj3ygAKlevZBd4=
X-Google-Smtp-Source: AGHT+IHNPxpp8b1HKi2Mg5Fq3XRzdS+oQvqg3rS2l/yx6aMy6ymrH4MIQSeggOMeI8AVRwRXP5kH7Q==
X-Received: by 2002:a92:c262:0:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-39a21777547mr710255ab.0.1721834617131;
        Wed, 24 Jul 2024 08:23:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a188ff9b3sm6772225ab.66.2024.07.24.08.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:23:36 -0700 (PDT)
Message-ID: <3915beef-5428-4cc0-a3d5-59cdc1b6b35e@linuxfoundation.org>
Date: Wed, 24 Jul 2024 09:23:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/105] 6.1.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240723180402.490567226@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.101 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:03:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.101-rc1.gz
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


