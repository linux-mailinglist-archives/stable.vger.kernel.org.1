Return-Path: <stable+bounces-222941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMVcExI4p2lwfwAAu9opvQ
	(envelope-from <stable+bounces-222941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:35:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E40B91F61C2
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBB313004F08
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C536397687;
	Tue,  3 Mar 2026 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJnUN3oS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C7397680
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566439; cv=none; b=AKVZDChTj6U5z1+Z8XcF3FtsmE68SIqS2h7wp/xG6vSxNgqT3fYkgJhYfdf7zktht1W6FZNaD/wKxsnZv79gsL19cOfmMTtAkutPsuDXhc/g8lt3pqLEq8vzPhVMRS7CGZ+DEElSsWPzeGhi095pg4FMGi31mWbku3y4x51Bgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566439; c=relaxed/simple;
	bh=v4W0IUWNCjSldMoui/Y6rMkmEfuNqcADiSf1iVMKr4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNd4mWTjJAZ3KzS6ejWorVEDkdCVmKg0/OFI9pZtaiSMwa/tHhCILr1mUmfTP9X7qI6eNUUi8V9b7GEG0UkvBs4QLHu8CoeqRTMCVcYhWuHyelxIjP+eMcPku4lQcCWg+dB6SuLlMPQ5kkOlrt9v3dKJ5r3PQLb+5jvMTYug0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJnUN3oS; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c383f2fcso4099459a34.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 11:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772566437; x=1773171237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZviA96oGVQXRs9IZPnXvFy1Y0ZE+xhMCmch8AHXIZk=;
        b=CJnUN3oS+prINSihzFw60OluI9d3C0eKiVv246kgPcbItU1z46voOai+Vr2ZF9K6b+
         ZKIbiUPTgox/YdnUShtCh5+qlBuXGAQJEkdoWmXKdJY5uP/HO7O0q1iL+qCtg05iMmkZ
         Z3qLl04C/rP0m9RIy0n7akIM/VrErryBgCpBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566437; x=1773171237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZviA96oGVQXRs9IZPnXvFy1Y0ZE+xhMCmch8AHXIZk=;
        b=Ge5hpk/ECTQ33ASYOH+Say6JlzDNzgxrAmAIwpvIetMVUSU+4Hljs1hGFiL0rS2Oji
         nRXtfjD5IEy8Kx8l1zVSDoG5gZMcxV9Vh7R9H1DZKFd+1hQiSVyQLhlObWtgt8nsUb1t
         nZyi+sOIC/8RCVDX9ckhkAUoq6vc/rk4x+JcSdCgi+5NG9oyJyrfM9q6O1p7gtKIE2pn
         0Zzjkyuh0e1uzdxxKWVoLi7DG1De6PQh+udb9K4eI85y4+Nzcz8YehVWjgabel7IDwyU
         Wt/kJ6LYBR9X6F6mzTAiyzBH6h0NPz1Od2dM/ZAxDCQ7UPKT65m2SeW8wKft7BHoMhE3
         y9gg==
X-Forwarded-Encrypted: i=1; AJvYcCW7A6LwF8gD/faVch+/iWmaG/H07czBBdJzgWuHS82N22yPp7Z85dVnVelT5F/frCUAnTQ+Z2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaAIRm1OUE3zdJNqeKTqSMX2RT01ypE/LegAHiUo3+iMEx9cYh
	NwlpMEv0B1vju/maWn1dDEf1kDIvEozBTUkpPwVJi16cLhvkLrd7wvYf16Wvz4MReEc=
X-Gm-Gg: ATEYQzxE5/HKUGPuNKBk0JhbGv5Xd7Lc6DEKvwJVbr9UG4ddpoR45PE/8Yt1Rma2Qlk
	9nq0/AP2XR20vuEkQBfkB74UBsi8D+T11tGkwqlc3sCPOmr800EWthIaX96esht+bjwToMxNyeH
	7N+jqUw+avcnFNECMnP0RhFNT7jgbLAfZGk1xBtWTF1z2JF91/MwvPNURzfIEPX29Zkogrjo4/+
	CYMzR7jIx6fdwYzXXnwhDAJTrcEcWzNdVUuKiTQGBzVHFzmo6egZ9+hxbR35/7oYphS6qTOKZub
	R8IT1CucHmjjjp/zWIW9WJGwydrwNGzUVa9zw9zCPXrNN1Tp1JM6GUw+jo+qp3oJ80s6sepLdnX
	AzrgcHQ1ybNl8t/f9qN5D8veggwaC+q0AYlf47X/h+bH+bmHtvrHmhVtQ/DognPHS/jJtP7TLoc
	AfvRHAfafZOYBwR1YTVj/zDlvZNj/pu5u8ESQ=
X-Received: by 2002:a05:6830:d88:b0:7cf:cd4c:347 with SMTP id 46e09a7af769-7d591bf3726mr9485677a34.30.1772566437473;
        Tue, 03 Mar 2026 11:33:57 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626895sm15470339a34.18.2026.03.03.11.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:33:57 -0800 (PST)
Message-ID: <aba962ef-e824-41c5-846b-a7cf04034575@linuxfoundation.org>
Date: Tue, 3 Mar 2026 12:33:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/684] 6.6.128-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260302160934.2521545-1-sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260302160934.2521545-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E40B91F61C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222941-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Action: no action

On 3/2/26 09:09, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.6.128 release.
> There are 684 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:32 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.127
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

