Return-Path: <stable+bounces-78208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A67A9893C3
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 10:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBCA1C221E0
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85D7E591;
	Sun, 29 Sep 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="YtOoZ2m7"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D9F9CF
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598643; cv=none; b=WjPYGlVdBBP0JaWQVZTWasFwK3ts+6NWVosShC3t/T3NU+D3Bf7SHqCA77IjTY5XVSzt6jC++bsZdjJ1xJNpCGB+DM3O+M6SnoKsQ5LXxZFN4NopOtdd9n6jXYd6fEza+B7tmQea1AY9Yd2EWAKMhDmWJ9+7Ewb9dB9aX4zwYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598643; c=relaxed/simple;
	bh=tHRyrLPcSm3HM6u3JAcVuv3MR6egb4hEmiK5dPlx4Wk=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=mJ9WM6H003qh3hVuRHpAGJkhx0IWMKsvg/1iHYuKFjCC1ywWAeTjvnNHymCKyQY9/PUyJTNUFz7mByaZROvVA6Y0iL8EuDNEA9A0cgXE1B+V6CrFEXNYhNbuQGAmI6vtSPMD4/Fm2srd0mt58CS8zaujPinSOBQ4xPReCZhho+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=YtOoZ2m7; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id uaO7sk7zyqvuoupIfsRV95; Sun, 29 Sep 2024 08:29:05 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id upIesyARZWdNZupIesh7CZ; Sun, 29 Sep 2024 08:29:04 +0000
X-Authority-Analysis: v=2.4 cv=FtTO/Hrq c=1 sm=1 tr=0 ts=66f90fd0
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2dUug4SSSRbXq+6phi7ey3Q6yy434qBCNBQpg/HBdho=; b=YtOoZ2m7xLloai9c6GxPqCZs2S
	zq7cT9QhqsHlV8BGdrEPoDbrN05TzwXlAJy2DrDXMZTpDMInQETuvcQThOMWU5pmxGQtNuxwOegYT
	8l2/BEafTtJ93IpFjM3xKfIMn7Zg77UB7JKrkN6nMIraLyA/qR7tLOTN3RNeqmFASPsYrl9KRqFpt
	9msp4n/S6M1nl7ud6VGxGEdqNBnwvkBsxOtSInCby7Y8OS0Cq6XYxDjzTChRm2Yu/KlJ7qUVanxQ8
	zk/O0Cgb0SoIwD/yLhkiJAPlc4bBz8pal7ukvH4vR8J5CHoU53Cd8Hf0cqPGQVwJmdf4xAY01JzcP
	lHIrQDhQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43242 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1supIc-003o0s-1p;
	Sun, 29 Sep 2024 02:29:02 -0600
Subject: Re: [PATCH 6.10 00/58] 6.10.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121718.789211866@linuxfoundation.org>
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <d9f09cee-b860-7329-0347-f556ce485cf0@w6rz.net>
Date: Sun, 29 Sep 2024 01:28:59 -0700
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
X-Exim-ID: 1supIc-003o0s-1p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:43242
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEzhBk4W21NH4C7bJlH8c8osQ553EMXsrGSpBcBYjeNMkc0Cyxnv7Rq7wKgfARBH66UUjwLj12s2mbIN7WZ2v3UtUww1GMgD5kCasiUrZi/sZClzejef
 hUeN5KUjWHX8WdQsDCHm2QO2OhXodNgykLeY5NowYqr8zFDW0trHf5FqwNxVAJLCkvDZBVjRvpJoeQ==

On 9/27/24 5:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.12 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


