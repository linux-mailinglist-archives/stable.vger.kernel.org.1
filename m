Return-Path: <stable+bounces-32304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF888BE4A
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 10:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0863D1C2CB32
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABB073505;
	Tue, 26 Mar 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="XH1Mb8Xf"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52F71758
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446288; cv=none; b=u80uQt5uy5OhWhfTShzr5blTZ6vUZLESsoNCus0ulhR5eVlhhIAxUZt+Ijcsd1EvrUq+ADKGoPSNNTCBzJZuP82YhsnJXvS3Sua12YfZeNm0zZ9y/DQujGCIkJHU95K08pv0B1df1YMQ5Qexk5avUQUZztCBZ5V536+vJ0Nwdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446288; c=relaxed/simple;
	bh=bM7N53HW9cHbe50fwGGMC411UGj2Ub64m/xb2/CvoaU=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=XEstk5/dExy6GSXTaNFV1e+uU0JbRp54xxmK3udXnm6+k32b88Nrhn4Jc5idMzloO8EP7lNs5rCpwXyBHc4+TjqCmyswG5S7AcsngcaI552RVZBHBC6Td+E1cteo8HYiR1uDhdXUhRWKNCPnoWn1zXqeqsUTUOJlyiAxd696kfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=XH1Mb8Xf; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id omuFrLif2PM1hp3MKrds0F; Tue, 26 Mar 2024 09:44:44 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id p3MJrKMlNVdenp3MKrU31Z; Tue, 26 Mar 2024 09:44:44 +0000
X-Authority-Analysis: v=2.4 cv=M4FLKTws c=1 sm=1 tr=0 ts=6602990c
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
	bh=9iAOw1w6GKBEvWc4NOk4V7o0xfGci2jFMetZcqy8gS8=; b=XH1Mb8XfaPUmFoXWHcvR4FTa3y
	Kyds04WUrP9VuYsLdYrp11IB2omqHQvD3c3F/1svaKhIOFAmebj+C7CFNsW3MZzMO3M4mjMvCvC47
	1wZFHHfICRmmI3HyYOJtU+Bfu4T2F9afcmIGocU3LZX0GnhBECp/Ib1l8d3O4sNiwa9aBvXUTOK08
	nu+ml5sVZGmnhIR/TSYuu3KKMcaJC2hC2Pin4I8ANSIOW+uikme4RKGQgi34ds0xyvUVuz5DPD0bO
	yJ9EUwI3RqfpIFApaGIKJkMvLWP5UNTFf0Td3r+ZTdBwwggfbEVV9Pn1FEmt1qB+gMuMDHfQUzz06
	kyswNzsw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:53530 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rp3MJ-001hkc-1A;
	Tue, 26 Mar 2024 03:44:43 -0600
Subject: Re: [PATCH 5.15 000/309] 5.15.153-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240325115928.1765766-1-sashal@kernel.org>
In-Reply-To: <20240325115928.1765766-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <b3c6b362-a995-a8dd-97cd-f7eca94d8ebc@w6rz.net>
Date: Tue, 26 Mar 2024 02:44:41 -0700
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
X-Exim-ID: 1rp3MJ-001hkc-1A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:53530
X-Source-Auth: re@w6rz.net
X-Email-Count: 52
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ5fmJfvTriGYJY7Wscwt623qEMDSEuPDUm/bhJkmb7RyXwKrId7uoY4eJVnJYtOrkxL0SsF5gBJjWz4SYHO8iOrJa40/gGFjX0bj7e5q5huys3Gq5u/
 VJeAKF4NNF9DtuR1xS8Ix8iRmRLWVGaFMG4IEPTj0/kA2Wz/K+eSf5i1OWnuoxQnvrdMTplnKPO9rA==

On 3/25/24 4:59 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:59:27 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


