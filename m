Return-Path: <stable+bounces-91888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0369C13DC
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 03:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127B61F2346D
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C11117996;
	Fri,  8 Nov 2024 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="mMwR4Fgp"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093D23AD
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731031759; cv=none; b=Zq+kAZUTJQqy2MB5TTXi0yZ6fh/OoIpUL2z0lEM+0ZU8HYKn9bjHHRnmQgp+X7U4nxQ+4HM6LJy47kqOFLVICAbnPNSS30gol5Z+nvPIquTpGhiaKrGnXtzaJIsdtXuw7YLlcHuGjs4OzZbQHHaPeoNFni0sRPcG4eIND259Zzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731031759; c=relaxed/simple;
	bh=I84i66Xxwf/IacDgC84XOWnMKCmic4iuwv4weUi9Hv4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=loeMbD9dqh/0LSyUfQz9yvM290IlmfcOoFhzR4YmT6P0+0fryeb4RzKWkFMjS7wN7Sg1nhtV0fsc3e4b4sBd0ReXsP3t8fDBl1k860rbeLEQrPdq/MsUpiOBWMbTZcBJS4HndRpFnStQ/JtIJG0RIbu6EDdW92Fqv1T1hRg/Uso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=mMwR4Fgp; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id 9B1wtLbffumtX9ER1tRFMt; Fri, 08 Nov 2024 02:09:15 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 9ER0tDkdVl9Qc9ER1tQZfP; Fri, 08 Nov 2024 02:09:15 +0000
X-Authority-Analysis: v=2.4 cv=TpLghiXh c=1 sm=1 tr=0 ts=672d72cb
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CvRpyJ_MCFv3iDE1wTgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QP6ZiI+V8u+00WCFK2yKqoR4E4JF50VOfCgpa2dTl6s=; b=mMwR4FgpkEYWTApT5CI4lbiOwF
	vZ6REyRVau4cAYydz1XcGeTZGnduQ4HLgPek49hBkLbs28vL+w8n+o19cFqYxeUySO1qTbec1T9SN
	IblY3IHoBs0x1c0N9B4AIhBjnn+NpTgXXmDu6rDFq5A5uBGYL88bMRwPdzMU7PC8rQ7SIdYR113gO
	gT5s8bpbZYWafAuyx+Cq6+/Y4Qc+q7Y4AYMGqAGcGRftqwSJPvcaxnXgTGmPZSRU3HryhCXMkh8vu
	VHad42sZa0cDKQ12L/MxawRx/LgynLSM4mg5QANVehmm2YuRgbsEG6EtgCAvqzcEx/uZx3Sd/qhda
	ANfmStMQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35490 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t9EQy-001Pt3-1H;
	Thu, 07 Nov 2024 19:09:12 -0700
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
References: <20241107064547.006019150@linuxfoundation.org>
In-Reply-To: <20241107064547.006019150@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <95db0e6f-b7db-269a-4f65-96c52a6a90b4@w6rz.net>
Date: Thu, 7 Nov 2024 18:09:09 -0800
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
X-Exim-ID: 1t9EQy-001Pt3-1H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:35490
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL5TohD5B6XrLfhCJvXkJEIYxRNdrTja3s6BxJRr4r/ZABOsxtibSECz64BtDVieOOFbcNiBx+LtTzd9FZAnhV8hDls2DK3TrS3Kx8ZGxIQWpiGtHy2c
 b71AvSJWtvIUqACZbaXCBDCmtpky6di/sgQnCkGtlgPClOF2vg0tFApVeKT392sNQJVkdnPx3NnEpw==

On 11/6/24 10:47 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 249 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 09 Nov 2024 06:45:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


