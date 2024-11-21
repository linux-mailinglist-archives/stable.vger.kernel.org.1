Return-Path: <stable+bounces-94493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0499D4694
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 05:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7E5282750
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BFF13BAE2;
	Thu, 21 Nov 2024 04:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="UOHenyob"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4542309B6
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 04:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162851; cv=none; b=LEbXV2lLNG+rH+2LGFqjlvs3eO/OzD4zuoSAsGglUxZg4QHAExR3W8N2ttrwSukWs3LuikpUC4Z+0sYpRgj+EEEy1ieaKaUfguIcFAArmXhnD4Yp3D4mwtPzACCPjQrHMnYW6pdx+p/XnmvW7zoqEsjn4WsNWKdMqwuTg6DaYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162851; c=relaxed/simple;
	bh=aArlU4tpz3uBMTCOrMzLqbpBYisIgpk9/gwftKpZWyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBx8MQbfR0sFLkXl8l7DvkY3To63ldZV6ypSu75LFWHqdd4zX4QBLXlPyRifsV0QwvnQRKcbEEaCuAIQZ+3/vRjf40NU0dX2NduZCT/JSFnZcaQQtikhcGHcJbiXR8b4+4B4N+VqhBsExiwe6ZpHQpH+dWykkBDCi9+5cCNkqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=UOHenyob; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id Dmrht8qzuumtXDygStyrNd; Thu, 21 Nov 2024 04:20:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DygStpuUkCgT6DygStMDvi; Thu, 21 Nov 2024 04:20:48 +0000
X-Authority-Analysis: v=2.4 cv=XvwxOkF9 c=1 sm=1 tr=0 ts=673eb520
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Da7nlx-0jZ_hJutoApkA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ydtcdRxwB2ZiytdFSHOrOV/wlQ/taDdubAe7sgkSaBk=; b=UOHenyobkWCGV0OSDbMc/AkjGd
	6zlmguY3AbGGI2osQvoXqWJqBLwBqBau0I+vEyoQnYmxqcTNDQZ7O1Z2ahhdQRK6N/PEi3/Ti08KV
	QFKVzextbWRwkRgRZsfUDYcWp9P3/mMpzrL0sdqx1YpcXs14FL0i12ZCiJYAgQsT8YQAEnTn7A4by
	maNx5W9EIc33WTIHgJizn6kjwg6FIZY8iW3SmYdu03tGr+ImlCxTR70NoLzZwlhilxM/onhsUhaZs
	R59Dah/pxStKb6DrvyR1xvyeyAszVJ5VYfdbyU9jd3+GTnRO+MyDDsEiG0OlexLEdD2xLA20fwRhc
	4CttglfA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35326 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tDygQ-003Ghs-35;
	Wed, 20 Nov 2024 21:20:46 -0700
Message-ID: <2bde7bff-a41a-4304-b6dd-8d5d62e9c312@w6rz.net>
Date: Wed, 20 Nov 2024 20:20:44 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/82] 6.6.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241120125629.623666563@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
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
X-Exim-ID: 1tDygQ-003Ghs-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:35326
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOpenfmtITkt+XS56/mojsCqBlMYHKZcRfPfwEQFADW3JsnuPv8+RiGC+JUARV9T9Ox4DavB98DUmcA+l85DuKc23yCZgwFwsbIqlRf+JaHIsdxCwf3N
 sutdpdM8VY7vNuuJYJ9F/UDXQ8XDuug5xqCgcvhF4dwwOqWP1kpKtuIoazKTDn0QbkN8lxPy236Z3Q==

On 11/20/24 04:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.63 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:56:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.63-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


