Return-Path: <stable+bounces-185676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA4FBD9E55
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117501896016
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3375314D12;
	Tue, 14 Oct 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="pdv4IrEg"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD99314B6F
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450881; cv=none; b=sU+geApFOuDCkDPeuPbVgHKjeo8hjD5aQPjSlgwxhpOTQLbySLexSk8VrWjgfDSH3Pb2ffVWO4REfDdeOf4t4VUrs3kQOZFJdp/fAomYkBiyVMs+jJ59g8EF6ACVaJWFqCvMZ9oZb5Ov7MOtpPeIFiVY+Lw4lrmlkYQYHtKq1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450881; c=relaxed/simple;
	bh=6sKVOPgAzUgWvKI/ZBPihiUgRU/gjgvXflO03UBRI4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fw6qlZUc5cIcjGXTE+fRbZibRfJgDN2ZfyQDC+t3LsN17WP+aqGcV9FLAo3wYATSHRbjNTeQyj9CVgWyCgc2EgSloopQA1BJf+DFo5gjgQo9cyXWurbEDLfYg5afi/INJk9pKCk2vuQXY+zDsF0H5yxCrRGXPTdUtEzYCVt3zyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=pdv4IrEg; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id 8f6jvX4CRKXDJ8fh0vNbh8; Tue, 14 Oct 2025 14:07:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 8fgPv2nQN25G78fgQvF8en; Tue, 14 Oct 2025 14:07:22 +0000
X-Authority-Analysis: v=2.4 cv=LuqSymdc c=1 sm=1 tr=0 ts=68ee593d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=7mImUwZGDDb17UAjreoA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pEwZ1wB0XVK3HMVObxxAtytr2yexg9RDlZxxS5uZ2DQ=; b=pdv4IrEg1A0Q6o4TN4GO//BEBo
	2YGlLsnF5Giod9SrL33RuuP/H1zpyI4I0HRLtuX82Tp8FxVZU/R3Xy2CWmTfVQZaI1mhQ0nvjxQ1N
	ysNFsU4Yos8FQHhJYz4Tn2jrF/0ZgsoYocdscmG010LagkMJ1MRLeQ771YLssVZG21IbPcDIn0Da6
	1EH6nsy4omwNljlagf9J6Pdui048jtYxzSI1K30Y0wkVbqC8Yx7oa8Bn+4ji6tR0PgDdSfIUxFCy4
	3rRq8Oc265kEUuSfG2P7DtZUCJQkIszxhfguthyoyHW+8r7EowyrzQdpVezFdLnqoqot+Ea/5p7bE
	K1AnS5OA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:38648 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1v8fgP-00000001oEH-1zfg;
	Tue, 14 Oct 2025 08:07:21 -0600
Message-ID: <5e43f6e0-91d5-4954-94ad-ef20c3d9131a@w6rz.net>
Date: Tue, 14 Oct 2025 07:07:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/196] 6.1.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144314.549284796@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
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
X-Exim-ID: 1v8fgP-00000001oEH-1zfg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:38648
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP+BmgHqHLrC/DR1O28NDtMukGQFMLqU1vZfDDXw1eImMXgIZ0bjr1D5hLU/Rn0He+pIqQgUV1Yw87SJhwu1AcpV1QLAmL3NXOGAt69sG+LndkgBCiJm
 /18nrZx6uHQJAQGDDOKCjbh9QMQ0eyDmgeUdBNGmUlOpUAU/oVn83Qw1R4Rf9ogIepA+9ByNrdVaVA==

On 10/13/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.156 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


