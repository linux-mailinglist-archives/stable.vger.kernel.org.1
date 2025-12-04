Return-Path: <stable+bounces-199992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040DCA3392
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B8E305E35A
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED041331A46;
	Thu,  4 Dec 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="3ulW9f+P"
X-Original-To: stable@vger.kernel.org
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210B307AD9
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844040; cv=none; b=hma1kPNyK2D+VnYh2mj7Z39lhVvPcJr57mfuYCEDS6LY/nYjQrXKapmP7rcoKigD7j4Kk5WOjlkG2q3GxDSOgpkZIcXjs5F/nOEmPKgbGJpfbgmFF45jJO/8WGrQfXrq+LN6R+3Cdy2BSRcH9zDJOGgaMV5G/tGDMuV3mz9eGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844040; c=relaxed/simple;
	bh=r+6AWt77fcDf6gqoDqDOFOrjB7sihLKMHX8TUNUIZlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALhlyQ8WhwksdA7mungZNHOu29wcqpB5r5Hix9lrTK34QjFNPWea7i8qHyi4BnIzGnpTGPHUFt+9Obvt/pfk7K+pLYoRCGePc/UHieH3cGEp8bncIFq89kyEKSvN6jB2yq4dMr35eHOh2c0dJPlvgUSnliZWMarVI43le258gwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=3ulW9f+P; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id R5xBvmkK4qgL9R6YJvS4m9; Thu, 04 Dec 2025 10:27:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id R6YIvrH2cOs9RR6YJvDsHS; Thu, 04 Dec 2025 10:27:11 +0000
X-Authority-Analysis: v=2.4 cv=HPPDFptv c=1 sm=1 tr=0 ts=693161ff
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J0gk378wmRlM6jpbPcKmXR3sdiw8XWzMuTan+A06LyY=; b=3ulW9f+PHE6iasf5DLvMDxjmli
	lHBbcw5XtOyB3qNUH/oxzs8DNrSA8GYP8hqK1HfclQwbtM7PhnnekvjeCUSK4sAZI+vI5u2+A7XtU
	XWg1shAqqFalPfoG7fdz3ZXcJV0poWoGer0pAD1tmGLdhKXlDay3ejWW5GzVQU4OjZviIS8xTuICt
	5GTQCfVBZgh9/BAfU5HRj90Ae+qlw+1bFfZcIce6zz/htoN8QRTtnjtVTZbV7h/kURRaB5Zu/EoF5
	joqpq9U3XVgB6CHJ9LoxBIiixmjKjHdu0nfn8NhkX71EkEA8NIuvMSYNUvHBqmOzWuXkqMn2zgO6A
	2ik6Wqqg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:36244 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vR6YI-00000001Tar-1u9M;
	Thu, 04 Dec 2025 03:27:10 -0700
Message-ID: <c04a92b1-75d5-4fba-91e1-ecf27cae6c44@w6rz.net>
Date: Thu, 4 Dec 2025 02:27:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251203152346.456176474@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
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
X-Exim-ID: 1vR6YI-00000001Tar-1u9M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:36244
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFSDXbNJ8HhxU62i4VtdgJZ9oxfUD5TVeVxKQN8VT7H5la/icJ4wgXWI3QoCViMZn9/xjVZAWQJ6rasYQsXBL7qrV2Duzzd4ehxWzUyzPr23souRmkIx
 /IcHxTLzo/2U/rXjPPGUmKJTIICfxvQSYeWdLXshxTE6qMUmCja0w3ywW/pNjRhgjAEs/sArenWX+g==

On 12/3/25 07:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.11 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


