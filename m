Return-Path: <stable+bounces-65227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80EA9445DB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 09:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF441F20FA2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAD71586C4;
	Thu,  1 Aug 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rbvmgW2e"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638071311B5
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498582; cv=none; b=EUoKvIw6jvlXqLNIMlRfb8phfvCYArH2XRSlGLoYoxZfKoKUtqNlLGWdj2mQDqgY4XnKa7pHSEh2uozLzugsnefdF/fYgRcAyC5TdrZBvvz0wz0rUpLzsIEf4NaVPfe+Oc7VblMIkqS1MB351Wd9SYht5FrV8r4D9Pb+/4gehQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498582; c=relaxed/simple;
	bh=0vmM1H9CGLkEj5b61DpXlkN0hnajcVRrXOOTPfY63QU=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=fQ0P1sa5eE6kG1ECKz2xVFnlpYtioLNvq8C8rgnVm0GX66j9j0Yi9J3eB/9cQUz1W2UsiUWOs6FNbMqinKnmPBDUatdNAdVhWvcyQ0HKimtJ/RmihfEn2HQyNECFsbJSd9dFZ1TMxFjxE0e5/BKybbctCwgZNiCFltU0Lkz0/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rbvmgW2e; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id ZNptsErX6umtXZQZ3s9h5A; Thu, 01 Aug 2024 07:49:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ZQZ1sXNzNks1PZQZ2sSj01; Thu, 01 Aug 2024 07:49:32 +0000
X-Authority-Analysis: v=2.4 cv=Ud+aS7SN c=1 sm=1 tr=0 ts=66ab3e0c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=A1h9NoyrmeG0ataDS-IA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WYL2rpPm8Ohn9LIe9P40xbDVnV8NlcfRPxHGqDTX3Pw=; b=rbvmgW2eukXIWJk2+AcpSRljTE
	ae1cJ2COBMQpNQPLIc48Z09q24FyqAoSLDfLngU8AYUcQORkWX1QF88J/4RX2H3R9iy3NUwIFICvN
	piuevlxUiS1A/A4E9HbZGtThNPeYlLL5c3qboCgYx8UBU5wA+g3XERHndfyr9G7QpnGR45ETVyopp
	fmNmhB1/bZ0jTnhOaYM+hS22pg633qDW7RoMpHWGrEaMMCeixyAfq6yBB5moXy/HGIyp4bIPmMDu4
	D86Gv+FtO9L9vOompQw0kJxOLZ7CcYaf4jA4uZpXfqCZ7Npskktn55pPLAXBse9RnnP5IkVE5bzb5
	7Y3+wxjw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:60434 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sZQYw-000GDR-2p;
	Thu, 01 Aug 2024 01:49:26 -0600
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <bb4ae8ee-dd19-728a-b53d-9ac1776c597a@w6rz.net>
Date: Thu, 1 Aug 2024 00:49:21 -0700
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
X-Exim-ID: 1sZQYw-000GDR-2p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:60434
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLJUb/uXb8379fOxHYbmknX05WnA88SIJxGKeRII+YrIoOR5Is1RPEL8Bhfu4iz8vEc9/iF+O4gLA2rfqPQqDyjDhsGUuT1ODl5dnltcj29nHUAduWTm
 /F/U8eXl/38sXl3PfYuGkQwdgyYdpjwQ+hyxtg8J+g1uE1QV9+PNTy0ch522BGXKX/AM2itfFGGwuQ==

On 7/31/24 3:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


