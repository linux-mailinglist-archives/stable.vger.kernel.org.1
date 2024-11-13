Return-Path: <stable+bounces-92872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7820A9C6632
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 01:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8871F24566
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5926524F;
	Wed, 13 Nov 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="F+PCQyLv"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4905680
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458713; cv=none; b=BFaNE+DZ/fnMNqZcK7NIOZ4K3E58+TUktrwdPgELaSjawpcp1UJqF6lzqouTJH0Hk1w/1G/3r4ZhWFOHUDLtAPmpaPzaKQ1O55cZBzaG5qQFKLP4HwaE7mTv0UATiV4Wq7b2LEw2r5gl9oyNhb4A7ggGXAMm+Uee4I7uTWA+H7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458713; c=relaxed/simple;
	bh=Za/n86KGJzHv8CV/HWsYmcN0pm3FBSS0dkUbihK4G84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgEk7VJvjz9WWMZ/IXM3cBX8CxGdoDPssfOV/lszHFsAox8M4ANLLWH9VSFv0xlcxroJnZ0trm0eLUc3iDGZyVmB9bGiUuMCJ9zmoO2lB2fscTJvJO17fTKI4EXdqBMRZf1W6zU8tVLhCf+jeaefz/5HPg32/UOXj2qDSfwHaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=F+PCQyLv; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id Au4TtcY1xvH7lB1VPtISEu; Wed, 13 Nov 2024 00:45:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id B1VOtdEgBCgT6B1VOtaAWt; Wed, 13 Nov 2024 00:45:10 +0000
X-Authority-Analysis: v=2.4 cv=XvwxOkF9 c=1 sm=1 tr=0 ts=6733f696
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Xg3r5l62jPq6txtoRjwA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UyZ6NhO6KwjaejbfgDoQwG+suVd2I5spH6TWGj+UIhQ=; b=F+PCQyLvVYgi9DFR2MktLXD7ri
	pUo6HXNKd6zoTNcQD0PrbG6a8oruxJp4hNfoI9XrprrwBLC3VQnTf4qQz8k13A0lm50TahIqBTjMO
	nevNke32/n57uQlHahkqWbtgSBmSmh5EczlESPJCEph8uViy43+zcF9MBkMwop9jPnczmvmQqD4TA
	xae1uYeBOuJAm0oG8mbC6ZMvWf/b32xJFfrt2Do6Et691srjlRIFsLU60bvs8vATqjqZvdgvjegjH
	sU1xA+nEIReCyDaON1DRsHmLcu5a8qFqfqNsJM0G9UpSOfhBOPXqVlPPJEVGmjlrZHjB5gLth71K6
	IRBczRrA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:53218 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tB1VN-0046jJ-1I;
	Tue, 12 Nov 2024 17:45:09 -0700
Message-ID: <1160c65e-7106-4cec-8b16-61a9336fb826@w6rz.net>
Date: Tue, 12 Nov 2024 16:45:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.172-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101839.777512218@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
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
X-Exim-ID: 1tB1VN-0046jJ-1I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:53218
X-Source-Auth: re@w6rz.net
X-Email-Count: 75
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNC0w9o+gbUv8y5K0hFc2zLUZANh5UHQxKd8WflJTmKiVZQY+ErBBu5fjsIHmlOML6WbcfHQ1J3m1RGNQOZ5ZHgA/V0mktHSsWeXpehR48oU7JFRREke
 BLUUiuoTrAuliy+woC1Vp98/p0wW+yJwARHtpV1JzScOCbU4pSqoAM0QNdzn+H0DuMKkkipDfriUKg==

On 11/12/24 02:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.172 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.172-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


