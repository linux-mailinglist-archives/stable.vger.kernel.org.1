Return-Path: <stable+bounces-123174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3185AA5BD00
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481593AD87F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B122F395;
	Tue, 11 Mar 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="qynyrUdS"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22F233136
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687149; cv=none; b=U5nPD2YkgX2nwYlA7qFDD6Yny314PAY3Kv8jpSFUmQkhRtx6BQC3oY4pD++BR5PWreWoDT1gZxDiJ8IdRtzSgEFAkjtVuJibju/Eh1L+ftLpHFRA7p4cgzgRO2xDF4QKcf+xasRyGhwzMlw7RLu84QYqnEnTDcJi2KM/QUmhs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687149; c=relaxed/simple;
	bh=L011vDdYdmYjXVONp7IA/Gm904T13YMP/OfTTpLO3rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezUZgSd4AohLpvakSZJAGQgNtTExOo+8eQiSkSoTx8P1uELC7y6r+3+5mwIkf/fZ6jcZWvUXGZQlndSAsdAYRZHxxiKC38fgMFADdyMseTk+FsM1pNk7MgESFjjVBl8XMm06ceFd/lN3iNDSr4kF3FO/iTsbJBqrLxMOU3M15+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=qynyrUdS; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id rgvTtueNyiuzSrwO4thICH; Tue, 11 Mar 2025 09:59:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rwO2tFMJspIRhrwO2tWE9F; Tue, 11 Mar 2025 09:58:58 +0000
X-Authority-Analysis: v=2.4 cv=ONwh3zaB c=1 sm=1 tr=0 ts=67d00963
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
	bh=p6iSWm5Sq2tICbf3W7WG8nFvRBVm0hU0R/EfCXFRGrM=; b=qynyrUdSJSHrdiWh8OhLAZXx27
	BEHXIW42LxIoLcVomHiuZC6XMLcIZDMZ8C26IKXj9kwkqvteU+HWmtWfMBIZWlYLjz3zj0sVfIcUJ
	BtnN0MwtqB6LKPk3+HOhfWW5+TngU0AspGIX6VM2WQm1zw4nUWR8hdeF2cgljbuGoOPGxXkORxUtr
	Uoc1r1HdoBHkgI+uBYbtIPzh5Ws5bPzVJu30Cnks2I/AjUgVw9kZJh+RmaFkXaxqrZgx7lsVISY8M
	yfUOGK6TgldSsGGZIYJvJvWqSSbc9l6DKgwqncI8KwKgml8zCsLKOFJE/KtNGEzHQ5cWz/xoa04Ur
	D8ZwdKzA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:58536 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1trwO0-00000001Q3L-0yhX;
	Tue, 11 Mar 2025 03:58:56 -0600
Message-ID: <769be520-094f-4ff2-9cef-1ba0b5e29454@w6rz.net>
Date: Tue, 11 Mar 2025 02:58:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170447.729440535@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
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
X-Exim-ID: 1trwO0-00000001Q3L-0yhX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:58536
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP8s3aPEsLhNVq29t9ZhJN30++plvdG+JVAbwU1lgqknWdZWBk6osjei/NWHwuthrIe1g1cOrlxmMu7ETXHmV60bh1oP9k6yzeafqKYtkzhi/Y9ThdPZ
 UEjvsZ0iZMFAR078jqHs/riYtCy0NYtEp0tFHw7X2OHTgLj1D5lzLDUv423iJYwL+Y8yCe9CJzroyw==

On 3/10/25 10:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


