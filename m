Return-Path: <stable+bounces-237633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGOOFWQ83Wk3awkAu9opvQ
	(envelope-from <stable+bounces-237633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:56:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C723F24B9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BECDC30AE70A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3639098C;
	Mon, 13 Apr 2026 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdpjOVT9"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3543612DB
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106318; cv=none; b=lRYI6oQVXvzY75GLC3t8vvwOxsefmVazZ6vh4/5AOD4npafXwZvAYJJIaajNED9FbcBJmzvpoLHvOc3UYhIn4NPnA0/StdJSiU9G0bTd/Lcy0LLTa9nXqvaRkpioT4tcAfQzesD9JqARibx2bHkpDLkY1rTWoC1W7btNiSQHJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106318; c=relaxed/simple;
	bh=7OReK0xhaVWwzq3lCjA8XnfHRyadhGmFgqb2ClITC+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoSUCENMVX/88maKl6404mUGgGkMVZqei+SsEQQpM7Qi3GCeMP+Z50jCvxSiFo98Y9m3xspnqDKZomWPcviDb2ILe6JZAaLdZRNNLbYxWYkZLoCrFsviEcXjhLp7a91ft95zRafuVwnLpK7bqubCbBnGj3mXoFe0JJQY0jjcnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdpjOVT9; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso4941050eec.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106317; x=1776711117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1EBvOVAJFA2G2UKFguZ/FfurCHUOcXs61KpfGnt95Cs=;
        b=mdpjOVT98EWd46lV64JGpjvLSKquGVIr0W3NXQlDCOyElZnj0iuyB4goB7npPbvu9s
         rfdHwNqiNMkym6sRHs2W6bgXVZ8B/xTuway+Sq+RWyDgCTiWkbbRc+p8cVjBvjx+PxiF
         vpE7iUxPW6ZbQ/5yehC0qsjvLipFUDYaO9X7iQ0G4nS8jEl8Sep8AtcOqHcFBqD25QYS
         gJwK7XJvSsGG6Ie9Z3J8gvB0b7Zg4FnZIcNOpmhDD6rEwiRlB8kiEkaBifNb5zv71FL1
         /BAoWP/qxbv5fk8MaT0QqnvzpZ3Byf8XDheQzr1FCrLIIiqH9anRk3tRNSE4AoohSR3X
         uVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106317; x=1776711117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EBvOVAJFA2G2UKFguZ/FfurCHUOcXs61KpfGnt95Cs=;
        b=eX1CN+oWA4ee9KrkuJR4JGbjjzAz4OlkI2gEVBz8w1b8XNXSfpV+Q5ingIhici6+E0
         DNWAjNuhTOweI1GQRKqTtoZwx4J6+KYRnVyUQNxOHJKtG85NVjU02NPFORJhv2qHNpFg
         hmsZHM5lqgDWpfHKn9eVoBvqyhNiNDFtTlcknmCn6/Ho4gpB/kC1VgCRZmjAUioAW4qC
         Qg3V1LxET5hqRQrKXju/05p2qOrfjNll5ciKPQYOXBONaF+Yn17PD7yFvyDqVzKDln73
         DNVTPO95GRiP5MrRQ84TNSd5VBQjnrEbHZ6aF8eC3i4bPlXsNZcfysToKLcQ/YbI0THe
         xq9g==
X-Forwarded-Encrypted: i=1; AFNElJ9325YNcWc1CDpOJvINHTUYSZFyCnlpv7JbHg4pap+D6tXUT3mS450DB7rAtjXlVOZbvvPmiTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3vViJip8l+Bo5o+d/8BWqijTtZCXK9mhnmts2qD1hsQVZpmda
	YmzON1uVyiyxS2TQvG0YgL1PTgsFTWAiJT0GZ80KEqWBu0hjBBZIBgWw
X-Gm-Gg: AeBDievF5c8tzEF58OyO08qvuEmyDec5X6no6WYAQG4fLCfdwFM9U9OSYAcbdmJW3c1
	LEuHRYdPnd7wN3qm8pyB2/yesghbf5T+Xvco7luoj0fnteMf0QmipWq3wtisfio67fHf+3Eyz51
	lRjQt6GeQtliDGwGJ7dFTKzxGq7O9AxTg7J8o5fYvny9EQVquWKtJtgokRxtXdDZLSPql0z/jAJ
	jYq63cPoc9Uw2PjXxjjaMIE5/uetahvEF0h6iLjkaIxkhh1tI8i60KaT+8/nX6MDQp0zT/yJAJK
	+q4KnIQ1SMvDz+Xh05VUw+TZstiKeRo2ULhS2eV53MLFkNs9S8rKOETXMLMHSiV5lwWaUunDeRg
	5CTycacAqkAWtwRmu9yeQYaGt3h+lxh6UYUqzofQjEl9kwMfL8H5DhSRS3MfVSIRurgjYGcLL5O
	X40Tc54XIqBUnuU7FKPVhfjNSey5VvzRstyFgGSBR3RX65h55XFQ==
X-Received: by 2002:a05:7301:1e91:b0:2cb:c1f8:a7f5 with SMTP id 5a478bee46e88-2d5881a8fc2mr7509739eec.19.1776106316736;
        Mon, 13 Apr 2026 11:51:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db6ac8sm17717582eec.26.2026.04.13.11.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 11:51:56 -0700 (PDT)
Message-ID: <ff673bea-6a1f-4c0b-bec7-a0bc5dec0970@gmail.com>
Date: Mon, 13 Apr 2026 11:51:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/55] 6.1.169-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260413155724.820472494@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237633-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: A8C723F24B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 09:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.169 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.169-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

