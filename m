Return-Path: <stable+bounces-180518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD6B84A75
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A4E7C062C
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02AC305E09;
	Thu, 18 Sep 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="pOUx7t5p"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48E2D3207
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199623; cv=none; b=Vsly2R2KUJ7di6aMnTO7XVO4PgdOaWurPsbnGxa7JEePqCzNFVUHeNjvThU4U2KpEA8hLgvU5RSBY24gOAJVoo54usye4w0jFgc3UCFetohQkn+m9GIbz5lii66TQFREHJ6yC5kbU2y3E1YhSdMRq1P9KwPxQ8JAlvlaV7SjmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199623; c=relaxed/simple;
	bh=/NwgI4Pz9Gazir1kDPO3ynh+LF2s3swEokSrXPvlyWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFxZCO+B+2QHO6qfjf6a+tCTwT0Fq27fw3dSyUXeTnV+k1FwI/Qtv0C6jV88rv1xgktDWakFDUJDlbIaZ+VOWJAnxJHj8OekzJLGGnu9G0evsSfLdpg22x6dJEJRkxMx2YWyDzYDgnUsNcGLawqZxGxxiN9QnA+HZiTe4ZYqM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=pOUx7t5p; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id z7gZuPOuvaPqLzE2Ju6dW6; Thu, 18 Sep 2025 12:46:55 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id zE2IuB1buktgtzE2IufYbN; Thu, 18 Sep 2025 12:46:54 +0000
X-Authority-Analysis: v=2.4 cv=PbL/hjhd c=1 sm=1 tr=0 ts=68cbff3e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uteLxf5mF2kd1xbYuWv0xsYKkoUJep4E7helE5lAOSs=; b=pOUx7t5pZe9T9aieByYzb4JWFH
	e8khIAOBS1tfyH7M/GHN22sbOqVmHKQZ8E4DPvrsBRmHzQv/6qLHI+OCNBvGjqI7CpJB/VON4QDI6
	sg3g/hrSCGFWhc0w7VjVr9zpU2a8qK8FMT7scdMY2daHXqfC3xgZEhXDnK6DPeAv1lIOUomuAHs4V
	T/tFxgvlYxn4ghbQGK+3GVq2wPg1BIAwYLlm7S4IByJb1G89EtzVXBU3DkA6icmNSPcgJyH5dDUJF
	wDfmUGLZUnm0XuZ3tXAaXr69QNhxCbBTxbi+lArU+JkDEWRb56T3MBSLPqSCJoudwk+Liqcv12afw
	58dDwdPw==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:44014 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uzE2H-00000004B9b-1eTa;
	Thu, 18 Sep 2025 06:46:53 -0600
Message-ID: <26de3e38-6c06-4315-a5a3-15ff16ea5494@w6rz.net>
Date: Thu, 18 Sep 2025 05:46:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123351.839989757@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
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
X-Exim-ID: 1uzE2H-00000004B9b-1eTa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:44014
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAe/jtVHOSTdpR1lKoPUpGCBfnCjpga70V9O3qjMuqOeWSU04DW+0gKEcjPAyqggKsujsKFJd2OqZvpv+ukf5rsMhmWlZt3iKl9TnmSGNp1OuHKE3rqI
 jsSzH5ikXB6MYLfMgpygmN+uGWEHVSRXiguSZRhu+l/SojflWEfMsXH0WMEdc+XwFnynAPgixIjYhA==

On 9/17/25 05:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


