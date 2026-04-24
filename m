Return-Path: <stable+bounces-241066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMdQHBvt62lHTAAAu9opvQ
	(envelope-from <stable+bounces-241066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:22:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EE463C91
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E61C0300EFBC
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394BD27FD4F;
	Fri, 24 Apr 2026 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g/I5ZWWD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B7248F57
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069334; cv=none; b=ilkFFs1hDKj4ACQH8cPCdF22WFtgyPtPVBrS7pveJQam72SjjlliEEQUmPqVeEUVND0ASGNlYXYUNy6kR31eA7swkLH1R4+Ieujgl73+8nXwFWm1hortbviyLiflSYTdsQZr9U4GMrhA8+uzpTKgLIZP2xUl3IS92fgN1n3pTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069334; c=relaxed/simple;
	bh=oYNo3/+FyEKrTHKLJkRD4aVvzna102CatqrFg3NdI4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUo+6TGj9wsVwkKkjeqaSU0u/pLlSAPLQxvhrgr0+/r6BvTn6VV8cB9IyWOiNnmzrOjvkkNHawP8NIiWHFTJ9gamnEY/GRSFPim125nJGgaOZaOtVcoqgHYhvq/pO1Ko25gys7xmn2CQM/ogwP70BersZOf7ltfoSzP0Ar1ar5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/I5ZWWD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d1872504cbso7089528a34.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777069331; x=1777674131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLa0zZdyW+6g0urj9+DuUfwOz9Hpy4c8WpAoeyZh2sI=;
        b=g/I5ZWWDT3VCmq2/MnACQAQwJr1z8quc007/S7dhTTi7bXup+MIV8mkS2mb4s/J9b+
         xdbzDJ0JZjzhcgrmIZ4uS3jj8BiGilf2LRP+CHIZM+UcMWNgjvwpFunMoOF6drcRPeBY
         luoDMTs+GFTuM8+s+Fgbv4HipjlKOBIiaCiTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777069331; x=1777674131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLa0zZdyW+6g0urj9+DuUfwOz9Hpy4c8WpAoeyZh2sI=;
        b=M3HLFoWC2JQCeGvSpuK/sejhzo8wcx56M96TcW5BzHiJG45zQogcmiNPZ8vIyLc4Ou
         xp/1OqTy/k8ib5dsBFHxAuqR+9nd31YVJCGpUZvfTuxpy5op47rmk2trpEFGvTSaPbOA
         Wc6ojl/XNAKXhhFIXZRkIdfmP/WvRAKKLhBfgNXOH+sNJ3kybe5u3jqjNIrukUA5pWaQ
         4Ur2pSxfbb79gnBUMXedAlIBndkurmRWo7vqGSGNN/cfPvjKeQAn8p15e04dKLBEzMDe
         UOiIP5eDcreTCbhry24piCawXJwekpT0PuCBhYnKfimT3mwAfze6Vbkt/xA+6DMAagX3
         qMOg==
X-Forwarded-Encrypted: i=1; AFNElJ9RKhvLjETJwVCiW/4DiGr3v9Myrv65dmvkVsTLCKM9ciXz07y72ukXXaBK3Zb7z5LDmqZQPvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznHtxuRG65FWUb81y64+rWvUPso3W9GcjCxitRKLqhfFzkp+Ir
	LF6Junq60V3YMmqlROMEkOfQ43LrFYuv9F87vkpoHX3dPV4XVupkGWlYdcvV1/P9feFBoCCrxqn
	5Vsut
X-Gm-Gg: AeBDievlhHVBjz5unsNA32fruwW1WFZCTRTg42FEAkeemHHZF2mb9AmSeh1TA3h4TVv
	FsyVvLpyOcVV/P4MtLCVxasm66I1XCJ8QaX0g/38M5tqaLSmy528cboVZQIlK60QEv99Uordy00
	gzKHx3ONRKWdRskNXeFJQTAZV7wx7ee3s32AtMB14+rgETLYCeQCzoGLw7/FuorQeR7jAgPm1vg
	xobuAGw01jzYC2x6tVoZ7yCik5KUDQ38P4Ouv9NHcgkbk/dzqcp0Q8N2JDIUpKP4cIFqyCCXxUu
	wny9MrwU+kOqywW565CUyGwT0282E2sieXigV1FVMTMIFBmWrd5xJjNsBlzGHQBrKS87yHksiYP
	VPkhpxtIKoV43Ct27RQ2G45JFA+bVkjWvXTi5scVVgUCzgOt00QyOGOsc93cH8x2LPCeFrrniGL
	J1h8GwTlU0VkflTEhYerUP+KnW1/N0ga+lnBmevAMLSg==
X-Received: by 2002:a9d:7f05:0:b0:7d7:dead:e388 with SMTP id 46e09a7af769-7dc955de02emr13490999a34.15.1777069330948;
        Fri, 24 Apr 2026 15:22:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcdd3fb6b4sm9815628a34.7.2026.04.24.15.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:22:10 -0700 (PDT)
Message-ID: <9272b18d-d88e-4dba-ae00-4302d3a3324b@linuxfoundation.org>
Date: Fri, 24 Apr 2026 16:22:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 00/42] 7.0.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260424132420.410310336@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CB8EE463C91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-241066-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

On 4/24/26 07:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.2 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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

