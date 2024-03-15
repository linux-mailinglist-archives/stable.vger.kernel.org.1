Return-Path: <stable+bounces-28221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759987C6EF
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 02:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C738B21F1D
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0310F7;
	Fri, 15 Mar 2024 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="npWq4onb"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC96FB1
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464762; cv=none; b=sBF+e3kjcFN7PbsYrhy+1+BICn5WwTTWTVSr9sAgf/udTQE+CArIDl96gaUmHFA5zEZjgrLomHpfkMMbiEnwHVkBYIwdXbkMzTn0pUQTpPYSgdR/Fs+xKJc2d0KcpWEouriX7qNRgp8J5ohU8yd23liaXYrlyMHmw/zHWSSORI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464762; c=relaxed/simple;
	bh=X/ZyG0aTHgaF46xsq3TWe49VpLqiKQo0/7ojJDuiYbQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=jZSPmbOpbNj6MwYBhR9+hg9zmUU2vcld4DZDYkDeMY1bDshcrxPlQ9qExKGI1vorVRMce32ukqjD0YWCo7pBYI3SmoOxhnvdb3ObVL1Do6bwOu+yM8T5i/P9hdRyxG47UsisvEUlDEbLzBEkpO/1I9tyI6NUVP6IstFiAGqnlYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=npWq4onb; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id kvgorpebvQr4SkvzirWs2s; Fri, 15 Mar 2024 01:04:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id kvzhrkFQM585gkvzirvm6m; Fri, 15 Mar 2024 01:04:22 +0000
X-Authority-Analysis: v=2.4 cv=d6bzywjE c=1 sm=1 tr=0 ts=65f39e96
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fgzz3YHIOOb4mvquEeWZhyzOq+Bfy/+Qp273CxCSJKo=; b=npWq4onb17h3/jlXmSSSbF126P
	gQRNXao1si/AoQUZUmrjs9iWVT1fzKIAAuICKxWMtH6qLARS63v6dXCszE9ZsTrqCHufG0YooAu0i
	luM9Whmk3PAZQNcRfl1r/lh9GpKA5VPd5x8CSsyO+W5wYIQioc95PjhfoczYJtWh0zGYLnwAsivlc
	VZFZs1HeEdkiGbyzXQ9lnBphvu4J2hMoHLTF7huhTHP4blULpJopD3YQYP1l5CIh/uftngfod313Q
	4/1yGPHII7opsLnlG5gH/sd1a2FaTV0G9sZTNfFQ1Qy+hbMEp/66UWDbMTwZRTGOyXGW3akSJlCK+
	cQmECvPQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:51114 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rkvzh-003VVH-0O;
	Thu, 14 Mar 2024 19:04:21 -0600
Subject: Re: [PATCH 6.7 00/61] 6.7.10-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313163236.613880-1-sashal@kernel.org>
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <db6e3a90-a4e8-5332-c1a2-7dbd869a8c79@w6rz.net>
Date: Thu, 14 Mar 2024 18:04:19 -0700
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
X-Exim-ID: 1rkvzh-003VVH-0O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:51114
X-Source-Auth: re@w6rz.net
X-Email-Count: 3
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHBDHZJS3d4SgXbldsW/li3I4EyOODD6mECn09myyGp9ixVG+V4KD3wfDUFWBuF60aWMM2dvGrj6kzL5UXQAM5Ts838DI+vEUo1QIZPwum/YJxGRv7eG
 r2h3zb0DQJWmFxztvrE7YasUIyXk0A6mlOYcfx5OP5xhY1CJVbvF8KfhHdmsh8JlAzvSAx36jBwubQ==

On 3/13/24 9:31 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.7.10 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:32:27 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.9
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


