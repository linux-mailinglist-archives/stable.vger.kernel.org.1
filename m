Return-Path: <stable+bounces-222488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IcnFCW6pGmvpwUAu9opvQ
	(envelope-from <stable+bounces-222488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 23:13:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D71D1D44
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 23:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CCB4300EC92
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F033C518;
	Sun,  1 Mar 2026 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="cPhEfhaR"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3483382C9
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772403233; cv=none; b=GHD012DELJ8sr082uV3CoRMeEbd6qeFuoLrYa1Sxog9jnjtaXm688wWve1LizyQll2NHiZJlyQOq5WyWIpySZTxSJJ1O3Oi0K+UeJ523ifCYDJ4JXBS+MBDoTQFJKIuvykus3yVJfABYhYn2P8VuH1TRxUEDjWHB8lcqXbC8RdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772403233; c=relaxed/simple;
	bh=gEs4HaoHTF8OGOA7yJA052UhS3XXipg/5GQUkdxlf0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdQUxfZPN3o4FNUyN2Bt+rlpazElVXmbdDr63a3UCkSgr6uILKYJEu0zhazbYY2PneB+bDab6dPchuuRtJbw4vjdsi75J66ybaXM7o/g7Q8z30v42zgOSY8Y25RQIAMlysrm2/wmUNyAVeYfJTfBMbDb9oCL/GObBjJFQrXIRwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=cPhEfhaR; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id wdamvxydsSkcfwp2mveSQ3; Sun, 01 Mar 2026 22:13:45 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wp2mvrpdvPL32wp2mvFrIE; Sun, 01 Mar 2026 22:13:44 +0000
X-Authority-Analysis: v=2.4 cv=MqhS63ae c=1 sm=1 tr=0 ts=69a4ba18
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
	bh=w4U3eBif6rr1moU3uICBB1et5M72luUyVFsi5JfNWnY=; b=cPhEfhaR28BlED3bKtyvxQJIGs
	GFSrBY7BQ4gAAYtV1Gva3T7TsG4xNDp++iAP2gpJ2VefRbT2JsS097U3A1t7Is7zAnb+naIQwOw3F
	PldhCnflPGprg/E3qh4ideCUGJ4DrWA8QSd4zT0wgivFqS0u3KCRFJLMQhl3Zv+3YARu0zW4z1VGR
	140BEaeW5MyMPABxY37YRHYOh219AtBBg4SdeQGJWAQk3K0/U6bDl2wD945tqEHNmW/49Gyc/RxNc
	0b/jnhSz/FoKEVMdsTRpfJunFikN3eWgDW3N5o4ov2sdFmNLyz8lRMMOnMgAXL7HTvRITxt3W7HTz
	hXST7Lqw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:45496 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vwp2l-00000001kvO-3ob1;
	Sun, 01 Mar 2026 15:13:43 -0700
Message-ID: <23139ae2-053c-4d8d-b949-a8990a768aa3@w6rz.net>
Date: Sun, 1 Mar 2026 14:13:42 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/232] 6.1.165-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228181119.1592516-1-sashal@kernel.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260228181119.1592516-1-sashal@kernel.org>
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
X-Exim-ID: 1vwp2l-00000001kvO-3ob1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:45496
X-Source-Auth: re@w6rz.net
X-Email-Count: 61
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHzve+6tVm+sN4xkjLZNBRl2CXGgF9RYJDfqWVVKd9XUvlszqTxFjv/BGwIYpIKWeh/r4wQfB05SaV+q0x/Pk2Sxs2AJijMFlvpC/PULwU9kABc4G9eb
 3waeZpUYv6JYOjO5RI+fQUeg26/+Vex3K23V0xnKQR5CYKtNwwx9dp/o/p87YMVdtIiZoauZh6iBeg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222488-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[w6rz.net:mid,w6rz.net:email]
X-Rspamd-Queue-Id: C35D71D1D44
X-Rspamd-Action: no action

On 2/28/26 10:11, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.1.165 release.
> There are 232 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Mar  2 06:11:17 PM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.164
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


