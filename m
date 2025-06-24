Return-Path: <stable+bounces-158337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9C7AE5EFA
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCF218974F3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B98257422;
	Tue, 24 Jun 2025 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="dkthkFLE"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E02571DD
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753280; cv=none; b=OJCvOVBb8VQ2ClHVTdse3mihL3hQr6ku2BRCIJgOooa3vXvcK0CZ4oizI7QeXr63dwHuw2dR794PtPGr29muyWHZR0vLLyVO8wxUUC+nPq1ZtU9Sd2WB8Gf3Hf+KDyT9xNhb4MEC43igw7joNeDa9Xkekwsk7IvVjmGqMz6JRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753280; c=relaxed/simple;
	bh=gsGfpqXNBOFQjO7aQm6wp9ReQC8lFVfAO7bBesxeXo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws0mpRsV9uWByvyeZi/f7z192jP73Dlw6miBU9FboeYujvowQLpCnKLCfHNuqEE1UBZANwN1TB8RsmX7f5c78B8PjQaxH0kY93qZpOEqN34NpWMBTrWK2mFM4yH5g3a4uuRTBW0pv/KyirrpUqxQewhB4j3d5vhTOzLBdwaVkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=dkthkFLE; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id ThiTuVpMTMETlTyu6ugnnn; Tue, 24 Jun 2025 08:21:18 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Tyu5unszH0xjjTyu6u4hUX; Tue, 24 Jun 2025 08:21:18 +0000
X-Authority-Analysis: v=2.4 cv=dPZtm/Zb c=1 sm=1 tr=0 ts=685a5ffe
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
	bh=DpAgQTyGaMxhVpyjbg8VpXO/7DZXxVpMMzkTGRiXc+4=; b=dkthkFLERmt5ivr1emUcHhGzE6
	PM86WmXLAnIpdi4WAQigSrK9QkAXVjJbTGaGu4ifsh4PC30j/2YQ43kLoJIrXTRuawYleMA661B4Q
	os1yEAHJFZ72dYsQP6PvhIczhC+x7ADZG4FVrFSSUqORcYGSbAkhSEqjGP/AImZVFyl5/jjjTxlKl
	Kw7DiO8g1caXCiT1+1mO/vpY6NkhYZju9x9XlRdMliWXsUaQsldwoTZG4RpSRbQuAiQfuKIGgyxgc
	Tm7toRvWAgwt/RhyKozP7yQtxykaPNsA8ab9Q3C8fuydtYvPuXgOQjIfqYP4U0eQ8sqUjBRFUmw5Q
	GYiko1dA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57792 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uTyu3-00000002J7x-0GE5;
	Tue, 24 Jun 2025 02:21:15 -0600
Message-ID: <0cb49e01-0901-4ceb-b352-71230982bb8f@w6rz.net>
Date: Tue, 24 Jun 2025 01:21:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/290] 6.6.95-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130626.910356556@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
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
X-Exim-ID: 1uTyu3-00000002J7x-0GE5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57792
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCNVEboZP0GnDflmWos7VvNfBJRblNoKDlP3YIJbmbDgtneSnJgPlbbW/890qRWOYl/s60M7P/+wzpm57fyLpzOMOn8kV0gowu34QfJDGGbh9Bzz5m2o
 C4Qg/5zYmSPIkQzJMgX5zOzAlXRemSDapJrpKVTHqYPLQf0jsVKd+K8ppO7zeTXgIni0yn80MdmPKg==

On 6/23/25 06:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.95 release.
> There are 290 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Jun 2025 13:05:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.95-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


