Return-Path: <stable+bounces-185715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6EBDADC3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D011F4F0AE2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 17:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595B307AD8;
	Tue, 14 Oct 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZibrZNOT"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF12F5A37
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464474; cv=none; b=CQXRa47BE0tzE7xDGEGEkYiV9NNgLsJ1PiumlnMvCQfv25azDW7K3XHS2OhTibyejTUID0O0WFJ8QvB2j6A+ql+UJpvlvQ8hNXIekbCxD7mTMkV/StZw2pYhpbLZClRW6YDQiNTRlYxECi+bvgJVLMgThayz8s5teFzE/7BebNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464474; c=relaxed/simple;
	bh=3MmYi1JoNQdXRWMSOtVp8Kdazcv+3jagEkZthqrzwI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpJWaAZnRLbgGiEmNdL9ce9AAAoZYFZ+4U0QJzcOLjOfv/n8CHN7JZOVhn1iMnwMy2N51mOeyPOG8YDScAiory05AwYEh2EyTSLP4+n0Qu/U9eRlbsIA0bsexpzDw0k54hjFs70a+UV1BZaK4dr2hfJnHuRD998BAMlpBHaleDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZibrZNOT; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430a5fe0c5cso5984595ab.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760464471; x=1761069271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gseXM3xre7+2r0O+6iOJ8UCID/6DfgPEO9X0+p8TwIw=;
        b=ZibrZNOTzP+AVHvxcE03N1aTFa6mkuFN7Z1jNy0Dk7kB4gYdKyQVbchWpNgfmfuUdY
         El0j4q1Wi/HTskXL2VGh+wW/P+4yqlHc7ebaXnrYhNhYi0JU7tjZDU+5ZUKvpeEOYCwW
         N/+eFiFRS3tlhj6vEcF2lZz3RqsmvvkGdyxVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760464471; x=1761069271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gseXM3xre7+2r0O+6iOJ8UCID/6DfgPEO9X0+p8TwIw=;
        b=IfOVLnQtqOWhdt32zEkZKTFl2WTX8W2Sb3pyGfJiZIGX7+Z+nPIVUF8mZFH8JEgijA
         iT97w6oxwseVExuEgAFuSrFS4lWPkEchiYKMZlAvz2ppQAbEzkfuX5U4l4L/if/7kipd
         /PRFvaBZL6z6/Lrsknrp9HThlbqFyxku8vIT+9OgI/UokhDLi+sJ3lE3Npky+psgCqkx
         axY3lYxHQqtnNY8Hwm8u7qe0+fdZxYPkB3ufnMQo2oNlL8Opy7Ae+nKbhyGUEJGxa9Q8
         dsbWbs2K9YzgcaoIZIAuXQK6KfGcaR13PxpIdX2TU99hQoDlYIp1uqiJ1D8gfth/m31o
         eXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnYMX9/aDUS6/IEIhjFlKQeWg+3lMmgQSSoZcQ7xSzH46s/XJg50Jyn5D/bEmKZPAdLJLyXz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDfz2zdImYndqZ/3xJYWMt9aLhyhNUr1VrQ6sz7EK+XPeRCUy
	vG+8d37LpSYXJPYakaYcKbHQJWsyYuVoBJFWD51clrCuv7a4vs5A2XslpU1sOdWYkbnlQSqYnkC
	BFwPi
X-Gm-Gg: ASbGncuyJ0qBn0VtIx/1bJGvZOFuiXrRoTwQ/PF33GnWJwY0zrtlIcUlJr7cWVRS1yK
	I+V8Up1Es8FK2uyFRAFCEX4P0CanwYzVCCYF6ldUl4YaiLOgrGEXRH5Cg/jrSNOvIKr8nNh+3qT
	tAPa3eqWCOuyo+UYgAH7SaTyaoiDImakNpJY/BPoPRRDQVmZZSYpAWvEUsRGX2by6kpIg6iFyy3
	isKKwR9DGAFEeqjJWZs37wBdk/Y42ysLK4QcVj9q3UnNZ6OXmq98ykTt+VrnsLeseeC3AzIvx/r
	FOgR6t9urV142WT3Lfnu90ZyaC2ZyAJqxgeOaAhlb0ISXsR/Xobi+pk7O6+PmAS+jbFrU4SAEyU
	U5y1g/3MkeH9p15bSf8WbKgKoNY0k7QrxRqjSpB2ZwYSs6N5xKFNbABkKwNnJyVNfB0v7Qt5BMA
	A=
X-Google-Smtp-Source: AGHT+IE9FQ0RqivT93CbQNVR3TRDywFKmKjMA7BmDG66JT1FsSkEi3MfzaXsz5AoqvIulaE8YE+msw==
X-Received: by 2002:a05:6e02:1b04:b0:42f:a535:4120 with SMTP id e9e14a558f8ab-42fa5354357mr187377375ab.15.1760464471589;
        Tue, 14 Oct 2025 10:54:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f7328a26csm4930728173.67.2025.10.14.10.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 10:54:31 -0700 (PDT)
Message-ID: <ee0b612b-2266-474e-b0de-b70ee6c392d7@linuxfoundation.org>
Date: Tue, 14 Oct 2025 11:54:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/196] 6.6.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013144315.184275491@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 08:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.112 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.112-rc1.gz
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

