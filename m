Return-Path: <stable+bounces-45225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAF38C6C9B
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1951C222CD
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA6158DA5;
	Wed, 15 May 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Zhd3P+oD"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866132F877
	for <stable@vger.kernel.org>; Wed, 15 May 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800225; cv=none; b=Tv+OwADG9qog2pd3+dcdr+oS3ernQnyFRgPRf4ZDHjDM6KDF6hFKgy7EPqyyxqDfHXDq8kM4AUttOG3MjRv29I/hOgs2vctcL69xFuf7m9Jrns8rzFcVzyZllLRe/tUgHxPvwRiqbMIx/cQDUSLqAEkQSOL8IrNs7JaUt4KfXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800225; c=relaxed/simple;
	bh=4oB1JXBLHcvFES9rbzP9mVt+itHaSCvKneEGCnD+In8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=o2vE0gw94HM/dWqbzjuAUGd28LPGPKdSq144G7AKaLNKUajDFs9oGgI6faOY8ZCGSBc6y7cm9AsCOIVhdhLUW/vmXP2+HNEyzFrGh7kJpK56o5SBt0l1ZUKKwhxnflc9raqIcTrNutD+3/l4jy0YmLQBdej9AZKb0ZhQqK+Mnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Zhd3P+oD; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id 6vaKsAL3nSqsh7K18sTpld; Wed, 15 May 2024 19:10:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7K17sPwgDEpk17K17sYB4c; Wed, 15 May 2024 19:10:22 +0000
X-Authority-Analysis: v=2.4 cv=HoRwGVTS c=1 sm=1 tr=0 ts=6645089e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6JpUg3wSLY7qGu7ALhdgxvJ1xbPGhzqxXEzKie5Iu7Y=; b=Zhd3P+oDn1trGPQiF2hyhQ0JyS
	kbqx/OzRm2Bm2T/Ugl2DFpS4BguG5ecH33fxhvB+QGDnHJ5SSbYb10zd8d4sLEO8RkM8K1CmXKbzV
	t8Z19Pa+WmonC2hhpCFyQNbeJri4USjNw/O8dNdFysGhw65moG5MhGxPCFKnvigrNxMzk7vbXBM0S
	2gfiDiCf2Mr4jod4zy/+coTDVrSGazeOcKZSDiUgWKJ/E+Ffq/x1ouQTt4sx95hUiTgfWRInmzAoS
	z4iXmIZbfuwHa/D4aAVo8aHzaiVEx8C3SHvQ/H6c5rqAFroN66O8G24DvJ9BV+gjcvqAXWLmhZKHH
	V81tt2wQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35806 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s7K14-002UIk-35;
	Wed, 15 May 2024 13:10:19 -0600
Subject: Re: [PATCH 5.15 000/168] 5.15.159-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082414.316080594@linuxfoundation.org>
In-Reply-To: <20240515082414.316080594@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <fbbc9d23-1111-ee31-8558-93beed611668@w6rz.net>
Date: Wed, 15 May 2024 12:10:15 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1s7K14-002UIk-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35806
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI0S286xs1idFjN8F2v/tXYpmdtGCZQHjJ+luzAV/1gq9thx5r6WYyKope/+yHATy8EJenzO/KIpoUdo47Pp+pvOlWKrlLh2nBZn5lfJ63wYUFXz40rz
 aVY6bjsPplvf4riX6t8ISZIOtgQoVWwatSQOHzP3k+1SooHH3Iq/grXljKB0uDvzeFGW6X75uRuSkw==

On 5/15/24 1:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.159 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.159-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


