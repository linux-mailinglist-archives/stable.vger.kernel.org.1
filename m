Return-Path: <stable+bounces-106028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB09FB742
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 23:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80ADD1648A8
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF881862BB;
	Mon, 23 Dec 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wd4H5MWg"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D021D7985
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734993908; cv=none; b=hTgsj2moQLjw5t6dHUPEwGsC6fdbcO5qK0a2uqag+dsHq/RaxOCcUDVPiKlJnj7E872GAH9clfH4ufHlJOG+yL2QQbuaXnnX+A57x00qRfEVFFIl3RaCnZTK67SiX8CKVz67kZV1zmAnSKmd5X9pecaSKjy+OYfSZJcPkJdgo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734993908; c=relaxed/simple;
	bh=gXgYLTW2OlqNBRzgIm+KCT5ek1lwbIb3/6bFTqw4BAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/Z1gOpaGQUt6iGnGXHQckj7tGD8GRFx0vrPX1QR43QQr8yPBTOoRC0EcBY5ja0dDaWve7m+x33iaaFiDnGZY9fYe8rlhSOKe5QC5ax9TRiT6PtaahGefrJYr/iDkronExl6bvIEey/2uP/MaWKHO3Uz+iPnTC2wfT51fcLojTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wd4H5MWg; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a9cb80dbfdso34082245ab.0
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 14:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734993905; x=1735598705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ykv+m6hE0b6l5KuV64IfjamfHxSbG8uVgMPxgNA9vlw=;
        b=Wd4H5MWgkj1jd4BEIn+dketcz0P5vYoldvSBUPpgXIqs+F0SvOmiS39jaWjpKF4187
         HxPRw7Zj2fcTfdeU6iuHdXiexq1VXg/02ycl0s+JObBsJ5D9WVDkCMfj43J7csyLqjb2
         4KFvA4xYxmia3dvFaahMmdDqBC0g34oNoR1BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734993905; x=1735598705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ykv+m6hE0b6l5KuV64IfjamfHxSbG8uVgMPxgNA9vlw=;
        b=Wf4CcRMqFJvr4PCamrCL4Taae1gFQFdkyQ34VsM9UCIH9wE4AhGjph5JGl39KEddDy
         NCc+OY1Nz5UdfrcIiMmKcXsrwjufzfFPE/VytjGQF+gmOLns6VhvAtYNmafhAwpMXU2k
         GOKxgp/gV/j60auGlq+MsC5MAxH34hlsfv69orocRAsECKzX5jfu2HafR+vs+RdFjXk2
         fnBIlGTf2NYsR84GPun6rTJSyziZ63Sy9dyXUWXnETSN9dKnMZm1LS048d9QHhewXxfU
         2RU8fEKve5gaxVHW7g0xKp67V7ek2f3CyZ01DAGZxvFqgUyyVfeuznnRKxnjDU2l8pRN
         jDqg==
X-Forwarded-Encrypted: i=1; AJvYcCVjA1BanFvTwsrNxO0lpm+kg/th5h0LRScJ/HlSHGZW//uOOVYLMnohM4QwP6IsvMwVHmkGakc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKslT8iabTAt2ODsPCzQu1vIUp2hDN2EaGzR2eM+vQRDCt8e2
	qX3OIBoPgcVYsOc12hs1pdsUNmIi6d6+QdORJPndcKQfwbZoX4StbExqx5SUyNs=
X-Gm-Gg: ASbGnctZF8frc8cpOZT52blQmNMeu7BNyoHpbRNTY7E4KYVP22bYHNWvAGoGf0XN41z
	kn0NPOGrNtwy4SwBLhElIUimXFP/HwuSUZDQFcfGE9p4/BbNAV66QvW3+EILA2ZMwK1oEyLJyZ6
	tx/D5belgewTOJRk525pHJHJG1bAXlQkZdoIPEHr43oV/bFeLbjIY6GTL7vCHRiA0lwolGbkksm
	6BWaYbAXbQQQ9bWsKssahoLy/4FYnqQ0d/ZehZsFsx2CAPrR8nZAbIbbmrO/mgCwXyo
X-Google-Smtp-Source: AGHT+IE2CGApCfTRTDZMLgjiim92aA8fU4tL9kj1UWudaba6KeAadozE87gCENq7lVJ0eGfZdiCPHg==
X-Received: by 2002:a05:6e02:17cf:b0:3a7:70a4:6872 with SMTP id e9e14a558f8ab-3c2d257934dmr140260555ab.9.1734993905514;
        Mon, 23 Dec 2024 14:45:05 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f378sm2356808173.2.2024.12.23.14.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 14:45:04 -0800 (PST)
Message-ID: <ef977f63-1932-4b93-ac75-ab46f4773e3d@linuxfoundation.org>
Date: Mon, 23 Dec 2024 15:45:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/83] 6.1.122-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241223155353.641267612@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/24 08:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.122 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.122-rc1.gz
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

