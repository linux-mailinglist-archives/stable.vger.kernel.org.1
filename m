Return-Path: <stable+bounces-42857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849E8B8706
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87E32837BD
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840A850277;
	Wed,  1 May 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="yTM/PQO6"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AF502A8
	for <stable@vger.kernel.org>; Wed,  1 May 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714553123; cv=none; b=kMuiWUGra865636vou/t8er/P/DOkmi+GsFqwTTnbFLXb9po4AIMSYYm5Or6ryT3fOQguRagHNiN6PE6G44W6WCuVORJu/UILbuL1q+Cd15TNe1Y/Hd0UXEQ7wHu+CtsU1e7ZQo3+KakDCwacDAtYgye8MJTzH7C+SFqmJxH8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714553123; c=relaxed/simple;
	bh=3g29c/9Ymw1Ku1BygdtEahxt6WNzjNj9SmlkQAbCpu8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=V7b4TGVY+Uuxz6+vJwkOuzR1gqACCw4FjQ5boX8bKlB+jnLoH9RZwazVvDZj4iplv4vV5H3aD9Uzbo5e23Xs1NayFZ1MKIHVx9yBi3Ywffphe/32fk9pcyMQ3JhWKVds0+TvuUTjB44Tjj3OmoEmRYAkmBwE6QgNtqlKrV66FLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=yTM/PQO6; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id 1rnRsJ4vJSLKx25aVsMdAe; Wed, 01 May 2024 08:45:15 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 25aUsVhbauv6X25aUs5ufs; Wed, 01 May 2024 08:45:15 +0000
X-Authority-Analysis: v=2.4 cv=YbZ25BRf c=1 sm=1 tr=0 ts=6632011b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=w3vtCogE_fj71Z-Hq2MA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U5zZUNkCthJCCdC4NF2rQFIUxXdnmN96a5roQLbWii0=; b=yTM/PQO61DCpQuyQ2eM3fUsUmu
	eKPTIms5Mfy12uUfkQJSfopQv0ncHL3Tn+T7cBBTFtZL6PTW8zGc4/KAdla0VSGXf3LA4+vR0Z4aU
	VSDOm+3qm/SfA8/LPBigiL1dF7wpKq2z080ocJv9IgujYNVk9TUrsF98vPCvWcsUsMhoEfdJ+t5GV
	w+ASWnloZwwVbuh5YQ5x/CrDR/Us0T/YMqCoCzfbFH6aYU71wQtxFJWJqUHW1hvcHrMWEM4yMXMUO
	J/oG31lmMjQM0IJxYvZodGWnOYz3bj+PheHRUG30oMGWqv43zJ3SSEiozIMltpm2r4AnYoy3Wedbv
	CD6IDsvA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:60598 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s25aR-00174j-3B;
	Wed, 01 May 2024 02:45:12 -0600
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103047.561802595@linuxfoundation.org>
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <f2ad3eae-dd68-3530-4913-d63eab56463b@w6rz.net>
Date: Wed, 1 May 2024 01:45:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1s25aR-00174j-3B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:60598
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLfNZ+4qG26SNSkrcQFSqENe2mSjntD6pr54ZvntJMT79IOyBo6vctp8BJaE200XYYVo0vPFlY0uRZE5XrMGJWbFDTpNrEKqqFQcZWBCNx379Xb6KOGr
 +AhOjl8tzk+pZY6vE5ZR13R1mSukn5qS1zxTCbJoDZ9wfWQHGgONhp7tXvLRiKbrxR96MHwUQYAAiQ==

On 4/30/24 3:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.90-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


