Return-Path: <stable+bounces-180522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9CB84B75
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A0F1C26994
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5C3054F2;
	Thu, 18 Sep 2025 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="EYf+ja/m"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5A304969
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200370; cv=none; b=HCv4gInuj5aWTGYFnot163yZ7Ip4h393/VgjIo8PtV+CDYCfNHO/+csw0Us83ob8TiZF1A9PmMrlsddpG9v4Rg5LAt5bV9zMxmi14aV35vD/OEQvhBBCurClAwNnyD76ySadWgj8+omhYPxY+bIpFNY9aB46oUVou85VZTYxjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200370; c=relaxed/simple;
	bh=CbZ6gYEJxW7XWC59yzH9WJlgV3s7R6FDbk4UYbi5ssU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoZJCR8/Wy9G6PIaz1FjKZbGo9J7/28IzEPfp2ImP6Za4rxiBnZrHsTqKOpv8g3cIXspqy/EJzsrHJ1cX8WmwUVqqmUzlgxxU84pdk1izjlahiNKyka1e4U86ZvEYe3KuDTBM64BPfPYCkdnCj8U3ewS9XSqi/QQWqtTLuekUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=EYf+ja/m; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id zD2DuKm2kv724zEEQufeoS; Thu, 18 Sep 2025 12:59:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id zEEPuyZ9p3MZFzEEPupnlF; Thu, 18 Sep 2025 12:59:25 +0000
X-Authority-Analysis: v=2.4 cv=BuqdwZX5 c=1 sm=1 tr=0 ts=68cc022d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S5I6IyoDQDCI//OVfcJNsw+DY9YlafQQ2nkm67LEAkU=; b=EYf+ja/mzrvxnjKdRVEAvFT3Xt
	yQ3sJeyRsVZONcSpPUXAPhSlyCRelxwTxMLJn0DMgisqA09ApxO96Q9e/seTmEvUjn+WNpTK2B1HR
	1fRmHSuTIjR9ZsZKJeYryjCHWyKLeIsJQIMT3+CeuRAp/wotasw5IvScEYbutb4+UNgijgpOel3bv
	b0RRYGACPgx/kFWVrzzjQNHV3Wu5oDLjfTSfe6Cx7JEkbwEfUE0Jyz/iYhNnSsF/TKxWDzqF4FVeR
	SZEPqcmSk/x7XV485uJmieEMNEFukPGRx+S71/ucV59f7V7CjZzK6jAiLjZIFw/qnDE+rr+96Rjyz
	msz0M/LA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:41152 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uzEEO-00000004GWu-2dF5;
	Thu, 18 Sep 2025 06:59:24 -0600
Message-ID: <5f3f06b0-c6e8-4c0c-9187-8a436c67d36b@w6rz.net>
Date: Thu, 18 Sep 2025 05:59:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/101] 6.6.107-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123336.863698492@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
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
X-Exim-ID: 1uzEEO-00000004GWu-2dF5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:41152
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBHV4Jx10k05YGToWWPv1i0XkBWtiWatG4acvMmMrFP5XVT/occe83/9Tibp4bUX82S2ELYJvFLHpNFeNfU/zcAO388CSOKL1ez2BebT9u0p4v9b26BW
 6J+dDjorC+ksunEayetUVeqUA21UFyklOEYgFCFzD16Ht1P58epyBpgfhtw/NYbcJjpjt1oEieC2YQ==

On 9/17/25 05:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.107 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.107-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


