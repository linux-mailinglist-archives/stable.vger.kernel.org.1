Return-Path: <stable+bounces-80702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84B898FABC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 01:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331ABB22480
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED21CF2B1;
	Thu,  3 Oct 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="AihTVg/U"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B171CF7AB
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998885; cv=none; b=m4rcPGvtbfdRj2GM3RMED8qz1l/QVT8KHwJ3LHxfLha6cUO+yS+6M+K+CDI+v9eryWolPyURT/MVKboxrzw/bd27ljNVU7F8LkV8YLpR/uUVE3V/CgBZqcDUK1vdAw65ZD54A8YfpMwiawnNXdxJmRLA7hwnG3/rV1zUe5Kxu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998885; c=relaxed/simple;
	bh=8mCObbKltHbvwBg/B6nFSJyLAQaTEvfhHx4vslZ5KOs=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=KNb+YhNi9OzL5kxF9E0I7dCF/56fGLBjFUiTZiveLnwXHZLo6Cbw/zakzdmKT+p1Gwqp9fK5mZ2qk5r/XqJD7OE/WragxgTN5KeGltD3l5syahh0Ph5Wi52uxkT00hh9GxOEJ2K30RNJvINgYmYQfvlM4sKturO7QG7C6mCmhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=AihTVg/U; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id wRX5sDFChnNFGwVRisIuMk; Thu, 03 Oct 2024 23:41:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wVRhsSRfiWvXpwVRhs6rMG; Thu, 03 Oct 2024 23:41:21 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=66ff2ba1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jmpvIFUU7xsSjFCdoVTPCOR1EqyFQg0MhzYccYxOwr4=; b=AihTVg/U/jButLf6StyBA13zo3
	P0WhiqVlCf+9itZSeK5Po9yX6tC25XTN3zHDbFAdDnqeDJmbwWa0IQpkaISNhdEB72ofM+JhNDh5p
	LIpg/9yWwShA6yxXYbCBHO8tvwOWv7H6u2LW8eFW8PC6radxse2AvpdaQ+RfEqBIjP6vHgZ6f+dXM
	EfLRhVR79Vdk3uGxhFvORHjgihjCEwmzRk8Q8U4R4M2X9Pp0eEoXQIMK611xUHmj4gb5ENt4Kn5r3
	j5XemZVz9BXVIA4HTCHkd1JN3oLIW8j/8LZlLluhU5kp7WAjVCMciCzgbI2qnGx4UL14Me9kwjp6+
	YH95niFQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:44452 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1swVRf-0011uL-19;
	Thu, 03 Oct 2024 17:41:19 -0600
Subject: Re: [PATCH 6.10 000/634] 6.10.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241002125811.070689334@linuxfoundation.org>
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <eddef45c-03fd-dd05-7712-4c40f58ed9dd@w6rz.net>
Date: Thu, 3 Oct 2024 16:41:17 -0700
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
X-Exim-ID: 1swVRf-0011uL-19
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:44452
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHEA7/mh9alyuLN04gAKDMNdYpTGRQ/1YHNHCdy/Lt1yFnSMCrZoP1SNZ5TzAsgCIbjESeU61viJEo4yvrDBrptdLPchUWCUNP50akFFidsk840LxF1l
 paA6HUmf7QAMaMa2RqwXi/9UrfLj5LVvdgl1lBrclXht3MoQ6xcPLD+8FK51OtkufacSHp0B5R4ncw==

On 10/2/24 5:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.13 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


