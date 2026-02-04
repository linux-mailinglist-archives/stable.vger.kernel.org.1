Return-Path: <stable+bounces-214352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF3ULJujg2kLqQMAu9opvQ
	(envelope-from <stable+bounces-214352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:52:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CA1EC445
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C40B300D35C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9C38B9A9;
	Wed,  4 Feb 2026 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxO+QHUR"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BA2868B2
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234768; cv=none; b=Rg9efOdmPhof7qw0jlLfEw2XB0ALKOFLiLTdhaOcxgsKaPElZQsi/YjeoUGZ7cLCBLfz0o6HLs6/2YJu+p7Xp66/RumdYgtjQ1Um9FTx/IlDtB/jHzLG+q9c7nLdXZ5q9EtEaPcWqHLffR3NJhDicpJ8+xlu2ggj+dqWkNy0j+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234768; c=relaxed/simple;
	bh=eOs5YJhuIMFvF5Pyi5qav5mAKRd6Smea1vyT/LCMguc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsyRlc5Vz3oXFbDGr8O0bztodubPQMB+HCGWHRPjBBxaOiKKB90iT2m5CDaP5tZGwRCVM9y6U/jGCb6+WG1PXA76WylkU0gkbJgzyyQv1aCqyOEqRXNvWGMQfxCiSnRwHcDPgSEJUULNNwneRHexFY81sc8U0wBvdFoXpLTqwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxO+QHUR; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so213014eec.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 11:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234768; x=1770839568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43XEN5FRmJdXIAFFjkZ/WehUolYnNIeYiLFrpcT7fUM=;
        b=PxO+QHURfuBenueSOc3/1UlArVMIq7KuVhDNtmx54/xcE9gAIFURN1TXFvAEuIyqHc
         d0gkhbn02ZeOdeJU1jTGO09XNC1yYGfZy7M9fiNSnU7sDWlFYs3OtD/GH4zRG7biedj8
         RhIqxNKhHuEzzlLh43J35hdgArQ4csyKLqhh/6ZJ7fEG9R5sJiTTUtARR1MV/vxUVrq7
         03iw6Ih/+Hx8i6a6+OLaBNdCQpYFvNiyGunVO9ApsEIoVbxpufOytPZI8yUGFTaEdI8T
         y/evvRN5buPvs1dgDvmJzOM/KDQ1OpVM9yW0Yw9rudsIcCm6MA8HykwIhBYr9E8jGGvb
         u4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234768; x=1770839568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43XEN5FRmJdXIAFFjkZ/WehUolYnNIeYiLFrpcT7fUM=;
        b=dFZLOP9nGdfB6QNLsL9TU5UeE6Wvdioivq3maA3akwGIQyiEBohtS8K0uu3eT20KTW
         /CpjHb3JBLmUMXzKEqPW6e2XBUZBiiYlQZKPkFyYMJLuA8gWWWXNVwG83TWkCHIr3Mf9
         Fs6UyNRhnkRNe4btUbtJ6jYtp6JFOuWQ41T68wmSnkMaSRTTYDK7za8GDktUCI6jVMz8
         mxlNV3oZwERtuoNvuRIofFjmJIzEudkbak/57j74ux+zvb7hTa7Fcv8nKoOlVAkHYhsr
         7dspH9uWm916H9eWuXiDC3NYL2S+dcvjwjmhRhjbXd8QvykdbhYbKPML7scgIEGrRtnl
         z7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxsHiKufxEOnORWg3mcgSmZindXthzakFWxHKzo8kANZLjbeLVPl2D4bdMUD3DB91XFXn7sck=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIFd+diG4v2oMH7yhHFLNRhdsAPP76kA7jG4AErZ56JdVPQMz
	Qu1gIg385/k0bqxGT+FJbD3ECFOfP/L5/Drfy7oBgXZhiqiXkdCuKJvdKbm9GQ==
X-Gm-Gg: AZuq6aLAfpwo/KldTicuqtAMB5PRuIAbTBwV48juGzjsxcuWi+06I/h8zfuqdszYCtq
	SCqcg9wKtkMt9MHV8KgA0GxtHNNiUQn7Sg5oj/jl7KyJGwdD4JTy1FJsrfeOghzfJqTzXg1WDIR
	saTU/uItopHecOgPefYg3jTDXrBjVlcwKemrE5jZ3LpCtUp91nto9lS4O3IbKJ9u6GwpRpNZkVu
	BXmh0PhMQLAfRWhK27KsZBOzee9cessZmZqU7Shl/oerOIigMBxHzn9+3Dv+qVXw20NUNaKyrQz
	9RAg2GmrK04zypzIJa901TTBBWtiPzNz72+rPZIENq0+2vBuGTp3JZiKy7kbJqjkqjjBsL7xuJ4
	04v7X3kqaRDhWGkhyzzaNy1Lb0uIOK/e/Gl0YjBae5FX2143Bo+HHIRx4jD6C3JPGTFgx8hiC6d
	/0frrsE0xZLTRDmb6wPDXNbtmnOEVzsFRFPg9lDw==
X-Received: by 2002:a05:7022:1b0d:b0:124:9acd:3a38 with SMTP id a92af1059eb24-126f47dabe6mr1491565c88.35.1770234767516;
        Wed, 04 Feb 2026 11:52:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e04297sm2686236c88.3.2026.02.04.11.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 11:52:46 -0800 (PST)
Message-ID: <52f93069-ee1e-4763-8435-5f18b1631c0f@gmail.com>
Date: Wed, 4 Feb 2026 11:52:44 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/280] 6.1.162-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260204143909.614719725@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214352-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 59CA1EC445
X-Rspamd-Action: no action

On 2/4/26 06:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.162 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.162-rc1.gz
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

