Return-Path: <stable+bounces-26786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB7A871F4C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 13:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4C4B234AB
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3754485642;
	Tue,  5 Mar 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="PrHjF7Tb"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BA85654
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642255; cv=none; b=IUOUJ43XsL5wdFUAUrQlqpo1/tCI6Hf+mQKy30GjpfAQEQWiltTDTEbmRYH/E0HUeoXoae5zVKofEpmx/kOzKse9rzkMzASvX+qPtDLyuDlC523ne04Hy48u4Dx0n4qVg8uudXL+6vfmwUMNpc1P3Sa2cvsDlEB91u1T5VfFHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642255; c=relaxed/simple;
	bh=Q/8Sxgh8pwVTBdT13/X0vZm0jl6EgZhuDOQgkTY4vyI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=GLtOan5SL5yoOauQcOxhuDq8o/5RCNnXUZQUQKJhjy02pajWv14XlAnMEMsKWoPa9QHEZIZqO+MGq9cDz2lG4gCH3oEfUDvZGaEue9VXs6lCZfOSkaoB1aLnCJ8JpYTiEXO1G8QhpCCSW67RcKht0ityAYR+cd7XJXTcUUauGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=PrHjF7Tb; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id hThGreg3vHXmAhU30rELU7; Tue, 05 Mar 2024 12:37:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hU2zrGX02i6JphU2zr1H9R; Tue, 05 Mar 2024 12:37:29 +0000
X-Authority-Analysis: v=2.4 cv=QZJgvNbv c=1 sm=1 tr=0 ts=65e71209
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=piSU1mTir-CSjbXYDCMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K6bBwShfnbeyZ6pC/jMFwJr3wSkYsmLTluFpNkwg/nY=; b=PrHjF7TbZlB4SKg5aOnh37Mmks
	JfJOaBBHYmBPU3GckwtqUdEEx56wMKZIxn/4ylRGJLXTAv1KLSrsrmT48WOihIB0p+VN7AnafLHZm
	/44EDROSHFQxHF1HD4PwFOWUzhnu7AnELvzeaBXrc/evXI1lM1YPylaca7GwPnhdKlarLeTxeLZDS
	/PmoCxR1Jl8GX2SQbOAgz2wLosqdIPaz4Tme5L5PkNwOe264KLATfkwOY9tvt03Qm267S6jFWLy8t
	v4HC230J1sijloOVQChOfG2UZZ2lHOjEwCcS9U9JqeHgSRWi8Pv0kwuqewMzF94NBm9pcjP0Lq/vd
	RJsYS/hQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:49364 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rhU2x-000pvx-1B;
	Tue, 05 Mar 2024 05:37:27 -0700
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240305112824.448003471@linuxfoundation.org>
In-Reply-To: <20240305112824.448003471@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <5a07da44-4abc-200a-7480-1f45dce1a68a@w6rz.net>
Date: Tue, 5 Mar 2024 04:37:24 -0800
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
X-Exim-ID: 1rhU2x-000pvx-1B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:49364
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHMTxgUUZWiItN2jUnugjUar9DlDCdVVlfnd3+t6wD7SbzzUhe0We06ZWCBWTUQtRFad1lxQi40/sS4jQnkgkfRikK/3CXjUaElK8yWq+e/6gSkQ78Bv
 vX3WdUkgbt3+MzreWv+7lydu4n0Slsg7N/uM1GFXf9YHwdYx7TAB7q4w3H6Nh9Xp8tMckFLooKww6Q==

On 3/5/24 3:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Mar 2024 11:27:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

All good now. Built and booted successfully on RISC-V RV64 (HiFive 
Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


