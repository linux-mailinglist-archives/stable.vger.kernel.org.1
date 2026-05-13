Return-Path: <stable+bounces-246922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBGSBjeqBGqRMgIAu9opvQ
	(envelope-from <stable+bounces-246922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:43:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA055374DF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF7D31CB22A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE483043D5;
	Wed, 13 May 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cavXrZRZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860C48BD33
	for <stable@vger.kernel.org>; Wed, 13 May 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688817; cv=none; b=JkrXt9XVj1ELSNN4No6gUUkWyuOsA0HnnnnmCNnPHaNF36F3+dI/DGUWKH2j0bRCztYKjzA/NYVdArFpd+dOmvNRNyQB7shNxlnIvPMj2g1CIKdUPrWhnhmF5VA9J3IPp66q1WwcFO+iMB2i4SDj7AyBf/1ADqSv34yk81Z0F+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688817; c=relaxed/simple;
	bh=YhBS2gglZpgBUTd3EN3gtxxcVc9j5kl99TM1RKqNIT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfxqoPQWynRllPm0Ix3pt+RfLZRcHxI5l8gaQxsqPd8W504RtYU4JhojkFmzr0jWyP32C8PK5lhWVX5JAHNSpW468NHXwkZ20mBn3qnXNC8Awv097TYn/YMM/1d3g48GOTodUhDkFJcJ854jW7KvTcRlejuc0A2vl1hpiX3TBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cavXrZRZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dca4debedaso6585745a34.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778688813; x=1779293613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbrAmocTy/GZasxYN3SuUtJFFgRGxP9XV3hZlSRDuZY=;
        b=cavXrZRZ3fYJyYN1ANkCvor9c6WsX+f+YFGnuy5iYGpdt4EF4t0/rbBkAsNsjqEgFg
         AUb0sOmztO0M3WXa4pQ6JRyksslqx4H23IEqoT4y2nwjGG4+fMqG9Frm0LN+wodm9ALv
         swpEpJ8HzUbo8fB480AWqObVP2UQyp9O0TEGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688813; x=1779293613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbrAmocTy/GZasxYN3SuUtJFFgRGxP9XV3hZlSRDuZY=;
        b=rbRjeS0vVjtaQW/WDtc4Nlg6rt8pdOcuvS2017W6uUgA5CRCsqtf+ng/Qi04c3r+j7
         uLNPMDEiuBez/1Br8YiQaSZL/bRcOyeKnVzqvFtlqQj3TRDVRBJuco4Gu3DxIDChY3wU
         sIxwVHujbEMQ6f7QAgrWBmD21GziUTub5u3ELIlQ9l8F181wMKf0WSdOsDLCaRp65K0v
         eXSqYSjh96t3lm/BNfwgiDdVpWekPD7y/+rnt80CO48uBNY7zdJQqLWI0uTL6Bj8Ne5w
         8Xdz3yvN6C5ba8N7cSRfXi6MdzeLCOxzYP9zhDGs+GA5jYzR6BWZFPc1t1HJV/N6a26H
         a2Bg==
X-Forwarded-Encrypted: i=1; AFNElJ+jrHMN4zuvY0i6rSrw3wQBPT6GoYS8xQ+c2+Gh9NrPp8WdCNAmztjyxdqjMWcthG6n6NfNUGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPiC2UZSVZu7JUi6y8CsbdMadlkzXG2QwMO84BHhKwo1sRLO9y
	pXuuecWPJwjy8v/rzyZe0wHkU8t+dFlONbF3qn2Hs9uCV6ffcFwwNMhYv9pKDi6htSw=
X-Gm-Gg: Acq92OFDOHLGl4QsFxQmSEHrfUYgPWAKzevrtIvssUQT+vjNhW5c5TuSnxTmXQj7EnM
	nLAJ8jqOIMOoOZMVyOjBAP5asDjmXWcMoSZN94N+SJJSGn70OgN/6XMC1oHr0VZ90M7mcqRJcwH
	LK4Y4PlZbI3dLc+o+321eN1Fbbbli2pjla0AjeDGwMzxkfXP3qNguADBn68j0Op3YIUmkJ+Qmya
	XTD1oY47y69mqRz2HZfIh5R/T757uAVI5hi0kEji7W0JEqG2k6hDtt2NKcwmXWWtN3mCFyBflsf
	7k7fWggL3UxQeIAMoNXBRB1WldpL2pLYAcc63FpD67BNmVm6qBOY9RMfhrTOCNveqiOxP06JrJY
	37xg9VjJKkEAz6k1EbXgGieNpwDgaf2ilG//1wrkx6pUwKbItlpt/94BOLOCVpFOHM4vON0RXM3
	xB4+DAeo6QxUKOTIhF2wcx2gZvvQ4F1e4=
X-Received: by 2002:a05:6830:44ab:b0:7d7:f5d4:ef5b with SMTP id 46e09a7af769-7e3da0973fcmr2213993a34.7.1778688813613;
        Wed, 13 May 2026 09:13:33 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c04e00sm11251548a34.7.2026.05.13.09.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 09:13:32 -0700 (PDT)
Message-ID: <73cd1ca3-ee3f-43fd-97fc-b1fc3fb4cca5@linuxfoundation.org>
Date: Wed, 13 May 2026 10:13:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/307] 7.0.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AEA055374DF
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
	TAGGED_FROM(0.00)[bounces-246922-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 11:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 May 2026 17:38:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.7-rc1.gz
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

