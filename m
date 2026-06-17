Return-Path: <stable+bounces-266872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FWRiBULcMmoN6QUAu9opvQ
	(envelope-from <stable+bounces-266872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:41:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42669BC1A
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=google header.b=M0itRPPb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266872-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266872-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2041E3014161
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 17:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83713630B2;
	Wed, 17 Jun 2026 17:41:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9621ACED5
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:41:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718079; cv=none; b=uS3iTj4cH2x4nvHzY8BSyeVRu6/dIyn9ukIy55BdgvWkD0uZURC1NDOJU694eR0kypbkDE41MKSPkJB31RpCSuqyGBB8UmEdDc3a7jeAtxVA+ALuPNlEkami35DVhK5hX5nVnY1gxL6mBAaSfiv65nlmnkaRjKndTuq2H4eXUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718079; c=relaxed/simple;
	bh=LILRFxSYEoi268hL3OSZ138XRa0ZaBP07waWon/0rGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmNWsXDb9yYhbD9RC+Yz/q8UlhClInubRr4kyihaHuDpOYFwEJOSED57zNJxvfh0/7lcJucCndCbBTQcD2ZyDTpuuEd+GD2YpQvoqTYxo1Ke+rSFSeJ/B2ex/d9qLnhvaiLM41sBuvn2/z53P9Mi5tBV1qOv4eIo4JLdXU9oMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0itRPPb; arc=none smtp.client-ip=209.85.161.41
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69e4ac3b37fso46817eaf.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781718076; x=1782322876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igyxVB7fmZZCgjWNvoj3rySPp2JuIhAo6gLty/VDFpo=;
        b=M0itRPPbYdJmsCnySRvGckyPaPL//zmuVCG9T5uk/7u83ZIRtnBO2MGWBOe2ECdHQO
         /CaWQ1s29T8K+hRqcPvihy5mrJ7y4qhmX/15N40TCVyxUSpKluqDI00GHs+BSunAy/sN
         VUOdWr3gG70zuOF8vnzHsvkuT4sWREErki88c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781718076; x=1782322876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igyxVB7fmZZCgjWNvoj3rySPp2JuIhAo6gLty/VDFpo=;
        b=j/B2nAmcx9hb7CQLXCxyqXkq8x9rHBen+uHQZ+sET4K1VDSozJe8jtcpyhexigHyTW
         gnEJB7JUgrndCP0XfQqPc5bC5F2syLktViZlHlv0dHZ2CLP8HVGRxVoJUNXKUetVNTsO
         n3YY9FLhtGo9lox4yqKB1z4oib+d5tYmKu87dcopHAlwYuvwp7JKi1ZYEeD3fYpyNJVe
         D6NOeMBxpLV/TI5Zkg0/Bhw8m+G3GthM4jnqTazXZ1PcK5QkUMjUToqxC7hFzaGs8nZO
         k7XMIjU+r8sbMwdfKxLljTKbuC7IRGBnMnfo52LQQ3WKUs6SbcFEDlw5GaHV3U7ZyBfC
         sqHA==
X-Forwarded-Encrypted: i=1; AFNElJ802PAVFf1VBPdvptas8jjsgjia9Azh1LKBE3MvnwE2Jt6gXWYEl+b2x9pKWFsZlq+bjrcm3vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3k6mGW61OkCtJYOvIpiO4+3m2jqT3ZKAQlPChC2uWwp7zTHa
	DIIUw7x98FoTyyGUa5K2krI8McGKf0xpGpAYuAJP9zfiWNfLg7DCdSlTAEVD79l+Dx4=
X-Gm-Gg: Acq92OHVLEgp2+LeG3c4qGxvJhme3FaUnXSoYbc1Ti4h5NJpwCvojmRJLHZKfWRbMT7
	kn+FW/442kBXwBC5GTwYLQ+jIRQWl4+aAozE0aINXhBY2QfO5X3TCd7f7X/ONJuCXVY6cKGPMtN
	yDnL2qAw2tfU2ioCgbUKw051VFIS5HW1FLN+mNsPwh1NkSSC+olp+J9EWp13qTlnlri40xoV1ID
	0PMTsA2c9oiZnJzgHwcRT3AS9wzayRD157n2Qk+GxapJnzkic6KFyVti/LAtR+FARw4JXEBcX0C
	XPFMyNtXgrk/Dd52g5e45Bpslf2qt/93xn6vsBorokw73RXa3ViXSVhUyJJZ0D5U4dI++NZD6Kw
	d8V9iYovgupteYSubbrugLDPbWgFtjaPFEUC+IzaHt1VuwAhA/HfVn4gHOnLqbOcIoJiC1/Fqre
	BEpqAbl9C2JgYWMpU5UT8T
X-Received: by 2002:a05:6820:4d06:b0:69e:36c1:8fa0 with SMTP id 006d021491bc7-6a0b619686fmr3355888eaf.39.1781718076578;
        Wed, 17 Jun 2026 10:41:16 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00edacdasm7277086eaf.11.2026.06.17.10.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:41:16 -0700 (PDT)
Message-ID: <0733960d-aa94-488d-a4a8-7ec07d5bdfa2@linuxfoundation.org>
Date: Wed, 17 Jun 2026 11:41:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/411] 5.15.210-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-266872-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:skhan@linuxfoundation.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC42669BC1A

On 6/16/26 08:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.210 release.
> There are 411 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.210-rc1.gz
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

