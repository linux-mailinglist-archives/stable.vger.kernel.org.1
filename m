Return-Path: <stable+bounces-131988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C432A82F87
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509898832B3
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2517127934A;
	Wed,  9 Apr 2025 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfIimZFQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5627780B
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224795; cv=none; b=Z2xIZ3DXRJhhMXIxhSh0Qs8n3MciNECO2ejyM8qbtcKl6AhgbI8p6Bc+I56V6b48ArR8vGIZR5nDYYNDP5itwvhZYDJ++rCdxC8MLBaD1BYTSEmRzapb+IsxP2Qi5j1f8tG4d+5l76eqfX9PMxHXuLZTlAPLluTAXUL+Un3FCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224795; c=relaxed/simple;
	bh=ev34B4BdC9WbGNJUDSR2Oo2ko6MrEuWxcqh2POvhMM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7eLlvNMul17yzQLh20Jcp1Dte8a0cuoLFE2HCDFFN7FgeykwDGZllK9lmLyyy4+rr3qCzNq0gg6xtakvPVMkBFU6X/iihkP9jlRrgugIWXIo4I3H03sEwf/uAcwUHGuv+k/W458X36DQG+j5nzvIdQdxGISjKZl/zcXRQh2hXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfIimZFQ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3fefbbc7dd4so4092903b6e.2
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744224792; x=1744829592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uprOTrpUfog8eVjEhCIqe4mihJSdQCDY4xj+acLb2lY=;
        b=cfIimZFQwaR/6uJN5YEUoEDS181WmG+MXHHlskBDii9T8w49dJvp9brLNUDLkRKO87
         BdPFsABJM0Ihw4dYO0Y2Sl6qLxTutywHh8mY+FpvkhfVBVPop76TGvdR8tD4rXCHtuH/
         AnLrZu9TIqe7/2MWW1zpcXMCPp59A0CGlwhio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224792; x=1744829592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uprOTrpUfog8eVjEhCIqe4mihJSdQCDY4xj+acLb2lY=;
        b=B8wvyFPNzcb0hcnOQ8VpkM3CfCCizhscrHJS899QYjsadrDrtX8ZHPYG09aTVYOTHd
         3yMEA74OruYzCLdPTM/vQNZoRZlECTPKb3ZdnGqHgUh6mMYRVCu2ssZGznI6gorW9mv8
         jYDpx1RjKd2rxTWNX5NHlTZbwLtm9IOYIXhWE8rtZI8irLwoYGWs8OqdhuFUSU5XkKyB
         vlrdZiJMf2whSCnpoLi2EOe1ms/sLCVO5exiZtsNQzDKfJ7KV0GhpduiMKUZ0BIMSgZQ
         Ueb6B3WpNS/rkhyAIO11EZtqLiBWrx1G7qYAUYcZzePOzoyWlaKN3mec0Z1X4zDarG93
         aDww==
X-Forwarded-Encrypted: i=1; AJvYcCULDG9q+NFKU7lUnBn4dNo9gphVVYRwjoVcHEwRfuueXGEJZniqAZJKA5f8IbxloAEe6y4+FWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAZTKd63s6z70hZz1/b6WUwxyopR5L3i5DSN+V4QXP9T+1pxI
	TbJL2dWsaUCYgNvewU70fjO89z5BZ/Mgt/6A8i3MidtuxGXr9avpOnsbxrCbZZY=
X-Gm-Gg: ASbGncv/gpPIuAYrN6gH77qxIh3N8vEIEJm/HbeE/Lg3chnd9ami/OWhFOfj2alyxXh
	xuJXTXJk6hRt2ROFvaCLyQZtvLgVkUcXUMpExUBxuPsIFQRg7iT/ofPkUWQIFo9PwVCgv6HfFhM
	t5VFTawK1FRSBFKFZPOBzvmaz4CBSdClXY2BRohkvgwRgPr9pTeql5+rOfJILlaPeOCWPbsIZdY
	tE9zXsT4Qw2w5gsgCNksWui8/qUa8Xejl5iscMiQNKay0Trn8+AiBd6Uj9eqW7jFdjPDDwSsP9t
	KN836WsIbZp7jMojNgXN3dx9bdpXTnV0eo9rOja1k8y1TSMyB8s=
X-Google-Smtp-Source: AGHT+IFogSAftN0uvxAUx3F88QuzGur+Ouhi5sC7Ds4Nb4RZ5YSZlk1EYlRWrYgi5Mtw/kI0xiptgA==
X-Received: by 2002:a05:6808:2a8c:b0:3f9:3c2a:e40 with SMTP id 5614622812f47-400740a0265mr1871379b6e.26.1744224792049;
        Wed, 09 Apr 2025 11:53:12 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-400762d4861sm259007b6e.23.2025.04.09.11.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:53:11 -0700 (PDT)
Message-ID: <84e6a13c-1dc0-4405-ad56-442e5f288aa7@linuxfoundation.org>
Date: Wed, 9 Apr 2025 12:53:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/281] 5.15.180-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250409115832.538646489@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250409115832.538646489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 06:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.180 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:58:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.180-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

