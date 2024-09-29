Return-Path: <stable+bounces-78207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F221C9893BA
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 10:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DDBB21B0B
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC813C3F6;
	Sun, 29 Sep 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="agxaYVdc"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1E13B58C
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598029; cv=none; b=PiJWq3Yz5ibtddhbNDcP7ekL+kJ9ZCAwX1J25dzWuS5nmrxGhYjtAzbnZkEW3xBWtqWywiIndL4aIw/ItLm+EEqf7Fy0z83NpIURsqHlLKkhVwwT+vcLkbKwnYbOO5zK/zMNBaHSZ9PV/VFrkEtPd1KpQttnAtFRoCjHQgVjVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598029; c=relaxed/simple;
	bh=I13Fpw5uTMenjXWyGuatTrgB1UAtuVzq60jSYiuNPGQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=aXZQgBKpiiBO5yfk/BY2uDBHb4OTGb18njX1TQkYnxEIhBIRW9BFJdjbGDOGYpj6a7Z+uufR3qtcOOzG7tybh6oqbFNWbb+kRT9DzDo/8+4Onnlo3MMZOR1ap9ElXa0BP7cuI12b/KE6iBAiH3H7AF7i+NG7e6BhX8koSBLD0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=agxaYVdc; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id uaKhspAaOnNFGupACsgEOZ; Sun, 29 Sep 2024 08:20:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id upAAsFeCTxK8vupABsp7f8; Sun, 29 Sep 2024 08:20:19 +0000
X-Authority-Analysis: v=2.4 cv=T/9HTOKQ c=1 sm=1 tr=0 ts=66f90dc3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=apkkSM20mLLOJUAzT4/TLg3b+haxaagzswG122a304E=; b=agxaYVdcA/n6n+2JXHxQ90sX0K
	NmtNyqreQRy41nE+RizH/RmqiSQ8Iv/WUTH7tBlS/jUxLAfnL7jkBapc0XRMru4yikC1Nrav/pR+p
	F2tB8GUbsRYtCdf8aPtpnIqpojDbw6EyDM/TbZYZ5Mb1TGgG4ReM/ZgYe5zhmjBcLpOPST+J0J9BX
	rCEYZfaS6MDP+aMfkOdsCFPmftMLHosVCxOZHYCdiMaNvkSe4Okt+f0LYWA2AvrIpvQM/SuuWLZC7
	//05hlrcmijbvJt3rRFSl4kg1RSZDgPLih9cyf5405YP3/erCMZBqyCCSoCwX/fZu/bLTXzy5isyk
	mq0eCfoQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43234 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1supA8-003kLV-1z;
	Sun, 29 Sep 2024 02:20:16 -0600
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121715.213013166@linuxfoundation.org>
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7e51fe90-d666-1b82-5b5e-e97cabc95ff4@w6rz.net>
Date: Sun, 29 Sep 2024 01:20:14 -0700
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
X-Exim-ID: 1supA8-003kLV-1z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:43234
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBgRxOGG/ntnEL+LrnNGie8vtxJaPtdjWTRid8+PufHwO0ye8z+2PVlQy6icDyAn2CgTOrjtTxiWbxU4m8G1+iMVRAolxmU523Hf84J8IsX3i1Z1j/Qa
 MHQmeUjXvzVn2PXE9tLC2kIdwOYMWAg/KG5Pj17nsyNDImtE7ZjDMhrleQoCg8u1nfa21kzkQZP1AQ==

On 9/27/24 5:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


