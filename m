Return-Path: <stable+bounces-72763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E949694C2
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 09:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC38B22D82
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDAC1D6C77;
	Tue,  3 Sep 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="jId/djHM"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8531D6194
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347349; cv=none; b=kzd/lXkmVQYYtutViA6GVJrmxZgBnhqGOgDY7KM6UYR7lWtWz47+/h0frfqledVX0+hVaZZOogA0QS4WR8fJtJfu5OSZ/q3M0hIWLHfKp3JDdgPSiNWBxY4NpIcyUjUj7pLakMJS3Mnk12gOGtSMY0pUVF8mbQso448vp6aewqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347349; c=relaxed/simple;
	bh=PLl7HZaKNJmlzuDTxOMe7aFguk1ZmVE1Q7rqbPiG6KU=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=AmpzthYafFrl/M8UYvYYEkj7TLTz9AV1A08IFdXFO+K7gTcolWhBNsk/EVhdsjH+Y7HQ4M4btD/XI5ltgg1GRKHyNVM3kRVNaYXrRrMMjUo9TDChWZK4ILssCmoQ1Hkl4KEzqAmQoewd7v3zTJlY9GPxBQhBq+rlnK2O11AVFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=jId/djHM; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id lNaJsZfPMvH7llNevsZxWP; Tue, 03 Sep 2024 07:09:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id lNeusfjLyVf7GlNeusPDRU; Tue, 03 Sep 2024 07:09:00 +0000
X-Authority-Analysis: v=2.4 cv=H9TdwfYi c=1 sm=1 tr=0 ts=66d6b60c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5qKvnjbeiT6eEQl47fWm4Ghr+gJnjmRt7nSNZM9Mnu0=; b=jId/djHMaxTm/3Spe3223xhjGh
	I21SlGFNBIx6BZPmexb34+qTAWACEDJ7jFEExREoV3keMcd/kX2sn3+VHE5q6j4YPEXHN0Sw5FViX
	x5Z2A9z3pNtb0DefvYWjSMp0w7Izzu04Q0YL1iZ32bcFK7ec4DWGili3kuem9eqhMe7mPlB27mBai
	GDTHhzAmfiljrI0CLXab3pO6at8hMYkzVM6IYxv6LBKpSFQTjlYMNeSDSllSvFklo5utyBFEAkxQO
	Eo/I39761qkiRy8XNmcNBhntW7tcG7QjLGcC4xiNEeCPajvwkP37rqqj/cgBKhWe/M2cVGC/Mku7/
	4Ds7dACA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38084 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1slNes-003kL9-0Q;
	Tue, 03 Sep 2024 01:08:58 -0600
Subject: Re: [PATCH 6.10 000/149] 6.10.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240901160817.461957599@linuxfoundation.org>
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <bf6c8cff-f533-9a94-0227-6f187e51c24c@w6rz.net>
Date: Tue, 3 Sep 2024 00:08:55 -0700
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
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1slNes-003kL9-0Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:38084
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE0nXF2/q/KtIZ8GTUTPOoouWVUdXqMev40OkN7yj7y/Nth35CEVhRiyEJrdA2pUIKC9/PR28SYZ7a2+sl/spjMKPAp+tS4h2+ylANjmbEuY6Q7tb3Ow
 sJOWZycz382WEth1DUJywsrN15a3pkEsxsW7objKMpOUcxzk3zsmiZ2+m9h8Q/ZgyFDOGTUcT+Tyjg==

On 9/1/24 9:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.8 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


