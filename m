Return-Path: <stable+bounces-66056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A294C023
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7421F2A337
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7518FC6B;
	Thu,  8 Aug 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Z6Z1AO3x"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBA18EFEB
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128216; cv=none; b=nNIXYklNZwkDUbs4rMXXVmRcWbDlL4PKVMAsyhYQaKxiV5iSfq8DFq4rL+lRhe3acWMvwEUomqed+vCtfcma4cZY1txSmVv+CVOtfYCUQl+3Olpum1l0J8mRjqbz5OH7wdEu7GFfzQ4Prb7XrfjueyHACFssC8eG/ZAsV/XOlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128216; c=relaxed/simple;
	bh=gxUG3otazyRmWtgtSd/bddgJMTeONC2VbsWENIfBB5Q=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tNWzx1cXvMCx8WCS8zh8SFhbhbVEdlVYAxF+cC7mtV6bzW6IDbNDMKt1G5S08GuOJUyvlDiHXY/Jf5TeGVuTNBMKiNvBmCnAlkAdgUO4noD8cv2nYBbSWf8Cz3umi0oSg4iEap42upkfvir4AjFqfveLVKYYHZCZi84vsfAxbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Z6Z1AO3x; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id bz3qstG4uvH7lc4MSsYqCi; Thu, 08 Aug 2024 14:43:28 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id c4MRsCEvBV2ivc4MSsjX93; Thu, 08 Aug 2024 14:43:28 +0000
X-Authority-Analysis: v=2.4 cv=OLns3jaB c=1 sm=1 tr=0 ts=66b4d990
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=nePSiPpqfSlj2YhcidoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YvH0f9/zTah/x6FI6Uo6PpueB5FzaxCQ/9Pzsx8uzqY=; b=Z6Z1AO3xIs+UBYjZcLsI8+4lNa
	rPmwnp13qZfnhIyn2pN+rC6E9AV+D+FNbxt138rAft+yrmJs/XvlXIZsBBQ6nlIkmKHLdBTsG70JO
	BUABhh7sJqGQ/y7lz9S2ElSOknGgWMrozsoqpIPkrN3ulrCsg07xpKCiGI4dtUY/RtyE0Eo5GNSf/
	Nb5fOgVbP3Ckvp7lF8kA324SjiHjXcBi1gefAg4WgoJwu7B4/jvEEOeaS5evfWoQWcF9PDEH+f9G6
	AwhZFyHl17280XsG4N+bGIvqgVj4GVwan95jYcGgDsnLzZiEn4GJSwywX2bLzPdItoKOZgTV5XdcA
	pQCA+zrQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33482 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sc4MN-000NZn-02;
	Thu, 08 Aug 2024 08:43:23 -0600
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
From: Ron Economos <re@w6rz.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240808091131.014292134@linuxfoundation.org>
 <96b86f9b-c516-9742-5e33-e5cbfbed10b3@w6rz.net>
Message-ID: <c4b1489f-42b8-8c16-f487-93b0dd8cd8c4@w6rz.net>
Date: Thu, 8 Aug 2024 07:43:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <96b86f9b-c516-9742-5e33-e5cbfbed10b3@w6rz.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sc4MN-000NZn-02
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:33482
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA7zdmi2xKjeTE5ziu+wQEQFJh59z7ygl/gzm14SE/YUPSnlWBIVNQab/wRShIhGPvnCapg7ulkBRqfxo2xlu/H0KY/CH+oMdqv8+LoMa9Q/S4B4Qyn5
 sKDdZFnjmlrpvtxuWCgWDuoruCtw8wC217UvYJYVV88eHdwRoqVt5eNBbZOd7L0xwKEHkvpa5uFdnw==

On 8/8/24 4:55 AM, Ron Economos wrote:
> On 8/8/24 2:11 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.1.104 release.
>> There are 86 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.104-rc2.gz 
>>
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git 
>> linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
> I'm seeing a build failure.
>
> sound/pci/hda/patch_conexant.c:273:10: error: ‘const struct 
> hda_codec_ops’ has no member named ‘suspend’
>   273 |         .suspend = cx_auto_suspend,
>       |          ^~~~~~~
> sound/pci/hda/patch_conexant.c:273:20: error: initialization of ‘void 
> (*)(struct hda_codec *, hda_nid_t,  unsigned int)’ {aka ‘void 
> (*)(struct hda_codec *, short unsigned int,  unsigned int)’} from 
> incompatible pointer type ‘int (*)(struct hda_codec *)’ 
> [-Werror=incompatible-pointer-types]
>   273 |         .suspend = cx_auto_suspend,
>       |                    ^~~~~~~~~~~~~~~
> sound/pci/hda/patch_conexant.c:273:20: note: (near initialization for 
> ‘cx_auto_patch_ops.set_power_state’)
> sound/pci/hda/patch_conexant.c:274:10: error: ‘const struct 
> hda_codec_ops’ has no member named ‘check_power_status’; did you mean 
> ‘set_power_state’?
>   274 |         .check_power_status = snd_hda_gen_check_power_status,
>       |          ^~~~~~~~~~~~~~~~~~
>       |          set_power_state
> sound/pci/hda/patch_conexant.c:274:31: error: 
> ‘snd_hda_gen_check_power_status’ undeclared here (not in a function); 
> did you mean ‘snd_hda_check_power_state’?
>   274 |         .check_power_status = snd_hda_gen_check_power_status,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                               snd_hda_check_power_state
>
> This is triggered because my config does not include CONFIG_PM. But 
> the error is caused by upstream patch 
> 9e993b3d722fb452e274e1f8694d8940db183323 "ALSA: hda: codec: Reduce 
> CONFIG_PM dependencies" being missing. This patch removes the #ifdef 
> CONFIG_PM in the hda_codec_ops structure. So if CONFIG_PM is not set, 
> some structure members are missing and the the build fails.
>
>
Same failure occurs in 6.6.45-rc1 if CONFIG_PM is not set.


