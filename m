Return-Path: <stable+bounces-247061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CFvG50WBWoUSQIAu9opvQ
	(envelope-from <stable+bounces-247061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:26:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F753C567
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04ACC3004DE8
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19562285068;
	Thu, 14 May 2026 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="c6j2511d"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3B282F2F
	for <stable@vger.kernel.org>; Thu, 14 May 2026 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718362; cv=none; b=YVPHLSjrbsFXTrvGGAt5z88eOAIyNw5bgN1w3t62WgNrQCrIeszwEmPfpwOHzCG00dNF6qX2ITnyUx2YPtCYCgFOn8TdPZRUafQbZ6s4Y028KGWAqUgCXeRm1h95edqT4zJlhmgz3XxiJnljdc1NZRjxqM4oELrmhlr1O4iIo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718362; c=relaxed/simple;
	bh=T3IUJ5N3cb2X5Ao8jYR062oCSRceiv9IXx+vsdNY1qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzt8om5k+64/hsldQ4Qs1gMWlN0q2am8n1B+A3+gusOFz1TNduTQOSm9dAGhjA9HJO3G2kGH8+qAEMf9xiYWEPKkFLd1E1B9DrTELw7EP+EZUlX8SMugkHlcc43nWIauh9uQu3ppYCdL2Xwoyn+RXtas83Nu6CLYefISHjRvKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=c6j2511d; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id NJbBwAvEt4RkpNJtiwZ1lh; Thu, 14 May 2026 00:25:54 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id NJthwlXu3CKa1NJthwXrH7; Thu, 14 May 2026 00:25:54 +0000
X-Authority-Analysis: v=2.4 cv=IaKHWXqa c=1 sm=1 tr=0 ts=6a051692
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ytQjkP0ak7MJFOk13KBVfWAL/1oxQ+ny/1N2uZnwIOY=; b=c6j2511d25Ed8/diummxpE0BiS
	faTPJrImi+X2jSWn2a6+ZpCNvPBgG2Vji7Ju9SoxPdr2C6oPH3Dd94TecEDPB0nmqPmkP0AegLhri
	QpqBgF4ZqFRpfXXUHcwFeoDxSI9njIBuUf3GVeJ773+n0RlPysGjO5Nuqw476wTiOP4ZW4/gu7xC4
	LhxrgDJlX+cAyBcrLmevvjyML0+rrIodV3bY/7VVRRnDP3kl1aexYPXtwirODBPbs31rzzkc4zAxH
	GQB8rgpP/KMHPO2VUh6+8HoOeET2k7Ce/zb/Sq5Gw5qldZXlxLokkk4MhtuqjHjgnOCH9e3Ucrd/Z
	zLsJy6CQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:42948 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wNJtg-00000003P7g-2mze;
	Wed, 13 May 2026 18:25:52 -0600
Message-ID: <a519a32a-22b9-435c-a282-b6abccf8e1ef@w6rz.net>
Date: Wed, 13 May 2026 17:25:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/305] 7.0.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260513153754.934923793@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260513153754.934923793@linuxfoundation.org>
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
X-Exim-ID: 1wNJtg-00000003P7g-2mze
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:42948
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMsT/iL8l0TkzSJ6yy8/TpVDoXMM3r/k3UQr/QhuLZpj6OXNZ2koX5r9py05txJK94NSaOZ3RfOU4s4PNdxbKzN60+PU1eQXeFnqeLLgUZILMgomNvmi
 5NgBRR4oGea0wf4Aj0RJHh+SbFKHnknUGBSiBtckElYzMKWZjqg++3HqbKJbC+rBUKiXwJAY/4lfow==
X-Rspamd-Queue-Id: 0C1F753C567
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247061-lists,stable=lfdr.de];
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
	NEURAL_SPAM(0.00)[0.399];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 09:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 305 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 15 May 2026 15:37:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


