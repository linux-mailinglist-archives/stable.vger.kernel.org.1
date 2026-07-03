Return-Path: <stable+bounces-271631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xP4BL2pMR2q7VgAAu9opvQ
	(envelope-from <stable+bounces-271631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:45:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D976FECC5
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:45:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=w6rz.net header.s=default header.b="Co/OpGna";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271631-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271631-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D63A300CF18
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 05:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40EA34252B;
	Fri,  3 Jul 2026 05:41:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA57330301
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 05:41:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057311; cv=none; b=OQB0jX8VD3ycqwn6Zpnr8mmE6VFmGVbBHDHl1RRjEZJJ9eIOIcB6vyo7H+FhYdlYuD1Q40ejT4TTYQqOjy/UzERHtejBjj4IKFPbpoXp1omU8NQFZ+ezrJeqOiEZi1F/9T0NybabatSMErAL3Mbt6udekAIW/uW2Di9v0o7vitk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057311; c=relaxed/simple;
	bh=1pJH6MM/YI04BFzDJJll5C6T+U7N6I/hlXQqgKp7w+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnHBzMUuSCX8XPGtFcuKz4xvqFqmi5z5p/D0NZd8KqSyw231Cnq79YPxvByAdj/fGlAsMgbXd3gxmaPqO/xHnIl3I737DwDHaR55oM7aYGot5SI6x3CsQW9hD5864syIxXBpr4rJMk/nhYuVx+UyYCVk4kYcg2//bC1E0Zv2V+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Co/OpGna; arc=none smtp.client-ip=35.89.44.33
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id fOw3w5Zu0lPo5fWemwL9nd; Fri, 03 Jul 2026 05:41:44 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fWelwWI2Vxg8YfWelw4WGd; Fri, 03 Jul 2026 05:41:44 +0000
X-Authority-Analysis: v=2.4 cv=R44DGcRX c=1 sm=1 tr=0 ts=6a474b98
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=smfpkZXRov3BA9rGheEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IpbFOvjkuLZ5F6PCLXLKuWI6WEUni97OdegGtjGwNOM=; b=Co/OpGnazX9lDGKS2yLxq8Vwhw
	RhYGKo5JR5ZN+IEihE9JbuF+/Jp3phjzlM4oU0MMyNk5qHHQKs8BuYECbJ548Xaem3+n2fhymgvAQ
	j21G2sUD0B/D7Td4H24ix3/Wwe/d3leIcS2KzZBEG4xGPYCetrcEe5+TFar3B0qPUk4IG64B32VSq
	csASdgTfkABWlOGd36ugP2FrEKxWfVcuWg8Tz2Qfu5Lff3jbFupTaSC1EYcOdBDGskBNYwSDBONat
	vyUE9nVGbOr1GldUJG/iUOuNbVQhonHlyVKPfvWa2SkKcSewqJCYnh6nru52+Emez4vNmhfnGGUbP
	EZErYHHg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:57166 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wfWel-00000000a2U-0l6Y;
	Thu, 02 Jul 2026 23:41:43 -0600
Message-ID: <45619dda-652a-450a-bc91-6bcdc3e6edeb@w6rz.net>
Date: Thu, 2 Jul 2026 22:41:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/120] 7.1.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155112.964534952@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1wfWel-00000000a2U-0l6Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:57166
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLceW62j0vWG6xAl7honVLbWgYN9wXGBx/ERsMtFlcsrHZDcPOO6fYbUijnG/7I/MC8YnUs59+KY2LmFX2FzFinuKtozMqMy709A/qOQpSKC5Zx2/FMO
 jM3WlWBZyPPnGN2iZwNtsTP4Oa0xmjxiiw+SPaiAdi1cpp2/ZELPD1+oHAAhF1LCmHgL63HS/+yhzw==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271631-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER(0.00)[re@w6rz.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	HAS_X_SOURCE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[w6rz.net:mid,w6rz.net:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6D976FECC5

On 7/2/26 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
The build is broken on RISC-V with:

In file included from mm/kfence/core.c:36:
./arch/riscv/include/asm/kfence.h: In function 'kfence_protect_page':
./arch/riscv/include/asm/kfence.h:25:17: error: implicit declaration of function 'mark_new_valid_map' [-Wimplicit-function-declaration]
    25 |                 mark_new_valid_map();
       |                 ^~~~~~~~~~~~~~~~~~

This is caused by commit "riscv: kfence: Call mark_new_valid_map() for kfence_unprotect()" 66fcdb7f71b9d3d32828130cf5895adea059016d

As already reported by https://lore.kernel.org/stable/6c5c0723-66c6-4f9f-8021-2562efc95c6e@iscas.ac.cn/, upstream commit "riscv: mm: 
Extract helper mark_new_valid_map()" 9ee25d0a70ff4494b4e1d266b962d0a574ef318a solves the issue. This commit cherry picks successfully.


