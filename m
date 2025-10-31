Return-Path: <stable+bounces-191968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB61BC2721D
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 23:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E10C74E1E68
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 22:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B022EB84F;
	Fri, 31 Oct 2025 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4pFgS7v"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D52DA74C
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950165; cv=none; b=CCN1WdaRb327G2hAecwE5tk86uFFJWW3qICHey9aMkmFy22aajO+PQswLmCE2o7a4HWfpu1BBO6mWdiK5iUr6jo6yHzO6sqyeno0OgE72dmVWScs4xHf4WIUmBxfOoBsh9CqWsJdgqxq2d/Bern389DWR+OgPnafAeQDXl4DPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950165; c=relaxed/simple;
	bh=0tVzFNaHEgPaz0CZFVVHB80gUFRmJ483D/NF8VfZ8Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mylBjcfVvilLMimkEUZ/px9URbNrQW8bLHFPnOSuJkdj0J1JFmcXIN5L2VT1XqWs0yZPBQLpuxg+8f6Vv2/nq77fgyeVqZYZ1zEVwHPdP3L7GhJpn2QQD0jdwqnXzxnPnMFXpIdSRwoUux1FxjK6Zr2Ce8EQO/p6WRZICFw4obU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4pFgS7v; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-945a4bfd8c6so237936139f.0
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761950163; x=1762554963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJjxAMRCSSyp0uaLlfSkXfbuT3Ybs5HEdO2ce/3JrAo=;
        b=f4pFgS7vZLqXTCX8l0GPvNh74SZx64byTH3tT0J799EoKBkekpMDGVyivYmcJ9GRNx
         zkxGO9Yja9835fejW9+80ZFRZNOGDW8r3SKnodySHiyhL9Bs3znnbFauXT6B/vB2HsXU
         DgwJmYr2PdXCPgZpD+IZg05946qR8xp19NuBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761950163; x=1762554963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJjxAMRCSSyp0uaLlfSkXfbuT3Ybs5HEdO2ce/3JrAo=;
        b=cCOa7Iu3l1pewCzSqun+Jw1rzIAU0ZjWzc/6Ea+7flv7OMopL8OpuOw+pywMrROFPL
         B4+Vl0mGEYw3cFHeS3t+VWXhVaYm/E9MdrNCEoprxSfeCuzxsXUBPKlumeXIBggoaZrH
         9kIDJE781ScuTmDhsM823VvakDNKo9SF8XtqMdldRb2oBc32Z6PtKB/h6gVr8j4KvLKD
         JGo4YjazcLgRjEQgU2dEF2NEJNIIYW+xQ4D2MpTIkgxojLlFkMgpras0YYd3cVMttT+y
         0LXsTKoul2jYtHGMAoIqu5Agxat26Cat37KFKCW5srhJ4LqXFIQSDC5XbDhJvTClKmX0
         HSMw==
X-Forwarded-Encrypted: i=1; AJvYcCVZjg4cT+6HZLBbxYPv7TPyc8WtFMaCUtsGidpRLj7lDDTpKPLvdoTbPIHzpq+hkPYGGg+Ilc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc149iEwhzIYhBIXGv2q5DQHQg66JzXphpEbQf6OvRRPED3a+3
	6/jXnm0zpdBlQqBjtbqqbxM1PKA8MGU3S5OBtwu0jMUEMhQ2f1ZBgcWvqHCG/6pqFR4=
X-Gm-Gg: ASbGncsUNFJinSNqBkyL1xGd87sa2wpwiBrDyqjruYsw+XKrxzf2fA6WwkpROxbcsNM
	mXnaREFl0eW+IdXbyCJ+JkqBvD5W+tYsj97qMY2DcuOf0DfRrNlLCdlOQDD6WpmUDuJXK/9DmA3
	riZLRJtlruPkec/YYQnRwuhDQQXLoX6Tpq904yrLI+tUxx8uQ1xPAQYPVe8Sr7Ho0Eu8+IVYZUU
	/YJRi+5DFblbrKQw1gzogtVc//gdW8bndkbj3BMNcW5OQNWCON3efWatSu7FbhITqbg1IznQvog
	qv70F1MyKY8BReqnxvtKyJOI0ArjgrZnPe7ioCz8I8J/z5y0UjgaDhenyWhdcfVpgPEz9yX4qgU
	QjQEbqYfQ+btB5es7/6IUTzdMfcak5sCggZBPmAjNwe7A766ugegdVsT2DvYJ3heGXGw2cOVHDo
	pUivCh98qXao+n
X-Google-Smtp-Source: AGHT+IHpp2jrTbLgg0/IEW8inYD+D6jhXRJdiw9OAuvNttZoQnFgqxt14vowND5GNwRc9wQwEHi3bA==
X-Received: by 2002:a05:6602:2b83:b0:943:5c52:f802 with SMTP id ca18e2360f4ac-948227e6a14mr838664839f.0.1761950162944;
        Fri, 31 Oct 2025 15:36:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94827baf909sm96079639f.8.2025.10.31.15.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 15:36:02 -0700 (PDT)
Message-ID: <7e1582d1-4d1c-45cb-86a2-70de0161d735@linuxfoundation.org>
Date: Fri, 31 Oct 2025 16:35:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251031140043.939381518@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 08:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.57-rc1.gz
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

