Return-Path: <stable+bounces-58952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93A92C688
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1394C283BDC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4130187541;
	Tue,  9 Jul 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hZ+9jCis"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DAF185633
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567303; cv=none; b=OiP89F2NhNIGLGSo8at5M3dWuLtN3MSQ+qKD0kjQ2p6ZuofW+36AB8gRB8PMvL6w7q/SBgs1Ed3OVXSK6oigrJJ3dvfd4cW9Wye3s0eWLLo3DAojQXiXq0L2V8E7gsHboOR1eNnhMPIVUMcsv4TLMHIHywY8sEZtQd6BqkvN8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567303; c=relaxed/simple;
	bh=wYSd1d6I8ZUz1jqN17N6LbvE0OS8wU2J93GAQX84iyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9o44aAFXODixylq4HkILsGoAFMX/PnMn61I1f86TgwDogDXVwm184LNbpUCuE16PbeobgLhZ6qWMbEJxC4/SM4qJ63K1mq4K/B+j4WpnGy6loEXkr/t0iiottZX+rk/X5NArhE7eip6jJ70MgN7rSRvxYpnR/v5sCf6G3hx8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hZ+9jCis; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-804cba4c8a8so296439f.2
        for <stable@vger.kernel.org>; Tue, 09 Jul 2024 16:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720567301; x=1721172101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WG9j90n++Fvu60GxgS8Z+nCwGoQEOG5JEx2i5UYLsAc=;
        b=hZ+9jCisKjPo5rs6JvECKguDurC/ctPsP+PZW0GsrWuaxvwJ0QfSOOXFOTHqFGJ8tf
         Sl59Plf2V6YTYAzPR7S1fLndPzkvPvs+cmTXP4ES3e4DufIqOGrOOr+3sWHf9uqPPTgt
         3edVvSwgZue7Pk+VH/AYzesM9Joo/txnX8jUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720567301; x=1721172101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WG9j90n++Fvu60GxgS8Z+nCwGoQEOG5JEx2i5UYLsAc=;
        b=s8vx33KTUpI5fsgq/DtYaa1N7MzIP9pCVlgnRxmqtuBueuaNFkrmCs5vQpxCw+JNc/
         SJnwL3O9jsGp56NwKM6lFG4F+3JjZYpPIONdtg0QewnApFK9thsK9cpfnKGvSp5jb89o
         ehwRReipCDdHgRUURc4W2Dyl77HVH/Yu41h88qlNPE7WiCYcsX/gSnNIKVFmiyKN1MXI
         bd/nvci6u8KD3r8y/nAYq7hWQ1AjjlpLD1o1jEu9GiG8cZWL0eSl1MOHnPX4N5rBzahA
         FNt4NX4XVmR36gILqgxZqpxb/aZ442vDEXSfPw6MQqWUpSDm3srixiu/j2UZc6LahpRc
         qzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF4pi314kXD2H9WpZRcAUlsGppLsgCQCHnhe7U756GeiGGE3mcdKG7aQQVngQ+VXV7AIxNKBSlUTj9X0ACUHfToZrA0obm
X-Gm-Message-State: AOJu0YzTHFg/kgSl4jSShk6Ycw6BEQHruUaerCo0fkt1GwnOTPt9x0aL
	Tm/ZLf0HEFwNZDduFld6ZP9bBDiBxXDTz8XdxZunll7UVbsrPG7SfU1M/1CMrUI=
X-Google-Smtp-Source: AGHT+IFtqYmZLPesp109Cd+MRvaqe5/TB2ZO/K0QeY0dpk5QpkVwCgb7Gfq3oMR24v7vXdmWrHhPZw==
X-Received: by 2002:a05:6602:6103:b0:7f3:9dd3:15b2 with SMTP id ca18e2360f4ac-7fff92c5be4mr426238039f.0.1720567300930;
        Tue, 09 Jul 2024 16:21:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1bf8601sm764761173.105.2024.07.09.16.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:21:40 -0700 (PDT)
Message-ID: <4fae91d2-5de8-4bf6-aa9b-25f4dc2c5553@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:21:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/197] 6.9.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 05:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.9 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

