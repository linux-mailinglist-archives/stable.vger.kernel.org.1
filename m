Return-Path: <stable+bounces-110140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E6A18F8D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1B01883164
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F55211477;
	Wed, 22 Jan 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="os1SRQl/"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537ED21129C
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541080; cv=none; b=W35SqkNHgyPhX2yl++fRF7TIMyE27Hi172sx/swHGpxm+Gn45BJJy0RlH+3J3CWaV0DHWNu/2fzc3K/fGmBJgkPwf9Zz4i9woI8YC2L3G3LWGWjIz0oSIMU9QlM6RE4DzH/le6/swKUXGwBRmDtgPj4M+LpPqrHSbvhHGy6JQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541080; c=relaxed/simple;
	bh=BW9F8T0VgPqa9o5/UD7pJUidTdXFBPfezYhXHtNT8m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdJvduqu7HOynWJVadIy3/dyjW8O+99b4SD+1PFeWudq3gn8t3Oxh3kH4a3IqsoWsgOiSLjL06njQfFkNeE8Sf+KqmSd4vq8lhx/Nq/Sdi3sBBQS9CK4HV9fC59y+hLIKuWcvccg2EFBGGJrTYy/yjNThooXy38ebjmWVPC5LA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=os1SRQl/; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id aWo8tx8WwAfjwaXo0tGQmx; Wed, 22 Jan 2025 10:17:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id aXnztEalDjBGzaXo0tl9xU; Wed, 22 Jan 2025 10:17:52 +0000
X-Authority-Analysis: v=2.4 cv=HJvFFJtv c=1 sm=1 tr=0 ts=6790c5d0
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kzNp7lbWoHKc9nHEsWMFzfP2/ME9Ty3uW1R2fxz2cko=; b=os1SRQl/gdDF7K9/yF0IogZC80
	Hj4t674OidV3k1O9UjXKegYCRuRGfFsEkxiTZ2DrggqyqiVmFYhmVkLnQ16fcea4h9eDJgd8E7b11
	m1Sdz7sGkQNV+bUtjpvxJdQ05/xui+Gpc2zoLEmkO/dJWDC/HdwLBZD8Vu3U4C+KiKwsURc/yKHsH
	e4IXCBHAXiX9YRMesD6G4DUNTW6eOFqKKcWyhbRPHHa/vVA8/JodNU230ul2O/nElZW1G748ouDJx
	WhymmqCrIfnXT/qunS53aYP2tJzv0yOYZTOThn8s3L8rmo16aiphbd5WrLDNBfLqX5i1MIebZnyK/
	T+xtwR6g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:50726 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1taXny-000BBW-2V;
	Wed, 22 Jan 2025 03:17:50 -0700
Message-ID: <1e5f0123-38ac-4edb-9b3a-b533b218b69b@w6rz.net>
Date: Wed, 22 Jan 2025 02:17:48 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.127-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250122073827.056636718@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250122073827.056636718@linuxfoundation.org>
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
X-Exim-ID: 1taXny-000BBW-2V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:50726
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfElF1ascsGEQU9osGNqQgl05LzxjDv7fRZDIjF4BFxhFpK3KN5RC0bdTejBN+3wUyVQx65XoEib+LQS5k/QAAQdk24CLQVJLy8GzpcZL2PpvwGvckeFg
 jRx/bqIITdUpuOZw0SkYyIQh/a/nU+xooUqR3wiy26MjsoGboGmgqZ6lPcKB1H17kRmpi2NCG+9Sdg==

On 1/22/25 00:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.127 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2025 07:38:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.127-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


