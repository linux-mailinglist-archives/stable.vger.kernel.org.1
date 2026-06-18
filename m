Return-Path: <stable+bounces-267041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HOIZKE6pM2o7EwYAu9opvQ
	(envelope-from <stable+bounces-267041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:16:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738E69E618
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:16:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=w6rz.net header.s=default header.b=AXMerhEo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267041-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267041-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82E2C301AA68
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6B363C63;
	Thu, 18 Jun 2026 08:16:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD602D322E
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:16:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770571; cv=none; b=T1Dso1MdiAjhzP2qPtcmbsqWbBpkuxPl9V/NmXwRaSWdUD2B1FihzSvjkTI94b4NmpeH5I8kmdxNj4W8iLFpV+bedB/otr3ErzYWNdutGsKHi8J8x0bIueJFs3QZoqyrNZmppEd3Qz8GMl95zgaT0ldScuclTzZoFefGItORnig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770571; c=relaxed/simple;
	bh=GHyigE0ZkY04GYxhoukj/4BiAheCQrN5JrNPTNOZ5yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cY7NGfxZksfw0BDGvoM0vfsrk07PAM4uNb2yDVgcqedcfM0fiU2o/C6KZJdS47l00emm4nxGZ5UMRtyy1DrxxQPmhPKcL/bS/7nukRLsfCXde7UjJz/sKuPIUhOAqFxYt62CMKPFAavOyiIibonxCpMKyKobz86OzLgXp+JJMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=AXMerhEo; arc=none smtp.client-ip=44.202.169.35
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id ZvUbwZWJUgwLna7uywaSKw; Thu, 18 Jun 2026 08:16:08 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id a7uxwq3sHnDcja7uxwlYKG; Thu, 18 Jun 2026 08:16:08 +0000
X-Authority-Analysis: v=2.4 cv=BLizrEQG c=1 sm=1 tr=0 ts=6a33a948
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=9GQXaQUDpQhx98mIA28A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a4QcjtBR1JHGc73gmaVGmlGEB3kKn1lLJ3Vy063lEAo=; b=AXMerhEoUuFGV630d3Xp/jaGzu
	L2CGLJ4Gz9fliZL7KAKXhy2YbCdDtmWknSq4NFGoYWWG3wwTmFDCYg53M8/YbmCJ/9m69gdcSvGj2
	eM145cuEUL4XovMlmryJFTS/LnV4z3Vr4F/x89/x96cro/I7934+KZMyTDUqrDISJX2J72PKCfEqs
	3946pbYHTw9eTN2w4qwkgJnekyi//4bD2dXHL4OCdDc/0z9cVJ4Lz9DEMv/AeZe1zWDPwuVrLUizD
	UXlui2G44IcoqRNzDc3l8//D3I6updUWUWoQdqWHArFyu4Xtuyj7cbGZCOm/2MTqlRy+vQbdrk1c1
	oWMul8tQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:48134 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wa7ux-00000002YBw-0lge;
	Thu, 18 Jun 2026 02:16:07 -0600
Message-ID: <0de8fd53-895c-4496-b084-efe5bd4ccfda@w6rz.net>
Date: Thu, 18 Jun 2026 01:16:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/452] 6.6.143-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145117.796205997@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
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
X-Exim-ID: 1wa7ux-00000002YBw-0lge
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:48134
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGJU48mS0t9s0O/q+eakLbcbbOlFbbjzeUqshJ3CRY/rzpHtg2zjmlksng+oJxbC2zwpIAfyG0PEbTSEDB0Sn0KUc6uVBuJNPpLy8dsq+o/lrffHZeCn
 0nDbSf1LwZ30HWtmtCU/VQx4Q91WTUiFfK+pti9dHeo4dVzL/h+Srj65IyvsENu2yjxKAuxHIplY1w==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267041-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,w6rz.net:email,w6rz.net:mid,w6rz.net:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3738E69E618

On 6/16/26 07:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.143 release.
> There are 452 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


