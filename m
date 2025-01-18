Return-Path: <stable+bounces-109429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD96A15BA0
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 07:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B584A188A162
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0B913C9C4;
	Sat, 18 Jan 2025 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Dj917hP1"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6321339A4
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737182235; cv=none; b=DGO4LthkxaMZQTH5Ajtk9c4QSr/hoHQnertark/G6gD2WW+LH8JCkOopk67Ik02O7b9GUZUHVzT4azgG0XBOfhU/ip5U2PwM4dHsKylLM8PcHW/JpOF5JF2HoaJ3Va+9K9mJEYHGzAiFdYc5L+EjO85SNCaIA67lWePgXqlGJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737182235; c=relaxed/simple;
	bh=dRODH/gAyL7GzhxgsvNA/Peix7Gy7vRP9fwBfST8dJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rlf7I5xFpGCy9VK5tou07ceLztyWhzbyZ539oQO5/o/w0+CHuIiLUJxZPAKu+SM5lT7O+4lYdycHZy0tHfaj8cwAUJSSKTwhgxAPAtqisTqADj3rpLEwRPCLxgzwY6E+OoAy5X+HcEwxwLwERV262HiMPUYztmDUlyOgoYHx0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Dj917hP1; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id YqQxt8VIF09RnZ2SAtCaVB; Sat, 18 Jan 2025 06:37:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Z2S9tj9NkUbwIZ2S9tVYaZ; Sat, 18 Jan 2025 06:37:05 +0000
X-Authority-Analysis: v=2.4 cv=JK49sdKb c=1 sm=1 tr=0 ts=678b4c11
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=p0WdMEafAAAA:8
 a=k4zwkoC_-2IYBYaSvqgA:9 a=QEXdDO2ut3YA:10 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ERI8uvsF7n4j8nNwPKwkUCzYQVPqT3od8kfcsdqqzBI=; b=Dj917hP1KX7/noZph7CzQ6Uj3Y
	WhXuH78INJbVCmcBrwwZ29jdCKtzVaCLqIUPqQXLPGsItPv5RST25HEqPegnqK7xv7cE/Qi6N454+
	tdWkSKh3EB4sanjlyNBBIZQ5R8aeFL7NUVJm2Ut6YFtznMNfES2WrsUxo74we4BvIh0B78GJubuwS
	SJ3G8POF+yn1zDGV63wpPXu2Zzs6cUVms3ChZ/ikLlIzfFb7D06UpWAYluv+qRY10529Pvt8jtwyj
	ZnJp0vD2r0rvlduEX5XNPbs0jI8l3Z0/aTW4ztq+qhzHHaCFW71Ixbk2hI7QZBcSSd1Ny5yBCiGCd
	qBOkyW5g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57280 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tZ2S8-003VdN-2y;
	Fri, 17 Jan 2025 23:37:04 -0700
Message-ID: <133dbfa0-4a37-4ae0-bb95-1a35f668ec11@w6rz.net>
Date: Fri, 17 Jan 2025 22:37:03 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1.125 build fail was -- Re: [PATCH 6.1 00/92] 6.1.125-rc1
 review
To: Pavel Machek <pavel@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250115103547.522503305@linuxfoundation.org>
 <Z4evJUkzHauW+zOU@duo.ucw.cz> <Z4e+u8gj6BV37WdM@duo.ucw.cz>
 <2025011725-underdog-heftiness-49df@gregkh> <Z4rIlESGC6mwi8HP@duo.ucw.cz>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <Z4rIlESGC6mwi8HP@duo.ucw.cz>
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
X-Exim-ID: 1tZ2S8-003VdN-2y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57280
X-Source-Auth: re@w6rz.net
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJfcmx1V6RIyoOw36lxg9pVeaYWsFXiRX28eJD3vnv607RcCE/eQH/xUkiaz75EUcpPHo6PxOPLHZT6oTarkp5VyC8Nsj9FX7MyWDqX9yKdjwBoxr3ee
 8N83AK3b4kLS10a1JbHh9J2YScFKgJOoM++IHXKd9oMQawDCTQ16Upk1g8z0iuR7qb3RJcOo+3gWnw==

On 1/17/25 13:16, Pavel Machek wrote:
> Hi!
>
>>>> Still building, but we already have failures on risc-v.
>>>>
>>>> drivers/usb/core/port.c: In function 'usb_port_shutdown':
>>>> 2912
>>>> drivers/usb/core/port.c:417:26: error: 'struct usb_device' has no member named 'port_is_suspended'
>>>> 2913
>>>>    417 |         if (udev && !udev->port_is_suspended) {
>>>> 2914
>>>>        |                          ^~
>>>> 2915
>>>> make[4]: *** [scripts/Makefile.build:250: drivers/usb/core/port.o] Error 1
>>>> 2916
>>>> make[4]: *** Waiting for unfinished jobs....
>>>> 2917
>>>>    CC      drivers/gpu/drm/radeon/radeon_test.o
>>> And there's similar failure on x86:
>>>
>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1626266073
>> Thanks for testing and letting me know,
> Ok, so it seems _this_ failure is fixed... but there's new one. Build
> failure on risc-v.
>
>    LD      .tmp_vmlinux.kallsyms1
> 2941
> riscv64-linux-gnu-ld: drivers/usb/host/xhci-pci.o: in function `xhci_pci_resume':
> 2942
> xhci-pci.c:(.text+0xd8c): undefined reference to `xhci_resume'
> 2943
> riscv64-linux-gnu-ld: xhci-pci.c:(.text+0xe1a): undefined reference to `xhci_suspend'
> 2944
> make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> 2945
> make: *** [Makefile:1250: vmlinux] Error 2
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/8883180471
>
> (I have also 2 runtime failures, I'm retrying those jobs.
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1630005263
>
> ). I partly reconsructed To:.
>
> Best regards,
>
> 								Pavel

Seeing the build failure on RISC-V here also. The fixup patch was a 
little too aggressive. I tried just removing the #ifdef CONFIG_PM around 
"port_is_suspended" in include/linux/usb.h and it builds okay.


