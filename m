Return-Path: <stable+bounces-188966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7544FBFB685
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 037C634F1B6
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980A322C9D;
	Wed, 22 Oct 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="y3QI+7ST"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EC322C7D
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128973; cv=none; b=L22hjp3Muu70nx8O8UjEQ53q+EBO/yq9d5FFiJj3wWML0nB3sPZEUmp+8d2LQXPuuO41TGyxv/afkt8umHJ4xM+58clFkyzlxud5s8kPHxZ4usDZ68W54tVVwKDe66tCkp2g06Hxx2/EcEaZ+5QXR/pDe2ql75Mhx6IAd7Bt9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128973; c=relaxed/simple;
	bh=Zimn/1Fq84om2vqJsWEkiigEFXiZgionMvk2QSRsJnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5dAcDCFBfG9g/p+SUSMVX5ZY3OJLpR5pIIOa2KF2UNKZ/C2iL7ZTXcbfeOO7228WdaSMLTvqxkF3N41MbrCQnm8wxbdAL9oi7CynSe0hj+UjBWBPwydyOggdlz+RcNw1FXvFTUc7V72uDvNFTcVTXviehMsr09muIh8+hE1CEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=y3QI+7ST; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id BGBQvP4eteNqiBW5tvkaff; Wed, 22 Oct 2025 10:29:25 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id BW5jveq68FT7uBW5jvecbU; Wed, 22 Oct 2025 10:29:16 +0000
X-Authority-Analysis: v=2.4 cv=Du5W+H/+ c=1 sm=1 tr=0 ts=68f8b205
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
	bh=6ZOJAY3MKdpOLhjm1I4FmgYvdhlyJ6vz+M1+6V5uxms=; b=y3QI+7STsfiIAdFSrBpMbQE1B7
	KZNEN+X9+a9mrxiT8PFz2S+sI3tURcYTZwWR6yuEFtYm2a8dO0pY6+Ck43JHahMLe2pNN9TS4nV3t
	u5F31/WsjcbCm+P4Liw+jnKfAp1pArqLh7za0MHwdPxJFtZa67ntCtIDHq56fop2cIIcTHDQB8V1K
	xgaeKlzPsFMfDQIJTMk1zSxtZ+m2PW4d5sz8R+VrWbD7RD+4uJZVPhBCgEA76++tyGZC9ep8RpZF/
	ZEr6xu1F5E8FihSuPhWMei5GDA49Zt6WqW7Tj7jxjaMpXacHPOme59YJ2/fA780ENSZylhjfO0DTU
	rvQDYylQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:55486 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vBW5j-00000000kMb-0bOh;
	Wed, 22 Oct 2025 04:29:15 -0600
Message-ID: <cbc91031-eddd-410c-aaa2-6d13b3f5afe0@w6rz.net>
Date: Wed, 22 Oct 2025 03:29:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022053328.623411246@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
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
X-Exim-ID: 1vBW5j-00000000kMb-0bOh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:55486
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMxn6RS7G3dXAn7meTxxYD0d0/W9OxyMCkDV2XXVQGlp4SgA1NsHOzDbPMUWpZhcOkaerwaY0kN1ntOiDcIkamYjjsupbHqOSWLdJGYisEJRBKmSzM1O
 vV+6M7NavjynSyL/DHCXMoKTCizmO75pAiEX4jHfo3TYdHrlwA+/uXi3varso8cUCwNdH3BQN5kShg==

On 10/21/25 22:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


