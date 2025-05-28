Return-Path: <stable+bounces-147926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43AAC64F2
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 10:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934D9A20651
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09C2459D8;
	Wed, 28 May 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="3IpnPYIH"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F42741A2
	for <stable@vger.kernel.org>; Wed, 28 May 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422644; cv=none; b=bLUC8Z+iEE5N5/JIPkcYk7Ki+iikny+Nnz8kKRVmk/pbDkNDeI43cG5IkIqKc18JTOo6v0atUfa3QNUEqbbeyA6HL+QqTAximn0jCuFu/Kr7R/tIShP4j4VrEJq2Sia5ieqzPkKPpfNTRCgxjspzIKUdeEe6WtlV/57mp1FRvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422644; c=relaxed/simple;
	bh=WqT5k29mabgxiTMmvCIyVa8aqzh5NKbZh6jGUFeRZhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSNJIpTIBVfDscj+bpPvfOU5HGAzK8osb8GxZnPTjkkGzEWlCsGbm9812Pe+YQFII0MT/s029i0OqB8v8BxwiS06fIyg0cEy472AQwNt8QAT9+xSwJdk9bUnSjG2YPBf3XW5JAaae57w492WdvRZ89S1ooFXv0XMTzBe4X5VUwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=3IpnPYIH; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id K9GsuTA4fiuzSKCb5u0Gri; Wed, 28 May 2025 08:57:15 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id KCb4uhIntq3CNKCb4u5Oi0; Wed, 28 May 2025 08:57:14 +0000
X-Authority-Analysis: v=2.4 cv=VpfoAP2n c=1 sm=1 tr=0 ts=6836cfea
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=5E2gbQE8QDOJjfjLMUMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=83C9954UDhMJIVB4ENt/jwjCY1O8WR2AKglvGvJAkzc=; b=3IpnPYIH318Ajs1M+RLelFaDBZ
	lSXwYShPxZTOXXQb/ScfHQZQAVXbtPw2UdrlMyLIPEgQpEyWNqjgt0wzbEcl9vn9LBk5VFM0cmwTn
	fIn2tCDkdDfwPYZMBA4fijFoRtpTCJcxMeUE8MspWGs7O8e3oUNXS2h9sMDuV2GszOC766Qinb34w
	jlaZdI68gBINWVqVLQWf2rbbpFo5Em9TcNCF1uag5N1ugXCl09PiFTDwL68jxl1rTdljlAaez25ev
	hkS7OIm3KMpCNnpKpR+tHUqlEpm3poOdCQNLruarnlCJVTAfXNubM9dAjdl5bX/dU4oONePUQK/25
	qAS9YEXw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:53932 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uKCb2-00000000FOr-1eGv;
	Wed, 28 May 2025 02:57:12 -0600
Message-ID: <736e7623-d216-4d16-ae7f-afc55502be02@w6rz.net>
Date: Wed, 28 May 2025 01:57:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250527162513.035720581@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
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
X-Exim-ID: 1uKCb2-00000000FOr-1eGv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:53932
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDu55EtA5zIjjigt0SUOnfg9mjxHJHaYZt0Egs6rOnpnuyId8RkHYfyq6RGVFtVoOqEIXBy6EFW9p2bohEoLaTVrFACWmewSW7g5oDzFvtpwWYcznQCh
 Kdh3iIGF5UhKJNWfqDEKWyfd15fIn+gFdesnCGRtKlpSoqyPLWJJ1QVc9XnVSIJvxGZ9KK9+Y7Ttug==

On 5/27/25 09:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built (with both gcc-14 and gcc-15) and booted successfully on RISC-V 
RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


