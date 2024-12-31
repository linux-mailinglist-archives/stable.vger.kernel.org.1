Return-Path: <stable+bounces-106625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F49FF220
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 23:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA5A18828C2
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D011B4259;
	Tue, 31 Dec 2024 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="roM162Cb"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9651B423D
	for <stable@vger.kernel.org>; Tue, 31 Dec 2024 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735685658; cv=none; b=VJwJyhPmfPHwy1QrjOrJQ2ppaCfsAEV9qDNeJ1B5Gmwg1ptGpZYPVC4M0NX2DpOLNxaTvu4ITyjgJNdqlf1GBahHH25exPzu34fVdsd7ZB9G1O/iZmRoKaqy2ulSXgQ/gVDmIsq++NGvqBa0adyPvUWrIVDBK0OdYrFwZn31OPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735685658; c=relaxed/simple;
	bh=qh0uWfAZmdCwtL+Buo0NDREh8Dq7YSWnigZp8nrPzq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9/2oM6DcbKhmssPoFnbI5Cxlu+ppVinRWbLx3qWmmWxe6c8r8AqyixuFGdaAeAeG9qi6+GMzKlzcd/Fo2bSKw1RDnGtvJm7lqQ+Yl4W/TXeIIEUB05AAD8XzzRu5MmKxSBUkKtjE0ztG2nHQ8bZCpM7uNBkUtNfx0yRUk3Zxvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=roM162Cb; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id SjajtcxzzoboFSl7qtkneL; Tue, 31 Dec 2024 22:54:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Sl7ptnfdRaFTVSl7qtTEpq; Tue, 31 Dec 2024 22:54:10 +0000
X-Authority-Analysis: v=2.4 cv=POkJ++qC c=1 sm=1 tr=0 ts=67747612
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=hdbwlJg4FSus6MSG9S8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+ANNc3HRX8Eunl3S+ASLCO9FeaLbEq+eK89fwl15kEs=; b=roM162CbuVcl4hJgW7DB8VarAt
	hRTo9LYlmNnTNayi3Rm0RbXtZTlr1jIXrKyfwbcnGBPVBDZMJKeLLoMFQ7JkWF4XE35Jcvnfmrlrj
	W5Ns/KDzTeT46JapXVh2pUWMJL2bJjzfVTvm6xg12QPHMdJkZ+RVlOPMgrytbD74LpmsaJJ9r7JoQ
	uZuoCchisenSBucL7hjmYprmkPQqBLuCfh/1/ChBx8/xnzb32LChSJTM3Qpf4bE+H5nVV0fbWbkL8
	rNZJhUyjQlhR5v3W2+4pa64yaeI3lQ5S9lEjE166v5W70NoFXR+ri/elciztzbmcvCCKdmxnulNPb
	n/nvLYPA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59568 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tSl7o-002jjW-35;
	Tue, 31 Dec 2024 15:54:08 -0700
Message-ID: <36159691-4c5e-4c93-9c00-07ca6552924b@w6rz.net>
Date: Tue, 31 Dec 2024 14:54:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/86] 6.6.69-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241230154211.711515682@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
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
X-Exim-ID: 1tSl7o-002jjW-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:59568
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI69sMRQPyncTVqxwwbSv2rlxPLTycAWckwScVJDm1gx2PfmkGGZpLXnKK+AyfbK3BlhLl2XGpjy/+YqjCjYE1+9Znc0tlOyPu5rYFCsah3wHG69Uv0c
 tqqGe/GHs4ahPM7BNZvkpDQkqad6wYWcRUWvM7cqh6jBZRvnzV3pZ92jYhkn+gY+9gl4zuf3itQWhw==

On 12/30/24 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.69 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.69-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


