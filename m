Return-Path: <stable+bounces-104156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B249F199E
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 00:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34205165FD5
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 23:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E91AC8AE;
	Fri, 13 Dec 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="bUp+Xq4D"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84439192D9D
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131331; cv=none; b=qjLa9c8thJEPS+jKZbT9tHOLYXioS6V2TEeg9eYPIYqRBvGigKQYT09vmEANbcB9CN7J30UsW7U8ubPh24j1iVX86MBu7Zq1HhB1Pyy76Tx4hRfz6bNxvTVXUEbuOrClA7rw16ivMbdEcgIE8AgQqZrNgBKNyUZE+i+F0KWoh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131331; c=relaxed/simple;
	bh=5V2fLkLyNAWyFFefIyLosNOmPZL7CEovGGUnqfNO05Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gax6a8u9WCXfIf/aPKrMlOsEjRl6B41oo//jj9wn3STCMddd+Lwol9kTfzmADfzR1Wmc0++B0MehUTEBqHvAOvbRAqe7oPkrFLEv+SJ0ew1VCLKV481xkRrBoYMBtfCZkdqFdFVqeiV3MD9+t2bMhX/qYX7uS/lVz++hQSMsfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=bUp+Xq4D; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id MDtFtZ8qaumtXMEm1tfMqG; Fri, 13 Dec 2024 23:08:41 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MEm0tZe3efkSoMEm1tUCxc; Fri, 13 Dec 2024 23:08:41 +0000
X-Authority-Analysis: v=2.4 cv=dtLdCUg4 c=1 sm=1 tr=0 ts=675cbe79
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WmhfTsiZKZinPbTraIEa794TxoV+jumWeRlOkIJH+54=; b=bUp+Xq4DOd1CtNynCE5+PDXXf+
	lHBfQJLqwwM5xB+mVckKIt98FFSja6lbAeljehomhq4TSs2vZWV2QDLvvNHAezyennoKyhMHvNoq7
	N8fHA1VyW6H9h9zLZxuUC+DkZdxp8HTV1xw5JWkW3z57Svl6wSZb4h0XcpqWHJsLm9gXpMapt95UT
	ovijYRDqOsWTAic9BIPQfJfPojDLlPbKfN+VI7egWvcKdndJPZalKy9lgJPFPeLV18E/Y1G7umjih
	RyflHW+h/S2No0bLe4iohjBYGEoGZtpzz9g3NX1LAdCUmAyWnmLlrS0KdXCL3zmDiyBcJt2SzNNp7
	IWshZaAw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:54652 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tMElz-002OPN-28;
	Fri, 13 Dec 2024 16:08:39 -0700
Message-ID: <01e7e010-2571-4f01-a6a4-934dfe3218a0@w6rz.net>
Date: Fri, 13 Dec 2024 15:08:36 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241213145925.077514874@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
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
X-Exim-ID: 1tMElz-002OPN-28
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:54652
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLftPU/bJiD5dYreKY40FrrOfhoVvE8fli8MGzJCdWwR10mOPAI0MBJBkFrHJL0x1VA4CFClPfSkNJaisICB4ZkIMCyW7RUWw6uMyr5w5+6utoPg9dWc
 8DlhSN/NRiqOs6hmS49ph76HrqL0kGW+1hcueIPZgv574CzTNwGCrZmnTHQy3fppgOkoeBLkXBtowg==

On 12/13/24 07:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


