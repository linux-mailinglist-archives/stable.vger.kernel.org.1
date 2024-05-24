Return-Path: <stable+bounces-46110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BB38CEAF9
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367081C211CB
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 20:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376316EB67;
	Fri, 24 May 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="YRrsmH9+"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AED3FB81
	for <stable@vger.kernel.org>; Fri, 24 May 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583591; cv=none; b=GHbfvkd8xbMb1r3wa9OzE95du63ocqvfKliYbQbrd2UOvHWEJnEMpopdQP7w3OUUoO3HQ9TGQOR7P7BMHlTPbb4qPiOvdF3CUfQyp5Qaf4PCqK4omyR+nfiQUCMecghbL+z85b4TDuv+1pSfP4EjLgxQvUMs4GWeUWR53UMoyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583591; c=relaxed/simple;
	bh=4x0p5bsNLSURfwYYVm4OqUI4PejUZ1jbNs2Y393OLJE=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=LAMsL9nigm7DsAHfJj6TOHhtWT/bouYw0u8Ck7opcOgXSvXKgM1/XluWvgwozzx59FO+tdTSjs6cdxj6T7hh5lzmW8W0MXbTjD/J4XdQVwQDRlvFgp6cPNrbHrUEKz+lXrQS9OvFm5RmBTYVkjITHSk3bx6H0HFebhD/CICQnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=YRrsmH9+; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id AYk5sgi1HrtmgAbmXsYpv1; Fri, 24 May 2024 20:44:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id AbmWsuT399zHMAbmXsldWf; Fri, 24 May 2024 20:44:53 +0000
X-Authority-Analysis: v=2.4 cv=fo4XZ04f c=1 sm=1 tr=0 ts=6650fc45
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=BXyYjBD0cXuZo9oD7aYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ubkw6X+8K6edrA1kunDek4yU9WxcX0prhTjNRso+A/g=; b=YRrsmH9+uS7zRqkAu4QJY2AI2e
	Hkky9Q2Onsk9NS7Jf5DNsf7cOKEvzGAYpBli5EG/l9Om5aVxVKA4NM2aRR8+WjmLD6sBK4q3JoV69
	Fxu+z7jVuYC6NMl7VpPStWJz2S0Wz7gVd0SVM+eT2dCup93mbgARVc4kBDzp45HWbzfVSKctrUjsv
	MrKD4d90eUmleK0KOT72doH6jG/qMLk40JMLjb+tEM/ffTxXF6hd8DOz/Nt7y3etwmVK58zzbUHEK
	7xH4H1ObLJU/RVh9jEdeo8saXIEhbuB9jlrW8CfhMgqfUGVcmtaYaFVh9JjEiijm86wwIosmQeBpw
	4+W/+TGA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:39810 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sAbmU-0037NB-31;
	Fri, 24 May 2024 14:44:50 -0600
Subject: Re: [PATCH 5.15 00/23] 5.15.160-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130327.956341021@linuxfoundation.org>
In-Reply-To: <20240523130327.956341021@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <cf69c5c8-af13-d381-8866-41ac2aa33d56@w6rz.net>
Date: Fri, 24 May 2024 13:44:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1sAbmU-0037NB-31
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:39810
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNTjgqwB4nis6IBC6DO35g3JlJdksKVTwjFA2TS6xG8uvvrEjNMhiKtfFnsVkq0ZnwOBctqFDgxP72f55jNj4DOuQNzmx3lWGyZl5bpQHUlQejQNswiE
 qyExaLrUorGVk5Umd1WwFcA28GDK3t/vXsgPTMNgy4zhutBYo1x2bjiQYH5EnLTI7nhNFbwQVldlfQ==

On 5/23/24 6:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.160 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.160-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


