Return-Path: <stable+bounces-150658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182EACC15B
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACFE1882295
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E0269AEE;
	Tue,  3 Jun 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="J/PbtZRf"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79292268683
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748936614; cv=none; b=qdWYGsGEgi1oPqml84PF2WvTcamfzVbq2gYDe9lVjaimqPey0i8VWh3YvHIjb0/jndmdNbQ4Dibn/YjCyA5/697CLp0wGhB3xEDOPetQ0Lbk/VguQmMeHybVMmXVcqrX0P9NHNO7ya4JaLxF+Ha1TYuBtAf0BIvijJgFWULUB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748936614; c=relaxed/simple;
	bh=yS4mv+JxO21QKaxhp2hFv4h3uZS3RJjesAtqe5PgnOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b35pAmBH/k7g0fbi25fw0dQki1YXjDL80YRhJX1BdiaEwwDA0F/kIa4m0A/Y/lKcmi/eBPr2daSW9sJSC9d5gShG1xLzsHje2jihJR2Y15OdBn51jiEwfA4wmPCrtOz6m4EAY8rJcTNksvGC9Ic1VUKka8Qx39T1UXxYB07HDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=J/PbtZRf; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id MCjNuxXXiMETlMMIwuwcr2; Tue, 03 Jun 2025 07:43:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MMIvuMYbljrgqMMIvuQ5HG; Tue, 03 Jun 2025 07:43:26 +0000
X-Authority-Analysis: v=2.4 cv=PK7E+uqC c=1 sm=1 tr=0 ts=683ea79e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HhoJFD9y0GdeyuwBXJtk3soczcT7TDdsKr4ofTKY5Pc=; b=J/PbtZRflgTgKmEoPJfTrlaZQv
	Rdl5Aq5UCQ4EkgCMQmVwdwnvOp6p8Pizzh77UKvVs2LOnxzLUqXwF2Xj//r1N3Xi5T0kAMH+nToO3
	X6syadcm3Hk6NQScr+cbD9o/55sOUbG1xr9Ll0S0+6E8XowAciIZlIn4lu6ztCqTibeFtvNBThmst
	Jk067gSD8JKNGXZp9XzqKVdYVZCFV0TkdZNE4w2lxkymQWY8vg51aMONqSoziT7woVjlWLZIUvgGX
	/lOuVlLSSccjAxQ+iyglYoUnabkZO8h0OZNfG9/F1UUR17Rq1OIIjzHUTSxrmCs4CD4tOrwbZnzQZ
	FYLeb40g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:45348 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uMMIt-00000002XTk-26Ut;
	Tue, 03 Jun 2025 01:43:23 -0600
Message-ID: <4dd70bbf-4d4a-46fe-ba87-5dc5a7aa32c5@w6rz.net>
Date: Tue, 3 Jun 2025 00:43:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/444] 6.6.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134340.906731340@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
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
X-Exim-ID: 1uMMIt-00000002XTk-26Ut
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:45348
X-Source-Auth: re@w6rz.net
X-Email-Count: 94
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfECOoMpvjZPimtvIAYa+pwz8FxOYR/eZns4HNclBBoRnMBWEZP1TdfYuH2b8MJM30QGCw9J5K5fnCbhCajGMbfwyekINNtHSOR4AlksLEMbd4yNvqrVz
 kFFKHQP8RwZ73gnDQkyYafrq+D0o60JQTRtXlec1ovyI3ZFOeJogVGK7R4ixVdcRfu5hUnQAToIEHA==

On 6/2/25 06:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.93 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.93-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


