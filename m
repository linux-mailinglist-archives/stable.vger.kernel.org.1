Return-Path: <stable+bounces-200755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D60ACB4228
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 23:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C19D30168C4
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 22:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53F329E6D;
	Wed, 10 Dec 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Jia6NHP+"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348C1B423B
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765404753; cv=none; b=CTOUr2rj44HIxZjju7VKp6BcGrGVdaoyNjEGl4yXRXNtJ7Wh+gDsrzxEpshLcNK/QDr9ywKMDGL7hZnzVtEuVn8oVMfDCgEl9wiGv2f+vdufKhjVcmD43aQfa/ceY9mEUaDM3euEpstiIV/fWQnnegS5YX/ADyIZoCkvjx1HbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765404753; c=relaxed/simple;
	bh=3YtcOKY8A31HEq4fRTlcWrzIzVHlAZp8XyxEHvalXWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnnS4SmZQ//iVb9fNQcDdVcAHl82EUUd43WY8a/4HKE6oi0Qbr/tr8qRbPck5rHhrwjNBIClx+6Jri4LSOs723ZEadHw/sz4ygEThMlrc11+VyNKjkBL6JJcde7kwbyp3BGMpR9yuKGewSxSQ/T91a68pZ1iOFe4ZaNXY0B2lQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Jia6NHP+; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id TQELvSUaQaPqLTSQAvAAV5; Wed, 10 Dec 2025 22:12:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id TSQAvM7OMK8vzTSQAvD4V5; Wed, 10 Dec 2025 22:12:30 +0000
X-Authority-Analysis: v=2.4 cv=cJDgskeN c=1 sm=1 tr=0 ts=6939f04e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C3dCAq2CdIGfaK2B9Ymf19bTFQtg6uA8yiJ+ZpzgZgc=; b=Jia6NHP+LA/gsuJHbxrIQme9AD
	k0TIlO54BgA/vVIkka7U/VkQMbqUjcXJVYoD51l8+nYgQXfVdpBAejRPNv/t+t0i0qheMZzQrwoLt
	y5Aa6/HWoPjRQyFw5jFoFzaXHJfmI8AbjzThsFLz0GEFtgbVvZ2zF0Belz0CYLOpD/Snj6+0j2XMH
	wCg4zs19HIpabVroUpLGfoxihQPKXaCXa+44TIupC7HBpkLN50DhT97dtSSv4P6yJbdBUWFoL6Tbc
	Iv890SMegw2tk0con741zt98slgrOB46JI2z13hlEeXGVLy+f0MPE7S/T+UbHlX+tq2jwFGFcWayb
	ueA2XzDA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:46082 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vTSPq-000000011wC-0LRp;
	Wed, 10 Dec 2025 15:12:10 -0700
Message-ID: <ccfd3227-c94a-42da-9d53-a9e4f05e4baa@w6rz.net>
Date: Wed, 10 Dec 2025 14:11:46 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251210072948.125620687@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1vTSPq-000000011wC-0LRp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:46082
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGJn/7Yx5MoixJv9wm0ZXTeh+Dni7+jDU1eOXOPA4aQ/CsP2SZ/4ViOH8RsO1QQRmKOx3Uakf86OgFGIIBsqmyeTIUktrj6yvaFH4SloGKIVaeqxrFs+
 qIMthOpWPhqyosF8nk8HK+w4fzcbf7SzqtUZmhLvPOboAuvOSw8aBuGekRrbAcdRrKTEi2dvrcTjSA==

On 12/9/25 23:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.62 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.62-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


