Return-Path: <stable+bounces-163180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1CB07B36
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970883B593C
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0481D7E5B;
	Wed, 16 Jul 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta0lX8rT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12818BBAE;
	Wed, 16 Jul 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683506; cv=none; b=IpCGad4+6Y6QKkAZ1gjlWvs0f69bdTrK39vNrcbX9AiEQmZvEhwN7FLWnq1bwAIlHrLrOv71pGeRPkemWXx6cShXcEtgPRBjgmNH7wY6Gm5HNSI9HZnnN1sI3bynBgSqPfoPHSqN2mmzEYmVZjI0KN2EzLRZhHflwQsqjSDDOEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683506; c=relaxed/simple;
	bh=lH8hAUXwnGmTTcGNrRpWjI1TGsdhwcEl4A28kANBwbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kn/77ybMUr47i5ieTm5ZWvip9PxQDJLR631m34etPFSlDLevj7OJAQEDrhksmbGIhr+nFc8EzuwmvNKvUwYPeUxEFX2abaRpl2bkqE3u00Eyrh7vF/jc7Q42Ag4jKE6mKjd688wyYyBw4dqLwbIZLN/M8TInBZg7Ut6MyNEtU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta0lX8rT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748d982e92cso108880b3a.1;
        Wed, 16 Jul 2025 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752683504; x=1753288304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JdkAV/hTgwELk3bnSKdE7d9fjboMsrDzTTGP9GZNiMc=;
        b=Ta0lX8rTpml8VfBQ/kvHu5ro3KmrywvNu8qWz/KpotOqVbCWIiT1+1sfmEyx9PjbgS
         P8a6iQ5cByFJp+a8fM3TrfNaK3gRzpoH6hQkA/D3bOhXp2AbRQPlwQeJ1gTdYZVnRBOK
         5Zt/Yj28BhiYovLMlDaPTfOFG+HqHoGaq4Pkahhyd2ZkWg8RgSvluLiywDbEe4he6MLg
         nDNFnxKPup2p5kzei1VqkJ3v5W1+QJFs5bg4SDe7L6s6QTJitb787iax6xN0MzSQ+yBj
         IsUAmB/xxQUj/2lqdzZEpWYnsJikmkWg1K/u/Ex/yAl1nXyZfoLdyttRW1ysRoH1dr8x
         i5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752683504; x=1753288304;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdkAV/hTgwELk3bnSKdE7d9fjboMsrDzTTGP9GZNiMc=;
        b=as6aVU6dNzuRLOyVPDCg8shw88N+92rozOtMuLTL2t17khaNaPrBXkM5wU57o981ck
         f9PrBVhY81BdyL47J6cIqgoGD+NTAPAI6sW6tfe299tIF7O4jmyHl4fO/UtNEb+jOw5w
         X3p2SWTeqz+8Bpp6sGFSOTlslQumFsl0E2QX52ZzIhg/QmY3WrlUrpzS/YS51Q7lfOat
         +8NN1TvArl3dzijy3+1VwdBpolklSxLv3Nlo0mljvHj8ENRLBCsnny2aDuNWwek9s6Cj
         HJMcWDvmWL9xaaagDkyhtPmq1GUD2kQX0/7DKF0094DLgrNhR5XUTWMwasuCK+TdwMYW
         Md+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUECpArUzua613N5RIbMXnR6Qxa4ykHHPtcEiAmKuMbjStwg7j+SAlh4JLJYnEAD2I8cl3dhWx0EMvqCtY=@vger.kernel.org, AJvYcCUhn9/8AcH0EdDyWV+WLnND0c+2DdWLtznQGIKuaUpbDYty1P7Dq08Gc/vP6PtOjBFXQENx7qc2@vger.kernel.org
X-Gm-Message-State: AOJu0YypHHtapWfMGbnEuqjSfc2bXIUR2uWAk16WSSpByWjvY4eLvewz
	MYwszDtybUHWxp2j20EZgrGvTsTBsbt0fqwHjApHDpCFkcIcLL0ic9Nb
X-Gm-Gg: ASbGncsf//7DUKx8lyX2CdSt/MwKHVbkIgKV2e1WBT5InWuBXUzkExgmH/G9hjsk4rI
	es45o/DXtcGzf8LbAkxWzyfhFAI/aXosoxwkW5L6gM5qqs9WhYLNMq7lR+54wf5sebxvQZvWm5o
	MJvOAbuWbttC63mURqzD1zVel4fn/u6/edfwgLO84MmTUEWuymAzdpltjeude+CGWgLn5Ah7/y7
	jynS3VpKq8mLGwy0VmX1BQqNPMlECO6austvko3rhntNWfhZL19XOPeRlMfY1mBpjwEgKtTqWJ8
	vH1F1bQpgOgqzqNqsOoM2BE5a6aanuMvmLPntpW10pfmOYQUtsD15gAKkMUd8PfgraEs3YTbmgT
	ytjmItGj3pdP8Rtt72SbbIQKqDB5DE3Xdt2vyk9+vdKSJaYAipqeddRQt/cRW
X-Google-Smtp-Source: AGHT+IE6N+g8dLd+UH5gFcF4X5IjqUvh5bFoXwdR8iJ99kiBcBlrG7TWst9ORYH+7rAEdiCP7weYRA==
X-Received: by 2002:a05:6a00:17a2:b0:749:93d:b098 with SMTP id d2e1a72fcca58-756eacb78e3mr5111283b3a.22.1752683504048;
        Wed, 16 Jul 2025 09:31:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm8580799b3a.14.2025.07.16.09.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:31:43 -0700 (PDT)
Message-ID: <24f12d72-e747-408f-86f4-689b4ffa3cfd@gmail.com>
Date: Wed, 16 Jul 2025 09:31:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/209] 5.10.240-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715163613.640534312@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250715163613.640534312@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 09:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.240 release.
> There are 209 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 16:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.240-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

