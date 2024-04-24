Return-Path: <stable+bounces-41335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3638B0435
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 10:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E030C283DBF
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7A3157499;
	Wed, 24 Apr 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="OK2tUl42"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E21581EB
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946989; cv=none; b=jqXiIJmvPkKZyPmSYsbFEB0SJ8y8+8Fnq31AqqHvc2MUwasYDM7qEmj90ykAa37UxmvC/1crcFW35P3NIaie3KKd4WYPCA2LnYmWGP82rNrZCCNKt4jyUSr8oebeR3Llp1ushVtF6fbpZyMqf0yjR3OSd3R0KC/jOeRNPqLDoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946989; c=relaxed/simple;
	bh=6QVLhBAJp84waL6ZUmhf4vEiQDIz+a6xaQzpqeWyOz0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=gU2NiL2HfnDTS47qlNKAIbtT1WHjjiYwJPzIGCKzwDSOmkFeJTdAZ/zn7vVUmXhFw8D5tH/Iv2BQZt9qB+31h4O3c/v/jkmtS/LyZgGVmtHZ2hcHDXuHAmgD77klYAYrL2H3cblJLn4M5vK8Qyu2rJoFzXUAt8dwAAi2whNaBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=OK2tUl42; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id z8JmrROYauh6szXuErVp13; Wed, 24 Apr 2024 08:23:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id zXuCrK4nPo82kzXuDrLMDv; Wed, 24 Apr 2024 08:23:05 +0000
X-Authority-Analysis: v=2.4 cv=WOB5XGsR c=1 sm=1 tr=0 ts=6628c169
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CMKPsDBNFkSOfaRWdswA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TbpKAwI5ZCWHUvqoKmQdNYHV152Vc+5IbI4Iy0iPG/A=; b=OK2tUl42Nd5DJlk2bDu9dyqbVT
	YLL9QYv9eJIwnvYM8KPWYxYTwi5+BCm73nnaL9/35BeSQnudEXgXIxNPXrByRJYcvc3W7HJedyARd
	p3ESN8AW8HAMcxhb9Est69v0v/rNVoRQ+0egbLwHuPPyVqV32qZgYRY5vfD6QzspJDR+Ac0U4N2fw
	5X/u3Z02tnCv+I4Sq+DBCpS9KJGVaCECAnjCQssIsECQlrnwnmHnM25J+pH41+cX2qXggx3LhAEjl
	A6G7LSmSkFC7tnbK1xC8/tMTd5FyGzmDyoFyQPtZ9/Ss5qDxjDwFLLqAIwV7BytQjWgAj1Iv2eYnj
	6z7A0e8g==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:59342 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rzXu9-003a5q-2m;
	Wed, 24 Apr 2024 02:23:01 -0600
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213855.824778126@linuxfoundation.org>
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <462c8967-e599-58f4-c456-6c672d89cd74@w6rz.net>
Date: Wed, 24 Apr 2024 01:22:58 -0700
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
X-Exim-ID: 1rzXu9-003a5q-2m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:59342
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGzxHvQodWSfUhkFMNtcqjDcX2N1t4Znnr1AzBczAXOB8U4jyGpakuOGQAhB/7yMOMKYVkSBTcgrRLFRmp83MNmTBGQ+nYnrA9x1qhS+VzhrsXXWcJss
 LHrx8wvbZ3732Vl+G2zRUAoZ9WaBKVYPb9qqjQfd2Q5ToDwkeAyInbn7ymtyj3LUkHuG9nyoUa/lhw==

On 4/23/24 2:37 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


