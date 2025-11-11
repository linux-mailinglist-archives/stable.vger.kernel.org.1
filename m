Return-Path: <stable+bounces-194478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7224AC4E1AC
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E70B344803
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C972C32C938;
	Tue, 11 Nov 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="eMH7JEr8"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AFA2BE03B
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867695; cv=none; b=Vd0CElGFVF3VxxNGP/5rb0eex1fwhUgcN5q5zFEeMPnaNGnbs+HetNpVsAJyZq5GoFTzbIIYlx81M9DBzRUqW5JrNOu8a1ztvlOHxwn2iZ9mpUtVodif5A7mpyYX7F0mbpGLjVNczuusnuhb5g9V+n9atuWw6pfjr1aFwfsLaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867695; c=relaxed/simple;
	bh=c7hoMpsZ/baVmjPyu5d2MW13scjJuNdlGhc8XNhuo2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mme4tmV9QzrQJ0+qHPRopwwsuJPX+vOhBU0tfsOuOWChIa/tEKXILzj11uEAoZogJprwLdWmQ3KjxmlBQTunM5eLcrcfw8c7wfuJZ8rKkjzJohD9l6L/wpZLYHQT8HqMpqRfuQGiSx1QAtAd5Lt4JmU0+1Zvcg6ixaJqtPA6r6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=eMH7JEr8; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id IiBcvHL4hVCBNIoPsvvXQi; Tue, 11 Nov 2025 13:28:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id IoPrvu0PRuWNOIoPsv6a0x; Tue, 11 Nov 2025 13:28:12 +0000
X-Authority-Analysis: v=2.4 cv=N+gpF39B c=1 sm=1 tr=0 ts=691339ec
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=PvfcHcKs8vLJRUA1CEIA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1nc8SKrnLXmD//D0Rk4ZCLqJKHJMABP0TbWA7r0yOH0=; b=eMH7JEr8ETFiBRX7p6jcZwOC8O
	fYli8+6MWQs/50JgiHfAXsXSKWSdLNsnMzRtUlpsPwh1yl4+lPdRWr9Jam328enF53Sdvixd0CIo/
	fcB80SLfz53/NU3RRu/7nPrCk+GK0nx/nockKda6mkbZw4f2Ykvsbjy6PIFmse34zbJCrgxk5u1SC
	qcQelPi0ca/FmUQwGOTccFwCUoNd2QYBLXTXeLrkjEYRaBU+4ormNnZgMaChbKU44BQI+iyhkDDkB
	qgHO8YMAqGTaqkAH6I7OrwxlzbVpf7EYK9/Xj6Jh+nMY1lylQGja4OGAgB5W6n3/p3W9o6si/n33i
	5G5YvpAA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:36292 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vIoPr-00000002Ewj-14oO;
	Tue, 11 Nov 2025 06:28:11 -0700
Message-ID: <e3b75b12-5306-4515-bf9b-f3605a11bec4@w6rz.net>
Date: Tue, 11 Nov 2025 05:28:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251111004536.460310036@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
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
X-Exim-ID: 1vIoPr-00000002Ewj-14oO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:36292
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD8q8YhCcAJAGwGnqdQzX4iIE8KPFwCyhG11TgxaUxOuU8qhAgDyxhUcXaBbOWm4aYFLg2/83qG/kFjchP0o6DKRJJOkYczZW4zi3Msxr/R35DRwwD//
 TUJD2i3GBewGRhTUe1W6VsEsQdSNgcYhJKBIQhzQpLsn3Bi7/v20Xvzz9VTF4q3r6W71v/s7J9OhTA==

On 11/10/25 16:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


