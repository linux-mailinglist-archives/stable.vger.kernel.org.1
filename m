Return-Path: <stable+bounces-71437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01A2962F9F
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 20:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5491C219BB
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 18:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938301AAE1F;
	Wed, 28 Aug 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ptki9936"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35785149C54
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869014; cv=none; b=a5mGDZ+9rJ+b8QRcgBf9mFtBhXmMGTkSCDTzWHopZc26759EXa5lvz6LxLMWvtEXnlYzMKqGlaAt2qui18LzMG3NsjdyE+Xau9+zagAl4NyN4O2sDrS/Rn1x3FlIwodtJjGDgj5mTYQh47taj6J48HFIUiHevrW4YNZ0NgOzeFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869014; c=relaxed/simple;
	bh=jhwB4jvLa98ab1yJS3Y/fvpdWNZHbszKjImSUE+xsLQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=D2UGro5ZAXIi3IkcuMzherW5bHe3xsXDIr8mxbtcKXf3Yrb2oLGvo4xizCjbt/NaVJRX9OFPsoE6dUytmXOl+AfXH6wa+EAWZMM6jJ0qfTXGo7R+ZDV423jaUUSU28gxAqPBCOybyx69649BMmANZ+dFNWcqHbumzFU+L0Zb/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ptki9936; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id jJKMs7lqY1zuHjNDvs2X5Z; Wed, 28 Aug 2024 18:16:51 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id jNDusFJ8ZzIkAjNDusPknk; Wed, 28 Aug 2024 18:16:51 +0000
X-Authority-Analysis: v=2.4 cv=fP0/34ae c=1 sm=1 tr=0 ts=66cf6993
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=pvbMRhK_gA1k-AccEgoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1JEqY8sjFsJlOEnaBDSBNyiVABiyV0rZ0bUhu1d/8JY=; b=ptki9936QP45Q01m/QlrYsZY/H
	WIW8wsU77pGr/Y5GHrS2bVfOUUxCijL8tq1NpBV1rZchZY2QSdbgB6CjOkRkHoq+ftnSNHbG0xtFC
	QJgJQgJD+n+01eptvgZq9ReaHAiL9O5c+EpHXCLiupYr2cDQzHsjNNSOvqkUGjRUS8kwNWZx2FM44
	qQJNy+qikNRlKL/eEZ/Z9kjUga98eJQyuIeUuZeOdEEvL2rhkMd84qT2+oEqvk0HBZ2LKcO2+04PU
	XP3n/equodxlvdDo5pf007pnlALmmGhNVnKoVkvtZDj8Mel9Zon01XPspBc9NZHpfGO7HfocPnsy5
	wbExsqFg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37098 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sjNDq-001IAf-04;
	Wed, 28 Aug 2024 12:16:46 -0600
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143843.399359062@linuxfoundation.org>
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <e4891588-6098-27ab-15f1-fcb3f46c0267@w6rz.net>
Date: Wed, 28 Aug 2024 11:16:40 -0700
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
X-Exim-ID: 1sjNDq-001IAf-04
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:37098
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNqcO/c4S4l4ehreQ0LdMb0IQRUIJ8WXpm0yomIA7zG7W3uBxq287IBwjmHPD80KNRDlEpYtxAKDHyhmpKfqoaVslpF8YW1ovTWvdhCZga/Q31oa6rmg
 Co1FY/+yyJs6Mk5wZGNVNpgPWVewxs18DlBvMTpI0dxLy8rRmaCr/KLa0ExBAqqNGkH/OVYVs8Blhg==

On 8/27/24 7:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.48-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


