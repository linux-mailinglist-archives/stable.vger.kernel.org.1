Return-Path: <stable+bounces-144154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B44BAB52AD
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 12:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2DD1894A03
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E240253F25;
	Tue, 13 May 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="gIYeV1lG"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D01253F21
	for <stable@vger.kernel.org>; Tue, 13 May 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131293; cv=none; b=fg9OSgb2Dk3iyZVe2d0tYlCZFR9Jre45g14HZ6zGXsQBMnxz3nJ7F6hFyL434jDjiJmbGy7gHkipZ7ybk+JpPe6/JVytHH3+W9bWPekwL+MR+/g/ie8GITxEHmj2BxaPKfidRINCaassxo52J5OCwIALdp9wFJkv00yA4cVNRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131293; c=relaxed/simple;
	bh=BdTGy28wMZlgh3Zpdrf17IYevdmEz295jwjYmhNjv1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5ija6LqKy+N3DNJIk5lEUsisR3TytHFrRHmfG1+QapyMzLjy9abPoJUN0e+PMj2xJXCOgN5lRM6opG4rk2Y8yZWFkkox6Fnaiglr+TWK9EjlZycoS+WnraJu41zGR8f+h0XbhliUPc0D8E4d8jNp0ry7W5smcWnmmwN2TFxNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=gIYeV1lG; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id Eebiu8nwhf1UXEmevuP4iU; Tue, 13 May 2025 10:14:49 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id EmevuyYnWDd4SEmevuVkKE; Tue, 13 May 2025 10:14:49 +0000
X-Authority-Analysis: v=2.4 cv=CZUO5qrl c=1 sm=1 tr=0 ts=68231b99
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
	bh=FZ5sTdBPW01O8ca3/UvAbjqPfK3+X4GxjMf1K+2FoYw=; b=gIYeV1lGr7Bae2GR0YYuGarm/9
	0v2iKHrexu3oIujgXHNL+yvUwSpuy6966KnghO4x1bUhufFWuAPdinQEuRQqOMPDydtN0apf9eOxy
	r6tW27qKqaAoqJof2TOq5XbboAa+852tt1EGbCFJ9sNeHVhHn+4oHXISNe+Cb6681LwpEdal9Hmmv
	ikKLXdqpvbPdXHqv0ZkNA2FD5/6xX0E9cAVvXTXSa2M27ERTWWMu/ckAImj5ji3ckVsnIwb0vGpwf
	hFqtuvwAWjsOsR04nwrjs3HwNP4v7qXCaphpOt3YARdDSwi4iW2nTfAeLUnw7blTIye+tmkDVco8d
	JdTrCueA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35082 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uEmeu-00000003UJy-1PV9;
	Tue, 13 May 2025 04:14:48 -0600
Message-ID: <0df0d357-8dd3-4bcc-ad84-675912bb465b@w6rz.net>
Date: Tue, 13 May 2025 03:14:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/54] 5.15.183-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172015.643809034@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250512172015.643809034@linuxfoundation.org>
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
X-Exim-ID: 1uEmeu-00000003UJy-1PV9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:35082
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLZBa2xXMJtzG6XjITO/cmYETZdwnLBVzvvMUG+enc4WGdFT3U+ztGslKSgoaFXvREn8qTYylQFh9nn+r35cgwLs8k9cmOITRwb14Ymzb54ZNaLHW4z0
 QiPIAnjNxv2pACT048H5rybckKqaP6I2FJhGDWjKsqrWL64rOSR5qRVlrKyxoqh/vKXvPhOpF1ebCw==

On 5/12/25 10:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.183 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.183-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


