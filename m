Return-Path: <stable+bounces-60443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFAC933D9E
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 15:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A7B1F23EF9
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226321802AA;
	Wed, 17 Jul 2024 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="nW5nIvnc"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9B17FADC
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222996; cv=none; b=CAogmmBpJq4MvUMfjEU91TwpkplxI+Kxr3wiVx+Qns599BxggZAIg36RVzmqhV/+omWlllxTTNJhlgU31bUSyYwO223W91CVj04BUvhT3aXB27kuloezgqntDOS+AR9AEqMs8hTIKVz2vXkFe73FrtW17h5Ybx3I7v+SrFC/7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222996; c=relaxed/simple;
	bh=8N34VMZed3IPqdLffPwpjQZsdnL5jIluRrlTb+4i7+w=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=qi+jbnF2jcqozKKtagTrJ5JV3hVXf9/l6LWWVbX3wQAtsuuquRuM+0f1v4YkKSOABAr0H7pDiAG9S5PY7f4/UOI3LBVhyKZ9xiMBRAYH1aT/SZ2vlMyvlpgmFw5STK8JjvaRqQFfZd+Wz2pc4s1WcMR/UFQBZRs07HN1XkwjfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=nW5nIvnc; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id Tza0sGzf5g2lzU4hdsB7wT; Wed, 17 Jul 2024 13:28:18 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id U4hdsbL4VRn6WU4hdsP4Yy; Wed, 17 Jul 2024 13:28:17 +0000
X-Authority-Analysis: v=2.4 cv=KbTUsxYD c=1 sm=1 tr=0 ts=6697c6f1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pwNASrOVLQyx88vnRDBTR35iOZVBhzCkTrKHlNdU4JU=; b=nW5nIvnc5YAfhVvXBoLuJ41D15
	g8lptOKRNvCGzNkeE108PhkB6FqvoHkL7cbE0xhGPucN6SAyn+w9p1NCd5mwOICge45Nstik3h5oI
	an7ZCCY8ChbSTEd5pdS2o+3J2MXSu4ImMNo3XwuM2vNRHUIdBZo5H4of6J+ergA2YUBEksP9LHsiN
	vsBlHmF4jVZ2hCyGFB5WQJRg/e8fpCRVUWNOs9W1efeOGS5gFdZf2BfaohJxj4N1r3tZtyhuTrkJE
	nJbeHJThcCgxzyfNiiGjbNxmrD8uHaXf8gJZp4X5dnluE2MAPnM6UXGNdkup0E30XM0F4ByPH3hHo
	PxUEbMqg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57956 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sU4hb-000RQb-0Y;
	Wed, 17 Jul 2024 07:28:15 -0600
Subject: Re: [PATCH 6.9 000/142] 6.9.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240717063806.741977243@linuxfoundation.org>
In-Reply-To: <20240717063806.741977243@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <c5172c58-2874-4cb6-1575-74bf2550c08f@w6rz.net>
Date: Wed, 17 Jul 2024 06:28:12 -0700
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
X-Exim-ID: 1sU4hb-000RQb-0Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:57956
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDvIYrT6EEQVR/t+vLkvg/Wq+PGJ9lYh0Z2SscmDWzaYoFxtV0kzdAwTl/ujc8Ex5k/UxfBxR739A1rEFeCZbV594dwXGr4CRqPQmGsV88Ellb1y3B4O
 u3/+Okv9BI6tuXagRsfKCKtmHJ1+Ki/aBP6M1wnAmlQn1SAof1QQW+oQBf7qWFIwu+v4TTyzHAPPdQ==

On 7/16/24 11:40 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.10-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


