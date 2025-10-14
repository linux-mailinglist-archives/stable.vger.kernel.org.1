Return-Path: <stable+bounces-185632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395EBD8CB4
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBED83E73A4
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328842F8BF1;
	Tue, 14 Oct 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="AVpJFSV9"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E12D24A6
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438601; cv=none; b=ilz2/kbJ+QNXHPTAWw63hZXcR2LHBYmAnjSvtE4AyaYRZzMjezG/L30LtdOjS8OQtLaaJVhJUqZz325gxPM+HJ28xjANEG4oIJbIrIW+6KxIPTgVBolCPw+iJijTmtcekPtOL0LqTq4D14HsfsLDE7+CPXxfyPiO+G54x8H3f/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438601; c=relaxed/simple;
	bh=X4ArcTDo3QAYeumeDhzl72JVM2zKvNb2aGAWhmdQPEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVx95YK8M5Vdgq0qjiXZuVRec6WOKEvNFJPiIMo9DHjN15LXLsbEXzgwtR3EUh/xD//Wkz+gU+0wx0Fobx0hoK0aVPQ+TQV7YAEbjhs5UvdeM+dvwWh0inCPumJoNGdnpPp1EWHrO2XNc8ksGoAje3xM1TbiiW9OlqRfRz1xRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=AVpJFSV9; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id 8ZWzv6MllSkcf8cUqvwBU8; Tue, 14 Oct 2025 10:43:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 8cUnvbmBP0HUD8cUnvoG9e; Tue, 14 Oct 2025 10:43:10 +0000
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=68ee293f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=P_cPeGO1By8CqGh9tkgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mzvb5/3ibAocfTL9NzSwx16avhcPrus7YfJ+qL05wiA=; b=AVpJFSV925Lnx3RjzODQ6OXeb9
	za53Uz/bRwYHSV0itT+BxlknY04zF9iLJGw4nw14NTj+2wcHeM2QLyYHoi1eoBCSyY7o5rS3Ly8Uv
	ZSKhAJYyB8T2lM4TUl18xfYZymdWAONF3t4P+NLNxOK4k7BEGMC2QSEqMKcW8PVOfr/57qQ6dmhtm
	eYdtPLZvQbpbZMbRMMwHGoKVwqrpv147MaK0Ko6KcIMELyXt+Fhu2QPK70e7TmRY7O0ehy+yTI2f2
	aOAU4hCF2pjNZlqMsmfQ0s8eet8Kve3TGdrJJwOleUIyiRiXV2Ng6nevFymmf9d/441o4z5awmLye
	25i6St3A==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:58134 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v8cUn-00000000WN7-0IXg;
	Tue, 14 Oct 2025 04:43:08 -0600
Message-ID: <c779f34f-e2c3-4b26-ba7e-cf8d5479689e@w6rz.net>
Date: Tue, 14 Oct 2025 03:43:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144411.274874080@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
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
X-Exim-ID: 1v8cUn-00000000WN7-0IXg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:58134
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAxbXhQMk4CvkDSQztDKllKH3N0V1hpqd4ZRnYX2yWUbcWKo/V+rGJJJm1cLRrq82pg3jQvEnmEZ1i9zJYLPEkNSGad6Zu/SbpPyD+dD2K0DwE7udYLq
 JCw3X5iQbXNYfWYb9h2gCppwYJbtPTR4wbIyfrfPDk0oJuNtGHpHkWO06Zc/HyTE6HTAx+xvXOE3Lg==

On 10/13/25 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


