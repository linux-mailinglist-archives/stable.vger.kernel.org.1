Return-Path: <stable+bounces-55841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98279918146
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 14:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434B31F23E89
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7D181BB1;
	Wed, 26 Jun 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="xbqAQ4UO"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB817F39D
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405966; cv=none; b=eT7zl890mut/+h7T8WJjcNg15ukvmA5LF2mo3QMgM7p3h1wwGfXMeKv623lYVOoDrhGkUzexvbDO+50awcaHWlGHYM/7H3PIoUOQRseL53SfYr3vDjRSq1qW2u2+QfBYbylIVjlNAG38jpathmXkLTLZ0DWIqMr5yvrPwbMpxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405966; c=relaxed/simple;
	bh=ARBEaufTM1wTiJu+3ot5+xuSpijWuCxVaQKS3lVicMw=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=r4NlpiBe8pFMCScaj75NXNidgyL62kBec6sHRIRyHhm7Nl15l2ATX7K2bKxMjmKr0dQVjvHTmpAtpRmc0jLPET1QoA557QMTs8e5cFwM479rciDX87KegViVMmkqs7reRIYcjLVNKGUEOL6L9krWGZjYii+ygJZWWGHY6NjyL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=xbqAQ4UO; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id MOVYsWUbqSLKxMS2AsMjcB; Wed, 26 Jun 2024 12:45:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MS29s6PxQCaXoMS29sF6IO; Wed, 26 Jun 2024 12:45:58 +0000
X-Authority-Analysis: v=2.4 cv=deBL3mXe c=1 sm=1 tr=0 ts=667c0d86
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=nIAznLeY9BhABaY2-0MA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZzpdcqY2O/Im96eQOpnzB/JaPm4sawgGi0lMMBZ251I=; b=xbqAQ4UOGoP03yB82z1ntIybqm
	CM+Ixw/8GydrK23ICH4y82h58bKy+NY5xeMAqH1X8Ndii4T2vu12ehwb5Lrq7n8bqGb7Pn0typY5e
	sWdWBKt/7vViH5SOMwTuNUrJgzJ2QxrgBTdCjVU4zXkC50HWr39HH+5nEMxvGY3Rp19LX5r+iiMET
	gV8R8lT22RvRaK/tsRcro85FnvpAWqrp5MRhZ63A1Nao0bol5z6AVbJmXKTe2PNmEVAxfx/prmzg4
	fZlaugZceVVITr5xGM7Mc9R4YXG3Zqf2TAJJAttZjLBHUIGJH23PvXS5zqU+Fxr4n4Thlw4/f+JLP
	XW8Gon3A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:45924 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sMS24-002qlN-2B;
	Wed, 26 Jun 2024 06:45:52 -0600
Subject: Re: [PATCH 6.9 000/250] 6.9.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240625085548.033507125@linuxfoundation.org>
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <ab8ad886-19e5-dc7a-20ec-766ee038f1f5@w6rz.net>
Date: Wed, 26 Jun 2024 05:45:47 -0700
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
X-Exim-ID: 1sMS24-002qlN-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:45924
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA1e0FfbXKHQT10OMexAu16TgEphHZdB8YhXVyIlnk60iMl6nxeGKIlqxEgUdbZ+eclF1kKpWpYy8BtcbCbGJBoYF02GYp8VBKgdXUk8wUc2wFsdb7Ta
 lKxK8odG+HlQdfGjZhmzPqwVuSTZJKAgkDJn8XKflEPgOSyCfmFra978pE41SVZoYkErsCo/bCOlWg==

On 6/25/24 2:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.7 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


