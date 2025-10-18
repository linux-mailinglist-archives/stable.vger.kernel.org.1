Return-Path: <stable+bounces-187740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA4BEC2A5
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D84B427FFE
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224B7126C17;
	Sat, 18 Oct 2025 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wl1kk6VK"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA6A92E
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747113; cv=none; b=anLiGOh6vv5NpT/yY0tH+mLb+abJQRYjMnXMmzLfT2+xJtHuSg8S53xdcslPeGItkLYzPeHyFIVxL6qC4Z6P3NcqGMZ2DC5V3Vc6hDwI8UNY00PtEHmIj/lRWypRNaf/UeTcKIqaaUZq4s/OYvw1V5prS9Li+GUnoIT4v6roxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747113; c=relaxed/simple;
	bh=Boo5q2fEiDnb5Yw1TGoo4/sU1WYR+nze8bhNsT/TMYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esEZY0xbUgGp/AHJyFmHt2P7Du7GQNb+CONxMglBDAoBMf6L6qz78gxZvawOBkW/LgbQTewZaRO8+7XxEkv1x6ePEc1VwvZxMsA58D/g8Bg/4YyorPKT14MjtE/+6dabRD4LYjea26xupKooJGmmHomafcybgks2ZM3kvD8HuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wl1kk6VK; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-93e2d26fc82so226152339f.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760747111; x=1761351911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5OIGFJ3C3vAizbGtOqivJi6yt4VdvmhKJruwm5miX4=;
        b=Wl1kk6VK/w8vC1QrV8iNPCnov3fKqRBaPvSDAmiI7OfNW532RphBDUB7gRiXAgfO+D
         9uAuYcq4CndAsl101ubUI7fXtfRtdh9mfCMD+z4sQTLPmuj32NIQkQZ5zDqDL9gIILfl
         9buv7UFEb3v/iNRC37G9i6x8SVnKtaFJow/dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760747111; x=1761351911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5OIGFJ3C3vAizbGtOqivJi6yt4VdvmhKJruwm5miX4=;
        b=cS+pYdWa5mLs3b7yt4PMLLBNnUbOi8q0ni7+uFJEPlBOFIChvgr4ZnbqhCNM7o2VxP
         GxUdPL8Y76OvoQ4sESSO1d0a3o4zNxRInpW/pURmb7P2xiiqh2NWiJs3ewOUHZopYY2z
         kZx5VAZrY8y3ZVMNAVFlAJArB2p23CL4JU0itAqPTc0sGkCd86Wia7BwtG3rdKE3aKyp
         jnyRkFNgcVwMDH+QRzJJtILZyQDCyFKQ+2p89dHUine7XLpw3kA8hOcE/vMXCnMof+HR
         mJ28jJ+zUa3GVSdwf5PffCe9Pu+gHOj7rKQCQ0wIdlfUl6KhWvN3QJKyXR+7PPI+hWQk
         /lPw==
X-Forwarded-Encrypted: i=1; AJvYcCUUKnS0BhiaZcD9k7ajn2AfleAMFo4RTEf2dTeZCnsRopipWMfJuZuyG5FO5TW9erPa7tgWZ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRYIEdQrx5XGBEsmCy+TjaBTb1OZIX5q7oa/exIUNflp098Hl
	oiveuDMCV8HyxxLpTlAW9LcPu8iypknVMCfyvOki/qG8PYmRvZPb/9vv0zD8K4TKsGQ=
X-Gm-Gg: ASbGnctyya93kFVk5TdjNPfi2ylyYH/W45Gzxd7pCH5J4OiLaLwNCHlVh2N0J8TtQ1t
	uktymc5CNqjaFDMrsi0n2pTwBHQgfTtrKFpPyfOuQmtYoPNQSnxB2v7IhYnq3nUl1j5mw6lzWYJ
	ffj5ibTotDZhAmkhl7Di3tDUTXqpZCOjAhLjaqhJZ0rxt4hiHeApP6GrGJHaeoSKzJfvmLaEGAs
	aJ6Ic9oEZnP+R6ZmYCxHWBXcCE4l8wpka/NhrW+jV2I96dfmmyXjzu1uC7BdQOo3XC4wNPyY6TK
	VkNOpneWpfdscTaLP8Q2CyGSplx1OEhtDNPnx7ervroetevHNkip5PDXh8Y5L3mszsP5uG2ZCQy
	E/tFKKVM2YoCybzAew3GmpD9pvNuoUtr5ga4vx/1hbzuXrCThnEcGNPYotivid5glj3Ad8ZMtMB
	6SjJOqbJFQ7WGO
X-Google-Smtp-Source: AGHT+IHppeA2hPs8LYCDhLY7KevVOdanbHpjE2XQVUuhdAl3Pt8S47OrsMyYRzUyr/ymQV62yGgSFw==
X-Received: by 2002:a05:6e02:3807:b0:430:c0cf:7920 with SMTP id e9e14a558f8ab-430c527bc73mr79338755ab.19.1760747111397;
        Fri, 17 Oct 2025 17:25:11 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d06fa6c5sm4829095ab.1.2025.10.17.17.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:25:10 -0700 (PDT)
Message-ID: <1d63e732-bd8c-47bf-90f7-def9d7235d06@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:25:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.54-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

