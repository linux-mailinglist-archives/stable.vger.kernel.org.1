Return-Path: <stable+bounces-37837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B089D113
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 05:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783E2285B16
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 03:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71DA5491D;
	Tue,  9 Apr 2024 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Mf5uvFgO"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CA56B92
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633589; cv=none; b=qVZKl4NBHAQAYoJRL4S6rrvDr1zqid/UtA/m0jD43Uo676SWUDhBlsN8A1DwsPu0sh8ACHhU8/5MS4rsHtEyQE8+QLB5DO2eXtT8b9Bdvc4hPExZFm+z7zCGjnMaMacs0BoHX8oT5oN7JBB7rLQTzYi7vuFrWJqwzoJO9J2RAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633589; c=relaxed/simple;
	bh=EFpLPzWISFusOi/KeXwg8luY/SwU7mmvlc+llRkMOW8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=eSCfpVXZUyb3CDprGBP7kRRQnafyn1SpAjNcYknMOO6rp/sJKFXBoVQlKImHv24sC8T7tEn+L/HcNotF//0VH9r+zYiAgRbWGUazt766L8t7eLMFDaw8JfocPFIlE+SyuA+e1XMvJVQHvl2cif8kSmyA1UUntx852/breU7fBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Mf5uvFgO; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id tiTorG2Kruh6su2EMruDa4; Tue, 09 Apr 2024 03:33:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id u2ELr07G1HHoAu2ELr7CBK; Tue, 09 Apr 2024 03:33:06 +0000
X-Authority-Analysis: v=2.4 cv=dskQCEg4 c=1 sm=1 tr=0 ts=6614b6f2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7TTvVFQ3ERsjMBJgIWUEuaj2mQu3636MoaMP6F8RdAI=; b=Mf5uvFgOjzF/xhdB7FoTGAeNqT
	y+r5ywr2fjCEWxBHLsAlcVyskBU3p2ywJeuGkToDm0e3hZ08HsIkIOPMqSB413f/cmIE5kr7kiN+n
	NVP1e5usHD5UX7bTBX+TGhGFL13U3mTRtcpGdwfFD1TMfqkC1m6ve4MzJz+Y+Slh60FMoMHhRiXwr
	GYA3EMpNVbPg7G73Hpjl7dx40aaCkifeWQHYE4mENSvn6cHGadUx+8q8YjOxdzjmnmSZAN+gTapHA
	OrSLkB+oY8Wt9K9K6HQyal5gIxMk+4HxWMFPXGNqKG9/koOvG9jeXC7jjf9ThTaiBMFjbyIhvcW4M
	0ruZuNdQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:56510 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1ru2EJ-003L4W-1t;
	Mon, 08 Apr 2024 21:33:03 -0600
Subject: Re: [PATCH 5.15 000/690] 5.15.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240408125359.506372836@linuxfoundation.org>
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <8b64df27-501e-40e2-bee3-1b1db9c16442@w6rz.net>
Date: Mon, 8 Apr 2024 20:33:00 -0700
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
X-Exim-ID: 1ru2EJ-003L4W-1t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:56510
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOa2gDZ2bhsYh0zU2dOtfdk3wZPtlP+A99v2my9OTjO06jp94HTRsXBQ+2dZdj+SN1caGtxiWZ9OGMwFEUzI1LzoRpIdFQLL/HttNfowDINRl2ElzWwG
 zUd22wP1ew6En5iEbg9xtN0dSrPpWe0MP/7g83YEHIfOqPAf+Vostiakc3M22tsh6pGjEZq+mhznog==

On 4/8/24 5:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 690 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


