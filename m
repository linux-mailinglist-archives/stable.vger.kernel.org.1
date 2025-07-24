Return-Path: <stable+bounces-164550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ACCB0FF34
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 05:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4311C4E1E23
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F61E3DF8;
	Thu, 24 Jul 2025 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="kPDFyVU6"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232E1DF24F
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328454; cv=none; b=CZwB45cbJir0A3kPqgmiUUKJvUEcoVMC714WnqAEeiM0pQCu8u2XnkeDAckG/1rLtpxXJtQsLMFJruOHdXIyBo7g2vz8HohRMIV/jgCE9TIz3wtBD5AJK8Rbj0Qka3mqXn73aKZR2QEfNjvtsM+c5hI1dAM4DOEyAQyy0+kCvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328454; c=relaxed/simple;
	bh=tBL49NCi6pedUcyfxKm3vFEw4AhM9zQpt4Zb13nuG3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ch9/DT+1HdQ2PEC4tCcxgd62wqiDBMtw1bm744EpIic6cM3Ao4woZGg527XDWsmpcaNq5nO1rLCrk9mRWVSWrHIc4aLMai4JGSghg7tqxzKh3BZW0gwunYphg0R415gJ9D0fPLnKQWwH0wmvJzp4VECgcoGOAqL4xI51izXDE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=kPDFyVU6; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id ekzDuVWjif1UXempAuL4lE; Thu, 24 Jul 2025 03:40:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id emp9uio13UJ5Yemp9uG79v; Thu, 24 Jul 2025 03:40:52 +0000
X-Authority-Analysis: v=2.4 cv=MMlmmtZl c=1 sm=1 tr=0 ts=6881ab44
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CIo_2QJ3nJB9J6BkDI8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hUmTki4whztw3NSBDJLDdzqDX8YPohUnTlDCGilssYM=; b=kPDFyVU6zQpS3JPJHKOgHKU00x
	+dcGEd80QOXnbqTX4s7ySNQZCLcqFc+Ay7bk8RZg/2TJVauoE20YC2DcaWSEoqU0cx1eUkh1t99go
	HwB6serCvc8r1/c8Potc1h1LhS8+LrT5c0k+GTdYXb8Lr79AUxdWZhsL/GKEU1TsRwM4BroUJeJ+B
	zGcU4fcCgIF746uTPpeweyrgwY5OgH8BCGlsN5bXgBswHvPU3W+DdewyOjRl8AgszFumDvNNwnBM1
	QGo8GcmJXR+xBMMPM1s4tdaEOS/sw7brli+Rh8spajepdxRQrCAzhsY3QknEhX3gW8Ne+Md6mBUdZ
	EJIKkibg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59522 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uemp8-0000000091U-2bTo;
	Wed, 23 Jul 2025 21:40:50 -0600
Message-ID: <de572dd8-61e6-4392-9ff0-e572de28499f@w6rz.net>
Date: Wed, 23 Jul 2025 20:40:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134340.596340262@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
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
X-Exim-ID: 1uemp8-0000000091U-2bTo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59522
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGPVRpYuqJZQxvLYKtqrheGi67mVpa5DFbBFsPMLbG5EA+teMNjy52R3r/F4M4TLCDauPZaNqJzpwnXl+eoRAGbuykGoJKiH9abO+rID9Am8vbDTtD8E
 Ea+Ng5MkG1IdA8JdydleO4f2imdfk7S3l4TmKli3RRS1MKcHK+Abc+rRQKi6eAZ6ESWXsNz4vw2Nbg==

On 7/22/25 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.40 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


