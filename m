Return-Path: <stable+bounces-189012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AC9BFCFB5
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C14519A323B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BDE2580CA;
	Wed, 22 Oct 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IEShXZIn"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A3254AFF
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148605; cv=none; b=BgYHb8b//iPAPBrYLTghrKstn641fEA+E/vIsFXdjLC5dPL9loKgcOVtHWlhhZvjo/nAdTWP7OvFnORXiRHGv9xN8VRonw7nLVFeyzB26ujxHHZd1mJzLaasRL9Djk5NbDv8smwRcKSEuGNnjsI+ksYZsgo2lPoD8YSKts62XcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148605; c=relaxed/simple;
	bh=yZxdIcNjsvsepd/jR431aaY3GWoUemNnmmdOtuw8xT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CY73T0/NJ8oamuT33SFh1hegs5nXQzNv61ygfatPEkykygpti7ZvW7Vm8PiRZPV1QXGX4m3UH+3KzcwjIRFZPtg27NjXduv4r2+DYR3hIrd9Pg2U/gUEloaczNewfAegUD3+P6YBJxYUpJykWJenqt0y3blUuyRk4e1DEP3LgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IEShXZIn; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-938bf212b72so296323539f.1
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761148602; x=1761753402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpVnSWJTgD2kkjsIK6B5EZxkI+BQNyamIAMlFJBOIaA=;
        b=IEShXZInlVIhkEXILYVYrV3fXf3MRQaAeeTP9eS+gNcL3u5miBtdj+nN5fmvGYOlFb
         b0FOfPq5mhUvXAD195DJE6tw728iO8MKd1I8Vmfdoe1fBBc64CAzwfM3XC6pUI1aovrQ
         sVPIwZBOK3QHFG8Qv8Kj2WE6XevHBF7eqRw/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148602; x=1761753402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpVnSWJTgD2kkjsIK6B5EZxkI+BQNyamIAMlFJBOIaA=;
        b=lEO+f8SejmBYAaBt+OluBLzCGCfbWQm2DxAOmlu+5ahqZvJ0twIHhyNXTGx7+sidd8
         4xghm/Tsh3KlKoRoUyZWzWzhPvwjaMAoEIozCK7NhPhaqjluEBkBt5WtqwUMPze9LmKA
         1TxmTao00RMWB5T/CXyZ7H8GU2SUo9WpYSanKia2Ils6pCATBJEE8ZrMioiF7MnSDye8
         9kn4ombwU+pMxnQ9xyFl81s7Rtitbm85a0L4F+cp9IbaACYmcKHIlwIOi5teH97GNgi3
         LbwzmSjYls83xEx0RqUI0ppESgOelCLxYBM0m1a17L66fKLPK+UnMkhwxwdhsHvzUzAZ
         bS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv15jm3KPGPEnQIluT+k/Jcn+uc7uWOa99WwMaAZyQhs2cq4rLz6xOS+X/qD2U4gQYtYxe1aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9zoUJ1nCY9W7YJVdfLKYLvBoIY9d4Zv7z//QPB09Q6I//6p3
	QqOIWUU9v+SB04se5GJWZoX0VeGdOygk+1oJJ+WSzQl/OY92Vb54d9lsiFmZrJz67eQ=
X-Gm-Gg: ASbGncs94hLxjC7GXoALy7W2qU+Z05ZpnFVeYwHiBZF6K1nuRmt7e9HMuIO9RnxtUdN
	N/KHBXXFjLqOxwOuSYqBDEUpYGQEr47/v3rtmJBRpw+7KgXzInrgu2wAlybyU7z/aGPsrYnV+62
	X3akiEcQwesma9jSacNi+fTXZFSUfonmZgXQMKrZoaYbmy74LZCcWT9ZxmE0iLRQkvh2d0hRV0y
	/Bgm5vPu3383cFDoy1GDNpkcK9gWl1f5JVKoBnVwNkA3MerjVH1afIjK3zJxMRIvfGWjpJXQ4WF
	m/IGhtp/UIbB1Avbar7WKD/UaAS8bQebAXOlJVkho3pRqXw7rB7+rxahoM11ZYrzImaB98+SDAZ
	HSNicl4hTAxo7/DIUlJdtqbLVZ8wiCrPDpMHmWCLst16v02h1ngvkq7MJh7GdjaYrZaS0I2xXks
	GHrQMwjOdjZtKa
X-Google-Smtp-Source: AGHT+IH+q0EsPvLLPOT6AkCFc3G/awB3o5SJxRzTQyoyquh1E8IUgNyuxjCWbZDUGJ1+3fGtEEZu6Q==
X-Received: by 2002:a05:6e02:4711:b0:431:d63a:9203 with SMTP id e9e14a558f8ab-431d63a93fbmr23185375ab.19.1761148601709;
        Wed, 22 Oct 2025 08:56:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9451918sm5225944173.0.2025.10.22.08.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:56:41 -0700 (PDT)
Message-ID: <ef7fd14c-fdcf-482f-8af4-115f090caab8@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:56:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.4 000/797] 6.4.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20230717185649.282143678@linuxfoundation.org>
 <bd81295c-d448-491a-91ee-bf07604bcc69@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bd81295c-d448-491a-91ee-bf07604bcc69@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/25 09:54, Shuah Khan wrote:
> On 7/17/23 12:58, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.4.4 release.
>> There are 797 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 19 Jul 2023 18:55:19 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc2.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> 
>> Mario Limonciello <mario.limonciello@amd.com>
>>     drm/amd: Don't try to enable secure display TA multiple times
> 
> Verified that the error messages are now gone with this patch.
> 
> Compiled and booted on my test system. No dmesg regressions.
> 
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah

Please ignore - wrong release

thanks,
-- Shuah


