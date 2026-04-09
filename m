Return-Path: <stable+bounces-235476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOdAHqbq12ncUggAu9opvQ
	(envelope-from <stable+bounces-235476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F30903CE707
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFD87300D179
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839D4318ED9;
	Thu,  9 Apr 2026 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNWWoXL6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE63E315A
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757978; cv=none; b=RvymX+419rpsvU9GmrHXh/DWdh5EXkPyaruI5sZetLVeJrrtEUz4VUX9u/tdrkP4EgZ8NUWUTkwsQl0tcNjcxID8YKZptC660eX2b7TNZzh1IEDMfhaB6KGnco/MIis8/Vs6Ys9UhGy2vuy2bznapuxxt4oso+0/utvHijiiz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757978; c=relaxed/simple;
	bh=Ep/bNCiLNilr+2407QjX5N1et8bGDYN51q8pKpmp26U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3OiTH9Z7vlwaplcIppTsn+GkDgHdyPSj2eo5lp8a/B/4/3CDi9/9dYAavRtwfP4w4m46agMamK5dchUlM9na8bRKJic2B5/hEv1/w/bO8/KFVGz22l06QvlksyVQH+9sFMcqpCEjui031BOSO2Y/DwHEKMn22dwFoUwnm+iNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNWWoXL6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-46aa216a65aso677783b6e.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775757975; x=1776362775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LC/Le1MW2BQyntnqxIySdIWWVYKn2c+zuYiwa/nivS0=;
        b=JNWWoXL6I4DFmB5OK2qT8bJcDAP6TsgoVhkajIAapnzXxGdeuva9SpbNs6iASnkPjj
         Tt2BcKyc0sD4v8GH24KxQNmCxtQE8sJPlbS8Ty+red9D/tf4iKx3qyvK3+c991bB+wva
         8+XB6TCret6iUjnA7SLO96MP22jINr1Mtdxg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775757975; x=1776362775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LC/Le1MW2BQyntnqxIySdIWWVYKn2c+zuYiwa/nivS0=;
        b=qg7g269bksVORie7JAxvgONGmaAYaf91F+0+mkyTQYiUA2VfzpjigO2r497w4YkHnh
         rXbgXIeLCAMWYDloJaeV1Ud7KaeH3m0EUVpJknn0WgjgzG6HFvWhrKiqSZtUm/zZ965D
         v6zT11lFvhjXFOSvM9rNkc3r7NfOrEh+2oydO/61Zmq04IV8UgwuzWmC2kTkBHdc+N2V
         mCohkWFpeHHfcihwO3e3mGyEmVOQMttTx7DE4G17Vy7mt12Cym2MiUm5SGhLv7sD0tNC
         PNEX3njIPWVsRFN0LtqkuYvtfvamCxW0Ks4FujzSKGg6+k/KSJcDBYiEAedCWFaNLuai
         KcCA==
X-Forwarded-Encrypted: i=1; AJvYcCWP5MhRMro610MfVIE5FD7iMVukmpXJ2ysWaUeXbaGFxavOM7StkKeN4+1RDefZW0DDrcq0hWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0mKsKgnDrqPj2F3bA7JgK65ppMZKSMc3We025I/MEddeqWpn
	6XZxBTKqv6SEHMbIAqD5YCC5uW7JYpnhCzNy1/KhpdkXrPldh+STchshrxjwgWt2FhU=
X-Gm-Gg: AeBDiesh+PxR/rvpBb+tCFemJf6rnXfWnnD6ga/GzkAQruCYgZkHS+vhbo4zFK6SwaW
	q/zBgoxuTH8Z8RtpIwQJRnEjWglilKNgwqvsf+o3W5jDWPAwirvQ3e0uDLDsLJqwHqsk9yu9UtP
	XAc3FIyxQAW/saBXL/SgY9HilHeqIiKfrvJ6zEF6pVraPskSieLFjdhmBlMz02ZuCGAW38aUybo
	ZKhEv2ud2+0y7tqiWrTt9z/dczMqGaVrFxsCAy6LB/qGR68HnsJ2UF9b+JwJLfyXqdyeFcokMGs
	BmhVoCSQtPZnkSFe3ABBKrOdjvljNXUg9r7M3K+CGINA7QAJ+r2fuFFYhZfSKt6TZDi2XMkbq7P
	/RmF1G0wvx8Ar3iYs/CxPS7MAm8Jive99vCVealYkGu9W77l57OXK41SXH1AOdCn8Yv1F1gUZCD
	lz9iHizWDSBdUM3q58jmvervXv0/S5YdJBbm4=
X-Received: by 2002:a05:6808:4f52:b0:475:be6f:aa with SMTP id 5614622812f47-4789e42cbbamr149336b6e.19.1775757974898;
        Thu, 09 Apr 2026 11:06:14 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb23a9asm322146fac.10.2026.04.09.11.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:06:14 -0700 (PDT)
Message-ID: <b1a166d5-6a86-4731-984a-75736f600ead@linuxfoundation.org>
Date: Thu, 9 Apr 2026 12:06:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/312] 6.1.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-235476-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F30903CE707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 11:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.168 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.168-rc1.gz
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

