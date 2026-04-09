Return-Path: <stable+bounces-235474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJIQAFzo12n8UQgAu9opvQ
	(envelope-from <stable+bounces-235474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:56:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCEB3CE5C5
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC1853009B26
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0233CB2D9;
	Thu,  9 Apr 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG0IHzxf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159193C5DBE
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757401; cv=none; b=YsH4taZp9vDdRpOtT6uzBcM3JbsmalpQetcY9LvvLl+K5DKuL+MwnP/gD6VakAzf/4Lq5ac43E8jbPG65aHr2iDvkDFRRtTXZNFAflL2w/+Fknbm7WyYfY344LIB2gz5JnwwWn+3c45k/pnVTSn7lK2k+wLPCmkuD70uRvy5Dcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757401; c=relaxed/simple;
	bh=syqRb8ZjrzL2v7saxbDAMLjih/Akx7H1/upy/WggxSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ewxsn0arbjjkCr1wfZrsQjjDUJPc58BTg64zSSGb5MBkpz/4UZgIxWKMcCmTrb0NMhs4abO39CHb/PXz4UM3qe8VbLampgI79O7zWnZ8P47rkAedwwrEZAnbYMer92p0SE/j6B2fUqwQsjq0+dIpq3j44zd+LIAJrXkpmSN7RWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tG0IHzxf; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c2575ff49so94724c88.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775757399; x=1776362199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3El7mew6bkljZoosx65G45vP8VAox+2w32bCRkf0mPQ=;
        b=tG0IHzxfuNM4ZJcSdE9l0kcC8V8a0tr/YDhY+ucE6uWpqetQOdnEkuBpjvOpcBDxoi
         JeSxYZrTluN5ZdW9t80uLyMr4vFT9mWxM9fPsxQvsxo/z08g63nllwuitVKntaQObvWh
         BCOHuph7tbSLHRQa2w29HYlHYMuwu4kxYrcHjNakKYr7LmRs2pogsXTdiuMOL53hbKQ/
         PL9x/caAkEAkqBZ9neX7vTaLEQHdo1rOw2CBDPWRGOw5ZbU5lC88tQCJwVRdohBe9e8V
         WP26Qe4nzrnnRD1T4G0CKHFmjQB3mOf77Fd4cvgunyU63i5PQNs/HqfnPdut2G6/0RoD
         dZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775757399; x=1776362199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3El7mew6bkljZoosx65G45vP8VAox+2w32bCRkf0mPQ=;
        b=e9xUQsUUPbjDTZntRj2Lqyrc8r37kym4ME/X5zKYN9iDNfFrH05594/iGbKLoUf7lu
         ssHZQ3UKqqQGoJEPFWAybkWFjmFCy4wVbIP++rQnhIWoFqKeZ3erowuAIiNpkSD0VXxh
         bmRBp+gLJf+8Gv580kUb/qopEzx7xVM9X+rM0vrW4ErC6JdCtdaNfI7Dy+DCBSGi66FX
         ROFSY2147iagN6Lh5sOcX7tL0PD4aiX+6EWg7j31kGxKuMtgkL7aGoGsN6LkVcml77R0
         Kt9Qccs8N9wZ/A7NNlZ3un7xPCwlQK2lYRIOqki0p4qkFFMt6/q3SriSy+BXQJZjt2K7
         p7BA==
X-Forwarded-Encrypted: i=1; AJvYcCXO78i7TPP6rZ4PD8HSJxR4qHqgNRiKi06CGihGUThu20VpGs/q2UINc+wlwh1DnOB5j1eni3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuSyvUo2zF4qBqp4Yx0p1Lxgukr7/V/0DPGxVp7sMZLhYNwrW
	IHzWg8qOVvHGyst7LC+Fx+7uDw3YVbBbav+mU7fIKC3PqRuAiJF2L/ou
X-Gm-Gg: AeBDieubSViY6t7BnF0KaSJJ7YxUiLaDWGiCx96QImfaONwnlhk9f7hbgVEOKbo1UHK
	4LUD4Q2nL9HaSCABCk7fZESzlzAto/AgEG19nXYU3B6ydD644zRsBhGDg+SWuDNKuSDCQPcW4xw
	fuDSG+mFzATxowX+py8RISJMEKCdtMlmSknFjoDZVFh3v1Ky1nzcVI4QN+QHhc6//EXG+ikjCQU
	zWf5K+TpfgGuB7nyLjbPMHNp11S0Fj2rzR03PjsM0cj1lhLlb9jcYH1H+56UXD6O4w30FFyGpXo
	0q/XXuQ43ic2NdeexDNwhrTPlYnnIzgORMkmXOaFtogPgykDuJ+cMr0sGPGZNSgXeZwetW0iI9e
	Uw19zaDVVI5vXnNqYdL3rtZ2ic3xi778CnmEx7zvVJxDX87bvKJhBQEJ+4RXx8vukjQDla2JqSG
	gVjsnyVuAGfG4FKx0uPl+rOayKC6odIux3jQPT6AoTX9xsFtnWMg==
X-Received: by 2002:a05:7300:cb0a:b0:2d3:dff7:13b1 with SMTP id 5a478bee46e88-2d589463ba1mr22997eec.15.1775757399144;
        Thu, 09 Apr 2026 10:56:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd3138sm629933eec.14.2026.04.09.10.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 10:56:37 -0700 (PDT)
Message-ID: <304e55c8-7e0f-49b3-b952-17c14dd79201@gmail.com>
Date: Thu, 9 Apr 2026 10:56:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/160] 6.6.134-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260408175913.177092714@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-235474-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4DCEB3CE5C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 11:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.134 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

