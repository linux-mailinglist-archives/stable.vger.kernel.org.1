Return-Path: <stable+bounces-73814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F054A96FDF0
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 00:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61563B231DF
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B7158DC3;
	Fri,  6 Sep 2024 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="st26PKPQ"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BED1B85DD
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661592; cv=none; b=ECrUUfozzUU1AnsyPFlf/F+8WQ5s/P/uE2VkcXeYF0xSpOhX+lMsvwDr3spnPxs9eO6XElRe0JX5bkt7/oBczd9a3/9pRdqsC/ZxvJREpz6dA7UQacR0uMQTJx91H1iFe3pgYe8mtEVk3SzG0a9UvI7h0zwXAnOBbA5H2mNBtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661592; c=relaxed/simple;
	bh=/oC/PdmaMO0XTDaTc9XRcNhxKrKgGWF5lBU1jPHVJEI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=tQxj2vqyP97+hnUsLqX/h24Md+meh1MNxtnbUWtk5VbFVrzmL1VLTHB0Hf6Dkvg1+7GV3+G/mYmhAdED4mFzc5WkcjR4F1OnOuvle2PBzXWka+ofk665Vg8q1/Gai1lnnWYdVPP0WiAMLXI3GxDN3M2+5x6hlV1lFLGMN9++Bi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=st26PKPQ; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id mY6GsHdmNnNFGmhPLs0ANY; Fri, 06 Sep 2024 22:26:23 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mhPKsdV7ERBkMmhPKsNQrv; Fri, 06 Sep 2024 22:26:22 +0000
X-Authority-Analysis: v=2.4 cv=CbPD56rl c=1 sm=1 tr=0 ts=66db818e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=hpZDtsuf1nd3zmBzg9YA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WJ6fgwvFf5OvkxM+l74L0+Ur2TRA1H+p4jVkkHF3pkk=; b=st26PKPQYltGjcitUhQfgxGOkv
	Or2oGgyIHqKutH9/fsXk7xELRzQql1m7jt0AIrnovtCiH423kQY+arPQicjZNJJA/7tb/aaV+xBvK
	DnMXQgB9OtX0bLRR2OaIEKwF5rb8KndhEx8wMe++ufYo4R1+7c00jFgtUKJPPaOT47+Sl2DGlcn/1
	hrqAomU+eEHaFnlF9BLzxl/jOXi4XcTUslHKGWw/i0CAGPQA0oychuvtLx5RN7wwZQIk3DMlFMdLH
	Avg7W//5OJgZbxeNgmNaw+Z52W8Yvf6+xKSO4amoREvbgo0G0IPcudwlofEQeU5s9gnAs3z1OCvgJ
	+s06FoMQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38798 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1smhPI-000Yiw-0N;
	Fri, 06 Sep 2024 16:26:20 -0600
Subject: Re: [PATCH 6.6 000/131] 6.6.50-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240905163540.863769972@linuxfoundation.org>
In-Reply-To: <20240905163540.863769972@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <1b1e5c7e-6045-5913-f23d-752ce0b4f7c1@w6rz.net>
Date: Fri, 6 Sep 2024 15:26:17 -0700
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
X-Exim-ID: 1smhPI-000Yiw-0N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:38798
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH85GaJvsDPofNI+Er1qhrFGb1K715q/fzy+3beS4tFZx5UxILsBE8r1YRNs+ZvgGZAUAyd3Y14PmQLvuBQuvwUImwq57ruroqFnOi5ayN87YvhjLAKT
 uG4jds/87Rr6ZjC9QFXeJXJESIcfqTrhhkVBp11tw3MLCm54j7oLD3na0VIbFbWqdP3IxZwZ0xIzAw==

On 9/5/24 9:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.50 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 16:35:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.50-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


