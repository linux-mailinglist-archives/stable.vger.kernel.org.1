Return-Path: <stable+bounces-23273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A18E85EEB4
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 02:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D4E1F2180C
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D28812E49;
	Thu, 22 Feb 2024 01:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Gvkj714Y"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6980C
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565795; cv=none; b=BNp+AWyw1Cg83LN/j4OaflpXA7psjXtpIKBNBUkpT5cFRXGclASh9HEYaC9lD6dFNYewG05DIEp34CAFDoSGqK3AtFke0vm2xmbBgZoDOoU0v4qs5DRqLQuZThnqRPXIbxhvta0LGjFdU3tNh6t0dF+X3E5dU7e75YKgrcdc1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565795; c=relaxed/simple;
	bh=kLkAqXGFnab95FKYljZfZW9pzL31Qc+WCrO8iyh4Dyc=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=PxBeZc/OdJoDdZZQ9JVK4MxMq7YKfMEKkJbscxJ2r982//JqOQRi2G3fY1hip+7y3sG/JeoG4OMK2Rmq1RNbkqpr+Pja7Ce8ZvSR8rpwL6Eofm4I3oAWQxpM4MmT+SoiP5VgfoTvt0P6bRNy9+UGBvCN1zcocpbiusUClTQE9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Gvkj714Y; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id cpxerwbAYpUFLcy0lrPBV3; Thu, 22 Feb 2024 01:36:31 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id cy0kr9UzLtZz4cy0krB2eo; Thu, 22 Feb 2024 01:36:30 +0000
X-Authority-Analysis: v=2.4 cv=AYi3HWXG c=1 sm=1 tr=0 ts=65d6a51e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=0mXXa4OsfGGRi4sNyRUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PBT3EwsKOSdep8GUCvESCkDtcLNNU9SC1GjL1m7B1B0=; b=Gvkj714YJ2k9cm5ACwDvEnpHeJ
	i4eGkqeR0hHqRFmpGfnlFlDwflA0ZMrn+pKBC/Pn8FKfi9ey9657OjjMeEsOP9ODzLND2KivtkpMq
	RaPp72K/LZS7Wg6jzX8eiNazUE5zKtVVBDpXuzERI8WNw6PKQNNqA2hfX+DGETN5a3mZ+UBXJKCWX
	itfMCohyq6jx0YsR946D7101nDzTRNE2V4oS/Dj7FXtrqW+naICRBUqt8N5Hofts+EyKuT8iZf0nn
	pah9skh2mu9kG7TdlGCmOfLy62AfAJdgFWoeU4C8+mnXccVn9kEXUNttwIqNxcskka5/Lp7cJbm2W
	kLFnt4cw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:47288 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rcy0i-003Hpj-1N;
	Wed, 21 Feb 2024 18:36:28 -0700
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240221125953.770767246@linuxfoundation.org>
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <0b5e606d-69a5-ed25-16ff-a1fd6a652f0e@w6rz.net>
Date: Wed, 21 Feb 2024 17:36:26 -0800
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
X-Exim-ID: 1rcy0i-003Hpj-1N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:47288
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK8AS6K4t/Q5Pw/Q6fcdnyH4B0JJdgwY36yZA4c3qWxQBR35ddV9/HYf8RPruLC6vZLN+fKdfuxlKvhKuKc+HxSC+mIItwk8HJU/0c9Q6OjSppnHf9hK
 F/VzJChlOcGzfcusp4AGcKIz/WdMogLsmRPtahimewxt54QR/hxleqbBJPTA6COYDrsoJM3/psyEog==

On 2/21/24 5:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


