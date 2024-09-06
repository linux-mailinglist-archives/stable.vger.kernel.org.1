Return-Path: <stable+bounces-73815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCDA96FE08
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 00:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6141F219A4
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3C158DC6;
	Fri,  6 Sep 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="43anE2gk"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064421B85D8
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661944; cv=none; b=WmHJnk6GbulvqDHKpJVy0yc3T5dUTkWU+XnfG5iiqg4rUynzjW6p4/1mZVWMHH/ewTqNFqQrB/ilXfaT8aObeSpFcecsJocxE6tb87zJDlaPvJDQPmZJh/TT4aGVJL8F7FcogzKo7Xx/lElmxD8CEZwYyxFZt4gC8YclZB3ugg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661944; c=relaxed/simple;
	bh=XSlIhTL85Dkf7AG09eQo8nLBuD0ZJMyOsY3Hl7kCHwQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=QK75BFRIMq14/4N1cnUtRVuqiI2ELWFXTLXHrHfSyQD3TAItl0nsF74GfSRKjkJPnjbU2h6NDf7aivwgU+QGLddsbMtq+IDDULBpxaRmYYUMyFj79kh589LbYnQ8qob8oCB1z3NoTowbNZYZOYmQ4LEVlbaChoDg7rOGdRBRDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=43anE2gk; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id mccMsInySnNFGmhV7s0CEi; Fri, 06 Sep 2024 22:32:21 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id mhV6sZOwQ0vWTmhV6srSh7; Fri, 06 Sep 2024 22:32:20 +0000
X-Authority-Analysis: v=2.4 cv=ffZmyFQF c=1 sm=1 tr=0 ts=66db82f4
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=BEK6XHwdWclZZPXDZJEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rDBREgK2nH9Lrz8BAvt0Zr2D2ezNqb3hegHj37VRtaY=; b=43anE2gkfSBVW0YXX8O8sb11rI
	S/Tf1whLfV3kOEj7IcMe4HO0uqQbPEi8SPeyIB5DcdvqYqYmmg4psEvgq5E7enUaY5RUxqnlE0HVU
	Txw7s952kc08M6ewvnC6IP5nBn45aapK3z+HQi3miqjAaC0LJLG4svSOP+CZMss/ZXYV877ha6JDo
	t7Imk6zcKVDGeMii6299itZkNUP3hEkMgZenRp/VkFQx74sfOPH8RRvR8NzQ0+71x1P25O/NhMtdC
	VABNmULqQ+JRsjr+elQ33K/33wcVM2/3KqGFA8CCu2aNZWva1SG7kxzNb2VT0kqogC/PxdamTBZKo
	7urhr2rg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38802 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1smhV3-000aQH-2w;
	Fri, 06 Sep 2024 16:32:17 -0600
Subject: Re: [PATCH 6.1 000/101] 6.1.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240905093716.075835938@linuxfoundation.org>
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <82de129c-6ed3-a47a-ca35-3bdfa7c23d89@w6rz.net>
Date: Fri, 6 Sep 2024 15:32:15 -0700
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
X-Exim-ID: 1smhV3-000aQH-2w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:38802
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNZ618oEYCRs8qtF76HDZskBY5buXlcWuctK/OFB8mOGhMInKxDt6wE8Xi69tW/DLBsYg3z0RRul0MOFTmZr9MJPoIv12YjrsuoJQkUkrpk5VX4yWexl
 oMPKBR4F0hGRSJ7ocs7S8lo62VasWInZTjfe3d9nOZ3S8d1vrb2P5pgsHWStsjz7ojCLyXJQrSc58g==

On 9/5/24 2:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.109 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


