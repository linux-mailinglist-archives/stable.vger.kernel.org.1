Return-Path: <stable+bounces-61348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF86893BC0B
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 07:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6041F241D3
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D51C6A3;
	Thu, 25 Jul 2024 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DeKZoMQf"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A223D0
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721885482; cv=none; b=kgk0Zq1XPcjBFaR49uCUv2bJLgnb2JY2ozELc9gR6x6de3uNQGc0PS+nPhPrCqBwu3MysWRlGFDwVvIjnj5Kof8SP2dBS+/fPpNdRIqOD8b9OqqrbnlAMy5gb5ZaNS9fj6lF+y3chVhtY1SjWxVw+O3J9auWStW6ARke6AYAxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721885482; c=relaxed/simple;
	bh=uZXbG36Q2EF7GySwh4nfozTd1dHlUpbJih4rSUWGGBM=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=sIgydGdxp2oiYwacC82UHmaTd4xKOMiYO1Z1jWOCgYgxCsPpBCFVT0ADwGEVGWQr2ruHyN+ubkDhQcX/GkF2znFAJd/ZLbZojkwqMBgEAckAuEZkol+tCamUUrEReg0zIjmhilS6btxqEfEavTUB5S8g2JjgTTMdRBI7mhSRlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=DeKZoMQf; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id Wln8smIouvH7lWr4LsOwdg; Thu, 25 Jul 2024 05:31:13 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Wr4KsfrKWks1PWr4LsurRB; Thu, 25 Jul 2024 05:31:13 +0000
X-Authority-Analysis: v=2.4 cv=Ud+aS7SN c=1 sm=1 tr=0 ts=66a1e321
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=CTd7gvyGw4ZjSuE7xIAA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NmLFwogGxk8T+/BTvVYv38MvO9AQWSFau4dqyGLbskk=; b=DeKZoMQffW9xoglVHlYzZ4n0l4
	XMHH1T4NQT8GAUNxDNNQjn95njCbfAWVBq3C1YcKJr0dzuEoa02oewtO59Qa1kdX0nip5oKpezpRD
	h48pa1XrTMu0UIyPuTnjKcxax+59XizxURlKLDlSqiO+KsocaBYwelg6AF6Tmwbib3W+ths1ibWeX
	D+CCq5ZVo6YOT1FujbVRSgoeJGx/6DxtzOJVRomOWKtlnlLtPDQh9P/xNouw7E1iodnWI0hs1mZh3
	6hp5lteYyGG9KPyKg1Um5nawGlmfV6mhU1mlluH3RCUBZvz3FC1vGmV/z9Hopje+u0LtEZtSDd7C2
	kUniy5CA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59076 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sWr4G-0031Cc-1l;
	Wed, 24 Jul 2024 23:31:08 -0600
Subject: Re: [PATCH 6.1 000/105] 6.1.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180402.490567226@linuxfoundation.org>
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <304aa6ca-71c6-4f72-26b7-72fcea3c6e3e@w6rz.net>
Date: Wed, 24 Jul 2024 22:31:01 -0700
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
X-Exim-ID: 1sWr4G-0031Cc-1l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:59076
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMDvpaNog0ikKO+FWgESX8cLpiWE7yw4mbrf9kuEuUqng/KgtsJl0DgN7rfUeUDZEhur/Khb8kM5vTXUTQ3EgGy/xCXWhbWYwvMgKpY7juFVp4/8iDUr
 6y6YgKF5KOZ4L/mXHoMEGrdQ5lHX0Jvb+WVgJFgq5syczxL2xCv0W8Jh0tzNQRNE3ZMPAlUPEXjKlQ==

On 7/23/24 11:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.101 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 18:03:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.101-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz@net>


