Return-Path: <stable+bounces-197567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87EFC913F1
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168973AFBA4
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171B2E7F0B;
	Fri, 28 Nov 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="sLiBLhNA"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAF2E7161
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319072; cv=none; b=IuUr9orpMwxf13s4s7F9qzc3JrjdMWvWfzuQefVpDu9Lkm8bFMS2P6ARaxjnLDQCq3aSJe0c2sP6EwQNLtyga+e9ASsTrVM/7KkzWB10kO+Q2BFKWLomNDvzP3VdWZz2F6DbLgXBPqpeHIfDkgsQ03z2TSdJy68qVE4Q4+lKqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319072; c=relaxed/simple;
	bh=y6NfYpMic7Ak+WQ+gvAW73Cpsl/TwpW+y/4Su4/ysGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgKF61rLwkNf9K5C6UGGHCGhRRRlBBUh1dDHRn4HZqtOdnj8yQ4jQWXk0JeiIuWykpP1/imlWkcww94s5uGYFl4RO/brSfG+m7YAVUyizPj0mUVF//fLQSWHwjxcb4PV/lyOA2DqjbPD48Gi+px5pU9/PexeQ9TT8r6lMl+UaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=sLiBLhNA; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id OMWFvdD6VKXDJOtzAvmFXs; Fri, 28 Nov 2025 08:37:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Otz9vG90fK8vzOtzAv2Shf; Fri, 28 Nov 2025 08:37:48 +0000
X-Authority-Analysis: v=2.4 cv=cJDgskeN c=1 sm=1 tr=0 ts=69295f5c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=-vIR4xfiFfPHUSV9ibMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TKHRV0EVEMguRRMMhcSeRIOEYGeQkNP/IPOQPknlUDk=; b=sLiBLhNAKpLCsf6rGF5LeVM2tl
	QuzEjd1Y3isl8Xu1n6rys9UY0Zi1T3LTQVR5PfAV3Thgbci5PNNqQxtKLd79fy3im/1gHZFlUqWgq
	NBtu6bJPBdwrD/HW2tMuM6BwRSiCtvJYWGZnc6tuwxjJWVR1dSNgioc+foMgBT7HfLnIvudcEYAgH
	Md6TfebYSaMoOAqFWXnRE+Zo+JZ1ZZRMVY64ulFmCV/EQOGlyAeAQ+4OPDBJWoq5QwxTLaMBNeKsf
	1Wedb/KmOH5JbHsanI9UCiDPSCW5e8VsqWUqO34kgjJn9QzHGMFtkXgx6s/qDomTkCl1wzrMibO5l
	BZC8l1Rw==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:41224 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vOtz9-00000001iZq-2gsQ;
	Fri, 28 Nov 2025 01:37:47 -0700
Message-ID: <5b429361-1bb9-4830-aa82-f9e6a72eaa25@w6rz.net>
Date: Fri, 28 Nov 2025 00:37:45 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/113] 6.12.60-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Sebastian Ene <sebastianene@google.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>
References: <20251127150346.125775439@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251127150346.125775439@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1vOtz9-00000001iZq-2gsQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:41224
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHOzDksB+MfIE5xriGkyw4V0Zlvv95UmtOmi50yHFa8d8Zwrv5IJ3CMA5SiJPUJ/aY/ltExvjRJNHYoqemPsuA9A2xy/PpgGTHbQPmcsX3DNitnUO0lg
 9MO/CsssUzIm4qXhytdl7uWjNjp47e1thnSF3QCQXW5dXjvDr7JUGECn7fGRcEbucDFSSYIIF380Cg==

On 11/27/25 07:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.60 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Nov 2025 15:03:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.60-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


