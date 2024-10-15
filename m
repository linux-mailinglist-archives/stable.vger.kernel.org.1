Return-Path: <stable+bounces-86362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C438799F152
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60516B22283
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21F1DD0FB;
	Tue, 15 Oct 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="mMuuWCL0"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F31DD0C0
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006494; cv=none; b=cBFCVA5PpjZOg/ZNhkUyMIqBMpGXF7vYs0+mieNz0pSHCguBOcb6yzhxdGGokGilP0CFABgemVvJlZCrLNBEQMtTP3qSVgGkKE1GdG245z9SJGScuF81fsJv8vkPqAVR0WBSW0Sx2MgH3Ke14aZIcdJvAGTtCactOjlYX9y7mc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006494; c=relaxed/simple;
	bh=K1RESBe6hiSI7jwJi8+1u9FQn/ETWoA9W0x4oO+1hmo=;
	h=Subject:To:Cc:References:From:In-Reply-To:Message-ID:Date:
	 MIME-Version:Content-Type; b=gA6hPHOpmsYaBzwpjkG38dqPo+/ACwWLQWgzMPOiG6JOFKwHhj3d1iTY3IiEQnP2jua624h6uE2uWzyMPYjnAoAlP1WFpI6f2uaVORxOMen5uzP0cNXO0YrFFDr9m0g7+5anQzkdaXCpWp75nu2rMUAIee9IfA06set+s9cSnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=mMuuWCL0; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id 0iaBtRNiA1zuH0jZNtp8Pz; Tue, 15 Oct 2024 15:34:45 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 0jZMtXii7cEKu0jZNtOP92; Tue, 15 Oct 2024 15:34:45 +0000
X-Authority-Analysis: v=2.4 cv=Z7YnH2RA c=1 sm=1 tr=0 ts=670e8b95
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=UiXv1XNBzq_yEhrWseEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i112Fm/NfDMeEx0S6/m50EZwebHt+8R5XKl+GAMpj2g=; b=mMuuWCL0Ovs2lIwbEvgLhgIOjl
	TIRZuwZZRdukFoY3no5dLJ8qeTTAh5Myb/bL4Liraj+1sWKNTrnha3+CBlsc15N25ir+8piEq93MC
	0kp00CFs9LhKs7vJqQJMk7exSxet1iXyph3oWxaNLQn+8pdftZ6Bi8JLjrBOLQR51GmWcusQsY0B1
	0KrSDjMfSaAXZ4lnUMUvI4vvPexeTObxgJdmOk9ECEg2RdkqyOZZNmJKXBNZktbpEJz6eo5hAbO5x
	TZF3t3uswfvIYp/ROLCj4Gwu1FPEnILo9nIJ0pdyzh58P1tzTQhAg7Iluf6Suw21vfmbR/yNlHExQ
	U+eEfiEA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:47890 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1t0jZK-00272E-26;
	Tue, 15 Oct 2024 09:34:42 -0600
Subject: Re: [PATCH 6.1 000/791] 6.1.113-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241015112501.498328041@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241015112501.498328041@linuxfoundation.org>
Message-ID: <62f2d2cb-99a4-dbc1-0f5e-ebef70386446@w6rz.net>
Date: Tue, 15 Oct 2024 08:34:40 -0700
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
X-Exim-ID: 1t0jZK-00272E-26
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:47890
X-Source-Auth: re@w6rz.net
X-Email-Count: 41
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCbgJZDp3Mgn1Lh0THJ3aCepvIIbbw9Q6misgG5iFAPK3QJI0wKkB+Z5MB5DUw1YpY3MkBzbwNoGHT5SjTDtvuFUVugm1nYQDEmmNSzCuc9sMpMpD94o
 qMnt3oQxoDj1Q5ZJffyoVfu6EuAh/R54lT9lu1MjQiDISdyGYCWStL71egTZxvh6StKfVAEDf6id2w==

On 10/15/24 4:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 791 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.113-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


