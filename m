Return-Path: <stable+bounces-253381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCZTNrcaDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-253381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:33:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8753E599C50
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D831D30158B4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C335AC0C;
	Wed, 20 May 2026 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4Ap5ERH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7FA3624A5
	for <stable@vger.kernel.org>; Wed, 20 May 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309235; cv=none; b=iGkEQAQubPH+7OMFcxfBL16DYD4V8DHs+ZGV3gGUxGzr36R9FdfJKY9+HJp2UbaVUIE77fdmtHb/NHAMRUVVO24nTP/MZM8SoUd42VYxEGdChpzDira2ZcmfjNaV5aJ7heQSl5z+0c/poGThIFKSzOh5UwmyNGIt6BTii6y/lck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309235; c=relaxed/simple;
	bh=2U2Lrnq6/mMF6JqqGqPi5ZlHPgVMQhiT+3IyPrsu+nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahryaoiO9+vjrtAvj95Ic74AzqefFkk8zSD0WJGAgxA/F4QdOTDnvRqu33bYQkv7Y6EtE2RUKmcEt2VwHI1IY69LUKKC9qByU4LFoha1PJHLPT8Bu2gxeZsD9TAaZ2yrBqAVQN/BgufYyqXh+EYQibKsM+cwBBaezi0Oh91oEW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4Ap5ERH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-911449d9d03so633888285a.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779309233; x=1779914033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enS5KHjm0XRPYA+x0TyDaAoN6jo0NHsshdpL/D7e74k=;
        b=f4Ap5ERHOlUOa4Lbdqm+hITECmSeUXOkgiGi1hB6qpk6+2++tLNseO/4wcdAACWYYv
         L/gCC35KUBTqcDJbKTX+jtSe+OjKhrJvkasONOPrwoxloYZMsQJW7tcU+cb9yPlJe4hV
         gaBk1AAtVm/GE3nV0ig7vUAhACvu5jJpAvU3Gr7uaM/PtmmbleD7kOVPQZMChcpDbrPu
         o30DDpuDaSnO6Qe2AFtwfNmikS7PKyhFQYz/G86PISHdO+U9XXmxHt3MJMDaEIehCAU7
         4zvewe7GaaFLWaK7zcPNNgS78COnjazO1BY8kZ81Q0hzkQZ42/FcmFLlCQpZlnmZw2wJ
         8Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309233; x=1779914033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enS5KHjm0XRPYA+x0TyDaAoN6jo0NHsshdpL/D7e74k=;
        b=XVv5n4OEdD+3GXNcLQZ1pl5t7t6YfmSrkMDHXbOsMvRwWki3NrLrnxogAIIysCtRlj
         FPj7CXDGPZaXkajnaxRRheUPFlZmbb13ZBVVCoLs5fUAKcKmzFTSa5oEe6Gce/UmfH/c
         zKBryoElBmEh24dfY7wIfAVmdHUBPE62hddvxA19aBFFSkDX68Kk7zBRjLepcingLGdN
         eGlL05Vl2Fmk9MyHMgrLFcDFVqhWOujhCfbE1IKT+2WD8UYvi8zZbtyqaqcd6G+KHYmm
         KyU64ePLv4UOgOfSzNJfYGxepoCzncnhsKMRRLEfO1FafWALJP3yoMnkpru1S2wGq3qZ
         Gptw==
X-Forwarded-Encrypted: i=1; AFNElJ8YU1rzrIvoKIjvpNokAubJrA76Hdnt7glu3o0XCVF5qxYMzX2i2voq9JdY9u+IIsTqPd2L9yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HYO1NFZVGTu3jLnuQYqH5lQDBF4Sevtc8LhKk4oZPXiEMnPY
	AHLg9Ngvg7wk7JSwZ6xR2mPeVwqpzt5ovAd9wF3okePTWOp19u7ErAxTV2RwYA==
X-Gm-Gg: Acq92OGOZc+GtC2h8uYId2+FFwczz7BSeQj6nlaSSzp1LDvu6AliKHsXLeVrg454vY9
	dk3rLMK4fSXugVoNbwWjEfOQXW6v9zqGuKo8vRqwO83zjosId3VhMC6SXi4/a5fvl/fsY0Mudhs
	R0mLLchGcJXmnYZ8KN9Dem5NuOy/P7LIOKsH6pWh9wCDMoowejklONolDqoBaqxYeFrLO50Hc6k
	nEggQs5J9cNbW+MwFYPdL9Fs0IsuzP6vNpAzsgYdvOHICh+1gjbPi9ebP8b57H15/2rjLb5oZDe
	NUGKNpjHQj3wPyTCosy8QHxvNutZHDD0FKUugYq1oPAHCYIkCuHdyScRiH+uHc0s8ZpSRAtAkvr
	aweZH5t01z4s0rmekPqM9P6W81XcqH4iYaOhXHx9nRsOC5gSLt/iPuEf/ABDYfQrZ9GSXxV3nwY
	aOGANuRRT5JoGVQHIowgWrqI9U9NmnSx0GzfMFN43lVh/m6m7nHA==
X-Received: by 2002:a05:620a:7102:b0:90d:c28d:9666 with SMTP id af79cd13be357-911cf9e0e16mr3452163685a.30.1779309232654;
        Wed, 20 May 2026 13:33:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bae24879sm2382261785a.18.2026.05.20.13.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 13:33:51 -0700 (PDT)
Message-ID: <fbe52f15-5b34-4e03-88e0-005ae6200a60@gmail.com>
Date: Wed, 20 May 2026 13:33:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/508] 6.6.141-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260520162058.573354582@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253381-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8753E599C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 09:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.141 release.
> There are 508 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.141-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/symbol-elf.c: In function 'dso__process_kernel_symbol':
util/symbol-elf.c:1379:7: warning: implicit declaration of function 
'dso__rel'; did you mean 'dso__get'? [-Wimplicit-function-declaration]
    if (dso__rel(dso))
        ^~~~~~~~
        dso__get

this is coming from this commit:

commit 8b4beba45e858aa793dd5d4d2e86d60c8c1915e6
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Mon Mar 23 11:58:04 2026 -0400

     perf tools: Fix module symbol resolution for non-zero .text sh_addr

     [ Upstream commit 9a82bfde4775b7a87cd1a7e791f46f83ae442848 ]

-- 
Florian

