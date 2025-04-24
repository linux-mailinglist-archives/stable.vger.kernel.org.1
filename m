Return-Path: <stable+bounces-136525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5AA9A311
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF71945E07
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 07:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81551ACEC7;
	Thu, 24 Apr 2025 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="F/KHw3Jp"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB31CEAB2
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478929; cv=none; b=B03nVSZMUhRUTd6SsYK4uFprHVCASIe/+NsrA/qjRxs0TzlfdIe3bCe6rLGfXaz25b1JX650AOejfSASYWKMzYZOe7+3rLs3FQiAiTnkof/xhOEyjTYeInH4ObCISDA0I72LVLmM3nrGK+KDKc6eZR69KpzZg2D2iPiSG3pcF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478929; c=relaxed/simple;
	bh=iD4kGIwclU4+/EfwQJoURKmsYnXw02hy0AHD+6ErLUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma8OCn9a67mZ/o2jEoSzIFeUP7kxXEBwnquWFttzWvGQC6rvvVWGKyrSDr6N2XdpjM/Su8dW5pnMrO5zXMI0Bz9fspvTuRgaU8sT/cJCy54YYxtHy7Hhvy6VfsYkHkmrchooTdue66T8xxqTXw8VQbkFQGrHrKgGBNlJq7rRxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=F/KHw3Jp; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id 7i8Uu2x04Afjw7qnpuCkHl; Thu, 24 Apr 2025 07:15:21 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7qnouHYoSrsgD7qnpuqa3i; Thu, 24 Apr 2025 07:15:21 +0000
X-Authority-Analysis: v=2.4 cv=TNGOSEla c=1 sm=1 tr=0 ts=6809e509
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
	bh=FIwVkz7rpymhvBS7w2y2r7WbeCWcuoUnG44jIo3M8qg=; b=F/KHw3Jp/zicfMfmDxm8jku8yt
	CQzJaqwBU9NY0wTKYnHy+OoPjQxZSXivl1k0CjwJafeHrtnMJjKgFLDvoUmLvBGishBYwWfMgZUW0
	kSRfhq1z11nAf4VQeHQIt3HEaUAWdg3FSeKwQXf0x/Iv8ut3jFReudv6PbVKFaHuAKVTbyehMDCZw
	jjNfWoV1qNgbrbSOZ1mLMYPLVk4T1A4fnvhHUKD63suCCfWWXvRg7iDaUfEsQC2Zqsv6k3XDnIjxC
	F7kco9ZZYEe5BDQRGjutD1FAXDD69wwLfRHGVQVdKN6AKZnaS2HeHnYp+9sj8aDSQjKZZgsVYQ6TG
	+sqgqA1w==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:39532 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u7qnm-00000002qKD-3zY3;
	Thu, 24 Apr 2025 01:15:18 -0600
Message-ID: <e1f56764-88fd-49be-8be7-9fea79c697f7@w6rz.net>
Date: Thu, 24 Apr 2025 00:15:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/223] 6.12.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142617.120834124@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
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
X-Exim-ID: 1u7qnm-00000002qKD-3zY3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:39532
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLTxIvoqeAJOPzUNE9LnumkAaGupffhBlALyrzr+42fD7ALZmH/DBMtzeh5Vxf5PheHxQHjcSxopRIqygpVaFL+iU1/hsdQNkipO64dcq8R447GRZSiB
 88vL4r+1WruEPZl64l1NS7giE0W546qfGWbIRd+cy/vt3nycMBk6H9rFu5r0V3HK86oTCs5GXyVuvg==

On 4/23/25 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.25 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.25-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


