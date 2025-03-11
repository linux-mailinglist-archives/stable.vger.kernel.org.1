Return-Path: <stable+bounces-123179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C090FA5BD32
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EF43A7916
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49122B8BC;
	Tue, 11 Mar 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="EAy//yhi"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559EF9CB
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687573; cv=none; b=qY82Ri2qo+FLxU34hq43vdKTItWdVmDs7d3T2qUuOvdhLCEkrxVlW464Gt6HculJBxf4B5wlUuIbMTVOkMMiitr6Jtq5gl0DNdXeAhOGfVEpSfWU5fZDbDS6KATTxxY1EG1P6fzckgP7Y8SfRWj54DKdcaWZTte/S+DKiurCwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687573; c=relaxed/simple;
	bh=rjkpyxd6RWcA9w9OKfTstC4hp2OuOWUSlwYw8CdoWwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecA2eke9xRJBOMG1OuELXdWPqjoEGCCY2WSAkTn4YPPpTMWZCheAopFW71CpYq+Q03MwD4ZWJxVw3nc65qMZ/beQKkK1NOwsHiv29L85fz8FIySsgwah7ZtuIIzi/5vmHiIS39WmaWHnKbA3bgrntj9ndsngnm99yto+bXLfhqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=EAy//yhi; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id rpqfteBEef1UXrwUvt9OiH; Tue, 11 Mar 2025 10:06:05 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rwUutWvaKZozcrwUvtTVT6; Tue, 11 Mar 2025 10:06:05 +0000
X-Authority-Analysis: v=2.4 cv=GvNE+F1C c=1 sm=1 tr=0 ts=67d00b0d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VGeZqF52+y3Rppa+8xZLTmlKkc+wJljUH1xmwaROc6Y=; b=EAy//yhiPgty5l4xUtFNo0yZ4q
	poel9alzEyUTFCmHPWCPk181FHWPZ6NY+mJBafdWLRebXoJX/BzT0oxDOlYHAKlZfp+Si9nKN4NSA
	Z4rtW1J59GaMi/iEzecJD8mna4dEjm88QNQqj9jMZ8uIC6m6vRmGwlpt+m3u35gY/zCxyJBW8dR1N
	ym/Dre2nxIlrRe3JK2muDfYv6YO2qf2EtZplHk7pLxsn56ivUOLZVVXKdLV2LMHdmarNlMaAD25No
	hPRXd6d2qTxDKjSev0AYCkVQjrBMNzEngysAJPtxJtf3KnmXF3a5HMCYho8LMJNOxdbihkfzc1B5q
	hwbkSfWg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57318 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1trwUs-00000001SwB-3ANY;
	Tue, 11 Mar 2025 04:06:02 -0600
Message-ID: <4bad0d2f-e359-438d-9160-b70b610f7ae8@w6rz.net>
Date: Tue, 11 Mar 2025 03:05:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/269] 6.12.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170457.700086763@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
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
X-Exim-ID: 1trwUs-00000001SwB-3ANY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57318
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLaGsT95hg02jCNw0ZF+oo5RpGXNQTK23ceG725eLTKd/5aIR8upGRShd/RAoPga1qNdvr5mFm/da1oQ5uvZk1mQIqiFJ4KibmXejNI5xoPhK3Mq//cH
 BPe9IWaRDXFofDwFThVsAfJV6x4sVoUfVnv/WjJQ0znp1bqt+xPYOwgpKvVJrrZIU5004t1lQRdBkQ==

On 3/10/25 10:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.19 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


