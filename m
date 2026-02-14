Return-Path: <stable+bounces-216471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TcTKBN1OkGnuYQEAu9opvQ
	(envelope-from <stable+bounces-216471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 11:30:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BC813BAED
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 11:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9157D3019938
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8302D8396;
	Sat, 14 Feb 2026 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DmquhwzN"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE823183B
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771065042; cv=none; b=Epv2JA/9pfSBiOd1EKcZW4B0PRENjHvyw7gAv/sDdxt6aKDn2uE9arWRFAN39UTFDUD32TPwQJI8tkvA/fpu1DTFhLiIvK99L7UDUVqxJftDP7QIc4z2+oCLIY0b0R0lPvHEiqFz9gyliP3tHnqX9WFriJAb26IOtg0WZHsmBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771065042; c=relaxed/simple;
	bh=mhVQbn3nnML0QhmjoO5oXEEVvkbwgpE8kBzVT0J53No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuIIOm45CE/1Lc18dMtrXJ0YWOuV1sBXT7TJCrzQHYaO5Y+PI9+4JDA5meKTG0vCctLu3oqNjwDZHSq5zQq8rSNEGq/bSy4i6T1sR7+NF88sOQDdhD2c917EUURDSYmSUcnSZj7pwxwpP9IU9cpuQofKkku3RjHCTaWATt/atsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=DmquhwzN; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id qaJivdq2HSkcfrCv5vj1Bc; Sat, 14 Feb 2026 10:30:35 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rCv4vQFjJK8vzrCv4v129f; Sat, 14 Feb 2026 10:30:34 +0000
X-Authority-Analysis: v=2.4 cv=cJDgskeN c=1 sm=1 tr=0 ts=69904eca
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uRFftV3Utlw4A0MkRmJBkp/echvduiJKql7tGexIFjA=; b=DmquhwzN5UDwX3jLG9STW7kNI6
	xatJLYJQ6PAF9iMbrQ3W0sDQyKx+ADI3Z7PnmQFTfbSvYDk93+CX3PZNhjZK8uiVXEEl68VxcPWxc
	IwytdY57K0jWvYCm2XZK1anoSNDKM+0aP3ijwxVdWnvz0Mx9XOQbji5POOledvSCHP28nWQ2G4AiD
	LZtLabvZOwiA1SYuI25TSwBwL95qZDikvWAfVyMHFaZRY9Ace56JNhHFuaM8DuK8zHowWgzE1lk2i
	6DxoLRDOcd2e6KIJxIZd4B+mqNI/l+rfadDO/TQ7SWDTwzVBTxEW3QL98KW7XvHloX+6H3FyjAtGx
	ubmy1O8Q==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:60954 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vrCv4-00000003QBZ-0xAP;
	Sat, 14 Feb 2026 03:30:34 -0700
Message-ID: <46e66366-5daa-455b-9ab9-268a033793fa@w6rz.net>
Date: Sat, 14 Feb 2026 02:30:32 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260213134708.713126210@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
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
X-Exim-ID: 1vrCv4-00000003QBZ-0xAP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:60954
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEUq7RaBO1obmKWblcquu95BTRiH3h5jQtOsRyVSwBuExQi2FJEJAP2DMcmfILIQNygekdVqgZU+rl3xxP1C1OKq5Pw8CQWiiACASJ4dTsTna1KTQg2y
 LkUUxUn2HgAFpm5toxay+ifV7MMzDOnuNUxeHIanX63MrVbT/vR8wpPcxGxyk7M0hR2ew0FXpH0oAw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216471-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_SOURCE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,w6rz.net:mid,w6rz.net:email]
X-Rspamd-Queue-Id: 37BC813BAED
X-Rspamd-Action: no action

On 2/13/26 05:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


