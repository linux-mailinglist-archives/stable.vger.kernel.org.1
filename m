Return-Path: <stable+bounces-110131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C13A5A18E3B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 10:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E3B1889421
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA320FA91;
	Wed, 22 Jan 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="EPUDDcJM"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B4170A15
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737537919; cv=none; b=RMS4lFnPj0a5AgQMqYYwqr7B0ngdNdNsrI2NbhMPeoRL1S06TuUrT7anOLbZ8VYp45ZilMVwyqfGF+GNRX28sCGX8figmkPgBqCslXQZYihQ/Q74PBkRYYDZLTPSl1mqrBNot4slgF32d6voM9K0L9G9Qt7yeT83GvMcXf6fa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737537919; c=relaxed/simple;
	bh=8pNMb0JP4o/bvyW+Pk9DSWQUwdyag3bbbosZK/1Qo0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppkVnyjd3W0VBGAGB7ftrmy/qBZOwzJNez2FKbZxaKpVxxfytIAk6DWV77u/TXr94r+p5oUJYqwDmWep+wSjSnTBz+fCIM38LkuARB1eHDnEcH2H9jKZgtnR+eHABF8iOM7qsbDMHZvRwzm3DsKAEA3V1R0WHfP7KW9Q4ES7JBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=EPUDDcJM; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id aQvvtoQxhzZPaaWz6t5unG; Wed, 22 Jan 2025 09:25:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id aWz5tLsDCWvXpaWz5tWt0T; Wed, 22 Jan 2025 09:25:15 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=6790b97b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Uq39ju6kSRtdd0OyVAAA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rWrATLw9KAaYe5G7DDzhULa7ryqVnKqVpE7hyRK1FeE=; b=EPUDDcJMATiNkD+FjcHFoL6Yrx
	PW1NO8ZmJfBn4VpzbN8RjsDCb2h6HlvkYRaYNIVYP0Y0pQQZlRtAk431S3oadrj6wyz7uYU3bWpo5
	l5d2gibTkRK7hXFiNP8tE+PVxs6d6FwimXJjxgHNFgU5QjFCC4+ShpdYmEEJaUWt1opGEZRieZ1s6
	Porm6zJeR1RNy72ERcQ0FOkIOMgseTBQlxpxhCUP22S0OUvVhzIwbEZoCI/sRxi2r+W+f0tJVCrrX
	OdSbRCHJ3X9zAgKaTEvOZ6h+UmLx9Vuk6gtWXPoEYsrZ5QQd65OP/cbc7MApNn/mFUifqL7K37Szn
	3Ei37MFA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36776 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1taWz4-004HMI-0k;
	Wed, 22 Jan 2025 02:25:14 -0700
Message-ID: <02c15e0e-d2f7-4335-9627-5ced7dae36a2@w6rz.net>
Date: Wed, 22 Jan 2025 01:25:12 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/72] 6.6.74-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250121174523.429119852@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
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
X-Exim-ID: 1taWz4-004HMI-0k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:36776
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB1Wrjh19YJrF/f2ebp1zjSIY2WKgjiuF8yt+Gb83vLZD6fyIHXNnFbD4pbze/B/wrEA/Qujn2y4gtIMdcCfUNJ1gsaKUcCkWA49uycS7FLfhg7spYG0
 z8m7MQWaMfKQT7g8+HJruov+qT4LvWLNNVCNxtN0WQoWWIw0RVCxl7GUniA1MwqCFkKLJJe2SOp7EQ==

On 1/21/25 09:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.74 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.74-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


