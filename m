Return-Path: <stable+bounces-131886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F6A81D1D
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE593AA561
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 06:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24B18A6DB;
	Wed,  9 Apr 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="GGzzat/g"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F01D5AB7
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180354; cv=none; b=Zt3WuBGq3FRqGeWkttFpgZfgiQ8L83gbnjNrDi1FVisQw6spl47I+oxvHhPzMgwKg1iO+hjjmdnVoGzj+Rtv9iLV9x43BUntU61M8WB4San2sCu3cfEGkgiPy8ZWlb8ZHd4gQoljssRISS2zcXun5xth+1GWSJte9hdBS2YbjA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180354; c=relaxed/simple;
	bh=P0n5ieh+g6o6HGAdK43qktzXXD5vVTv1CTEEArbr+HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXwOYLrql+RNOyCkxPaz+X+wb9suF9XFkRnJomRPc5Q3DmFpe7pU0hMTr2m04yditUq+y2VFyGUg+XwRbO85ReQA233ivZkNQGrhEz3S4GXB4Q5gyobKE6D6UZLFo2kZ0kYW1iNRfTUCh7jXq3dieVMuoljhxhjSlilfoPyukx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=GGzzat/g; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id 2ChaucQcPAfjw2Oz4uIkBd; Wed, 09 Apr 2025 06:32:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 2Oz3uNUz7RxIG2Oz3uGrMj; Wed, 09 Apr 2025 06:32:26 +0000
X-Authority-Analysis: v=2.4 cv=N/viFH9B c=1 sm=1 tr=0 ts=67f6147a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DAMCG4KqC6S0IVaUW/bW9NdlcATf9WHaqkSH8tCf2Ac=; b=GGzzat/gIN/pSjfBPbNQejkBNA
	DETwpBdkQ79c9bvPxLytOO150lYNzeMR12i1yPaFfsFbFGKtHIetBtLC9HdvEuHqlbDAk1+7FEtUr
	uBwJSajmCXZpQS1JAk3F7L3NfcAQZ8mgm/fgIKP6e50gOYp6QZGPx1AlmA82oxFNCInCDCGky/JCg
	iVDnBzWypm/OrFI6ZXKIsJpywxg5bS/iVBa8CQ9HdYKa3KTOt0VXumRBEoUVVm2JW6yfFXhPyZeuK
	0F0di0nu78CW4Di8J68bbJ3KFW0pEs0M9WNoEFEWL9b5IE/ku2Ef7p8Spb/PZNy16yWKO7DvEEw0X
	IISZHDzw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57796 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u2Oz1-00000000F3O-22uQ;
	Wed, 09 Apr 2025 00:32:23 -0600
Message-ID: <c7347b3f-4b63-4682-ab78-15b10326f5d7@w6rz.net>
Date: Tue, 8 Apr 2025 23:32:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/500] 6.13.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408154123.083425991@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250408154123.083425991@linuxfoundation.org>
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
X-Exim-ID: 1u2Oz1-00000000F3O-22uQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57796
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCtRu/4RBOX2aV2BnQG9SmRa1G1rAsL2BE+Hs4owzIu2+bYaYcBUwNctQodH4i//9VLPzRBjRAsoiuTgDHyEq6Y1JnyjSEijXCuvKTcWIEIyccDp5UL7
 g5fgAwARze1GTxI8c8sw6xTROnk6wRQWD15rJ8Q5XpYwp48yZhYrapBmIzvvRTkYnsUvobmPVEjUlw==

On 4/8/25 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 500 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 15:40:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


