Return-Path: <stable+bounces-163121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4693FB07469
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FE9505632
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE52F365C;
	Wed, 16 Jul 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="2N7YFRME"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7CF2F2C5A
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664468; cv=none; b=hkP42s073/YM6iJ7JRkemH/mkI9CpFeqd0xBGDIRlyf/qwq9egUP70s3kGZePlapKh+UijloI4iiaHTGlrgEyu/gHRg2BJsKl5+qcOHsIom9V81+Qoo4MfX5AWEis2uJI1h1va05c6095ID4FxkBFOaSgh7N2pHJPlnB9cqrPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664468; c=relaxed/simple;
	bh=+kWRZdHA5sveSqTRHT7T+wiUa880suE/NcbD2Dsy5A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDVLl/bdW9EI9NDBrt5jFb3dKIccEndwyAX4UjWHjX1C/F51V2usWbboX8a5POP649qB54uab0FFidoI4znwAXyUJt12JOuuql/Z6KTGabLRWyGHKX45mygH3t6sbuGvM25otEKxS/d8tQPPwF/1rKaouDNvAin57Qh+YBOaONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=2N7YFRME; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id bzrouuwyQf1UXc05huAW17; Wed, 16 Jul 2025 11:14:25 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id c05huHd6GlLZyc05huuzTZ; Wed, 16 Jul 2025 11:14:25 +0000
X-Authority-Analysis: v=2.4 cv=bNXdI++Z c=1 sm=1 tr=0 ts=68778991
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Fyo-qtgZ5HMtR4iIztsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Skt+g1XkyWKSJri4D/2V18Sv2BLs34XHvPDFqMQPu5Q=; b=2N7YFRMEWTjDEKxmUlZMTYpZKs
	lcMdo7no0FRTaXF5bH7zoV0nXuRYfA1E309VMLGjc2XxotTqBP4w2fpJofB2NSTyJ4uHvsPO6k1Rd
	00hXJb/bymCT6FibiZPWgKhAPmxAubv3/Z5GMohgMrJSfIAYEGpG8hJhY1gDVJ/j4RckLlA01vj+K
	6/B/S+9kvjOrMFAPbyf3qnxMORoHXP8a7fgwdpIggly/8Am7WkGtM784rMdEf0vrYLAebixpiEWVF
	b/XqvQzKFkPzjIGi/pW8mKa0Bcj6ltLkt5ko8gDpgAXzcH8GLz8WnJhZXp8NTok9L3zmivo02wBVr
	VCLqG3tQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43336 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uc05g-00000002aaj-09oN;
	Wed, 16 Jul 2025 05:14:24 -0600
Message-ID: <adc7c120-b80f-4317-8f0b-216e27f6c36d@w6rz.net>
Date: Wed, 16 Jul 2025 04:14:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/89] 6.1.146-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715163541.635746149@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250715163541.635746149@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1uc05g-00000002aaj-09oN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:43336
X-Source-Auth: re@w6rz.net
X-Email-Count: 41
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIcZ3YqDRTvL93ZsiGVeOIMHD7X6bgx4s548UdKfw2Vf1Go41JndzwUBm1uUPElEk7BZpHLjGFc6jhBYLUzppdZIiuyTc1jiw+eYDAAPQ+nwuJ7q5D/o
 TiFAdhhgywynI5ILgJwAuVEKDKgKtqsF4tklzGTtASmzVVEx0zjf0ApfZhPT9mSA3o1HZ9EllxCmDQ==

On 7/15/25 09:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.146 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.146-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


