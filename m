Return-Path: <stable+bounces-144143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C2FAB5019
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F14E3B5B4D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D10238C34;
	Tue, 13 May 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DX9UobXb"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0D239E9A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129329; cv=none; b=JZdd6b6hvJ/jZm7kCA8BvTJZVtqQyuMiWL83r/gpwpmDp+/DxeSBQ48gWYP7ZpzKQkA6pcFCHEbUCumKj8gC9oNya0D9pZW+8NqLNqvO5ih0hVE/rT325rxzry3dOC8smht1IJNV5FMHP8ZGR52wp/WBRX0Oh3j8hICkc0TKymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129329; c=relaxed/simple;
	bh=R0ZublMzHi0L5F2UjZoV4w0MqxHy5eMAtevtdRGQY9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEOXQRaZaUT+8lIdHl1zjLMwlQew0snEPiYpzA0LcRHh+2W9oEnulnQInnWsBrHflqzM5AnclKfVwZnontQ/ZIc1XodOpot1CErK/DCb7/7f64cfdJfFe7HOn1CKCMFqOVkuTfyq4Tj45Qrj8NmtkOwGp4W2XOAtOOm/IZ+PeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=DX9UobXb; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id EggyuDbDmzZPaEm99uTVU9; Tue, 13 May 2025 09:41:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Em98unIBQsI0JEm99u33Eb; Tue, 13 May 2025 09:41:59 +0000
X-Authority-Analysis: v=2.4 cv=G5caEck5 c=1 sm=1 tr=0 ts=682313e7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mi1f88HNeYx7h5VBROdUl3nH+OWMQScvPND+LUs4vEE=; b=DX9UobXbZMX2Wg2K7y5eebV3ns
	vf9xH4EDijfaiLZDWO1YZTr/JCrUvgY1yNnDiVagX3shZqVsQsFacmtomcEw+c1I08k9PLk9ie99a
	vxJflzsfE09E5bNaPw2hRfIhbAGZhN6AE3xRz84Eg73jrOKhh6Pl06P8EkpUifEUA5vMg5m/YTLBo
	sBgA+yCrh6sXJXoJ595qu2ie3uZ5SDs5TvTP4x7gKsu4+lJbkI5EXHu4LLhz819k0hf+V+SJTvfDN
	Lg1AdSilCKgG6nqKHaWCPf2KAlHig/RQ9qI2pNK9xMeJoS2hnPDVEsZh1jAbEwm2Gz0wBIzdu55CY
	707XvNMw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:51786 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uEm97-00000003Gwe-3AWM;
	Tue, 13 May 2025 03:41:57 -0600
Message-ID: <f17c341e-4618-48b7-aa08-eed73c24afff@w6rz.net>
Date: Tue, 13 May 2025 02:41:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172044.326436266@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
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
X-Exim-ID: 1uEm97-00000003Gwe-3AWM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:51786
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBHl32GEXPBpfx3PtM//DKkwibZksZLUuLDyvd5kJKo38zmo2a1We9j91oHNOtAl0OilfKglvC+CCy7tLMcuKsDhm/+p/w3bOPE4f9PeykKWQHuP+LVB
 BTDE5aSHJ9UdBW6nB6YWhJJv2AyrJMI0V2tbSTaO4LFcJq70PR5FOiEV3I4Py1KFspe+X4ua80BK/A==

On 5/12/25 10:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


