Return-Path: <stable+bounces-136524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8FEA9A2EF
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211825A000F
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 07:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319351EE7B6;
	Thu, 24 Apr 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="4NPThwSw"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E991DB346
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478483; cv=none; b=GBYK/j1AFWo0HgluLjqrcESpQI3vbQPhUobFjo6eLEB/YgIomL+oQjFVJfiaydsiMc4MGXMwNoqNBOy/0zhRwNrFTWn/5FuQkogxXFeN5m9TRGFGsJKicYU4LsnZPWPQB4pzvbJiZXXzCK108lhiFrq0N5XFtJlQEMYm5RQg6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478483; c=relaxed/simple;
	bh=dY0ycV638kiMVJP20CNVdFwPOC7SHIrX0pWvD46fLRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyofIIKsxg8hk73DzbE2uRRYOzVLrHtbl9y89ZmKwQqWNVJ13ZeyM+9XP9nNoBxSN6MIxFOoao/2lV3HDyQo17O51tRr9Pa8dV7NlL+5BmULPMSjDt4PjYFvFeAR6Oma7Yn6O178Ki5paXWrV1a+TblI5AU+ry3XWJkZWrhU5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=4NPThwSw; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id 7ba0uF3MuXshw7qgcuNXHQ; Thu, 24 Apr 2025 07:07:54 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7qgauacp21vNy7qgbu7mx0; Thu, 24 Apr 2025 07:07:53 +0000
X-Authority-Analysis: v=2.4 cv=VMQWnMPX c=1 sm=1 tr=0 ts=6809e349
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xRiTxlWwWsYXxK0NcaUbZc337pZVsMgdD2pL+vGmhMU=; b=4NPThwSwsh9+6UHFs+UDl9nnZZ
	pGX/Qg0aHK9V5pb71NIZ0HEzTNSOI4Om7MwF7LV2o8FNk8TAzQMLs2eJMnsTeNQnlmJ3ErV0gksFS
	QThZhqXuyYISggtFN2gy9cqlWHWHJbtN727E6z0T6JKERDtquY13m26VbzyKow5UrxBVzeG2L0rxM
	sACJdwvxIw4ca08x/W0NPAajmbRsu7gXKz8YlFonPb3XK/Ddaoez2i4ZXdP0MBLurNQCr0OrID1S4
	t0EDK2WsKuRR9giSLhokNSymzFDJJX0auD26VspK8zRbT2hppukFj0WhX2OwPIGm56i2Ast4VZ3ok
	bRg43bjw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:58930 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u7qgZ-00000002n6G-0CTm;
	Thu, 24 Apr 2025 01:07:51 -0600
Message-ID: <f942a79e-5c7d-4b62-8393-8dafd0d8af16@w6rz.net>
Date: Thu, 24 Apr 2025 00:07:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/241] 6.14.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142620.525425242@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
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
X-Exim-ID: 1u7qgZ-00000002n6G-0CTm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:58930
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIYKY8DcDqo8gCcWw60aFHQPa/jOVmUqRYP/cmmwBsqcyRCA67knyH2/U06IjuLEdAc0iyzvcrCHBZGuRYEByMfl8d6iThry8KbRuUoHMPVSpTSOeBbh
 OBI+DeNE+kZHAH01UOOaZH35T/tqAR2pc3ugzGDiVqtgO0re9Ybfm4hxUHzaIi6vKFJRdKXRzCR5cg==

On 4/23/25 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.4 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


