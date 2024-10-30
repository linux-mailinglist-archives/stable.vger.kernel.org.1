Return-Path: <stable+bounces-89282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D559B5927
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 02:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DC91C23710
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FF37581A;
	Wed, 30 Oct 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="FVSjLAYv"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445FBE46
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251901; cv=none; b=HulocKU5FGg7+8Iqrwf+E3dvAdw4KUN5pZnLab3Q94n3H6Jh8VThMXCUuBK8uFQg6zE6ypH51uXhy7FRVIzrApHdvk5CiE9lgSPBKWBNeA4xlYeCeu0UhWXSxONNT/qY1Zp5/K3/8BO045yDgTaDb0+9RtNYpnjclFe5XsyFnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251901; c=relaxed/simple;
	bh=R3q0dPELC599uJtphGcY6pZKLHS42kH0SLJYtP6cdEQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=CqPBgRo568D9lCrWpVfVNyjeADMJiB/qq1LPHqgzJ3MZyEd8CBe+dG2wZtw3qhzLsKrar1D3voxJPlipgstR0vB2djJg0oJ+FtzmdjH2uuAYPAR+0w2E7YTw3UbQXO3oVc0o4tLN/CpLMIhap43L8iF9ut2YEkL9M6RUKwmBPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=FVSjLAYv; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id 5p9Xt5kJpVpzp5xYbtnIEK; Wed, 30 Oct 2024 01:31:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5xYatNekUWdNZ5xYbtx8zK; Wed, 30 Oct 2024 01:31:33 +0000
X-Authority-Analysis: v=2.4 cv=FtTO/Hrq c=1 sm=1 tr=0 ts=67218c75
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=4Na9fpYnh4hjKbwFJnwA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NFJKSAGjASlvJI0n+bDCAkzsVkHO6HlGZfLxudFBndE=; b=FVSjLAYvauQbPF2bHU6+83CtW+
	A+tdjMmI5xW2BbkPxogoLTHjQcm8VVcho8wD5gNDVUcbJhKQ8VeMDJqkr+hWYXwiC41gwsOMCFjgE
	hj/3pM04iLjoLDrtxTmEJ2DPv1cSguYzTPoIYD9FCu2Cv4Wnr3/AOzY9S97u/Zxf9c0BKuI3/WCTp
	JlwIFxYKBz8yRkUOJ9CKdDl1ayypAAbU32bpZ35ZsjuZl2aNQs1Yt7C/aj4r+HodC/T+bB5w+m5j3
	mGF8c8byDbd90cbX7cP3C4TK1s4Ng5mwg/Ruj2obEwUFE0BPUiTJJd4LXysVEEwRn60rZ18AgxvGD
	hsSHO+1g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36540 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t5xYY-001H46-1P;
	Tue, 29 Oct 2024 19:31:30 -0600
Subject: Re: [PATCH 6.6 000/208] 6.6.59-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241028062306.649733554@linuxfoundation.org>
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <6e9e2d08-338c-ae6b-977a-160c13081a41@w6rz.net>
Date: Tue, 29 Oct 2024 18:31:28 -0700
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
X-Exim-ID: 1t5xYY-001H46-1P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:36540
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOp2VEvok4bx/UZFOrJxTCF3ZVjhbePUksJCnpr4gPcdw9EkhHtdjd+QrSlqwTKUYNWE7S3FMj3Pi405LmQe8cFMXM4wMm4BS5malojjAIamJVroZgap
 aZRtvt/Es6Hff3CSuNvfyVlLNAmHKg/FZ2GeLQE5CXiI+D6xC7VPyeQPUCRpo1PcVYteqjB13AdBYQ==

On 10/27/24 11:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.59 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.59-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


