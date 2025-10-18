Return-Path: <stable+bounces-187739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0DBEC29F
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF8C424FEF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8659A13A3F7;
	Sat, 18 Oct 2025 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MgmskAGl"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544274A3E
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747075; cv=none; b=T+xB2NFEkXN3e3i/Z49uuctNtaFFqh876tGbkbt5VzVZS3CNYAY/GP2W4ZJEMCEPayM6y3rSlZ6qR7sgyD35VjOMWrT2q1s91U0ONBgcHFkuYqiIQnUC2nQpyv4OcCciAUZClSN5GgpFETbdBvd4c6iFTguMixyrEeKgvUenKJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747075; c=relaxed/simple;
	bh=U9IrYANTsLnJeSvCr1DnvWP2LKuNICWu5JtEQxnWi2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyG9JNzRkY4k89f98Bp0s7AJoVzDdhEYi68VDdjH80LrQSS35wRB70ts6MdM33H/Z2lnSZOrIaUowSwsaQ9wSFl818jVE5oBVpJr9jb55pXyg4aGoL0C26AXSkXQb1UYpD89QWE8dBS8yVCLY/hGEH+rvOQVf78YgXpgvZzaMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MgmskAGl; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-911afafcc20so106126939f.3
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 17:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760747072; x=1761351872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnmqLG6mD8qqWt7UOjgypO2NRulVIOp0w81YmvKj5/o=;
        b=MgmskAGlDarCSTX2cpYtvVL/SZtJsXEAJz2U5IuviCmBOvOKIs1fOpkLd/xg0N/sOJ
         +J6IJstL3RxBxa7oQRcuvRN2edfO3Bz5QIG2yosM9fdi4GPdj3MOEI9ShZptCoBeTUh0
         yvTnwh8WxLwb9ud7yufGD+E/7qjDJALAwSpRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760747072; x=1761351872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnmqLG6mD8qqWt7UOjgypO2NRulVIOp0w81YmvKj5/o=;
        b=QVrptde72MSoGtsaWSoZ3yPY7iH6k/ZsHcwoB4ZoJIl4QTYW4MzAFllaq0VAqdveNZ
         DR02YG5x8UA7ObY1fyMbOv/uco4bEQP6JaRrZurn5TtOFcls0oW1p5tu4tvyAfHBWYSB
         oIissUSqlloLXFZrsCTXYicFvwgwF7TZuM5+12s7UlS2VVT+OgVcdFENcB+x2dvnTImv
         kq2JhmkyFhFhM33nSwXRxiEDrAlPMn2zYh/yh7aLmSWdRWH/jBk/2p6gyfp9LciTOMok
         gtnjz540cTa4EiYlhTqKQmQHzQ80WYQQNump0MYOb/bEEWNNER7zntmf1672dUdyNEK6
         2O4A==
X-Forwarded-Encrypted: i=1; AJvYcCXVzbrwCa3UpDY2z0E9+RRVvtyzaJTyFLd/vfGenKl79J4CCDeNQyNg0uG4SWugNBLuDtlFy/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tFyLI1/EXipkcAwalp8yY8YBOmjJuWq6cVvBv3g6wvgy5myA
	oK8y5SquvwLO1uJckUuVk+rwTvy4ucUxB95/jOCaLBLsW02nmDBOFNUBNUAm209TTsg=
X-Gm-Gg: ASbGnctMdp03eC8K7HpmHWAxBxhmEmMS+0DcDYFhM/tS8Mh5knAD1VLHXjf3oZJK2++
	Z66GUP7lvFm/PL2rF3QnqAJtC2ei9hCeTscUHSQkL3Aw0DDRM9QknRv1EJrddY9KVLgfQkSHnHq
	gw2L0gdEbNcavpOA4JWogCOaV1uzlKDVZdh9Qd51oX4ojqShPghswp/xGThjsfWbsbmBBvzQ4rf
	1wy4mARRZhAjcqRMtEp+kvGTKIJx1K/zJFFneMnlPhoCFufKH3KH5aZKKc52YR1qif1NE9ONo2Y
	wyip/eug+tjjgMonsRfGzsbxh0VIvBJ3aGLJ/hMrORjRSLdJhdPCvll6IGJBDNxU4qUWj3OU3iU
	KcrTBjVMHKYxufTEvk+AGcXKstY5K8Yd2NBsMdWlhNeTn6XxfZ8cEvyBAPCAyvZ5UtYK3LLeSL7
	Y/+KLi8hw5+lMb
X-Google-Smtp-Source: AGHT+IHx8toFL4okOKYH1BcXiwIuVau+vE6aOwtifNCHVZJjzx9BtPHT8riQx+rY+R82cWq9XNmtlw==
X-Received: by 2002:a05:6602:2dc6:b0:93b:ac2b:d63b with SMTP id ca18e2360f4ac-93e7634f25emr896183039f.6.1760747072392;
        Fri, 17 Oct 2025 17:24:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866cad8fsm40199239f.15.2025.10.17.17.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:24:31 -0700 (PDT)
Message-ID: <bcf10471-28fd-4949-89e7-fc1fe9e5df94@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:24:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

