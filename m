Return-Path: <stable+bounces-121185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D80A5447A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9598918869D3
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 08:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE6198A34;
	Thu,  6 Mar 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="KbJcnGyy"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634742E3386
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249066; cv=none; b=d/BhQ2VMQdn8o98Ip6S+OaQ9QJFzEdv2b2CLl1jisE9y2/sdOiGXPuKlEmir3UDX9INaF/4muNF8pE+QTxsQLO//Jk0kkuVufrk7O4PXbAANBARX4UYBP3kJZNVMLim8IoJ9FmvZXcy1mxDP6Gz1NfXqw9Z87b453vwBqpV6COk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249066; c=relaxed/simple;
	bh=VLaUAwNP1edLMHeSaERvqh7lMUi9z526Kv+r15MuJyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESqUWhfPYP0MArNeAVuh1SYFjZ92eqdeXNOdV9xR77GprTRUTyhXoI+bDoSlcA5Z9u4P1tKwyyPoXzx6DzXg2WSo1wQzC/tIkAxrSDuueZ/LC0/jS5k6rEx+JfzofLfe5kpXjCyCRrJLuQX3PRw2vDnnl3fjRiCRyXrPvNJUEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=KbJcnGyy; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id pwVntdeFXAfjwq6QDtjHbe; Thu, 06 Mar 2025 08:17:37 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id q6QBtIJMvb7c4q6QCt7wde; Thu, 06 Mar 2025 08:17:36 +0000
X-Authority-Analysis: v=2.4 cv=KvSG2nWN c=1 sm=1 tr=0 ts=67c95a20
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
	bh=c1pE88z21ZUCUgFnw62EhCwTd5GOdYeT0Cwo3CqLRGg=; b=KbJcnGyysBv8wMQK/KdZBvxQ1A
	cF2hHk6+3SvJVYsWNFnmW3kPFZ4QKfI0KfuLV+LVhzdnrj+n7LOq9oN+QkKDZLasgdN7+EgGCArtr
	wISBjIzzbslg2ebUCsbWS9P6iewpswC4YMWNiTMVx/SyRZLgdsH5E+OjEJ6nuQ7IrWS1oxWIoZ/4H
	qU9DY9Z63bBkjDNCScuDOJmq3mIWuLENB3SDPuBzaIRgrqiYXr6ACcmM7Nge+hYodKhzx+SrI4mXm
	6CoYfeOzYFnvkxviiliZTfKAKNlffjmBciLuqND9eGcef1YRZa+QXRchCGP/5JTGjVJBImgVH+nyE
	V0bz932A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40648 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1tq6QA-00000003281-1JRx;
	Thu, 06 Mar 2025 01:17:34 -0700
Message-ID: <e6a2951c-3f32-45a1-aaa5-9e7adafa8f26@w6rz.net>
Date: Thu, 6 Mar 2025 00:17:31 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/142] 6.6.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250305174500.327985489@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
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
X-Exim-ID: 1tq6QA-00000003281-1JRx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:40648
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBGgylvVs77+o3H7D2wOwvvUbnkN0JSqYJO1Zv05VsRHCPC9zUCuWkOD6ImEpWI6RRA3NaLPxcmmIYH+Opi284GSrvL1vzEcgXZnISUX6+Ndi+fCn0U4
 UcumNBtBlG5Prah4O3FlywFqL9oQ0S2zHic+cWQnaPmmQPxdqrPwVO1VdJrklUIqoMx/j1N28MItuw==

On 3/5/25 09:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


