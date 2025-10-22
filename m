Return-Path: <stable+bounces-188969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99975BFB6DC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 12:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D5818C5847
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D3C3254A4;
	Wed, 22 Oct 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="V0JRybgo"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7B3254B8
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129407; cv=none; b=NUH0fwhr/WRgPd9Pn+b+XfkuRa+kQQlmC4aEWNbj5g3hOz5aJCZt8Zroz/rvkMVeW9EJeZqJ5WAzZea2XiT0VnP7e/KWybCYxXIJ5M4i6swo2Q75Cby1QHp2Q2QDm3YvRzqllmX61nH0Edi0sSChZejtFSGnhlMi1PnYfI+/9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129407; c=relaxed/simple;
	bh=2TaZ97NyCXK4dJbRqlEcI/nEmLeUSXLGubsnvo9iAQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxYNTsb+3vb6P8R3W670MkxMOmQPpNJi4tsJ6rA2FqGXOIRM6QOKurQJ8hineQJkym7UCX9B/P5AMZVEQsjn6zFiWvHjNGEhfs2PNcAtuJCVYECMWNZxY7/jt+pnrbzo9SWh7iGmqJ4j6BwP0XOvzokiBhFzGMXIIGNYdbDUDtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=V0JRybgo; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id BRGcvbtlTaPqLBWCrv7ivY; Wed, 22 Oct 2025 10:36:37 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id BWChv1YSGp0HqBWCiv15NN; Wed, 22 Oct 2025 10:36:28 +0000
X-Authority-Analysis: v=2.4 cv=H/nbw/Yi c=1 sm=1 tr=0 ts=68f8b3b5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=fINcn6sw8SSkWJO5QzsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=opEUkDtkRFM9TJVwG8Ew2R5wA4CbCpBdTnNMwTVOIUE=; b=V0JRybgoLJknLLgL4rugS+uQcQ
	Tp2kMRY8H9P9+T0oN52vPWRffny4dGZisYHWyuqK/BBzP90EKqmzvC9CqzeFr0VOkIgzXLd9Ati+v
	m9TPvwdXD1YxfAnWrR+/vdPLIDSzqOuwWn2JU4tclotHOL/AkKaGRgRaWoGO1in7Y3/uggWKI7ydW
	hTHCXIwCWCabuCnfx8lkLSkhx3xINwvqxbyPlwgQWCN7S2acKLkz1+cgow/dfkRliWqXN8jMdjli1
	qp//K/UCoLcVTEmCW3PXt24kTlNMItIN3IR0hSwLXrDXIvEB0OW95S8tNtVsx53wMzcI+kk4JMX18
	n6F6bpuw==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:58472 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vBWCh-00000000oCE-084h;
	Wed, 22 Oct 2025 04:36:27 -0600
Message-ID: <4622bc31-d326-456f-8915-2e3e0cb9f00c@w6rz.net>
Date: Wed, 22 Oct 2025 03:36:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/135] 6.12.55-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022060141.370358070@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251022060141.370358070@linuxfoundation.org>
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
X-Exim-ID: 1vBWCh-00000000oCE-084h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:58472
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLAwVcpVapPGz33fRwngtqQPOA1+dyjy6FOHt/leubHPgvAtTIeXV7GXGqRdmxHRHklI5SkbuWoYgfjIEEaOwDAVrGXC/VwWB4Zh/lyTKN7NvR1OOd9H
 isOaL//N81lamU+IMmXJhPtWBG0Ae6VYSb+EUeCp4OMKWVQbr0I4gqKqK2VfkGJl9Ie2opMoSTtVEw==

On 10/22/25 01:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 06:01:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.55-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


