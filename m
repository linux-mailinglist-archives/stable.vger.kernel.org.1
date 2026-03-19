Return-Path: <stable+bounces-227209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCmEEZKAu2k2kwIAu9opvQ
	(envelope-from <stable+bounces-227209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 05:50:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D028D2C6095
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 05:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F012B30D20C0
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 04:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB6A33D51F;
	Thu, 19 Mar 2026 04:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="JC/wHhM2"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1E10E3
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773895808; cv=none; b=bUmajNtyXaLgzO/tzELUnNn1JyVvmi3R5lC3Rq+Drrq8RVzxfOkcGKkQJ/Kwg3PJXdriNEP4tm/HAQF27wzSMpIDZy2s8BowPtRqe4pS8A1R9XznAXsbOz5aLORL+4uP7Wpg8vkOrFjnMIdMrHo3cuPtf0o2JETd4BovX8LI4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773895808; c=relaxed/simple;
	bh=FDcoSrmixMyY2O1xpF0SWUMhfLTYSwxh4032HUDIXjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+ZNOIRtcxNioDN21eoNs3WIKSJTjRm54lxVoNQ5ekApvoeeWQVWmDeWMHpBmkiIFwgtYzkoRm8PU6WpNwhubNYSQG2iJRZrPteDBHs3wvKzpFMiG8wAE2tZJi1QKcf0xB6aE6VI6EpB+XUPD2vbpqBktlDsvXW0ElMtS/CiRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=JC/wHhM2; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id 2vBdwUKtsKjfo35KZwntMz; Thu, 19 Mar 2026 04:49:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 35KYwsKsWSqlV35KYwzzHN; Thu, 19 Mar 2026 04:49:58 +0000
X-Authority-Analysis: v=2.4 cv=I7FlRMgg c=1 sm=1 tr=0 ts=69bb8077
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fT769vdYou+aDRuMDO/NADCfSuK+ejypBBByAE30CEs=; b=JC/wHhM2ZQE3oclqJEwQGOj8KX
	1kPqHznk57Fr1FvLLns7DsI6QptGt0sjIzoDcHAUDutiinuvAXAVClX9Dspk1GHxarfFrBiC9ju8L
	xW2SBETUN8dOdAxXvTnTC5XBFosA7gr71I6UHJPeyMc4Mw+pkTFQAnSMp6QSfBW6VFGpwm1bKiznv
	croPpahMFatSnxR3rU5MIkNdjWrIVjbWkiOLC5iWbbmyL5+n6B6KgH4ti6z1PlKlCXOCs3mYeEsvt
	SlaiToYMi5Lqwj+wWLrcGL5xD7ABtSVy9yGuOerajuxOG9E2jnoh5l3GEW1COajqJJWNnrI6DgJVT
	mL+BspRg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:57060 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1w35KX-00000003x1U-3Wae;
	Wed, 18 Mar 2026 22:49:57 -0600
Message-ID: <3eb07c80-39c2-4074-9cd7-a582ac779df6@w6rz.net>
Date: Wed, 18 Mar 2026 21:49:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260318122547.233850204@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260318122547.233850204@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1w35KX-00000003x1U-3Wae
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:57060
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGacjJ2ofXZ19O+egq+uJZzwrraYU7BPkL2zTswpuvuSuJRuIELbn6sQjXnvaJCpvZtrVDLj9T2edgeXvbw7dJEEvUR43evWk+kvRpSr/OtwbYri8CQg
 YogHO46vEFdIxou4E5nnZmxBVOUuv2uEp5MOYg4AfjXyUAy42FVwLXLlp7qg85aKXhGJlYmegRGNfA==
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227209-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.149];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[w6rz.net:email,w6rz.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D028D2C6095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 05:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Mar 2026 12:24:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


