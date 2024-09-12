Return-Path: <stable+bounces-75922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CCB975E04
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723222858CE
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 00:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF31C36;
	Thu, 12 Sep 2024 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="G0A9MBNf"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BFE1D6AA
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726101293; cv=none; b=NLWXgpLSIA9hJzRLBXBlvQda9RH6H3BqabA4hDjMr2fhlcVPCaKsbDLxk1Uq6WqNHyfu0+an83cU0KpB9N5IpzbJy1FgTN3ztFQ8o78g45byFQvb4yhOW47/VV/I8qm2vPGjIoc7mKs0uGOdvjZMvtcElBZwE+jj7sO8oZYHrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726101293; c=relaxed/simple;
	bh=XfUOfMV5igzSU5sun/scqEAqRQy+RsiSxYiFuj8SKSI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=rwP/gtH2a+PNIB1LL0lV6dJCD/GPfI2o/oJGuVIV05f9NCwuUDFMMaZMuFHsjy9AVayxhQhQhlJOVYugM4gPB4yaAdr3LbFk/cFf6F5DjFP0ksvd8LVn0ihOnL9WDKLxUvYz+EnrIDTkQ6+e/W0NHO7CwWfG6tO5NQfoJcb91Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=G0A9MBNf; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id oL4us6qglumtXoXnOsObre; Thu, 12 Sep 2024 00:34:50 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id oXnOs1o9CmqhioXnOsLhhe; Thu, 12 Sep 2024 00:34:50 +0000
X-Authority-Analysis: v=2.4 cv=NdEt1HD4 c=1 sm=1 tr=0 ts=66e2372a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=YArTxWWgIjO1YVvZgRQA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cYvbNQI+gpCYqzJpgX7nuTA/hukRC+DHzSBUzBcEdYQ=; b=G0A9MBNf4fdYDTrE5swOuV181J
	Kv5IQSjMWb8d2cuu/oPwrebCq3j35WxDx2AqfXY0x/z2OpMP3nqCVQjltSvZKuyOYgvmFmEAm50lu
	LLwk7/xy8XNitOL0RAlfACgpNZHQLaCw9tOMCHZJQq2yfSfOqj4akqIYcO2k6yzYjL88PyRBl2wYz
	qTqtQJVuXjjzQF2zLBFicuHJXSa6Ye0C2itv/tL778va8NU7DpLWGN2Tg9ajOA0YY68EFmMb+RmRF
	h3uctcHdZ4V8y4HsM+6rjOSdzGQ0qNOELHcwEpimUQUjCtya6Nj+pJd7zsWiTa9tY3pyJJZWiULfv
	hVcqx37Q==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39894 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1soXnL-0035UP-33;
	Wed, 11 Sep 2024 18:34:47 -0600
Subject: Re: [PATCH 5.15 000/212] 5.15.167-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240911130535.165892968@linuxfoundation.org>
In-Reply-To: <20240911130535.165892968@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <bf463a26-4bcb-2709-fb06-cece37b09688@w6rz.net>
Date: Wed, 11 Sep 2024 17:34:45 -0700
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
X-Exim-ID: 1soXnL-0035UP-33
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:39894
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPRw4DJ7aGsvX40j8TdId8SfCwZum1UOc8hIKdCsrc83dTz106c0ESFvB2GiWVI/qIIPySkr29WxX9pt2j7GGB8jih8IOqbhH4gIlNP3kc7z1rciMt+p
 aT4MEkhBx9QsV/V9W3Pv9xyyfyCzBfQxMwLNJ8Xp99RUqm79PhG0z1Xzb4iFywqUcXBb7PjCq1mHeQ==

On 9/11/24 6:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Sep 2024 13:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.167-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


