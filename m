Return-Path: <stable+bounces-126814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A8A727CF
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 01:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77510178BF0
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 00:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848B24A06;
	Thu, 27 Mar 2025 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ZxxHjLtD"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A3C2C8
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743036031; cv=none; b=jMoLmPeJjs2TxD1Kulblig4eoOOOfS0vKQAzksy2xmcvwIxdPf637X5TBE3nCzzXWV/2HVmgaAXF8hSsCtO13XypmWnyB1Y6tzmRRWDiE4zJ9anUWSIAlJPpbm+IXpncMEclV0eMb7forKbCXF+LJbg889mzLRAjkHGyxyISim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743036031; c=relaxed/simple;
	bh=4ob9zGCHsFyV814vIdeQiPzbbuhBnp6oBd37hrYBBoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4NGs5OKHHe63dugC1ZiFT+RHKbIuhsRXt7avlQxrTOBLRku+rhlUrIg3hjNm1UJHXLGGSDU5oovVmzPDwI0h2nEtaWem+Y0T8Ab0x2FBcZFnjpLjHe23/4rU5hvrmcmcPVPKxJnv7kAoz+QAradp03j2atS2nUP9c8OYL/3XSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ZxxHjLtD; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id xVdntHUrDMETlxbGntvfFT; Thu, 27 Mar 2025 00:38:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id xbGntM2xonR6exbGntPUIf; Thu, 27 Mar 2025 00:38:53 +0000
X-Authority-Analysis: v=2.4 cv=QoNY30yd c=1 sm=1 tr=0 ts=67e49e1d
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
	bh=FdFT2AR2+K8ys+1PuyrS1jlibUa7DXx+i/bD1DWp4p0=; b=ZxxHjLtD7vE6PvNUqb4+ykBWLT
	NevAZGAbU57vt2jOXGsNF7zIuuX0HqrliV7WLzSj5knQuOps4vT9GDbqoLAqTtBl6bPZBa2r2A6Gf
	9yh1ftmwXeynARQbCzkSvRH+FJpiC5/nirud8e3H8FeCY7Q1lodbVSObab5IGZJhDli5jU4HbJrk+
	+EgvWEWO9YfZ/guXWT/rvdqrIoaB8L6xhMAgLJ/AiA1Nf0M1dtrlec26ceL1yT2M00Dhu04MpRyqB
	QoTLiuMQJ34+zyzsL3FESXwcRAD58CD0+0C8kkSQEf9YyXynXxIvUd1QqtxwVpbVtyu7w+OWa3+XX
	J9acWfVw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:55026 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1txbGl-000000017KX-1BPJ;
	Wed, 26 Mar 2025 18:38:51 -0600
Message-ID: <d8d93857-60c1-48e4-91f6-c5df2c703a15@w6rz.net>
Date: Wed, 26 Mar 2025 17:38:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/76] 6.6.85-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250326154346.820929475@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250326154346.820929475@linuxfoundation.org>
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
X-Exim-ID: 1txbGl-000000017KX-1BPJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:55026
X-Source-Auth: re@w6rz.net
X-Email-Count: 57
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCDTgmtNmg37xRyHj14yMKzhO0LuqOyqURE3d1YJDqaVOGXbrVWFSzNotMpw1PpKMVMAiIglODBNXV6oxvRFhjXmPmtKFhHmudnrN9UTL9EP+LzYAYQ0
 UWYw1c7EVc8cify+k4l2JzVqtE123AmLY33qgF0GAQc2946MhLEXXhbPwJBAUbMIsIOdR/5uvLO8aQ==

On 3/26/25 08:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 28 Mar 2025 15:43:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


