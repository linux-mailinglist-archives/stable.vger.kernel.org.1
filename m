Return-Path: <stable+bounces-126927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C58A748EC
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065DC189FB6B
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7908D1E8340;
	Fri, 28 Mar 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="NU7i8rsx"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41E17A30B
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159929; cv=none; b=FUPKUg25eG257BnMy+7PTxmxGclvdB0luZPWj90gl9Pf8QQOxgF3wLIllEualOl1DDiV8QAIBE9nx0j9knh53Ai0lk6FYq+ndoGZPbpCk2vaXZGR+18xwP1mP6VItg+qn4JtbChQW9pgQ2e2Fn1sSQhJ+dMl11nnMCbkGJYuMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159929; c=relaxed/simple;
	bh=NQrNeWiAf76cBJGoCFsee3CqYz8eDCUEAXmnaztq5xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtuKn29SznY7C2bOMljh8lmal+w19h9YQ8xYHiaHOTEkB7tL/JTLj49jCe5BCzesgyC1XJ2DkjzhbtDdgIUTHGGm/eekazojYDJ9sAseLqrenlnUfcSCN1F4W/41fbvj7IZqCTBwk89rGnbMhaXdPUEuxikBpWPftDu0cv04Tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=NU7i8rsx; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id xnYCtqGZcWuHKy7WatI14M; Fri, 28 Mar 2025 11:05:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id y7WZtalDxoAm0y7WZtlDkE; Fri, 28 Mar 2025 11:05:19 +0000
X-Authority-Analysis: v=2.4 cv=A/FqPbWG c=1 sm=1 tr=0 ts=67e6826f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h4HWIJHnwFTQaRhgmudOOoUYyzborXBOUEpVM5YGe1M=; b=NU7i8rsxb4f+Ey2j31ewEl2bM8
	pAbfkQ5FmGGoVXweNos4k93lS61xZ/QZCyP2svqBG0omEN7J8ni4jkmurmdNQ4vjipkw7Uj+xfMpf
	jQgBP/oH9lmsS33PAkQD9jZn+ceQrzSKYvjyZmMf+haficQjflKOv69ZKLiQIdg3rjMK3GIZnhGVo
	7E1Cw+F02qI18mhNk0AxPW+PeIg+kccr/D8o3nciowzeFsvlo109/x0/CgyWU0RofkdaafT9qA98X
	3JjDL5hXiJID2vAJfWDKlHkojVlGYcl1gOkS8pjWmssstYdUVO74wjT5eDW+inmuXw4ehbqp+Skkp
	3xlo/5lg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39488 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1ty7WX-00000002Dld-0OsO;
	Fri, 28 Mar 2025 05:05:17 -0600
Message-ID: <e36e5cf2-8d4c-4577-a5d3-5dc9a1e1ed97@w6rz.net>
Date: Fri, 28 Mar 2025 04:05:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250328074420.301061796@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250328074420.301061796@linuxfoundation.org>
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
X-Exim-ID: 1ty7WX-00000002Dld-0OsO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:39488
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKlZn/Aa8MkmBrcmUHtwJL4bdffR3ko7mI1bxdEKPI3U2B9xj6HkhrB2R7JRhu3a3C7X2TzPVVRKLSEmmv240kyLoV6AT1s0Qo61DPkabEO5Uz32CnZ3
 0SEVNyVFHcdTQtE8+2pEOUK/6zls89jgg1UpJY7DfgWGAyCEM/UoIgXlVLANGrpuB9RDYB909TGibQ==

On 3/28/25 00:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 30 Mar 2025 07:43:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.132-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


