Return-Path: <stable+bounces-119446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CAA43521
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 07:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A33AE5F2
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030925744A;
	Tue, 25 Feb 2025 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="O4G4xvSh"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F7256C7D
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464613; cv=none; b=HiFdo8CzdaC7lxbIrbXnFaGQhZZ9rbqfujwtXpwQhwIUGVWbUwBfHX+imb41TZe1O7dNTQ2OWwp+dzgLYIyIyZJjXUm/zuKQr2nXUzetPhJQcc9B5omsDfrq4bfeFm6/J/9u4+KyoTlaljYeDqB0REXg06caxabQmJTNCj9ss2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464613; c=relaxed/simple;
	bh=InjPphvXvck7XZQVAEzYp3L5qLZyOZNGayaXBVX5opQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JL8PDouG5XYs4leakpsYm0X4JALEh2EJK/wI5iOX8ouFdgy0nguBwiW37jpMWFEp7/M0OTRNPdEWSvpkRmNpoZMcM9fAKMblgQHEWsN+XctqWN923ktT4VN5s3SCO8Y6NA5RFn6mAKaqdlQTd4fd2wcrVtZ8v4vbLoOfPDpBt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=O4G4xvSh; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id mbI5tP8E6f1UXmoLqtF1kr; Tue, 25 Feb 2025 06:23:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id moLptmrPb6YSOmoLqtKi6E; Tue, 25 Feb 2025 06:23:30 +0000
X-Authority-Analysis: v=2.4 cv=La466Cfi c=1 sm=1 tr=0 ts=67bd61e2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B77GYMjoi4kFFzLnU8gYlsi6rIvhF1nmTqb6FN5GZvs=; b=O4G4xvShRUp+ijSWsMOnKFSH3c
	7zfEJ820lKzdKts+t8+x1xhnWpi5nIRQ9xGYqGGTJZ3PpNOR73KU28hUVDI8ECQ4J9foScuReNO4b
	ZhRyFfQUstNw37O3s1+6yfdBi7GiYeuCKeP99UR+Ohdd6b80b5IiB1iGULMP1FestiigZmGG7tmqy
	Yx/MRGBvV4TbN3RUz/0WPZWK3mtWWyJyZWzP/D52IJMH2/93d45VknZBUi7cAwEldSPTSDFUdXBdo
	jCQ2TIyOhdBy7xkhnf21Ar/Kh4rnQMhmftzfjLqMwPjckE5fWcveVrumwwkITeU834aprIm4/F6vM
	NHhRR8qA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:56256 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tmoLn-0048lH-2a;
	Mon, 24 Feb 2025 23:23:27 -0700
Message-ID: <30b018a0-0468-43a0-844b-82a00e2ae677@w6rz.net>
Date: Mon, 24 Feb 2025 22:23:24 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/154] 6.12.17-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250224142607.058226288@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
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
X-Exim-ID: 1tmoLn-0048lH-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:56256
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNC6TXm2KBogRCIda42j5mPqMb6MLzqsU1GjGgcN/U9xW81dwBG0NVpVRqr0PR0irHBacSdYW+UYpciBmIsg33dsGhMa/gtsxB0xlp0jEJUAyvOw5IKj
 0udFyp0hFiGZHheXMVC0pivb92KG/E8bL7E2kwaD4wivQuadqAv5cspn/8Z1JgR7tJ9uTZWsP/6gyg==

On 2/24/25 06:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Feb 2025 14:25:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


