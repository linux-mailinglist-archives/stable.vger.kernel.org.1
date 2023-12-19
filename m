Return-Path: <stable+bounces-7896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBB818516
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED976B2285B
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D0E14A81;
	Tue, 19 Dec 2023 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="PZLwEv67"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A014297
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id FSc2rvO9EhqFdFX50rhxcG; Tue, 19 Dec 2023 10:12:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id FX4zr7D3W0xkrFX50rlTwN; Tue, 19 Dec 2023 10:12:02 +0000
X-Authority-Analysis: v=2.4 cv=N7U6qkxB c=1 sm=1 tr=0 ts=65816c72
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ek58/Dn/yOlYHhx/8tFxJz3CawUYMzo0ZHTISftznQ4=; b=PZLwEv67a52YclfUBV0Fmut43G
	L5mZZ+fw58wd0Yrgup485awPwCnb2n2Qsdim0zwMpeYXsBLdY2UCu23tx7DHSKk9+RNOevEJsxI43
	5TJe5ZsQEAowdfJ9QlR0OzJqN0zXvBHpNiNaXLQ8wuT4S+aqNuj+v6IQSUt7GES7fQssJrKEXe6wV
	LJ7K7xHxbITCI1hnZxetuhCiaeEfM8nSlYnp9h9Q9mahLex9tNj8Vg7Sv0DgpEEjvt8b39+4nJgDr
	+jUa/Vetpf3r/DsZnUYuj+ttLFR5Cha23aZyJl7tqN8c+6/pRJYErLCIVmHsqVf5mcvgrl7hG30RW
	0G8VmdGA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:60502 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rFX4x-003xcJ-1R;
	Tue, 19 Dec 2023 03:11:59 -0700
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20231218135104.927894164@linuxfoundation.org>
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <75c03579-ddd2-5e7f-7370-499f077a1dd5@w6rz.net>
Date: Tue, 19 Dec 2023 02:11:52 -0800
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rFX4x-003xcJ-1R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:60502
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG9kfXxRW+2nsq7B3PIJpiqk1g1DuSue1FyH68ghs+MvZUtSZH5rs+7cPS8Iv5Ysq/BJIKmiSyXrdxjSzgFg0Y5GIg14ZyJs4ugcXspXPGgqzITSLMY1
 mFj4X8T0I4W5WI5+tudeRg2tM73aJzHVTxdghHJAKiw3UGDuASbOsEt6yYUYAWm/H5ljLsn0GI3NTA==

On 12/18/23 5:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


