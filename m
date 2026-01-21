Return-Path: <stable+bounces-211183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DFHL1JjcWkHGgAAu9opvQ
	(envelope-from <stable+bounces-211183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:37:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3465F95C
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A397A46BAF8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426F2DB7B0;
	Wed, 21 Jan 2026 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYYan9m0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EBF33BBCD
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769038668; cv=none; b=qVr9inH4GcsY3AgB38kLZm0m9dILhNUOlM7gtPPwmDQcgiPP3blNk6E0Si+s/MFwiiWPVnOnxWEoq/8W13NZdDk8g10xQJBYuSLQQogJx5OzKOMK5MK8WVgc7qn/x9XgdBxcohxgjqzAz3szcAXbsp2w57DFSWT5nFiNflkoSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769038668; c=relaxed/simple;
	bh=8fEOLru0G7fvqFglB1tYJ3qq2/9gQt/XW7KrBiuJdM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZYp4WGa2At3minpy7EP/2F69SObeI4A15mvPRMpgN9MkPl1uFzJb4GUj1Q5jq951F9czVj22Ayxd+MQSFAz2fDrLwSvrhJ2OiHAfM8FowXuqigW2l4Z8rEJZ9SV0uOMSW7xDAjxmAtxzn7VXx8c+Bn2uB1w/6G/mnadQsNBFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYYan9m0; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfccba483eso138871a34.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769038665; x=1769643465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=as/ujYEMKTJ+1vzNUDKug0B7Dg4H4W2+gS4ldR88Pk8=;
        b=XYYan9m0qfrGmbfz0bZRUggD/72lNiYWD2KDgrqiUzS5EVFPB0JeTgdqB1mLKoLytO
         LFgEEOtRRPHgmgz9JS3zpdK/aQ8I8lu+5bB/Hz599mK8kFkwaYlZ7YvCt/rFzU8xMtVV
         X8GajUXFGkFBwL9bu0vOORTwUWJ5DydjeCTZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769038665; x=1769643465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=as/ujYEMKTJ+1vzNUDKug0B7Dg4H4W2+gS4ldR88Pk8=;
        b=QI2HvG8OZ/qK7Bd+LqRqhsYUgPkjQ5mfAGIshAcTYoWFpGnze//k10P+QASmAhcMR8
         YdYCeen6iZgAwIB/rX8EQ+1LUTCicI/IN506c0l4MIZ+AzAZd7EDDCFPCLnJiMhIs70U
         JWxPAStXpZxfj3m57EV5niTzIBT7sP9/MvdeuF1aRFyaeKPAFyHT0DslV4iSgjfgSwlD
         sAV2eYYUWe229V9Wd+MTP4k8cjiylD5zfnR75vWuqQHxvEGF8YyjzNjqRc+BBQFN0YXV
         sICl3zY6e1Z0UfTNWG75hkMCZEKlmSv4hDcSocXng3rcVpIAm3zA+rzqAawJ54GfXggt
         PonA==
X-Forwarded-Encrypted: i=1; AJvYcCXx2eBwliN+AxN7EwQGaVVdaDRyV0/168ptgWnWqAF1W1e0tx7Rn6f7sE8vMDSNV8tuhQWKBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyvjftQzTqyRFvRNI/KXqpkghAPxpoMt11DJl4lhDdO5zI9BYR
	CJU7u96ihhQ205IfiL9qPLbSpI4xbRL4phij537Snx6ENSx6ByNj1TsCCUdk3oqu6Ms=
X-Gm-Gg: AZuq6aLcgFOn9rj/+bSN7A0Bu0kv3lTMQxXrQLxFIEe495XAOsmmKwfqITDn5xDTP4Z
	etFH13rZjPryAf0i9d90iDvVr/Epecb0ABNFWmMA3Ng/O+rSIvsmhVHr9B6DPBwD/CL/ndxRADv
	t8lG/DFZ0JsvG7MgXyS5/mabXjkqgA97fE2RLggtkD1LItrriKXbsL8RKjT7/SLLbYQRyTxwBp3
	xuBL8uxb8dGheHw6zs5Z4kr5JQ4VaBzy6cxsnaHn0VaMe7tL2slkdlqjFX+AkvKxi7U/HygiNG8
	p4X4lJy+ThR+VF+3EMd9OJqqTpj05NZTP4TPWc1vk+2f5BD3MQwituUMlagl6C+nJLsfiQRpQ7V
	qTUWiIxKWI/8ZlEZuwCqexQ95RNp8VYMhcKDSADw3PtfNXtf/QdyI9xC4v+ac3dg94/XtzlDf1k
	oXE1VAVoTps4r9NkhoMov17pg=
X-Received: by 2002:a05:6830:10d9:b0:7cf:e4a1:8b56 with SMTP id 46e09a7af769-7cfe4a1d9c2mr6653764a34.36.1769038665113;
        Wed, 21 Jan 2026 15:37:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b55ecsm11822215a34.28.2026.01.21.15.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 15:37:44 -0800 (PST)
Message-ID: <947e84ce-50ff-4dee-b79e-0f934d8a5c06@linuxfoundation.org>
Date: Wed, 21 Jan 2026 16:37:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/139] 6.12.67-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211183-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[21];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5E3465F95C
X-Rspamd-Action: no action

On 1/21/26 11:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.67 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Jan 2026 18:13:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.67-rc1.gz
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

