Return-Path: <stable+bounces-225367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLAJBYJFtGk4kAAAu9opvQ
	(envelope-from <stable+bounces-225367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:12:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 948F3287E7F
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E068302F981
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC33C73FD;
	Fri, 13 Mar 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBCfK00H"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F73C5DDE
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421355; cv=none; b=r6SPnLPax2LKO9c5pGjw7yJSmiDGDXDtZ6JVMIjZvpCstF+qsNFS4cu45zooKk0eVeLmCdJ+p63iKUpquygqAShOxzb/dO6E0qIfAWssA+O9yu9lB5kGIHtTGgnhzFqlBtc7q0XzogmKAiB/fW/5dBXR1op+V7RJ4caeD96+aBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421355; c=relaxed/simple;
	bh=w5AlOwFdnlULwQcESRQdoCOJWsSJRnMvGEX4ADD7jng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4aCJA29Lw9AVbVrgVdd7iI9a/xHqWgbNZknxPSs6DMjTZGkAA+EUPc9aCZ7DnGX9EIXBHgotbgzYSuxpAhTCOwQmfamChEpd5ER2Mx+Yo1PZ7ckhrGOvTAIBxHTgM68dct4jLkWK+2iL3kb525YX7Qug52m1Otg+g+F53Vn2KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBCfK00H; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bea8a1c040so915854eec.0
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773421353; x=1774026153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9a17dPzIDqIL4X7UEpxgCYfEwk+WmJdSdSzwqIhoGE=;
        b=eBCfK00HmYKlQIKLKfCTHWxJUaEXncnSc31WNOFqNIIIcUMhKVAczHjV6voHUgYt4+
         I7EN2A/jRUvSyjOIkf9zQs5NPzIjxXNf5DyV8XKE/apdUHGpDdR9aIM+svaGSq2A+LqS
         HGaDLdBoGq9Qod0obE91JY1NKCEGema8kdwjdf0DRTo3jEucxnWltluGw/OgGAJJlj4m
         +ttE5pwjRtPqhdaSaG1KQ/62IJYBdTO5Uv2dFa/cxiDyPsaVQyda7+Umc7w/c1yRC4Up
         bN8QOEexfs/zuqppGYtMnPJE9q1lnI4T98QnMGgqY4niVoy0zUBddhJr4NhHySH/Twci
         HBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773421353; x=1774026153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9a17dPzIDqIL4X7UEpxgCYfEwk+WmJdSdSzwqIhoGE=;
        b=QdFiYQhdPBWgzmN66yRMtgv+PDATKs9ryJLlXmIH4zQ20xpMzkD3moVpbW1oFc2j9y
         AxgqHbDSCIs7JYVxvjXsDY1rpQ5oBkrupaXBUZH4/AGbjtp418tSbo5CYmdCRR21I65l
         S8oJdXMSylerUIKJe8pUG1tY4KtZIz+BzcJIFojniLya9jUS0miXSJJprWRk1KjnAZjL
         K2Ite0mnB3rXp4fDJUvA21I15vikUKBSO4gHX3n95MLi0ccRSxoXbk9C25s+wDgeYpZa
         NDTafoKSU7X6UJ90hE/x4cyUoPBtakpCH+/ZmGEjFmGFiv2JbGV2O1E++z0hZ8tP3wil
         OWyw==
X-Forwarded-Encrypted: i=1; AJvYcCVeUWncv/zdVBcTFjjFHqC+4Zp7cDel2mETGZDjCJyixqCpaenC8nfbMzdCjp9h4xgPBUd2OjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmysHTsvI+5nhOU+bu8rr1xEeCm16IBECK2NsxWCSBtDXzE8z
	2268d0aZ42MMkZygWvqrqAz6SHo+2AbwhZZADUQVItUWAHqTwBnk20ppfWU1hA==
X-Gm-Gg: ATEYQzzEgJv2154XktMvOEGSnwSnNsvAD+sVnZUR7LvbT/kt5XFNpVUP3n6l3ac/RoC
	pYvIkTkY3IkdyOfeSYiqdnxexeX2//9M0F3IPYEg956AScRIOEGliCBeSBFX+WE7c1+y68krjKd
	eH4p0j0LyBquTq3CnxLDYBadxYP9rMjyQzFYF4aw23kB4nEoNCcfzy4qC7xayIa35w9kW/TlMQ7
	e4PX2n62aBfsatQ84Zyxb5TgsEjmHQpeyWJubcXkbpcdj59EAkkKsje7Fihacp2Gf9kfScYcb2F
	iXnPX9sbjgHc/otZ9sy+BZRgNMeWBOHhmDy3y+YEkiGrSEY6wyKe7SlAJP2mJu0l9Fu2yBZ4k7i
	0jxcMgt9X6Uf6TMrNVTD+a5/pWP1mAzOQXUOWy/xmPlSV3Qpedb4IAx2QkPELwe/IpTAik76rA0
	L6B9QYYN2sFHBF4zALJBdMW6rHmgFpT+wUFY8qkoXcUBH+595z+mxdp/9gSTCV
X-Received: by 2002:a05:7301:fa0b:b0:2ba:6aef:697a with SMTP id 5a478bee46e88-2bea54df24emr1749497eec.24.1773421353131;
        Fri, 13 Mar 2026 10:02:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0b3fsm3463739eec.5.2026.03.13.10.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 10:02:32 -0700 (PDT)
Message-ID: <c8ac11d1-3e93-477a-be4c-721579382fbc@gmail.com>
Date: Fri, 13 Mar 2026 10:02:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/265] 6.12.77-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260312201018.128816016@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225367-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 948F3287E7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 13:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.77 release.
> There are 265 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Mar 2026 20:09:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.77-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

