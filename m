Return-Path: <stable+bounces-262012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dpVNICGjJmpFaQIAu9opvQ
	(envelope-from <stable+bounces-262012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:10:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D9655860
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:10:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bP9bT0+c;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262012-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262012-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2B4302D966
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F50335BA7;
	Mon,  8 Jun 2026 10:42:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAED3B5E01
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 10:42:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915343; cv=none; b=mW3Hznbwn+qc15GxQqG6QclU62vgjJsOuwSF9qxsOX/keb2iQwX2PW3aM3PXE/N+p/gr/41CJfymveG4DOp0O6J/Hz4qkkFbWuZHL590R59e2gI1Qb/K1H7rGHBytwLpDSmvyBUYQXEPu5sbj+sqmhTa4SmK8eUc3fUFwdNPSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915343; c=relaxed/simple;
	bh=tyFm1ydanooCPaPGXWuuurLw9oSfDkDuy+Vhi+8VaDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzhJkMZGKXAoOBwFVDyH+vXiFwOj6q1hoIdSAp13MRv+cypmKzifFikcUxi7BRNXq2pXvHjxYJ5n2hgEOMOTCRfGddNcxBn6FTm2g1d231ESj0qqvJlkAEt1o1f3DhqJ/QgyJBQugiMV0Ehy5UXgS3YCfdsLyJaTpv8ag7opWsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP9bT0+c; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b64c8311so46555595e9.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780915340; x=1781520140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azxfeq+XTXz75Qe37REfwqMLQybd94mTkxsSsjtZPaw=;
        b=bP9bT0+cuIUWb6AYX2yhe41yDY88ujrwum5LMOInB/r1RI9WDryx40GULcZbB50w28
         by9xRz0ZwOABQlcOsSW6S1r2EOn3Lb4EruhOmdqqf+Cq1j75yfAb+izgy8wXQN/PsLNt
         y3yLOSSC+mWcuya9VwTr7dbd2VbtOfV8FSLX99i7YUiJZoCKhqRegNOUW4dLihp9P1xy
         /9gA6C3QM932DiEqU+kvPBKvicKVAh8BQcBjVwgQSKIb3W1a/VAWqtKw0aCFUwSH0RBP
         jCelvx4uDc0c1MUr+Cbxpvr/DCyQZFha5zs3Xt/kyB6SnXQUOe1Sdu/2WhRPD27ZKKgk
         38VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915340; x=1781520140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azxfeq+XTXz75Qe37REfwqMLQybd94mTkxsSsjtZPaw=;
        b=Fl0DZyrAo1fFusxVUNliNtF6P6rYNk5lYrbqDmMeuenGNfJG+8P9H/acIhAPoTGD9J
         K+eFviP37JBsGjOH8izC2JcszxN1OZ+bRI9YFueQPL06dhutgt3GkqNpk88w8D0adVKi
         /L0/8pyOXaCzde9C7q2SPxS3sJV0ex/3R1cDApZmg9zXLH8J75uKZJrPckVq8cvpRVUZ
         ElWhi6J2vB9e94ishRv8knGBccIfM8fiqgoaiPrQ2G4HtNFVKhqlfFDYIcaWO7EXGhXt
         7m0zigEq8ah/vKwT3cHHdd4/oQLnSoWsA9U1WJ0OxPMdEOTUlsYHwaR2fm/f4nlRHSUl
         j0IQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HYMAxi21fY01LJ7QpZcsjoZt236llYxkVlH+4EiW3G+adRZtdO8RXSjwWE8cFxJoTjRFk+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBws09ifSMa1mqEJD16KkYGqCNskOIpougY0tbZTnyRXhDboTV
	3gWHD0wdE4mzOHm2qYdyAGPGU1cIB4NzLVxMNAgdKoApgDlBxuM2qS0k
X-Gm-Gg: Acq92OFdqqvea1CupvEnjr7f7DC5n3FdI0E/KpJj3rN8I3kwuD+2iuMOYA6JUlhuHK/
	mzsyTiyHILqMcphFyDHSgVjPB0UbQp1M5lde9bZu7bfsjBnvcKK+eUdclTwp8owQRym9/MRQKTE
	CR8kDejr4BxaosQ+DAXvIVRFBqA7QbxR7wk14lRTC8dPYvD85gNQhXgPf/OwjDQYlOL+k6rJMxn
	lwkZbAG6llCDl4MoJEflYLxXXt2YriLr+CAPvhfqSpLknHhkE6WO4B4sXay5xACWFHxcxZYnDQ1
	mQwH+93WG/UvjqirhJrjiU/aJeeiF/RrPgy7ucMgWpbfT8BjRQCC2eR3iKje4GKM5leNcAiBJdZ
	TLI91EIhTVx8feicj2m3arLpIJzFZgmil5KQe3MycxA4twqkc4IJsdbvUsLMhPy3kRQwnPNEEKR
	ucFqxvoRAg3guSzI+fmFdzd6ZlGt12mAHz5nWXS9LqYLk1spIn8kvRYdnqgMf7JBcU0/rcntIOf
	LNSUAmBkIE=
X-Received: by 2002:a05:600c:458a:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490c2614beemr218939445e9.32.1780915340086;
        Mon, 08 Jun 2026 03:42:20 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm290366725e9.2.2026.06.08.03.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 03:42:18 -0700 (PDT)
Message-ID: <e35f543d-d0ee-4ab4-869e-8d01191a5240@gmail.com>
Date: Mon, 8 Jun 2026 03:42:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260607095727.647295505@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262012-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 121D9655860



On 6/7/2026 2:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.93 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Jun 2026 09:56:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.93-rc1.gz
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


