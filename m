Return-Path: <stable+bounces-66030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E694BC9E
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 13:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFA81C2200D
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B13F18C321;
	Thu,  8 Aug 2024 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="FNSo6y73"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B118C33E
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118142; cv=none; b=G9nkUFLh3SkYr/sQcQD6ICJIypqTuZqVI3sd/YrVp7E7JJCi2omjvRDCahbRBEsiorjsdXTpcDhK7pFXYHDWe5s/mEf9FHMMis8MtVYvQJbqTf2zylhhYwGZIXz+Ryyn1uMDsFxI9MTLMR8AfPmje6fmlf0brSoMHEKC/RXbU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118142; c=relaxed/simple;
	bh=maJUu45KZlX7FeMIpGorIoOQMDIfA3yf1EfQUBBVNCw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r/M9Znev4Yn+eIuXKrGXMH7rdI9u0ETCNKKfM8HVc7vJ3SLpcPTHLu2zhJktkxm1heB1ir43tUyF+nHlS72wgAFaW5SVL1ZGUAli4VQYoIyXWUR6YEPwZGEIeN2106oUMnZVp+xVRlZYEFJ4E041kTiD90FE1MP/WOKe8UPPFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=FNSo6y73; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id c06lszxZjg2lzc1k2sTbX5; Thu, 08 Aug 2024 11:55:38 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id c1k1sK0AWcHN5c1k2sFI8g; Thu, 08 Aug 2024 11:55:38 +0000
X-Authority-Analysis: v=2.4 cv=W64+VwWk c=1 sm=1 tr=0 ts=66b4b23a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=1GQxe75yrw9fIeUcjpcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZcW3HDl9lOrDODASspPnNrMUFSlpL6DN7JxGWATxdsM=; b=FNSo6y73QOcH0KRxzTpHWAfuDE
	XjDpnN2zCFcXZXQh/ih/nF6xDYJP/gsJA4bxE9chfT5tIgr7NstxcXSmvDKq2W+GUzZqPcBxbr0hG
	dYNLBX/OJ6ALdcMTsuqlXJtXAxzpWzoqc7m+rHlHhgyJOP2Q6ifZJYciXEuUNKRMEL5wsAuUW0OWk
	O1fyLSOFTo+R5cx8Hfmhjcw9TIQ6da2Xl526dYEMYCK4+un29enuIXILA0G5YdHj7Se6705Ad/Qcr
	TpSeeqggYFqY63oDV5wTt+ltuup5NIBRrR9jrFgYm7fqROfPAs1fhfwv0GC/wbBjtlckKfe5uHy7Z
	HzlI9T4g==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33410 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sc1jx-003iMd-15;
	Thu, 08 Aug 2024 05:55:33 -0600
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240808091131.014292134@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <96b86f9b-c516-9742-5e33-e5cbfbed10b3@w6rz.net>
Date: Thu, 8 Aug 2024 04:55:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240808091131.014292134@linuxfoundation.org>
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
X-Exim-ID: 1sc1jx-003iMd-15
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:33410
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMFDBKjOLrEnd8/D2Rg2x9n34n1qinA1SADbof1nF4UF+cQ2GmM3mmUFmtrF2owFJFaMMux/kdbRbZD/IegFY8FYL9BMN08a04bFbR0agoeTFVam990f
 RCjaU8uAQOuWNujZeONP+/jMm4l53zPnrZp450ysCCnyOOU6xbVOYS50z3yFfNZQIVVjjwB5nJ0xkA==

On 8/8/24 2:11 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.104-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
I'm seeing a build failure.

sound/pci/hda/patch_conexant.c:273:10: error: ‘const struct 
hda_codec_ops’ has no member named ‘suspend’
   273 |         .suspend = cx_auto_suspend,
       |          ^~~~~~~
sound/pci/hda/patch_conexant.c:273:20: error: initialization of ‘void 
(*)(struct hda_codec *, hda_nid_t,  unsigned int)’ {aka ‘void (*)(struct 
hda_codec *, short unsigned int,  unsigned int)’} from incompatible 
pointer type ‘int (*)(struct hda_codec *)’ 
[-Werror=incompatible-pointer-types]
   273 |         .suspend = cx_auto_suspend,
       |                    ^~~~~~~~~~~~~~~
sound/pci/hda/patch_conexant.c:273:20: note: (near initialization for 
‘cx_auto_patch_ops.set_power_state’)
sound/pci/hda/patch_conexant.c:274:10: error: ‘const struct 
hda_codec_ops’ has no member named ‘check_power_status’; did you mean 
‘set_power_state’?
   274 |         .check_power_status = snd_hda_gen_check_power_status,
       |          ^~~~~~~~~~~~~~~~~~
       |          set_power_state
sound/pci/hda/patch_conexant.c:274:31: error: 
‘snd_hda_gen_check_power_status’ undeclared here (not in a function); 
did you mean ‘snd_hda_check_power_state’?
   274 |         .check_power_status = snd_hda_gen_check_power_status,
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                               snd_hda_check_power_state

This is triggered because my config does not include CONFIG_PM. But the 
error is caused by upstream patch 
9e993b3d722fb452e274e1f8694d8940db183323 "ALSA: hda: codec: Reduce 
CONFIG_PM dependencies" being missing. This patch removes the #ifdef 
CONFIG_PM in the hda_codec_ops structure. So if CONFIG_PM is not set, 
some structure members are missing and the the build fails.


