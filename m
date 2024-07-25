Return-Path: <stable+bounces-61347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5725793BC05
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 07:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B1728622A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 05:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E101BF50;
	Thu, 25 Jul 2024 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="XJzqeHTh"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A2125B9
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721885096; cv=none; b=cCDHyNN2RksLtXcZ94Bp01DED6NaTT1Y8HVQtomobhlLuC7wTAj9wjXO5dnAiSN/BMdOyDNm0fo7Z2LhxBfsjS5JnxV10UGHngUReNfLnu2YVLT/Vy8fB+56cbVqGTB+NGSNZPyh/xwXDaD5hS3bAmiHpRpTLKIR1vQYsrhmozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721885096; c=relaxed/simple;
	bh=SaP/1IThYvVIpLTE+xAwIb7qDzWXVdgDiFMmd8FTv+I=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=T05eYsCOcoLJRSeSMR//O/OIks1bmnxncGyg5qIFDk+4+UwGID9gEJaRsHpdz3scnIAHmCH5edR0vxBsVn3tIt2LY4JWgkcPNXuuHJr7lLu2NgNtjMkgbz4MxxNIfjtVHv64XRlVX/QkdQOW76D/mKd2k+WznSO62kOZjSO8ReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=XJzqeHTh; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id WqaBsFHDHnNFGWqy7sIAZG; Thu, 25 Jul 2024 05:24:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Wqy6ssttbpG2AWqy6sZU8o; Thu, 25 Jul 2024 05:24:47 +0000
X-Authority-Analysis: v=2.4 cv=E6rLp7dl c=1 sm=1 tr=0 ts=66a1e19f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=Xg0jV_bQd1NVBgWXQVwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A+EjfyCsY7SonHbP5yis2Qh5AHJX7e9Q01O05zY+IAY=; b=XJzqeHTh4hc6ryV/jm+sR6nb3r
	u+i2cnQIp9mQpCC9JNLDhyv0C4ZPgODByXtfzS2BCUgb08hh181SIdWb9bfvfD8oU2lll7Iyod1h3
	Ho2ziBXY2XeNB/KWyRNdtjR6Fm7WvzVznNJL0TkibKIoL8F8HM0QrlKTroNNpNX3+DAm0yY8bYI7C
	86ydCZzpSjE+tJRLmlS6KPXbGu5Kg3gxjlgxC6CN6KfQoHKHI0PoRZuXI4SOsSyc9JX43/1Xo0wji
	vIMO7GQqxfMNO2UzyX0X+97v057MQqczSbhsA8Uq5qNS4JUo6+KB7nlxTjISFZwK4CB+h/P1TfC2N
	KbI0evCw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59068 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sWqy1-002xs2-31;
	Wed, 24 Jul 2024 23:24:42 -0600
Subject: Re: [PATCH 6.6 000/129] 6.6.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180404.759900207@linuxfoundation.org>
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <32a8f234-9703-49d3-43a1-85ebe988c6cc@w6rz.net>
Date: Wed, 24 Jul 2024 22:24:35 -0700
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
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sWqy1-002xs2-31
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:59068
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMHb3i1RGH8Cq1fQhuW9kiXTITWWZpzkj3n7ruvh/WlFl+SqLm1lPyp2y/UhSgqnX9qNptdDGejEGX08ZdTgLgMrui6PwP/TWGU+eqRzIQ5wIkO08O4f
 T/ed7Xafw+Zrhzdu/5AkigATOZ4tQoLHZ/KubDkWPhwyL1TgyaswPeVGJsADqeRbF6s5DPpHHdxUFw==

On 7/23/24 11:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.42 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 18:03:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.42-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


