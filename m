Return-Path: <stable+bounces-179036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF2B4A1C6
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 08:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A754A3A9D11
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 06:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2632FE04B;
	Tue,  9 Sep 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="2kiwonoS"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB8219A86
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397980; cv=none; b=Ugk13c73umVpta6NzXgJ5K3ASCtsKCJoz/YBWJbWa+ZdTP6Oybv/OM+nDNjDxUCyWOV9qgP9MBWIALYD/800mJLHU9T/P6h62sh/mVcIidSSifjDGsLCtRKRtQ9Cs/p2kHbfIKwbgmoC6HkeusMz7Jgu8KaEgHC8+g77NvdC4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397980; c=relaxed/simple;
	bh=t3sp8W4lBqRQ3eAgd2Hnc9sHhw0bngi72HUjHNm71cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9dR4+FfxC9oAHJdjMC0EtY0POOfiQWLhKsd+pa9ePv5e3jyf9rhmuiUCy5KYuRWPNR6uciJ4ovk3OsArr1EZBFL7XPa401wTVP9/RkmVd4DHEipMrUG85TeMTLObSp1NcGqq7WYEgBLaw2k60PTGhMXJM7IoHeOcG6tyOCmRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=2kiwonoS; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id veI5uvyTpSkcfvrUdulPVv; Tue, 09 Sep 2025 06:06:15 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vrUduA2VwEYttvrUdu9Kbq; Tue, 09 Sep 2025 06:06:15 +0000
X-Authority-Analysis: v=2.4 cv=K6MiHzWI c=1 sm=1 tr=0 ts=68bfc3d7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sq2vnZqGTaj5nL7bFp93D8iDNpza3fyp6NANLQD8Y8I=; b=2kiwonoShMTSQ4hclVBAv5R1NN
	H+p57dt5t3nbQrBmdGG44h86+wwT0HYXYGSAfducBboqfwi1b8UMC/69f+rwbFyyf2cKrS37jaB2b
	rZVdaG196zM0Hnsgv+laldV3Rb53y6qaMoF8lLpsBsD8tqyYs6y+9sYjZr+bvEn7uZ+n36R2X7ARU
	pDkTtMdJJ7ZLn/CARbSLRzW7bi+EiOkhZBQiVIskjWUBcKlpFVXrUwBSEWu+NlV5iTZYpB/EmmbRi
	7qhHzQD4KtgTVjAEP86BTFyqC8NcQOBxBYKizy2D391tYbWQ8R9j+bGEBZ8yu2Sn4TEgMNt9g2AJt
	B6C4xHAg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:56076 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uvrUc-00000001sOv-0uOb;
	Tue, 09 Sep 2025 00:06:14 -0600
Message-ID: <a26f0d99-dc8e-49c4-b6a2-07a2f3860818@w6rz.net>
Date: Mon, 8 Sep 2025 23:06:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/101] 6.1.151-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250908151840.509077218@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250908151840.509077218@linuxfoundation.org>
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
X-Exim-ID: 1uvrUc-00000001sOv-0uOb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:56076
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFdNeIc+9XZEC/n6PaENHjxfC6//qm2W4XP1pNtLkyXL9IoY9sP8Bbc/azUPvaDDxJr94jx/UNprta2jKa/qxkg5Kk+hPZFvK7gmiB7t2DP2a/D1xsCA
 +XvaEmxGk45oJvJIIiKzCGZk42WED8gCZh2T9aSISTmr95gCZHWyb2NDYQ84B4uCjMUNwwv6Y8hysw==

On 9/8/25 09:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.151 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Sep 2025 15:18:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.151-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


