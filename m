Return-Path: <stable+bounces-134662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14886A940CE
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 03:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0377A80C8
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 01:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991BD84D02;
	Sat, 19 Apr 2025 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="OpkmPycL"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB71C6BE
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745025850; cv=none; b=HJ2fUOTlvD8KjSsamqTEGDQ05Tv2hZY/GPHnWMfJHbcwnRw/QIatIiWGiwoVR4YCsMa26dcPLT6STR+2UQrhGTiCI2ZOsp/sU42ZVPASvYS7pHgn6njv8c7ldK8V8nLCPEm9S6x1HNkoU2R+CXmIddw3AKaGjVtZneaZj8nwB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745025850; c=relaxed/simple;
	bh=S2MJmhbus8YIwuJmB754nUipcA15zfIREhQScbrWOys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpnqKeakP904P1vii9LqIAH13WvtthgCxmVU1cBJabMGzYIBtd/AvXG1JmFeoQWqyKN4QaTjzKTLY3ZkvJc+2bkyVnGs9+jMyns+ynAXhbhObK//vjrhrPLCFtCEO0B3ahKoWzW0EJB8b3sDVyPY7NhwHSJSCUfL05gqwHrfxc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=OpkmPycL; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id 5p6ouJDiiMETl5ww3uwrMk; Sat, 19 Apr 2025 01:24:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 5ww2uqB7GkmGT5ww3ufxBF; Sat, 19 Apr 2025 01:23:59 +0000
X-Authority-Analysis: v=2.4 cv=eYM7faEH c=1 sm=1 tr=0 ts=6802fb2f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=16BE+Vvb3MrJ28vkUhorkPNFAMHTd1dyG57SbBGUkEs=; b=OpkmPycLbcgZch1FlWvlcpNiwN
	gIdAtFbJVy9serPX3KVxFBry2qKNPsBE0LxWmdXrwW2Sg7SJQJBKlu9PyxaSoOM6/u4OHwnauWZH5
	2f6L8BQwsV3KY0f1plU8NLjH2CV1xMS56kdS1UZ1AhGIG7lbFySdgYhp5Pi+PzqOiysOFOQQfhw7H
	6ZbZYH3zZGhK9pytq2tjaRa2cMsEYM0JDKOV/8GS3EgmQlzETUxFtNb13xFUBFNuqeY2K6c+lGGSL
	1k1haHFYFEH25IPf0ecaEe/y6FQePMQb7L2UFEXT8AKNYpo+0U/fdhMe3HkRBtLuRN7E3r8AzxSo4
	jcdOw79Q==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39168 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u5ww1-000000003XC-083l;
	Fri, 18 Apr 2025 19:23:57 -0600
Message-ID: <ca91d833-4557-4bf0-a310-7d41fa64b85e@w6rz.net>
Date: Fri, 18 Apr 2025 18:23:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/447] 6.14.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250418110423.925580973@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250418110423.925580973@linuxfoundation.org>
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
X-Exim-ID: 1u5ww1-000000003XC-083l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:39168
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPHnDx5HsJGIuWEpvPFlXb+HcJ3feL8hHmh5Dj7GefMWKSD0gzHNooIR1nw8QUL1as9qT2QNVTJkwFHI3kmap2zCF1mWWbUJygvF/r43TERJIw92LQRZ
 AGVPzS6TIZzZRpc+olNlglopYcmuVyXRX4xnWi4WS7mnq9tR5KD9r/1NHGqzyRxkYFh7rOpfONnIyg==

On 4/18/25 04:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 447 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 20 Apr 2025 11:02:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


