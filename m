Return-Path: <stable+bounces-111817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D980A23E94
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A83A8E37
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0FA1C2317;
	Fri, 31 Jan 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="IzU+TW7h"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9EEAC6
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738331171; cv=none; b=ZDGx59b++fkEggrctZab0ZhV22Or/U7O6MRVCxVGGC/nJHxt1um5VlU2aH9cLxoh2BLmtpQ+Cr5n9FrCqoztKpprppJrcg3EyPlZfolirepORKCfcke8Y/Mv084S9RDRFAlVewfgMh2+oqQxr/OzxSmqYovJ0eXHQfInug8QKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738331171; c=relaxed/simple;
	bh=kYAicBQzP6lZkPLYESvS8OVEQ92iGRvrp/Q2LPztiY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IG2mi2ST4LeEiCTzOpGrON58xcGFwyaQq5SuSZhfltfsPh2IBhND27CDJ9a3B6iMDfNIn2+uj6BQz8JItSjxGkFHriofpxhRkwq7Ifep1neLiITQjmQBrIDbnwu627kL3v+88bSkDbTQDj9NN4IX8i3+pzPvYVErO78ygRMR9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=IzU+TW7h; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id deS4tinX21T3hdrLTte5EJ; Fri, 31 Jan 2025 13:46:07 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id drLTt6M2MNMSldrLTtKwF5; Fri, 31 Jan 2025 13:46:07 +0000
X-Authority-Analysis: v=2.4 cv=K9DpHDWI c=1 sm=1 tr=0 ts=679cd41f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=4ymXsQHb-jpPZ-Q6s_kA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8g8OSTb3F4xJ3W7Ffuk4ficOVIujrH1MMJWWuOz4Djk=; b=IzU+TW7hmVcPNIgClfeyQAiUV0
	WJ/1XfbMC4/ECXSl7hDp1vgumY4ntv+yR5vV3lvMmQv5FC3DW1asdSPVeSirsOWaKwzAFCMaTBuGU
	vkSajZnzykE8kOqfYTNgVuS+3X9w8z/8VELrbD57UDHs3SYa8iB0JLV0zsyCwUcQsSos1VDh0J1zP
	y5XV6u4BaycyH26aurRJNWW4wdqm3B9+ucKXRfNYHr9gnScLHwaP27QNB99MKn5wuOCz5zmvjyCOX
	ps9V6bYzZfMLCgsjeRUKTzwnCRyigFG75pClfgkrPtNtdYPcSQudd0uH5ve4Z/LAhP7dM6DzLlzie
	zZXoDCPQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:58624 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tdrLS-0012AL-0j;
	Fri, 31 Jan 2025 06:46:06 -0700
Message-ID: <b6846319-33b3-4f38-8cd0-1914f896ce90@w6rz.net>
Date: Fri, 31 Jan 2025 05:46:03 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/41] 6.12.12-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130144136.126780286@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250130144136.126780286@linuxfoundation.org>
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
X-Exim-ID: 1tdrLS-0012AL-0j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:58624
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLayNdV1j3WGo2vhN7WTQ24Wguv/QExEr4twM5TWxFXopWmWamSEjTRn3NSLy/8Vjr7YgOXXmkPT6aEvM8fhFsiUxe98A1pnDWjgdH6GTS04UuW5ODwF
 gnrYM297Pqt+IdKdOuYbYtKx/paCNt0ORarhcmTABIOJNwAnIvv1zHEVbhH/tTRw9qBxSQJyfLkYIA==

On 1/30/25 06:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 14:41:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


