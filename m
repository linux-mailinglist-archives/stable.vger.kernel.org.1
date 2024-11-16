Return-Path: <stable+bounces-93663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 870859D00DE
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B5CB22BA5
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CF51990A2;
	Sat, 16 Nov 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWlMXgYX"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4C194A52
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791167; cv=none; b=ZP1UPwIWk9/+GpLqshsmGtHekpuwxA1duGO+b2Lepg/ML944ifjzS1z2nAz3RDodMXEK8Cv9ww1my6eKzB0mHvO38JSIpfSJCUaYZZBwx/bA+lKPY5GSHqOk8xe536ywlnUPAuUmAqkeYcMHOIbKHLK78FSD0NHhJbiW16MFybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791167; c=relaxed/simple;
	bh=wn9xCKXToTyI9t1rtvyW1oEEfrLH5/5AdrmpGh/vjL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iu1Xs/p+I4dNLradG3T0/r3TbIRgEAvH7+J6mCXdi5T7lfaSGJ04VFlUSTdSRMY1rJ0F/gOhHfKMt0B4Q8sSJQvgQjtJ2stqwp4BoZ26K2WbT/TzXnLnuqe3T6R5P2cp2F+tXJel8AUr5+TeR4DAyQKL+9Utl2vI5vjmgOoMVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWlMXgYX; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a6ababaaa9so6767995ab.1
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791165; x=1732395965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AbCMuB3hBadpOLkxJkWemVNrqkK9LRa2QCq3z5Qco=;
        b=WWlMXgYXDpWRFsPWMH3jnAYetiwTUZhp9tAPTDnj64fXNdoVPQwhLjMWPCv2nje3lA
         FG0oSWCJxgouN8Cyu550he/ofrS+DakSmX+9H9I6SipH+KgmIvmKhnjfoiAr/4tAfA4N
         C/qTM3jLoxYdYQcFDujr0xR6CLnu7JhRsixd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791165; x=1732395965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0AbCMuB3hBadpOLkxJkWemVNrqkK9LRa2QCq3z5Qco=;
        b=N+2/aMGhqt2LcqOqxkTYjM/M/TWXOizklq4Jxll6U6AaZn8YdVvhElY0xGTBOMyEKQ
         jqDjq/W6S5gH4VEDPvIIMn2ZrAAzGf1o0QPR9reXIaxH6ekE7Yb9770qySMsTxGL5aKl
         9likHWXN/MUN3mzqmf6t4uAp+LtJ7PdL4ZOTcrc3w6xh+1x5/qlhxM/LzFVk40PvjqIo
         ZYNU1M0hM+79l/OKGSkt86DuUOEHEK6ImCz2KzRt5VeLlYZB4wfEpKnNGgMFwZiqg3Ef
         VBCe2qXR5DNBCTki8XJ/b8DhjzKSgHnfa1e1X3DHxHB6V5DX/O/vl6L7x5u1yFjr3C5j
         /bQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPptqOekB5IwHT6PwwNmZFD5Mqi5ajhD8uG2YGQPUBva2WpB9j+J/q0x/xkyob9dsVQUGrbCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6v0KyhxYnOss/A1HSVK/RvC25TvQumhhiDs0YUo1sbZepuSJh
	QpDzlLzKFEqFnxOKRsc20Y3kF3hG+ps/5bY0ANQElWAloe2HpgzS8tFfrwM0NvyhfJl210EAtq2
	3
X-Google-Smtp-Source: AGHT+IFLAGWpLruvWVct/AIomQLfHk786eMYKwC2cfKMYTqTaAo0hlwJFI62U1jwxMViXP9d4Ur/sw==
X-Received: by 2002:a05:6602:14d6:b0:82c:eeaa:b1e0 with SMTP id ca18e2360f4ac-83e6c12ffe8mr679102039f.11.1731791165065;
        Sat, 16 Nov 2024 13:06:05 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6e7374sm1174251173.32.2024.11.16.13.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:06:04 -0800 (PST)
Message-ID: <5ea45f0b-bd60-4603-aed0-10f70e77096e@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:06:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/48] 6.6.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115063722.962047137@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 23:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.62 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.62-rc1.gz
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

