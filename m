Return-Path: <stable+bounces-182890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF30BAF0BC
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 04:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC2D16165B
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 02:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAAF156F45;
	Wed,  1 Oct 2025 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ryg8qD7T"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926922425E
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287527; cv=none; b=iXZVQSoCbCa1Zm89+GmsZNwxQWHViCT2kXqtatMSJBfBmk7J9XCLImzbPw1YB9K9RTLLhcBGzo0ih/wvuKDLdzK39y3IR+S0Smf44iUW1butlr1E8TxYHyIUJDmDcnBH+itzWwaWCixtrxF3v/FT3NvpwhoeqonhCrKicuIqiuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287527; c=relaxed/simple;
	bh=GtczccIzz5O7Z16gKNcv1d0B7uzOoCg7X8Xa0WzZdAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/RlZKPoJt+lLE4ljO1zrO8Z/7ygvHsoAG8CJKy+5dnPvRRSgEUvu7YkpGsv+OggtIzG1WG2GhtD5Bk+Bd3MQrnfZSZ4IDQWhtAIcf6zsCXEaLE2OlMOcgyBsRShBLWBXbtM+by0H8xmsPK1/zzmHPpvuA7lC24cAgj4PJPEvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ryg8qD7T; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id 3cIlv7kwmKXDJ3n1hvXzYv; Wed, 01 Oct 2025 02:57:09 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 3n1gvgcaoMem53n1gvTrOA; Wed, 01 Oct 2025 02:57:09 +0000
X-Authority-Analysis: v=2.4 cv=bZtrUPPB c=1 sm=1 tr=0 ts=68dc9885
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=p6xn7wKALUHmEImb5F8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LC4TixobF04pYEoU68Fuq0uTJ86xlzmVuhaZY5JWCoA=; b=ryg8qD7TkVIAawpqrSAk373Sh3
	EGTeWNpt0SxSXcY5LCNE3nV5MBKODS+UYF7hw8OgNiwazT4ChW1Xb7l0j1R0LtHMObPC1oh+esPHq
	V/eksqdatVSQCMsjpOdH+Hx01DcmC7H/uY4GfPqTC6dwHR3i8p1LKrm6oleg3ENKsEXA1RclyDiN5
	aDNNmZpMAKhU+Rky8c/eIEahvu3sA+z+fvSih5r28KPeXPLtKeiIjyriY0FGbxzbUSG8/65cPFL/i
	ncR9RWTl96eek2vPUUNQIPCz0IrGwS6TPo0C+7aN1OIsS38cnEC/J4jNYKbtvLuultwKWRtkRu+j0
	cb1QOaZQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:34780 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v3n1f-00000000ZJr-3gt0;
	Tue, 30 Sep 2025 20:57:07 -0600
Message-ID: <fa16c90a-ab74-4848-bacf-c0549bdbe227@w6rz.net>
Date: Tue, 30 Sep 2025 19:57:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/91] 6.6.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.118938523@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
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
X-Exim-ID: 1v3n1f-00000000ZJr-3gt0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:34780
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIbZ6teRwHbv3OW5INwq17JXIhomcistWV0edkmNYCzzpIUMBP7WOPF625ZBNz9SJeD62W6Av084YupNLwJ3jiiRsBMdBoiwWJbAkPmzME8DklmNSbKB
 bfXReyObvp7HUlo2k96w8R3RvOaqJMEFRZvndGND7WcOYd/s/aoetihvoCzoNfjFOWFtaGg7f5V6ZA==

On 9/30/25 07:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.109 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


