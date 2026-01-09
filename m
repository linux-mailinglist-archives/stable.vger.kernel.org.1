Return-Path: <stable+bounces-207922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF22D0C976
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 00:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16AB33032120
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804CF33BBD7;
	Fri,  9 Jan 2026 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UPZRU0FL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43702338590
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003096; cv=none; b=N5iKx7qNR8SeJhMnMTIFA1fXy6dW3dEMSP3sJ7h5SiCrCyXpNQ6yrdfCcXBD8KVVB5LFllEJ1v98VdACduEHjAOAXeiwmJ5fSQcY9+Uat2uusRMO2Xd/PIJUoZ5HXFRq5ENwbwXKw8V6p4VSQm82gD/eZOSa4AeNROTym3Abs0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003096; c=relaxed/simple;
	bh=I9Cfsfg3RLUq/nIMfIDqMEPRiGfTmJ+W0kuYh+PJOr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqnNWCtujQweQ6h38sjNnZGBvgHe0QI8W8FyZIP+uoIKpXLNBEl7vlMKMLGt4zGARPilPlNibdWFcaj/HjwkxGO2nLpGQ4CCAdiYqTKbdn0V0oYJvGyPnc0lIZH2gwTK239G6Hywbm7+YBsF0Btcimp9VMa2ZGSj5SI2Z4bZgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UPZRU0FL; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c75fc222c3so2478497a34.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 15:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768003093; x=1768607893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFEQYRI/1yCnUCm31pPkGuWos0aM2JS2hDmoF0o+HQU=;
        b=UPZRU0FLXkVQqYCgLVanvaOzvGmdiNXMm4h+PL/ayDmdGi3gJotg+aJOHQ7BBITdSi
         x6IGXRQmHZdAWNpFbDZhY24vYBI+gobJrmlVRzeZmA17pmvn+AsQGFUNetQIu72Mr9bw
         5GyYp6zPI/Tu2DOgeWZqgOXUQAOwnpc2F/yZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768003093; x=1768607893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFEQYRI/1yCnUCm31pPkGuWos0aM2JS2hDmoF0o+HQU=;
        b=TKHJrlLDLZUN+cVotnE28pL7rKhz637vhne/xmkcNwayt2BmPubkqK/iN3XDjkDnMr
         QWnyUqJhVXY2glgNkQAWKOapn5XNU897nMfikrmM5cxS0XTpHwzzHmmLlw4BqGsz74h7
         SpA3Tk+e2g5RHVKutx3CPcDb6FoDmD/Dx2NORpUIiM27/VD8eU+zI9mrF6hgG2hW7VRi
         6iJAWOdfH7okI+jwekBcph9nlqr8JuHcwaJW7ET609+wZWs6Ra2E5izxXmCTNJbOUl0e
         OCZFgBlslaMIPIK5a5/ppou75P5+2jJ7f5bp0q4tAF+qYvnELUOyJgMvGHS4/kcowYb5
         iN7g==
X-Forwarded-Encrypted: i=1; AJvYcCVXhLvIjwGYsX55jx/xvRjj5V4sC5atsaNKDmSAELg3VB3gdg4DlB2ZaTRCBNRrJwuORrgxhO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDkjs2qkoZAjKPBo3LR0WppQbofoVUnih9kCnIteGs9JouS6c
	FQaEiiixEXvUT7QAfQBrMiTiSlmn48ePdSalaPubs82OzCQljUw0CzrFIqwpd2fepcY=
X-Gm-Gg: AY/fxX4v0LOBDNRqu+62uFy+ZUxcblOKQ1MDEMC5j75tYgUpzvPFlvwul1FIZO6r0SV
	0cZvYsDO71Ex+Ui0XEjleJaB52DSZKnUoNE7rtK17NBXyZaFXCGf14CdoIchJi6fvgpcpA+hbGY
	tNzCHLLORIwiBiI04BQk1FhvuVRtUdax8eRgNWJh0ZIluiDUBPmnUe6avv4o/QYok7TxuzYAbfe
	QuLI/M6vwoOJ24LqsC94GuA/VgCCfJxeHWVjsZJEvYyx8fRqBykT9UyNv07Q6Ew8sw4b7K0Vbv7
	VvzooTbSt3qDmSQ6VfqZWfMC+/wQdtGTZq9ZA85qYCXkeodI0NxMMaOWOh0YC4D6pqcTjlFaoik
	43Ub3JOoePvbYcc/Pp+C0GGS6/FpAl2X3XmQC/lkTeEDi4Sn9Z0xr9cY+hkxoM03JpJ7hX6WMQy
	8iQKYzsdgWy2tUCc/ABCigLmm17obZen2ahw==
X-Google-Smtp-Source: AGHT+IFuhsAMsjRaaRlSKB12kpUhOh4j/WkmMN2jjP7L5PC1K6YEaZKs3kdjw7+AeCobZACBX/x3jA==
X-Received: by 2002:a05:6830:2e07:b0:7cb:1288:329 with SMTP id 46e09a7af769-7ce50ab21cdmr9144795a34.37.1768003093250;
        Fri, 09 Jan 2026 15:58:13 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ee883sm8538140a34.28.2026.01.09.15.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 15:58:12 -0800 (PST)
Message-ID: <b6fbd379-4307-46b1-be96-2fd13bbd1a79@linuxfoundation.org>
Date: Fri, 9 Jan 2026 16:58:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260109111951.415522519@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 04:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.65 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.65-rc1.gz
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

