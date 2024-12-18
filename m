Return-Path: <stable+bounces-105116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C49F5EBC
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D685F7A259F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3065156885;
	Wed, 18 Dec 2024 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="opYdsLSa"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB41531E2
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504133; cv=none; b=E2kBiX2JvDXI7wnT0klUB38P4XhPj7aRa6Q5z/2oV6zBP7qVsHaRZDQ/BqPiXMUf+EiR98I3sJEv7wG3wbE2WlxaDweNSQJrCc2q1zDZWl+aqDBF+dMGm2+Gdn4vkPEk3oKHEDi9Hm6gGFojXWxTKBxhyE8b2x9cTpm7+G+qPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504133; c=relaxed/simple;
	bh=biPTOeGK5kNXwHfntlzD18SffZPTQSAkvtm4SLGlpK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDQx5PdRimSleKuGRFsyQXjUXG3ztZ0YSqeqPNP6zDrLxkpXpTu+6Id7eLngn7TiSUXmJhmIckrkuJ2ci3XAHEdy8dlX45s/JNiPyFeVSqVTLXoeKBmEOWw6bO2tAVkQmKJYJW0PIWnt/1IJXIKoUvPhFuMPzJ5uSlpmSbYNEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=opYdsLSa; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id NE1StdplFvH7lNnl4tPHh4; Wed, 18 Dec 2024 06:42:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Nnl3tZZegw1r6Nnl3tXJ4C; Wed, 18 Dec 2024 06:42:09 +0000
X-Authority-Analysis: v=2.4 cv=KOBcDkFo c=1 sm=1 tr=0 ts=67626ec1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=HPvIB9lQppeJS2B-OsoA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DNXrao/3f+rQ4IwMlW1jtyRCSmmcxYqv0iDNaoRwtbY=; b=opYdsLSa6CyFY/Y91enfpa9aoq
	929RTNTorwjhL34j2R07LFHX26oZEuF2vz+/K2EIe2C3r5QVbHCW9r+niVfGlvu/5wNX54ndpY+2z
	jMu6+t2GkLFVo69GVGwWvisH+gjR8Uo+wLwQgFUE21eOk1r6D0nPVh90XyYovSR+PnD1mzHr1xoI8
	KV3pP3yS4Px4/Bg0U+qIF8Y0vnRSUU0lkt3qaKLfSuC2jwyOeSoDPZdXVdwhvAKf5ha5GZdwzR0X8
	rcV15eBnur7zHscApH0n2yHHneiW1AHPRk1ofPxTA1/BN9+AViIwIbPt1B4AUNPJGRa6fa33fDk1K
	CcKpolbQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:44230 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tNnl2-0001ts-14;
	Tue, 17 Dec 2024 23:42:08 -0700
Message-ID: <8554e516-d9ee-4419-8478-89aa3607af9a@w6rz.net>
Date: Tue, 17 Dec 2024 22:42:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170546.209657098@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
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
X-Exim-ID: 1tNnl2-0001ts-14
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:44230
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAU5a9YM78jFFGLTO0e2FZWM/vL0vJoPXgfIK0TASS7flfDejBGZTO2Cupioqk5ZNpGMIFZunaa3ynsb/8pA+MFV83WzeOwphQgbtLUpPCFr87Elc/h8
 uEmFEGxtuxmxr4F7SAatSL66quemKdhY5/cWl3n5Wr0T+w4Go99Cs6MR/KJiJr9IBRNNW9sSHZAMGA==

On 12/17/24 09:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.6 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


