Return-Path: <stable+bounces-202765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C12CECC607D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 06:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589373016194
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 05:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5015CD74;
	Wed, 17 Dec 2025 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rWNzbmpJ"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0074A35
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948984; cv=none; b=rKa9ufh0PkOQ3np3bLXSWxmneDmJDzn6QnFQvGD4Qt/FSATbSMkUj+jtbPL2nV7emttFdXFAKM6CoClYyYx46EiJKea49FYUjlnd0NbPWfaFp0C+c77At5oC0ZwQooALG8k+/BOIk6aKbsuHh/Of9PiFP59LbwCBysdM12VOtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948984; c=relaxed/simple;
	bh=RmMt8lC+DNZb4qkpkFIN0JDM6NQA6YYoxZ0d9AQKUTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4o6qNiy4mj8X7a19JtHn2PbECyqsxKsnteddIGHC3ZJssGG5ikzrWx+RJv4LDBI9OqeOF2drxLORvmEnrPlu7d7DwUO3SSkLXBg30biX3fd5dALOkah5HY21Ni7mIneXxEm920iOP3sX0izEwShOZc6NUcWaIFxbq3FImM9Ix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rWNzbmpJ; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id ViEmv6sJgKXDJVk05voarJ; Wed, 17 Dec 2025 05:23:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Vk04v7kLdV6WMVk04vHc7D; Wed, 17 Dec 2025 05:23:01 +0000
X-Authority-Analysis: v=2.4 cv=E//Npbdl c=1 sm=1 tr=0 ts=69423e35
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=shKLvg-12WSsmoj5OQgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1ry79zZ0BMDyGjQ1Xu6bnHTLh4S250iNMTQH9bYZbMU=; b=rWNzbmpJ+E28R4vzrQJg15XsEQ
	tkTTcfLf8iwjbd7jctHf5H19bvl7wkeHkI4cH7xYAk4Cr1hAYU+XqVc5jxvTAqMdYvP+xPSAdMNam
	KKCbZICfdabptG/1Y3gs3IMONWlSw3P1pqu9zeeaVRd8HD754gbRiag/ZA4PqDSQ5tnhSSjgPTgcY
	ZwHA6o9XqvyGNFxiBJxxbNySPyeL9ZXsTvfHyC1scPm/xGsNeGfcPVXjxjHQgoeCd9NIWxmpp9lXS
	Tt8OWUh6/A/tYAlVTsA6tpw+uUjdbsv6aXYVxhbcafIceL5yFOtNAmO5miXXW0fDe+0RJyvLyQvcd
	U0qy/gmA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:42952 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vVjzk-00000000Aww-0PmN;
	Tue, 16 Dec 2025 22:22:40 -0700
Message-ID: <09e38999-a6b2-4330-9b70-731ba1d2b4bc@w6rz.net>
Date: Tue, 16 Dec 2025 21:22:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/354] 6.12.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251216111320.896758933@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
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
X-Exim-ID: 1vVjzk-00000000Aww-0PmN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:42952
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLAzfCIKMTWpwK1musUqTYSNUh/LQhzdMKQfQtaf8Q8RpXMFup/OUsQ+qClGoOI5/4Hi2h6qv/R0zcfC2xT/MzVDvBu5QEqfF4mQ9yVqtHBBKvfxmnRX
 RCV7ux74cVusu6cIXVA1PdNaHYBXsgPtgVgexnli9HIbjnXNW4mgL/aLKr+Uwbmqd5dxHppWYeTnvw==

On 12/16/25 03:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.63 release.
> There are 354 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.63-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


