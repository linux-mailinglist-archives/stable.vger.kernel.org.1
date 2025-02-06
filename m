Return-Path: <stable+bounces-114058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5AA2A52E
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5911889504
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E93226528;
	Thu,  6 Feb 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="FWCwd1uU"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95582144BE
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835594; cv=none; b=QX/Eb3fJtl7svHt3NOTK0JeJ3PEMMLJ5bACnpHf5rQTsBV8syGhfa1xCYV0h92HEdGfhB8LZsDLh9ZVs57l4wgscqR41FrTVUE/ppgxpNF1EuvqzmoJ1EF1SFEYXYqAsf0TLwsgG4WNnV22h07JyZP/D0fsLLzOv9sPcFh264a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835594; c=relaxed/simple;
	bh=V39skD+/eTe9Gts1XP+dz8FWYa7ChamoYCoJzGWc1T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lieBrTzvpVFNg4gjk1vIQ7TNof2KtwIH+XioNHoV3807GhIbjIAEnbeTvsN1iOq1e7dTjW8/wD3Wfq8LI7ptk+/t4AY1r2AsImI2bFponL4MMYMXxiV3v7sCsJZAQBT3HKyAQtNWl9tkptG1LAHGO0SSnJGV81+TaJfu4Mhr4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=FWCwd1uU; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id fmVAtEmMDAfjwfyZLtABJS; Thu, 06 Feb 2025 09:53:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fyZKtHmutUvNvfyZKtSNyN; Thu, 06 Feb 2025 09:53:10 +0000
X-Authority-Analysis: v=2.4 cv=SMZEVvvH c=1 sm=1 tr=0 ts=67a48686
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
	bh=NrxwET5oIQlMPkpfD34350qDLLEVZjRr+OYwqmaMwJw=; b=FWCwd1uUJZ45ll5DV+TxNtLwwV
	C007+cPyH9JRJF/ctmlH3wbiMHXEA7imn9asUi/g6VixDGEg5j7vZdnd30k5t1bl+SDmab/RfT0qs
	J2LH0h8ySdr7yFDskoWpQADpQuvecZ3QM6Nm338wWA60f+BLsWvRhXdKAG2FACeUlG7OA4/+KSivw
	5+/Z55U14A1IVjP3RSVduMd3OkBtjy4wlCqCxKCrd71duhnCaywDz4UQObzr/UxxfFPE/hBFlz0pb
	g+uWbhN3EloJd7jRtk6OmRQNKgq1LL7ppe311tLR7jGvlDWxv0ydR9hYFzdj/1gKmbwQ/SqyB/S7I
	aeTIka/g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:45656 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tfyZJ-001qjF-0c;
	Thu, 06 Feb 2025 02:53:09 -0700
Message-ID: <66c87ad9-5987-42f1-b97f-75d53a0957d3@w6rz.net>
Date: Thu, 6 Feb 2025 01:53:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/393] 6.6.76-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134420.279368572@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
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
X-Exim-ID: 1tfyZJ-001qjF-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:45656
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB7GVNKD7XOuSSU/dG0md8Qwd00h7aPa8ckkwDB2W+1+Gm7fuLbb3sbVyUCWcR+qQV3Ch8kOh6qIZm0HTYAMwtbKp7Ybo8KnezygmTGokHH0ELGhWak4
 EhLG4Fv6/Oq+6SmoWha+5hoPSPuZoJ2PIzqx4S9LiJM26VTpdM/err9EozjzS3VB9Vu4OH8iVGBEaA==

On 2/5/25 05:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.76 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Feb 2025 13:43:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.76-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


