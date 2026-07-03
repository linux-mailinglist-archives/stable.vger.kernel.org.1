Return-Path: <stable+bounces-271634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AchXMblOR2qUVwAAu9opvQ
	(envelope-from <stable+bounces-271634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:55:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB86FEDE0
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:55:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=w6rz.net header.s=default header.b=hemeTBVs;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271634-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271634-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C1E63010D1F
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC80285CB3;
	Fri,  3 Jul 2026 05:54:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA13290D9
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 05:54:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058073; cv=none; b=Om0yJ3vnGPVIgtIXgWAjZD80YvzwPoPVVtyZz0wOXIuxu5L48xMBhu1QLB2xmR81rgZllljody1GZ0ZbqFwLk9XDVvid+e7+9C3rIdGIA1rKxDUUlnYjnYRfpRqVWJWcsmCC5SFRRU7dXGV/qNwSABz6u3gIV1dbAhuESjKUtEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058073; c=relaxed/simple;
	bh=Z2VEkFlgYMrqA5RzIlY1A4wDmsIB8Z5DNlzS3XqevtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJvMu1fwsjarhtcxrQ/bDSnAW+QHaofYb0J7NVRD/fvUsRBzOdnZz1QhL/cDuM0LV42rNXjTdqsq1Gvqwfd5RPxnWttEqoUHNfA9AVptRcWLKdSdVlgKRiG+DZNfTANH1sOK5SalBKIQMJKUMmhLaox3g/79eEkJkH4PsYkauSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=hemeTBVs; arc=none smtp.client-ip=44.202.169.35
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id fHwUwUe6OgwLnfWr3wcpwz; Fri, 03 Jul 2026 05:54:25 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fWr2wWbBaxg8YfWr3w4ngI; Fri, 03 Jul 2026 05:54:25 +0000
X-Authority-Analysis: v=2.4 cv=R44DGcRX c=1 sm=1 tr=0 ts=6a474e91
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=Fowlm8kEtbx0O9ktuRkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=35hBBtkq3T2Pp3DSaSRbdRe3FPOi3WynMPb7oDO45lU=; b=hemeTBVsR1ni8TidBOef8fE8sU
	iMsyMOctStTBVS52Cl2o9FOcrEcP455pWxz3In7lsa1QfISiDZLq5iq6DIAk+iAroJnlyoDZ0HXQv
	mdWgJHWOPoXx1H3cBsl0v+bQEQRYgN2foTHHxKC3IXMXwOLBAWUaodCcsuKFKmzuYuhG+SuRVYShx
	vjWKKHocLYR4hvAHEJHA7Fk83rGOhaYmk9kuO8sHRZ3mUnkZUKvFlJrHX5007oBAgV5jCyjOubd3G
	sfZuCaE2bWRMqB0xKuME3q0rG0ZtFPKRubYLaXyuYdO4OmOQ+e+OTuQHkU9Om72CNoKZirmO8La6B
	pROB5n3A==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:59202 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wfWr2-00000000hDK-1RJk;
	Thu, 02 Jul 2026 23:54:24 -0600
Message-ID: <4561a281-d46b-415e-8272-32c88b0f0ab1@w6rz.net>
Date: Thu, 2 Jul 2026 22:54:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/108] 6.18.38-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155112.110058792@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
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
X-Exim-ID: 1wfWr2-00000000hDK-1RJk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:59202
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJO6/sX6YZO7PxKOQViWTRCb0TjrJqcb0Moun7z87ULGmBNvU/sPjcVVtpFVywmKd2xcC8uNdmXyJGAN4gOwgtEk61POLJlQiFuvYq3tnhGu5NkmJdDA
 AcmiiYbLbYGnLWPZt439Ky4YkgTfRxEa1LO2XeV7q3HUdrldPLKhY+og9RMFKcGu7a4r+hMREc8Bag==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271634-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER(0.00)[re@w6rz.net,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[w6rz.net:-];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,w6rz.net:mid,w6rz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7AB86FEDE0

On 7/2/26 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.38 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.38-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The build is broken on RISC-V with:

In file included from mm/kfence/core.c:36:
./arch/riscv/include/asm/kfence.h: In function 'kfence_protect_page':
./arch/riscv/include/asm/kfence.h:25:17: error: implicit declaration of function 'mark_new_valid_map' [-Wimplicit-function-declaration]
    25 |                 mark_new_valid_map();
       |                 ^~~~~~~~~~~~~~~~~~

This is caused by commit "riscv: kfence: Call mark_new_valid_map() for kfence_unprotect()" a8818008680a00a86c080a55e8842c714e9a62ba

As already reported by https://lore.kernel.org/stable/6c5c0723-66c6-4f9f-8021-2562efc95c6e@iscas.ac.cn/, upstream commit "riscv: mm: 
Extract helper mark_new_valid_map()" 9ee25d0a70ff4494b4e1d266b962d0a574ef318a solves the issue. This commit cherry picks successfully.


