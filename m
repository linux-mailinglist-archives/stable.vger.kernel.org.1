Return-Path: <stable+bounces-200752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DBCB41B3
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 22:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79CB4304F654
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987732C933;
	Wed, 10 Dec 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Uj+/+hTO"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B932BF54
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403732; cv=none; b=qyQLcwYsLthRRVmUxIyuY1eVtBMfnm8Xr4xfhRLsJYvJG5Qi8ml62uQ/aR+VLi1abLCM7jjdl/z54AAGwfaR4C64pSg8xcPjFlnFrr03kQNmDljW6V9H/3hDKQUXqFOi2u8uiW6EpVHuA7WKjGrg34YZO7fC6R0t9oWMhrRLnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403732; c=relaxed/simple;
	bh=OyjYD1KUSuS//s9mXc2B84Fc6z7wtLHxLAzZb2KaUmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5naCPjvbzV4eGYRWMKY0JkRHIAygaRyZ6a5FSX67cBr+1VN5H+qmER6MqFuO5Yr7ykv8z3O6sQnh4EaG2lQJbU3qF4702HWw4XewzaTMRxZlqiSiioBtThTnYYuCbfsxKTxNjr8ufZGTsMeahyozRmUD24gsbFPLL0KkP7c8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Uj+/+hTO; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id TRATvvrxAv724TS9YvhsvY; Wed, 10 Dec 2025 21:55:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id TS9YvBeiHjAxuTS9Yvhulu; Wed, 10 Dec 2025 21:55:20 +0000
X-Authority-Analysis: v=2.4 cv=EoDSrTcA c=1 sm=1 tr=0 ts=6939ec48
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mUbO/3P2kbi8AcWx8sH6le2Cn0WNsR1Lm57F9fb4+Yo=; b=Uj+/+hTOWqIypH5Ng9jb7n3khj
	1dmWNuhNy9R7SukTdqNzSn3cOHkeb8dChJ5RIPx6D4ghSXKzv8qSzMbzWCnsszIeiLG14V9nB2agT
	n87zf1Nb+/JPvvEphhwic8KbWSaVh+BfLE+6VkDUKTe2w2ULLnG67TgZfFx6T33K7wSpwDHvSKvq3
	yOq95vk02+EJSboEHBlio+jhyLB9Mu9UjQTapBDvMmSwQfq/nheGQo2vicRlnLLmau2wHNtUcVn1o
	REQuBuqgU/ewTsJmnHrwNH53j9bfKshE0uYCMVXg9f9KBGT7q2EhhCI6kRsupHDhkMinZ9Yaom8PS
	bycDVQYA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:58238 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vTS9D-00000000urX-2Kkc;
	Wed, 10 Dec 2025 14:54:59 -0700
Message-ID: <c4dd1d48-1ac7-42ce-ac92-eaddfd24c7fa@w6rz.net>
Date: Wed, 10 Dec 2025 13:54:34 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/29] 6.18.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251210072944.363788552@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251210072944.363788552@linuxfoundation.org>
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
X-Exim-ID: 1vTS9D-00000000urX-2Kkc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:58238
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNEJ79ytTS2yFgo47e9ObUKtG41FwehjmnzzSsXZIyMiJ5peZf/HklwOhOCuYam2mCBi4fpF4rv+zeZzhave4UdzWuQJ3UsyfPBqxW4mTe2Cf+mQifez
 6JaSjabXM2DUgvMf1baVgCk/iWVy9rUtbEzvsAXTY4sYOXpJjJZr0IZwuQQl3MZPX8M8JOkyUShlAw==

On 12/9/25 23:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.1 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


