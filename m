Return-Path: <stable+bounces-165600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4815B167F0
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 23:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C30C7A552D
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 20:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D92D223337;
	Wed, 30 Jul 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M46tIZ6P"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2821E0BB
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909222; cv=none; b=qdliXvZcrzLUH3lalc1+1uRFoe55aQ2/HGTv3+cbXSTK0Nlnc9DatOiqHa+0VUFzT3HtZDMH41r9zbO6BmYt0Kcn0S8AcOQE9tiAmUr62szzcoU+D8+AXhcFfAQHBhheBJ3+34qdX8ZYdYQJCZDjDL/qVinM5ex6nup6x/iRQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909222; c=relaxed/simple;
	bh=qYO9XYMd9Ess2LLFsyadSHoQze0pFR9pSR+4q7JxSB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccn/S8vzQCF6xhe8PrxKrZNMpGO5VKCw1XUvcB89sFzp7CXquJmvNriVGJsNGykfYo5F/V7ibIpTEHTYakqYw5q8fXfDDMjsdJPyinpG/poBwNcA7IPDI+VvptqXwYg7VtiitwujjpkgBJ7RjG9Jx4fTh88FmlJacspdhzm87mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M46tIZ6P; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e3ceb1030aso1339695ab.1
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753909219; x=1754514019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nTYoBlbWe2hufH9UN/C4sSrgwEPP02z/hVZuVmtCWI=;
        b=M46tIZ6PXfLfP52r+SU0yCBUE/63HE/9r4avOn3XDSE7WV3r10KYmvT71xXH9/wTF0
         X5UHPRKDEX5yCEkKm3lovsX6rM6H7Mg6HxTD8Nryx59vPb8JkshwFfo2hoRoMZrmgydg
         Fmz0rtZynd8g79gEXYbS313g1OVw+woajmNoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753909219; x=1754514019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nTYoBlbWe2hufH9UN/C4sSrgwEPP02z/hVZuVmtCWI=;
        b=P1fg+vOo45AL4MmXqBUgO7DTpgQ2yCeOR1ihfmD7sNPyRUBGfYpTmoC9AJkjIBs3VP
         k0RJQAQ49WkBfrNr++VT8Qd8WLz7QOKTgknIto1j4AaG9PrbsmByFpHqhmx07uAZUM22
         3D7X6yK1R0/t0iZzrtdwu4M/ivh2B+oEAVI5wqM17SwpEXO5FZe2lEFnOuTUSAMPdQtn
         1H+e49XTR5ifIOPbAzHielt0huqwWAvwtwal5BEHQVo/58ZaQMmvLWWeoZmiEu+Dz2+E
         4snvHqUoOcds3PCnssmNRzyWKjPPpbSZODO4Iokzx5HyBJRrYfvQR7hs5aSs1LNixfR4
         7sRA==
X-Forwarded-Encrypted: i=1; AJvYcCUvuD+ilfltf9RzPf0dJuTVq7LfSJADiMvy5HOql91b2AEcbilJ9Tpr2qN13PIFc2+LdzhoQaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzozV44Uq0VRRuVA/8+/GhlNN+bTbcmwAhGYY0GE5MBgVPzBZFG
	SE9txPRcpQmMp5q6qnSs2lVnDpvDf2TpuuLaQJW6O5+uLBeCur4vgIKdgpf7Q5F7png=
X-Gm-Gg: ASbGncvZfadJVv5j18dKS6UGyACJbw2M540t0a4wIh4huKq8sh1BnLS1EDGnUAy1Lx/
	hImZjYpdLoDLKdooAC/gj5jWITK1YJ0LyBORgeHGihbVSiz4LpX+mFveGPTh8X+CTr1NZZsi4HM
	ZOIjpe79gYIEksKcG2rNMNhwEbSl4tMT7jj2tsDBstIAHk90/6TeZFn89HaHs9Lu2n/a8pmWyTa
	OptGx0iiG/FmePE1FV5H8F4V9XUNnGz286f4kS6HwdgtHMslrpmqM+GzUaadlopSK58Nv3oDVZL
	1+e2e2XfGjteSNxU9l8TcUSZNVwcrtykx/yrcM9IaXRvZr0TcTOJExHWuj9Jprke2K2wYTMNtHM
	/MBQiGYUDKdCk6aB0Sgx7AFNkEy06MoLkqQ==
X-Google-Smtp-Source: AGHT+IGjPEbPegqBnEDpd/XcqciAKEnaO2geFGrPEn0TWYZQKwLtS8S00ByN+2MQJrm5bjkEbIXPWA==
X-Received: by 2002:a05:6e02:240a:b0:3e3:d50c:d657 with SMTP id e9e14a558f8ab-3e3f60b6207mr86671535ab.3.1753909219396;
        Wed, 30 Jul 2025 14:00:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b19250sm59262173.5.2025.07.30.14.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 14:00:19 -0700 (PDT)
Message-ID: <ba33d960-df47-441f-8898-5253e685ed2d@linuxfoundation.org>
Date: Wed, 30 Jul 2025 15:00:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/76] 6.6.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 03:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.101 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.101-rc1.gz
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

