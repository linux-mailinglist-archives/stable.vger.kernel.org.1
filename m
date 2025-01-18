Return-Path: <stable+bounces-109441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDAA15CC0
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 13:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB993A9013
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B755190662;
	Sat, 18 Jan 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="hS9Kcqb6"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CA18CBFB
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737203357; cv=none; b=SJZkuZHIjqoXx2/yMHK7yhNObenD+D1K3zGrlIE/F7xIbhct5GNoaW5DKjJSsWbB/cHBeeQfQHMV5sdYjsBFCp9/MR1iuoFteVhenfQ8g20XNY5qoWjXVLBUIOUBqWKPFHc7yqku0fi3OKEsyuirZuBqpMy4kD6sPoqqtvxJrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737203357; c=relaxed/simple;
	bh=vOijgfYPsk58EuaG1eNLf/KOsMPfGEFN8OsIuuNQD1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8ZSizM3CrU6I9On/LkVQbKayQxAjCIPMjJMmtxLpsqkKkCt59Afh+sIhkGZH5PFPR+CTPUAsK/uokFjKb4/zKAPL2hRK4yU3+DTxgdC1zE4dGTKACGY1zGqO+xbWgi0gx/lW1keYxMzvUr90rfreJCqFblQ1RSEZjusp9/BMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=hS9Kcqb6; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id Z6LWth7Z9rKrbZ7vNttvRl; Sat, 18 Jan 2025 12:27:37 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Z7vMtdMCeRkwVZ7vMtcFBL; Sat, 18 Jan 2025 12:27:36 +0000
X-Authority-Analysis: v=2.4 cv=Fbkxxo+6 c=1 sm=1 tr=0 ts=678b9e38
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=c26wF0Xrfz9Rjk-tUQkA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+hEQ7YD7BTHVMQ+g7evqG3flseZUGy5hiE1XqvgtE1U=; b=hS9Kcqb6elW+LuNZTzj5vBR+jN
	SWQErf8nrgppdV7JE4NBHUqhoJ+mlScSJFDxRVTECDEKMlpt+6sdAEfpBqrYUWGYo+dSeULJEhUTA
	ysDZkFbMIEBrRNvPefRVBC4zFGchdACLOniOeHigCA22S1DFcVIW2uzXor0hjt6UluMa5eVwqPukv
	xHBjkyf1SX4RIhgkmBFtfTnK/1LiqRtsv2jLK8wEKq2/PayKWRF70V1i2Mt/YzV4tlr1RnMekZlkc
	qUwUD7MvRrcGDEIzDeTYCxNOxnPR2bZaIaahJ6xcPmpMfbAVQ2RV8wDEsVl3Pqs7VUXTyTx+yx1xQ
	pn729Ctg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59238 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tZ7vM-001JGR-0B;
	Sat, 18 Jan 2025 05:27:36 -0700
Message-ID: <1c0f0a12-a65b-4b79-bea9-cda35f8f5caf@w6rz.net>
Date: Sat, 18 Jan 2025 04:27:34 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1.125 build fail was -- Re: [PATCH 6.1 00/92] 6.1.125-rc1
 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250115103547.522503305@linuxfoundation.org>
 <Z4evJUkzHauW+zOU@duo.ucw.cz> <Z4e+u8gj6BV37WdM@duo.ucw.cz>
 <2025011725-underdog-heftiness-49df@gregkh> <Z4rIlESGC6mwi8HP@duo.ucw.cz>
 <133dbfa0-4a37-4ae0-bb95-1a35f668ec11@w6rz.net>
 <2025011851-decidable-managing-eb8b@gregkh>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <2025011851-decidable-managing-eb8b@gregkh>
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
X-Exim-ID: 1tZ7vM-001JGR-0B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59238
X-Source-Auth: re@w6rz.net
X-Email-Count: 9
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEFcm7qJYd1wLRBnC3dMGMtxY8k9Qb56qpOgsmAC0PZH0rW0uRvsF+TSdVbgbqOkCklNV3E766ikSNfXDcD9gttcyBO856qU5uVPH2uthDmqj0hYwXZ7
 yRqwQL1lyWEFQGePZmfRtWQ4x8fuvtZ70RLogTda9yp1SCmSNv59ehLLtw5qYmbYj/LHSaxyAbpCNA==

On 1/17/25 23:20, Greg Kroah-Hartman wrote:
> On Fri, Jan 17, 2025 at 10:37:03PM -0800, Ron Economos wrote:
>> On 1/17/25 13:16, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>> Still building, but we already have failures on risc-v.
>>>>>>
>>>>>> drivers/usb/core/port.c: In function 'usb_port_shutdown':
>>>>>> 2912
>>>>>> drivers/usb/core/port.c:417:26: error: 'struct usb_device' has no member named 'port_is_suspended'
>>>>>> 2913
>>>>>>     417 |         if (udev && !udev->port_is_suspended) {
>>>>>> 2914
>>>>>>         |                          ^~
>>>>>> 2915
>>>>>> make[4]: *** [scripts/Makefile.build:250: drivers/usb/core/port.o] Error 1
>>>>>> 2916
>>>>>> make[4]: *** Waiting for unfinished jobs....
>>>>>> 2917
>>>>>>     CC      drivers/gpu/drm/radeon/radeon_test.o
>>>>> And there's similar failure on x86:
>>>>>
>>>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1626266073
>>>> Thanks for testing and letting me know,
>>> Ok, so it seems _this_ failure is fixed... but there's new one. Build
>>> failure on risc-v.
>>>
>>>     LD      .tmp_vmlinux.kallsyms1
>>> 2941
>>> riscv64-linux-gnu-ld: drivers/usb/host/xhci-pci.o: in function `xhci_pci_resume':
>>> 2942
>>> xhci-pci.c:(.text+0xd8c): undefined reference to `xhci_resume'
>>> 2943
>>> riscv64-linux-gnu-ld: xhci-pci.c:(.text+0xe1a): undefined reference to `xhci_suspend'
>>> 2944
>>> make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
>>> 2945
>>> make: *** [Makefile:1250: vmlinux] Error 2
>>>
>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/8883180471
>>>
>>> (I have also 2 runtime failures, I'm retrying those jobs.
>>>
>>> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1630005263
>>>
>>> ). I partly reconsructed To:.
>>>
>>> Best regards,
>>>
>>> 								Pavel
>> Seeing the build failure on RISC-V here also. The fixup patch was a little
>> too aggressive. I tried just removing the #ifdef CONFIG_PM around
>> "port_is_suspended" in include/linux/usb.h and it builds okay.
> Can you send a fix-up patch for this that works for you?
>
> thanks,
>
> greg k-h

I just sent a patch. 
https://lore.kernel.org/linux-kernel/20250118122409.4052121-1-re@w6rz.net/

I'm not used to sending patches, so I hope it's okay.


