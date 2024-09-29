Return-Path: <stable+bounces-78209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F121E9893CE
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEA31C2225E
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56613B5B6;
	Sun, 29 Sep 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wo3jy+zO"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7FF9CF
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727599073; cv=none; b=dD0E5hYuKJVdcLMR+xwFuSPWsMc6IDMxeN1RUZNl45uPb22sap7geYR5VBZuG76a6yzlJYmwOzLrl8vy/voLfNo0E05/nr1Lj0I8rxvmWSJpXXBiPOfRQirkUC+PMF60t0H0/xFAKpbxtE9xwdevn0dukpWPnIquq12aC/fbNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727599073; c=relaxed/simple;
	bh=5Do2guePwOK57d+v8qG2KNR9azpVV0ojuW1F9re/km0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Opd/z8o07nfdwewBTUBgBU9Gi16/0hi31ldJEVWq5i+ETf+A+DcbCVM+Vct3HPPsmuu2m44eIQwvYRZEpZzfJjNfKli20jXKoHvv9QHR2bRGVNvphFUudvgNHrWz5eyHh/sjmYPAd3v7XIprurj8KmdS+kePfRaH8IkWgSchAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wo3jy+zO; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id ue7YsGkon1zuHupPbspBxX; Sun, 29 Sep 2024 08:36:15 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id upPbsq7BOWvXpupPbsiQZg; Sun, 29 Sep 2024 08:36:15 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=66f9117f
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
	bh=tMra+jIX5u9eakWkQNpvG55B1lY9vA8Ro0oxZ9dUffk=; b=wo3jy+zOZy1o/7G2KX5rUku9VE
	CHhRL7c+wfcSId56YJwEhBYZwnrtsb7vPR6VgHrgnigkXUxq9odJ88cL+YCNuX9yGC6WsXcJp7hx2
	M9lsMXSBLvQA3V6nAUxWZBtMfD9B/Ts5CiMRJ6PJqFlHdxP+zZEytRyDPkvi4lhNLfEpB1QSMvkY/
	iSd99ikaXnTgOsskhFWGfn5k6VQrIIZodF6KaXn+09Jpce62oMCbzvxCozeQ5eh1y/r05FCbbQjuo
	KoFMYiUzCLdeM8N7G9HQ7m4C4f3v2L19NO3F4sis4jb5qKcmTXghE8vP2lPNCdInoLNrrwBSCr8wO
	UBG40Z3Q==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43250 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1supPY-003psM-35;
	Sun, 29 Sep 2024 02:36:13 -0600
Subject: Re: [PATCH 6.6 00/54] 6.6.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121719.714627278@linuxfoundation.org>
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <9b3274b6-5bc8-beee-a7cc-b445db310b18@w6rz.net>
Date: Sun, 29 Sep 2024 01:36:10 -0700
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
X-Exim-ID: 1supPY-003psM-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:43250
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGGus8j4Sx3OCk4jknvMwUf2sudqFup+pQ5JQg31ZZy5joZ7kmGU25vJWQEDwhZHYonEhOdhCdOs9UVFGayVFAYO3lgz/ZAq1PexNDTwgl8zvH2uBGZ/
 Zm7JGmuBTnDaI6LBq4ps8yqts1vgSsbM2cHmzbPfQ5LK1KbzDhdY4sGhS97tIkCONe54lWNCBdSiFQ==

On 9/27/24 5:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.53 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


