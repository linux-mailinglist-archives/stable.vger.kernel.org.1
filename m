Return-Path: <stable+bounces-39269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B18A27F4
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 09:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A5B1C23258
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A6481D5;
	Fri, 12 Apr 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Sk8ldQ+o"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB35025E
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906761; cv=none; b=SpcjNafZXIEyuDLXc1CYYSb+ElIUe2K35pD5VNRkEsZi6s+gzZO+BSkKbkNd5YjgwkuwJ5VE50iCWpbI1QLpMJgK4wrICY7gsEH/T5zGM9jp9eMU2MQrnqO5+Fzy8eg43bLeQIgJ+gTQPYLjLxGSX09xnJqGw/t7T0RuThDueSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906761; c=relaxed/simple;
	bh=pH4tXmQrI5u9rLxOdblnG64YudYX6IgX+3dxC8uArt4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=gt/JrzCSk9NE73Z9C8CV7RO3pdu6NZ/5YG95FOjgpIE6Pk8aY6cKaYXAemC95qCiA4EGYWBda6wZ3B/FOzgRubXF5MSxK1+3zmbGRPGqGcK5BPHuGYcmBZaaTyARjesCryGGoMUgiiAY4cIs0I7L9OaD/6YFqQgefzInBppv8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Sk8ldQ+o; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id v8acrGDKpHXmAvBIHrTuCU; Fri, 12 Apr 2024 07:25:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vBIHr87xtEKylvBIHrKuoY; Fri, 12 Apr 2024 07:25:53 +0000
X-Authority-Analysis: v=2.4 cv=Bombw5X5 c=1 sm=1 tr=0 ts=6618e201
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=iIpkR4LGDAw3iw8gTDEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+WPztAnXoKOQ3I6Xy+6y40vl3WjR3O9njesmgrRuDqY=; b=Sk8ldQ+oCc0EGketQx0jeEFb2Z
	g2lPKuenOXPvvqLRohTrM8nCppaR4JIApR5c1R1QZ9h3hPD2MB593nJKAtO9P+YVwy91x9Z0hwPHv
	n7T/1dmWQaUo59vDDWFR/S5TMHz6VYHFtiNxdgWirEguqpSrJgCwn/Z/5fbJOWlLGSNuVvLE/qZGW
	kS/r66v/uASNY4rxAVuLa0nEYe3SOA6HYxOzzhrMUl0bLLLZLokVErV8kn4lOF+1dop8c4WIWbHUK
	k7c2ILHYUEvL9vTvhmOM682IJ1DEmghVWcc+PNg4TZzgIiZrPBDTM4RD7yMlDNKH2RxNguyFsnYST
	uswe/FKQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:57260 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rvBIF-0022yn-0I;
	Fri, 12 Apr 2024 01:25:51 -0600
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095412.671665933@linuxfoundation.org>
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <13890c60-e27b-ef1d-729c-95c60384a8ec@w6rz.net>
Date: Fri, 12 Apr 2024 00:25:48 -0700
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
X-Exim-ID: 1rvBIF-0022yn-0I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:57260
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD0nYghODypyJHp2wyhJRmoeJJSMCl5YY4bc3W2Y85ebcnIwSSnRbrxoPgPD6/IKVbyISnMVBo0lpnygH5t/56x4lHbzR6ymPwhelEnUnjCQ/FLrnzn6
 kNbIsddhpyIbMs3fhz9tOgDiTPRCjL4kFgD7tBQ5zoZRjjB3o1jEIba26Q+xteVhtQEmW9MpnWNI8A==

On 4/11/24 2:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.86-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


