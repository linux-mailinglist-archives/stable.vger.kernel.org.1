Return-Path: <stable+bounces-160143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14249AF8796
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 08:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323CC1C80CA4
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 06:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F47219319;
	Fri,  4 Jul 2025 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="LstC8Jdi"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9E92222D2
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609170; cv=none; b=I7O2BJ4R5CboMCnmNzhnVCWZXtOf7ySfy9id4nc/bfc2dUwv/0aNv8fOhxTIyfzTHYSpAS/lKI5mHTPhZUmPmrj2rnzdhUjxvVKeHddh465XJH9BIATH2wy495N600A50TR33hBfN3GpLddJT8JFGnbV7cu01/VTG/EEmjwzz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609170; c=relaxed/simple;
	bh=3OCzd5BTGn/s4JT1674h6fkTKDdG/cjR5zkZ2g3ccBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CB32S/mmIwy893VkksUZI4nW2vj23eQ7KDj4i/bqyfUP2qQYVqH+W7t2JgsaH5so3DqZk0lOtBC1jflQNdpxQ1SHStviMKoGaSq2mTI34Ekw4cSPNkAkUE2/m25WxIIhY++m1G5b9tgcWzuUM+VjbNtvMHPKHv8RnVb6OkPtOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=LstC8Jdi; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id XQsouEUTEiuzSXZXDuzuv3; Fri, 04 Jul 2025 06:04:31 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id XZXCuBOh0mygZXZXDuHtzh; Fri, 04 Jul 2025 06:04:31 +0000
X-Authority-Analysis: v=2.4 cv=MNqrm9Zl c=1 sm=1 tr=0 ts=68676eef
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ZJCAKeS_rTr8ZDEThcMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TlZBlsExbtZHpp9JpBdKHNq+76CAEy3oCuHbciuofzQ=; b=LstC8JdismZmfKNgt/A8MPlYqZ
	iXbu3GxaivOw7ZurjMvvTpgNUcIdyV7wKegzrEw5RUbbdJihIa+V2EKIxHmiZnwoHst5YDeb9MYNJ
	f+EhTrsPWzh1uOBbKwZngUkKHVUuheZyZvheCWgCM2krc/EDZqbQjFbaq3R8CkKNQR9SnZnecJrVq
	tfH8gBabS5F+2xzj7y30yVMtCGtQveKwjpnjpBiLA2FUAyeWSzROuqQqPhx08Mh2APrCRFqfDdnRq
	2SFpjRdm9UWh+u6QGWi/80KsCLd6WYv+MKUVJ18n5IpArl5D3IaqF4g88UVCRdGjpjHhaZVzcXpyY
	ZYoxuRzQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:50322 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uXZXA-00000000sfL-1Jzn;
	Fri, 04 Jul 2025 00:04:28 -0600
Message-ID: <c64dfabd-cfc5-47f3-aed8-7f9e6fa9bc7a@w6rz.net>
Date: Thu, 3 Jul 2025 23:04:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/139] 6.6.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703143941.182414597@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1uXZXA-00000000sfL-1Jzn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:50322
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOmis8iGfgCdnvG0xf5U65PbKDMP/nE2I+PPbl9N2PuzZHaUasrUnHNaGVW/3qh4x4P47nTiXjvORC9kveGLFIMp/08kRd5Y3IRM8TipVFfUCRGRNEyl
 wmEYgFWvLH/MG1VQWc459wGYuga/DPgeN82m1DUvQrsDrFUDxQ4rpJVj/Q0tCbO/DRCC1nBrzjB1KA==

On 7/3/25 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.96 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


