Return-Path: <stable+bounces-185670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6608BD9D01
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC8E18A79E3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C221E0BB;
	Tue, 14 Oct 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="hCLfVjke"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37743749C
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449923; cv=none; b=l8rZUyEQjTpAe4hQXOsGJWfolmOJDXR8FgkgQcjVFGOF/M6UvyJ8Iy2vhmUA/8V55pQjANxCkH3ZcLFjhhCc6wVqjhyR1yiwiQ8HKV1XFRrm4nH47CqIDEazNijqJZA7AwOlPRjaymO5HLwtU/gg0lB8rfst+D8/UozlXR6uJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449923; c=relaxed/simple;
	bh=nskP0eqzPM3FOd7xn+E9e/Vv+U70RRfZHhzrNk11I/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ta1e6tq7INAwIaeqH2XWlMksYuBCerdSgjP3xqpoEVK/rbxbFmPDLLBNvp6p6VclYGRo+t+3i0/bbz7O7uwtuZqUInr8fQ5UuCMsqjxYig5K9VxoOR7ygTWCKNCFK8YV9o+eA2dagjzF8FLUheuDBMy1x2VGHyikcqjWJI/Lcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=hCLfVjke; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id 8eVlvWra5KXDJ8fRYvNNly; Tue, 14 Oct 2025 13:52:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 8fRWvPN8Op0Hq8fRWvcOCf; Tue, 14 Oct 2025 13:51:58 +0000
X-Authority-Analysis: v=2.4 cv=H/nbw/Yi c=1 sm=1 tr=0 ts=68ee557f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=7mImUwZGDDb17UAjreoA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cD7Tb49ErmVJbMd2cXxUa/ewmY8h9WSczri/nvNIydo=; b=hCLfVjkeC/B51l4uVyTcIb1rId
	pvtVzkAhKmLb2+tPliNn0oELZgWncrw7dPgqoICWOYDjB85vq8ngqb9kQ4Mev4Uu02MFR2SPQS4m4
	ZzlJ8D4QcJxspyccBc5cUWqRMHzmokJzUI48fscZfcM3Y8rYlJR/loFCTJZH9PL0r/BSN1R6C/5r5
	pIXilyHfKfrIFFQ5oLbCJv91+5vvum+x4TDp4G8JVUrzFRpfORapxVdOduoF5HRSJJVceomIrbxgb
	e0cJxB1HZqTpIMgi3FNolJxlbLZmj5NFjGC9UMTnDJzLlddZLAN5ZJmKhCmgRQ9Qnklo91SpuyhHy
	IAMBLy5g==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:36628 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v8fRV-00000001iHZ-43sO;
	Tue, 14 Oct 2025 07:51:57 -0600
Message-ID: <8ca3a16b-2eef-4e9c-9ff2-f13819829cf6@w6rz.net>
Date: Tue, 14 Oct 2025 06:51:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144326.116493600@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
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
X-Exim-ID: 1v8fRV-00000001iHZ-43sO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:36628
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHhtVp2WqaPtJpsKtkMsQsepS570VthG0FM2fY2ex6MCCbS/J3AUsugmPkH6AZN4fj01c8Yl0p/oVnQ+zrl3M5SssJjcMnwkxM67d827Pbw2pLIDNdOR
 rRKmP+BXELeXpLZsDTnFnkhvsNxNs5tsOfK8GEEsFtp/b/R8WmomtV1MtgPWv07gq0FfSGsiqYZMFw==

On 10/13/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


