Return-Path: <stable+bounces-110284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA90A1A5A3
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F7F1884417
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22332116ED;
	Thu, 23 Jan 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="u4TbWVfz"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176C20F98A
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641988; cv=none; b=VNs0gTBxPPRrx14Q4MZ9mY/qLKQsgKVqN9eyk6PPPSLuG6LyeYnWyFWNxTC0EG1tDW8c3KymwNm++ihX0rnmwN2+KGJa+bGJZEhP5X32thiiQHQibIvc+o4oZs+9tJfGRjGwdEAP4/ZFUQgWNc4Xs/u9qBWDhExYJp3HJMrnUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641988; c=relaxed/simple;
	bh=qPKX9WEzdNTM8Ya9Ofhy7l9XkwCVyqUbudlzasR1Gj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTSxNEebjBrKINshhnwrbMwxAz6F2cf95AsINKPRUL8TBMSzTvKpa7TkYGTRgF4yIYEwdf5rathac9RDa1ByGl+uCuWPVLcheP+qi4SbPQ3cN01MRRHTJ5/S60lEZhsSzw2CqzvNuxwvkL2brj6AjuLxp6QhYSfm2rYdVCcONBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=u4TbWVfz; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id aqbMtoaq6METlay3WtmxdY; Thu, 23 Jan 2025 14:19:38 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ay3Vtr5YKlqdtay3VtT4yH; Thu, 23 Jan 2025 14:19:37 +0000
X-Authority-Analysis: v=2.4 cv=JIzwsNKb c=1 sm=1 tr=0 ts=67924ffa
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=AnkGN9JO_e9D5-sWEHwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JXejurzvQdVEIRHNDEirgV5Gbc2p+r+gwhgyt5mp9vA=; b=u4TbWVfzyaGrt6CHOWUGdZIsCi
	y3E1w+VEXN/RTg+3rFPlOx9A8tVfux4rdZ+frhIA6XcnPsenNUjWZt5eOvndUW1sEnItM4KeaPrUQ
	xvvrf9VC+jP/xYI6Bl6hZ526QhFEz8TQNcyu7qqL6J8EJ3A7W42WiclwkLZT3HQjX9Tiu/QSiku7z
	5r74bhAH4CHXDVDnVUqqYXcfzG3l/z/CZQAdv8IJwyhogU7rUZsmdkyzmlLypmVDlvT7+JPg6oJxl
	23o+tbvj3tdFigMYtK1PVaw60bFn0+i2+P4u5fheZcr9neqhVoMkQnFzzfPfdmuX4Dl3hHDOYyS9i
	SdZeM0gA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57952 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tay3U-001IDG-0s;
	Thu, 23 Jan 2025 07:19:36 -0700
Message-ID: <65b96357-3c6c-469a-b738-e0576edb958d@w6rz.net>
Date: Thu, 23 Jan 2025 06:19:34 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/127] 5.15.177-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20250122073830.779239943@linuxfoundation.org>
 <010553d5-4504-40d9-a358-8404f57ebe9a@w6rz.net>
 <2025012347-storm-dance-adfc@gregkh>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <2025012347-storm-dance-adfc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1tay3U-001IDG-0s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57952
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCdbCCIH2j+0XI/KqxGtjuU/MCm/IP8buPvgxH20sgSIeUM1uIEsTgdHajRp2xoqD2XwZr12kDDj/PZCJzm6xtYC236EWtLjq0tkMuG3P5Hf8Y7zVD3Z
 apJszLiEHNqFjojoHeLQ2HuublwFYnQVKAHCMxw8rWy6o7uaC97CwWMgdlMTunlLyH+KSbnF/3dTfQ==

On 1/23/25 06:11, Greg Kroah-Hartman wrote:
> On Wed, Jan 22, 2025 at 05:20:54AM -0800, Ron Economos wrote:
>> On 1/22/25 00:03, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.177 release.
>>> There are 127 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 24 Jan 2025 07:38:04 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.177-rc2.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>> The build fails with:
>>
>> drivers/usb/core/port.c: In function 'usb_port_shutdown':
>> drivers/usb/core/port.c:299:26: error: 'struct usb_device' has no member
>> named 'port_is_suspended'
>>    299 |         if (udev && !udev->port_is_suspended) {
>>        |                          ^~
>> make[3]: *** [scripts/Makefile.build:289: drivers/usb/core/port.o] Error 1
>> make[2]: *** [scripts/Makefile.build:552: drivers/usb/core] Error 2
>> make[1]: *** [scripts/Makefile.build:552: drivers/usb] Error 2
>>
>> Same issue as with 6.1.125-rc1 last week. Needs the fixup patch in 6.1.126.
> Ah, ick.  It's hard for me to build with CONFIG_PM disabled here for
> some reason.  I'll go queue up my fix for this from 6.1, and then your
> fix for my fix :)
>
> thanks,
>
> greg k-h

Just FYI, I tested the fixes and it builds okay. I did:

git cherry-pick 9734fd7a27772016b1f6e31a03258338a219d7d6

git cherry-pick f6247d3e3f2d34842d3dcec8fe7a792db969c423


