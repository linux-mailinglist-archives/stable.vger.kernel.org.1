Return-Path: <stable+bounces-111815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F030A23E8D
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7B0161EAB
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3377C1C5D5A;
	Fri, 31 Jan 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Bvcegygv"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646B1C5486
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330884; cv=none; b=lB1XJ1TvY3JedRkvPZ+dSRc1FxtUeCR5cbMZZuFUzABIIvbTmSYb75tSQfhFrFiB9dMXB7HsO1inC8QzDlkNn6BfT5XzW8USv/03IWLTBIRIktOuBuAr3hGZ0WWdvoGBAGUBZkXaEb+dqKvCBlR7Zs+KHP8NAJOrI11zo0jqoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330884; c=relaxed/simple;
	bh=ocByIrvPvPiznh+3UoEMt+a0DRHY7iLkhPgjk/zAa1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J70nOYtPexNDo4C6JBcX0CdUXoh1T9OSLNCi22tRc40Vmxvh9kZ6bHZojRSlW9Zgd4aNoBy6mcA6y06z8xK3f9jeG1mTc5VP86ZJlC7ieyG29ZtPgx+PMCbrxgM67Yj7saQJ5b3bPikSO08dweo41uEY4pT79VZF0/lKCAlHSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Bvcegygv; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id dlR2tkMTv1T3hdrFJte2OW; Fri, 31 Jan 2025 13:39:45 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id drFItSJRAs1xhdrFItaN1P; Fri, 31 Jan 2025 13:39:44 +0000
X-Authority-Analysis: v=2.4 cv=G5kaEck5 c=1 sm=1 tr=0 ts=679cd2a0
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=JFz5sLme7EOQrv7eGfQA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=48JnqtXpYh3jPntJtpsJ0wyjkcS58NHjuI70m2I5qMM=; b=BvcegygvxCeVCJ9x4Q1sMOouM1
	KalJxFTN9UOrCFcbE2+XtzwCaI8K+S6y0bt6ysZYmXnOnCz9+4JTACVwaWD1SUR7v/aFE9lpuUGpq
	/hSZphisHFXMzEJJff0Kq3Svtu5w8eoSIwXin4oFX5gGiWNNEZ6vIJFCSSvS0oCP5psQ2QCHS/Y5A
	4i+f+EShpKp7KhC0noOOFjuX6KOcB9r+4o08rtpXkwQWuE70RvPJNvOfPntfm/3u3Wg6ETqa3RV9w
	Z4RYERKuaeH5mCtKSQeXVdKCaxkvcBrT2USiC14/uXBZAZ20mrRgFIWT0z3NpnQgGFALLQD6u2/T1
	Ho+A3D2A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:34732 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tdrFH-000zXC-0K;
	Fri, 31 Jan 2025 06:39:43 -0700
Message-ID: <95de5a81-3d33-4bdb-aa09-c27924791d49@w6rz.net>
Date: Fri, 31 Jan 2025 05:39:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130133456.914329400@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>
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
X-Exim-ID: 1tdrFH-000zXC-0K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:34732
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP+7yXbUpG7MV1gabCeqsOlloHczLe9HtcbDpOoMQgScRzQZQXqZYmdvTF7m5pq7t9f5SG7+jwmbvKBxavPQhV76kT3KF63o4oxZCwp7+KhKd2gzvzeO
 SasNhk5NeHMNGcPmFU3ZMI+PN+E0rgnSK7sLSqzXur5EEweHpm/7MUhNAPkSzkjGIhNcvEJcblJepA==

On 1/30/25 05:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


