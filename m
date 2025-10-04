Return-Path: <stable+bounces-183385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD0BB91FB
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 23:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B5918992C0
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 21:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C1D27A444;
	Sat,  4 Oct 2025 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="t6lTLZMB"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92604223DE5
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759612307; cv=none; b=FWbRkYULnZsC63Ji0EfpTnV3a1917rdKXfelshjTwyFKPkAgohyIWhf6uAciG8Rty+muZilA31bf1Wbc4PN/VPRqrHL3e1Q0lxXboVi6VTOZGMxL0OCKGfGgtL7u7V9u0oTNVBQmbJx3mbESdHgrnVSuEdPRu8Nll1zAbrM8jq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759612307; c=relaxed/simple;
	bh=8xdhFsItQ0U2tYROnaMCOHxanXUQgL2CLXiRIQQkiOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7gDqqB18tHvCDbal6bFIR1Vr9Qf2i3Gy+W7R3wjQ6PaNH4+Nwk7H5+IUr6GVrMIBAWAbXcmFux986u0wMyB0UfA3Mi7oBwdfIVFi8aB+Y2vR4myuhJXFOgX1riG3Cc7HNOqLMU20nSQ6H8LlDtC5YL2L/VQ1RUBNT1vT4NORp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=t6lTLZMB; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id 4xBVvfnXeKXDJ59XcvKtnC; Sat, 04 Oct 2025 21:11:44 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 59XbvhLmxMem559XcvJlaq; Sat, 04 Oct 2025 21:11:44 +0000
X-Authority-Analysis: v=2.4 cv=bZtrUPPB c=1 sm=1 tr=0 ts=68e18d90
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V69s+psccbVPjTVCvylqlbTUuMfJKlsD2LVf5RTBIxQ=; b=t6lTLZMBVApxforEGZB1iMm6Lt
	9B9py77ZUU+WUWtCzT8C71KfTYOMqyIGpZEB+oxEJHyHGJ0zuOQ7TyjUkgTm/mcg5PLoowchGLRXe
	YjjqXJhSTwAUWH7Soq3fPrxteaHASC27QzrQ1zY7+umI9KRmDC44zKGrzRNQL6QcdL2MwmechReRX
	oJuU/UPgSwEsOPE1HrzRWgLdKuUcnKG0YBqTQs3LzE2OzAc0YrMIAU6H/TkVXCP5avMpRPZG3Mtqa
	0SrjTrCEwaZL0lR5W2Xh3abk2hp9eRj6mf+NM5nQiih8C9w9r1BADVo/ICwgiWG8URbSf0gn8irNG
	gb0hpGoQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:52342 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v59Xa-00000003mTf-3hL3;
	Sat, 04 Oct 2025 15:11:42 -0600
Message-ID: <348a7f0f-7fd0-4ef3-8a77-ed19d8ddd0f2@w6rz.net>
Date: Sat, 4 Oct 2025 14:11:40 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160352.713189598@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>
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
X-Exim-ID: 1v59Xa-00000003mTf-3hL3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:52342
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEMjui8M/lnY47CZxI+y8VTTOBEZQL00k9BeZrlcDRSIuZPy8tBeKLhWxmU+1DfYxkL1R2EpVXej/Km0687RBUzaRT0PHTf/lAajNZl+cbTY2YOOS10c
 u3OMOEsVcav1IIduLTL06iYBI3fjyOi6FGVM2DXYBKHhG8ikN7fWK00r2dfMldN9ck3TR/lmZ74+/w==

On 10/3/25 09:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


