Return-Path: <stable+bounces-121190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2CFA544C2
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784C91896427
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B11A238D;
	Thu,  6 Mar 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="vCrNJf/L"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6D1EA7E5
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249441; cv=none; b=my4OC12yJ01gJ5D1Ox46faXXEg52llt3BN8UWX9CHcOerYG8a/+wsuOuPVfud3P06cWAF4DaZnnwwK8dq8e+4jEo78VGxidgmmK+DnOB+C8IH3fs5O45csoxAz4bqNY0B0bNaYz/zTzI11aL4FSzneihGIYiZ35q3MjPxz684/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249441; c=relaxed/simple;
	bh=e76/5N42UTY8yUCJgY0iayZEdEKtDnC0YQDXiChOLsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNHhutZDUjQhGQr479enGt91aKWKbQ+Tqd+TgQdVTEYZ4uDPIZKDG1eEfn8/Ab2sYGKkOTEwd6OnBL9uSF5khkypdksUR5BcXq8aP2CHWGw7W55uFsibc96Dpl4qGCV+66dypidMntluuzz57cxP6V4pD1byqyww/RNUGQ+VN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=vCrNJf/L; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id q5FStE76yf1UXq6WNtUMc3; Thu, 06 Mar 2025 08:23:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id q6WMtcacv5f3Rq6WMt2dkb; Thu, 06 Mar 2025 08:23:59 +0000
X-Authority-Analysis: v=2.4 cv=MrBU6Xae c=1 sm=1 tr=0 ts=67c95b9f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L7QhEJsNy9/Z0iFlznz0qO7b7iPa0NTNjo1Ex6WjagM=; b=vCrNJf/Lyugu67vBBgEfwFnpz0
	J+b2ejigEOCmjxpKXuQeRx6hh2ZefXZGL2eYD5wtFp5Qs0jmpg0UB4SycC6XPUkRfb0Mf44fSxhFc
	4wX1NusFrdXzCqzoupiyjGo9SfAyaimeqyNmA8NlL3gMpRxPw5LyAsk0TNNUTlHD3TMmWLs1QoznN
	Mq/7cAw28N+TgInu1tOXApo2bZHVdSQy2RMWzS8SPIOY6o70jaYJkNvnye8wTV7oPqnqxVPyBKEN1
	oYOjh/EhbRxifnVfJWSDy3jrpz/F9KryiTNx5vv/nK0A92XOEk282F53Nw4O2F2eiVw10riXei7ms
	BASpajJQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33428 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1tq6WL-000000035Qd-01dW;
	Thu, 06 Mar 2025 01:23:57 -0700
Message-ID: <158982f9-291d-4a24-af5a-0c8c2d94e9cd@w6rz.net>
Date: Thu, 6 Mar 2025 00:23:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/176] 6.1.130-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250305174505.437358097@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
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
X-Exim-ID: 1tq6WL-000000035Qd-01dW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:33428
X-Source-Auth: re@w6rz.net
X-Email-Count: 75
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAUiaAe+ENuOPk7HM48AJuG8PwTFc5pQNbn4wa7lMur4FnRPc/TO9yd/XoQhW6b/NTtt2OEMZt7EXzxIEjKa/YsudJiN+ljUb9DgwyjJnHZITVpsRyRb
 pjJ+4mkK6zLf5y61B6hYeGtr/un93zJt14x6EFcLfZQZSc3lTneSgUuf5Jl/5QIp3dQTA9kWG2YhpA==

On 3/5/25 09:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.130-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


