Return-Path: <stable+bounces-83285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E844997965
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 01:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26422B2395E
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158F1E47AB;
	Wed,  9 Oct 2024 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wmPbI0HK"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B631E3785
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518129; cv=none; b=R8h4sBENO4urkHoiV2Im1xeZqgmY3glJK0a068iiGvBYZHHXKkCXAzFfR/yvfTJPCjcAX3m4apeP5/01qBStquZYMNJQaH/gHrXbf4W2EmvLgWOKyzoKm38It1l77UIYS9bPSdP38EAOj/NouJYXBa9y7wtSdz8TR3qPJPR7D5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518129; c=relaxed/simple;
	bh=qHOExL+m94eWa2cgVA8y4g+ufofYJ5Zq8B3r5x5ZKOo=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=bGGu9mjUm5l2njy545o2lsVglFq4AlfJZlHDlwmd5LaWSx5lf9egKAphffDx/SVPpl+jfV6/rk29yeerKJYvrP7aDbcW7E6nA9jr9uWJOAUh6O210tf014ZMjDT8uUZwUt/BehIbGazzO1D6581OaDadyb1Bby26tVQdLTuoINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wmPbI0HK; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id yAaasRQetqvuoygWbsmpUj; Wed, 09 Oct 2024 23:55:25 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ygWZsay07827nygWass3Xi; Wed, 09 Oct 2024 23:55:24 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=670717ec
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qz3nJ7VPPRrQ3fo9WI3Ql+6KHu0dzpOhd13Cpiv2E6Y=; b=wmPbI0HKMsBgv50f3/OIdGK500
	h4aiw1EkGQQPUuubzpnRG43qsylHFpSDnxREXGHUnid97BKjquBrt61JutCoY1mowoLLY1GMW7sbb
	ERdw/OQtds5+2c7QnOPA0OvzhpA7qW69FtFr2VgULxoG+v4x/97sh7V/S5iXaa95KNYUcshXHUTKH
	/eakGIgpbFdyibYIRlnaDPUGfBP7P4Uo23+3esj+I0AT4uy94ttUe59F0JbNxnAz2PdgURtn2H0V5
	uliVo1zXWCnyHxV4L0wDSKczyOo8aNnHOLsR2TLVa82lfewDWqZW8dGPZSlG09wZRqbQq1Vpvj7DZ
	SNkzNsOA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:46218 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sygWX-002jTP-1q;
	Wed, 09 Oct 2024 17:55:21 -0600
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241008115702.214071228@linuxfoundation.org>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <20cc7325-c036-fddd-0324-7b5244a43e63@w6rz.net>
Date: Wed, 9 Oct 2024 16:55:19 -0700
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
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sygWX-002jTP-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:46218
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHt6/dQAdQYU2PZ+FZyesyJ4Ub5i1/tYthvaO9kL3EBBCnabU+OYGNla3trSny/mg+yChgjFdE6pIxCl8ekFV5wzIQh+Ts0FJM0oFylqkATwKje5VOiW
 DJEOL/V8mH96mrcqHWQx3hEo2SZJn9dqnFurqLZ+oNpsDp05vzCrrqqnhCYapoxyoRVKIIVvIVQmxg==

On 10/8/24 5:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


