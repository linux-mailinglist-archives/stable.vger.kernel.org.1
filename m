Return-Path: <stable+bounces-176474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F5B37E81
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF83AE4F9
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282FD341AAC;
	Wed, 27 Aug 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="vOKlHufA"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599432254D
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286015; cv=none; b=EQ52Pr/RZtestDY/8StJgNTSOqnHWyurmL0aVTh99dDGObFX7ERKVCHBhYuPDiflVACSILwN0x7EGtuMjtuFIz7fO9oBO7PMbhaoVyBseNITYw9/n5ea9aCtBJFpkS7Sf/VbVr+9k6dGTbtZpMO9dty7bGiMGED4EX1p3tF1nP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286015; c=relaxed/simple;
	bh=VCaK1nx0t2j3rr3ka1B/z0pnxOsJZRFoIa4IAEBrvGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyZBzA5c9yq4at1c0OWl3x1q0ghfR67sdqexvRHCq6mr3rmcNtQz6xRvIDwl2B+k0u3fm9kx3fgY/wdiI8dtRNNka+foq782oPpu3UBSYfGYERR+g6oWTCf8H9IxVQzDiFIxBMPl0yyZU9FJ9XrgnOCmvcjfIc//Q/CqpVm8MrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=vOKlHufA; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id r5pPu8YQwA1smrCDku6DJh; Wed, 27 Aug 2025 09:13:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rCDjueylKOhG0rCDjuN3yH; Wed, 27 Aug 2025 09:13:31 +0000
X-Authority-Analysis: v=2.4 cv=PIgP+eqC c=1 sm=1 tr=0 ts=68aecc3b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=YEHoC-VGhiYLYAQQwFQA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5f6lODDn8B9cgeT7CvBFWOWnpQJbwtJfiL3LPnz/BRk=; b=vOKlHufAgyKn0LGdRtEM8+uoN9
	pzf3YPVTNlF344/Jeu/3eqvgCjkfrJRcnG59gBdxn939rdy81FKW30aMTs60lcw9ib0uAhmY9Qw5a
	Cj528yJOD1jX7O2kuJSUZrWxS0ET5MzfLt1QZb5dCTiYSfzyA/AEdxJeW3LMjXVaTfQRfoZipSY21
	k3jAh2xjRwFBGa1VGWJbRuYoH8vvPv91dXzOjejzrbqKGjWXkZhamEvIVzO1IgsAc5OwybE8QZ5MI
	EbKc2ch59NkUga8/IdqmVVX/6tFo1TszhHRTt/UDl0XJXSYoiz2eAEAJ7KEwcIM8VLoSoNuc2adnL
	tW+fzwFw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36040 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1urCDi-00000004Cou-2Jb8;
	Wed, 27 Aug 2025 03:13:30 -0600
Message-ID: <adbc131a-9df3-4409-9cb4-25699c6f8afb@w6rz.net>
Date: Wed, 27 Aug 2025 02:13:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/587] 6.6.103-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110952.942403671@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
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
X-Exim-ID: 1urCDi-00000004Cou-2Jb8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:36040
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMptpUvomYL0bOX9y/SqooNBTHVqRTSw+AZRHVQ8beHuseO9O/TOqVSHkunYva9w1Bn938aBF8nTslzs50gHIkP7R1CuP/A8XhmTl0b6E5SXuETCvZbY
 YGczwlCinoHRoTmfujLQbzXEQJxQw8+yUW+zuJyfKJV0IGOYWEP2QZmvZOls/nANgzzfCEyEOXI+kw==

On 8/26/25 04:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.103 release.
> There are 587 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.103-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


