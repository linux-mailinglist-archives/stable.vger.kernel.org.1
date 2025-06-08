Return-Path: <stable+bounces-151873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EBFAD1110
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 07:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44603ABCAC
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 05:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735C1F3BB0;
	Sun,  8 Jun 2025 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="cDk9ImqY"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB11372
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749361842; cv=none; b=KHxLZB+loJIFu6JeXJgF8znp6ogyQ9iBqK11voxRcu1NNlLC72WU14ZIp2zT4OPC6/qD5YskkIorHFgN9QAKkSrIvv+0OXRo7VwL3oS6xSie2OGOAbGMglkchTD6bCemlLEJViBqoss5U6EKD1Or5LKVMpDvuDkn03QWuh/AB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749361842; c=relaxed/simple;
	bh=TlOIMpuuoAyKGk9gjg8G/OAZyZmpaD/ZxYdYhrdhNdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKKrhNzeL1fviFu0sIPZCfpvSOhKqCkOH5Ti4X1P2RV3+fxqApnHZUfiEIpRErnsL7l3TDUlhMcZjZb+1cAY0tBj+5ds7jOmzg0rJtd2sAxEONTX7GWChc1RmzuMWsa2icYuDZ3RA2Ds6ZsjO3L6PCG3ohp4IupwsHNgeO2x/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=cDk9ImqY; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id NufUuneu2WuHKO8vWulCk6; Sun, 08 Jun 2025 05:50:38 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id O8vWuwWljZ6h1O8vWuUufx; Sun, 08 Jun 2025 05:50:38 +0000
X-Authority-Analysis: v=2.4 cv=ergUzZpX c=1 sm=1 tr=0 ts=684524ae
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lUHmgINEyCFmmkEtF4jfi7/biy8jznJWVAGipEhPEvM=; b=cDk9ImqYc2NN9gjE8g0lgZPuxB
	axIpbJ3bye0M/5qZHW+18czKia1gtD53IbqrD6/19nbNoYmnN9z/HSh+ngMFHSEgU3pFUMelZPVqQ
	3HfZzrKrNulDfux/Z7OxzRpdZ8KHE5A9uFGXioY754HYWv+4tnwLEAALfKjJ9TBNQvymwbSYa4Mo2
	lTsqRDndfGKrY3eSQ0kHT2wyenq30NJyoAo+aSP0fodwF3LG+gtyw0eLOtrhyrCaTQd6MdNGC+Cvu
	QeDEXd4U6kEFf4PQ2l0+/r8+hbsSAu5ltrsmjl82ljBqbKJ9HtJOmAyce00Y3h+hm9LdW7c8PUKp4
	amGnhX9g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:50976 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uO8vU-00000003U2C-1YPz;
	Sat, 07 Jun 2025 23:50:36 -0600
Message-ID: <3491ec91-fc3a-49b7-abf7-3f5c8e227d93@w6rz.net>
Date: Sat, 7 Jun 2025 22:50:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/24] 6.12.33-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100717.910797456@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
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
X-Exim-ID: 1uO8vU-00000003U2C-1YPz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:50976
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNuCAd1nwutDd2qXPHkzZqNB+q/m2wqvP9ZtqLcOtLk6TUQqRtSTkklxyWZAo3jlzvzZcjBfIaj0f7mEla0LIQ4j+iEhimVyvLcJA9ZRiOGAS8bahPUK
 7wm7TSCHKkVuYqT1F5BcInn9KLjEqL06ooJn2iKKdKOrwhPYPlfkrsJP5WekYRlKA/5S20+7/Vc98w==

On 6/7/25 03:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.33 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.33-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


