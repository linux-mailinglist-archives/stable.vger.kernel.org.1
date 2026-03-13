Return-Path: <stable+bounces-225235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JJTEk96s2kZXAAAu9opvQ
	(envelope-from <stable+bounces-225235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:45:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B027CE0D
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CF09302653B
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 02:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DCA34AAF2;
	Fri, 13 Mar 2026 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guL8FKBU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBB27470
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369932; cv=none; b=Lp6onjeUpA4hcTIKlzXhNpvYzHmkgRBxz/PuhdWNezh/ESQ4RD+gf5bnOPeXVtdZjiclF9BYXWVIUzDtV18e9IFqyi7nRxM/e8zs3tcfbwoQkiVylOz4UHEVIH8ifLSLeSi8J22fp6cMggX8vfdhfaWqhvTCyOuxaT2lEEWpXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369932; c=relaxed/simple;
	bh=giTsXWYiMmee3pERN9Kh7gFTOn98G4rPfrj6r3VgU6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOMEBjlv7NdL+RIUUhsDCSzbSivGpL488jH31LSGNb50p0GK8kvHqRgMDhoOTtkablLgAXtcHtDjZX8Bks8K28cJEo0xg8idj3n9seNIbh7f0YuDV0LdlvG9fc5mV9QEdJ8X1xuGYRRXJnwjFwu63uHw4AvH5sgVGBicYcrc88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guL8FKBU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb20bcff5aso167157285a.3
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 19:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773369929; x=1773974729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8NQTwBNhkmEHjj+/QCO0V8kqmBWWveRFnSlOxGSXyc=;
        b=guL8FKBUKQE86I9Cy4OpNYjPgMVkLtCGeCvauEf/eJpiFpPQDNePxPd5dEHBdRzki4
         LQdCYdzeRE1fLqNsQ9zOe+6Rl1730IOw3CIHKgnsN1Z+9KA5jFYrF5STW3wzcCN+HUZ2
         YGY8U9RADXLE4sHAJNQruzcqoiviDmzg/iHjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773369929; x=1773974729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8NQTwBNhkmEHjj+/QCO0V8kqmBWWveRFnSlOxGSXyc=;
        b=q+s0De5I6qcJLErnjcDg1jKmjjwvQ/D513GYH86dDSIopABgyf3KHe3hFDlpobZ+4q
         vzQ0MXBtnBRdeFVdsMm7oZtMkiKMNtnt8t8C260gFtEG8zmpThQfGrl18A+kfsVboxIH
         gM+fLaaLbuna8qd7nFBe0p+/p2GMZMX3u7gfUScJKHXCPr5+WVpHmgcoKAfyT1fXpuuN
         74hlB5fVKM33AEvAqTOrgglLQSE+YPeTHQMzVBpQ9M1zcVPJp+ep+caTgZjGxwlZxd9v
         aGT2dYRQv0ohC8GREcfh7yWv0rOwfO6fu3sP1tkpOWoXf70cjmavFNEkM0puuMA9zR0L
         r0oA==
X-Forwarded-Encrypted: i=1; AJvYcCXLTKOW4+BaizUo0oJT624fu+EW7cRKP8OPnEDO87PvlBOLQrzQTCvpmfgzifeVplkfWQ32WyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWD3fzKBZ7pSAagtOB1mhAm2vStB8TejHblsrs/VCfpJ+a71e
	iPfMQh+SIk0hPiBtyyWu6MPrVtmZZi3wglQ0YXLQ6EBvd3baDyH5GtuWn2MYmnuHpu8=
X-Gm-Gg: ATEYQzxYouTOHwqkQRGThqU7Hw2wSj6+oflsfj36dGj/gvUWvwACwRfX8W9zC6dM4UH
	UIVTSs/P9CkH+DRzRi9x4KrSRiM4ZFO8TDCuFKhAItyJpRAw9tirppEps9vQGUXhdVBg+sRZDst
	GqQpk60JRneTOcWE6ei4uTRrPnDgYwrRLJfNMyhmDoeFKhLxO05aCAv1Y4zhqF/ZjJ8/Ad6sGUx
	rBwi4koJwNQor6ONBKaUWFFvna66OS9Pw4DK3IUtac1J5iB7VPhk9pN+DCGZdXLdg36B4LGpjak
	CHRfJvFAyFnWwLrEEKEK5bSJGacwA2AtjI/4RcX8V2JXJRV9a9EzOIiBJ0zA3KTwteF9jTemcJk
	mHtHvlze5aNFezh2Oexe32zJvveVCdIbQpTJqCgVqJha8RaYzNW7N5rySSo9uSUjS3y58SvOzrM
	YBlno10rZM4zXawP5+A2vexgUpPqnX12lkmS0=
X-Received: by 2002:a05:620a:318d:b0:8ca:123e:819c with SMTP id af79cd13be357-8cdb5a9e994mr293434085a.35.1773369928677;
        Thu, 12 Mar 2026 19:45:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda211036bsm494717385a.23.2026.03.12.19.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 19:45:28 -0700 (PDT)
Message-ID: <1c15fa4f-9017-4c03-8c1b-35b8ffb37524@linuxfoundation.org>
Date: Thu, 12 Mar 2026 20:45:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 00/13] 6.19.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260312200321.671986598@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312200321.671986598@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-225235-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: DF4B027CE0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 14:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.8 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Mar 2026 20:03:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

