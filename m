Return-Path: <stable+bounces-194484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5776FC4E22B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3893A359A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6E833BBB4;
	Tue, 11 Nov 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Z6tn8a24"
X-Original-To: stable@vger.kernel.org
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38933ADBA
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868136; cv=none; b=bBju89mbt7WexERpV9d5BbRmn1af3F/L2C2pMiMNMhNgNo5aZO/S1I8g1SeTTLckEigVlh2ApMtTqaseOmNMAIZg3eFVLkWKdwq2ywDYQpHlCJbvodqBTN48zyWkRquaiM3Vtc/S7rwUdFmKHPLYNQuh5a05NySV8pAkROqRhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868136; c=relaxed/simple;
	bh=z3ZXIvYXjsVZ1cD1nGTaG3KtjR212/GOPRxgC4R+gjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgCVcLPRMxjmcdCjP9ez5TP1o4U4YEr/adKpKXSyhD0VfGyU9wXZA2uqNElIQ9l7JHNcCJv27dzR0wvYIDozIYy1Z86EwizTaetQ8IXo56ylI1IijiBAkwIj2i1u/iTPlNshxI9bl3AAa8Q9gxj04fU8rqbw+UZevYwoYsTNHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Z6tn8a24; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id IncWvU4vdU1JTIoWzvg6Lz; Tue, 11 Nov 2025 13:35:33 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id IoWyvt76eHjyIIoWyvP9dj; Tue, 11 Nov 2025 13:35:32 +0000
X-Authority-Analysis: v=2.4 cv=Ys4PR5YX c=1 sm=1 tr=0 ts=69133ba4
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=RevD4IuIZOIosi7Z3eEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lbR3b93pZJ23GTDhYqz9VgVXdiNorbDVnSQIsSbsXBw=; b=Z6tn8a24re9S72cM8gmbYrfsV3
	iFti/DNsI1OJkOaCuRuiWQ2Nyj97U4sMSqNGZ/rUMxmdywC6DxUr83wfQORBIVTs9PrSWqgP0n/c0
	OoftoXYS3HgoQPf2s7seJDlkQXsIRV2TEMtXvJc3muPae3OKkx1NcXvNFs6oO/+e+bwe5hVCcEtEr
	cdeeTeVTuS3/dsmUw5h149ckTEbywovW6NqZuBd+1Ug8t6J7flvahipsfpCj/h8SlmFm6SaImq2n9
	xd8rlzEGcJnc6OkgT94dyXJYB31NnEaPTzcYcDyRki4q0m4Zkl74TmZPX7Jcvb/N95S0UJqzxc+Kl
	td7aGZHQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:40038 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vIoWx-00000002Kut-3fZy;
	Tue, 11 Nov 2025 06:35:31 -0700
Message-ID: <8b790183-00cd-4dda-82a9-0988eda9e6d4@w6rz.net>
Date: Tue, 11 Nov 2025 05:35:30 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251111012348.571643096@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
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
X-Exim-ID: 1vIoWx-00000002Kut-3fZy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:40038
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMUieyu1EWXHSBv5x/AxLNDWCdSVj7JWAYcrfMyY1auFzZo1zaY3lIpZWAoE7NFn9RzuEOk08+SS08q6Jb3Ie+kCnit3kb6XoDYdeyHPe7hBXRoavc/Z
 Mx+wZwPrbFtZXpYT7n70RozCUKRLNRaiD11X1UUWkVdncUcTUBKgVpUF3/omh8uI04QE4DDC7RY15A==

On 11/10/25 17:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.58-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


