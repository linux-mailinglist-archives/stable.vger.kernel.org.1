Return-Path: <stable+bounces-144153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C23BAB5111
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51524A535E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69724502C;
	Tue, 13 May 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="bEisa3rH"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7D242927
	for <stable@vger.kernel.org>; Tue, 13 May 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130653; cv=none; b=OLplAs8l8JAFumfWjJskz1+g2JwkOBMJxQnk08UtRWZwI98Hoamjvf6wxfeJ458Qqfew82RYNu17tYUZm1eAlPMoqyI9ZCHhuSSe45x9U1NKi4smd71E2TfglUXKx1jmUzEOenx85Mfjar0iQl8JrFuqQQmZHUKZ1SGFT2kKlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130653; c=relaxed/simple;
	bh=IIpZ5lfhw0pOVldA08LdaSxH69X3tGjvb0komDGNPS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aO2IEdE2DPn5LhLkaNDKvhV38578QA5lGghpouhKY47mHgEH89IKxTDR54gwLTazPsdaNCGrYrAD3ccSCfq0trCUod3BU0YBUHFmaVpnZ6iT2hSyPfzHn5o3LzQ4cwcEg07XXs9hKpXt6Du71RJCL0TihTPe4QLakbDQjutL6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=bEisa3rH; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id EaipupDVAWuHKEmUWu9VyI; Tue, 13 May 2025 10:04:05 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id EmUWuqxNvPUhjEmUWuNFXh; Tue, 13 May 2025 10:04:04 +0000
X-Authority-Analysis: v=2.4 cv=KsRL23WN c=1 sm=1 tr=0 ts=68231914
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=57/Dn3UwCL986hqzQzEvM5a9oL+PnKM878ZIy7xd7jA=; b=bEisa3rH8VX1ynxwkZ0Nq7tDmk
	9rGV1qkwLFOE9FB+UhTqa2d/6fNiwvpS99XUZo94wBX0zzaJ34FoJQOCeDZYoH2cSX+zBELUBT2YJ
	MK5g3HrH9xOyQmeeHqkJMJOtbTY9t5HFDgn83ljveUYFRFIPHKxZndsB4Z2QXGHcyge/F/jsYEuw8
	RjLvvq+Ebllo3YoqIS22EeVOph7lgMwarmixl8Ea1mwwvgR/FL9fM9mcGk9dWy1PwPJCyb+oATYUC
	iGuVcSywT6Qw7RHuM+cl6eZ8BxTW8vSeS0vCTQlpNAACo4K2mRc9Z1BRRmEBXeaU4Pu9qrNOdGpp4
	JvlRnuxg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:54846 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uEmUU-00000003PIk-3xBm;
	Tue, 13 May 2025 04:04:02 -0600
Message-ID: <12a7e641-8672-405c-b609-472a7627a374@w6rz.net>
Date: Tue, 13 May 2025 03:04:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.139-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172023.126467649@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
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
X-Exim-ID: 1uEmUU-00000003PIk-3xBm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:54846
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEWKE0xNhWD5MccqyY6TN2L7oIeKBocn/U+ZxJZhSKAGJzBM0yCdCvkyZCAjLNsemr76Fd++FWdYOg6sCaKY2yEa7hRq4Vzl9qrnFAzoef59FmFMf4pR
 AchKiN+3GX/PFz9k5xLZZNuY4WstparAU34yt7t6axqP9pWMkyGrQNvO9RuhWBI6V3pwNtckcwxe1A==

On 5/12/25 10:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.139-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


