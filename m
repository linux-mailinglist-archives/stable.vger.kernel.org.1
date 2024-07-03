Return-Path: <stable+bounces-57988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BF926A21
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 23:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA2F283801
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB13186E2D;
	Wed,  3 Jul 2024 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="RQ4Goyh9"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CD2BB13
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041683; cv=none; b=Z90oW7NPHrb/RjuyIzbBc1XMXONQ1lQwE7lHIrbxWchHnqz4wyO85yQSYj0Uln2Jn8bVpK3dtNSOC+iOyikv9Q10ezmC7k4WSr9rHUnrKSv/QrlHPL2P8U9gizkVehN/j46GJqAdSc03wgs0CeTBX19dQOhpveiec8uVpn+uq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041683; c=relaxed/simple;
	bh=Vc6PHCXoH8EsVqwOstz2jsom7VF7LYZCtdJ14PifpZE=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=G53gNvrP9Zw/rgnNpPyheb3KVJrN6L6sIjn//RtpIGW+CRNJMCY6wI9UpDq1EW/jqYgRFHIQvJR9NCafTuAmu7zmq+6roeSiGl2c9AhgeXL2LlfFP5ki+NG26Gv0gmYU0ddG7G18MqQuxQ7Lbq2H5Q5IggOCzJmv/nUZ8awT+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=RQ4Goyh9; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id OgIgs1SD8SLKxP7ODsWerV; Wed, 03 Jul 2024 21:19:45 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id P7OCsv6RgNoTfP7OCsplk4; Wed, 03 Jul 2024 21:19:44 +0000
X-Authority-Analysis: v=2.4 cv=Gq5E+F1C c=1 sm=1 tr=0 ts=6685c070
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=dM-kR4knkKEf_V6v5WMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4hxvPqnDIHOP+GOeNYXRp8lB9lTRiCyQRC8A48PGWHo=; b=RQ4Goyh9UNX9EamkU6uNB9/e3S
	duH6in440eS4uurshUR52k0XyiizimXgVflijo4KtAaYoVsZfe62C24FJI56Uvme1JXIaA0stPmAS
	W9Xw1CSxnHVhBmdgRQE2v/QBgAT0/zMmEB5WcPw+6Glx8jK2aBttO8FmScc43AIeDme7Y2HBhF+yw
	EwyT6yNYwm2cjtvZK1kz1OYOSgqx5ThSTZx/EYJL7gaAEgAWQz4RBhFyQ1CPbu6qrEkvoWsVKHrR4
	gmVcuyMc6oWhBWGKLLR1oetrt8IoNZu74mongvL8TK1+zUN45wLVP6tiAr4MmtFEc8+k+cYYHwYF+
	MHcmjLkA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:46978 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sP7O7-003dBL-2n;
	Wed, 03 Jul 2024 15:19:39 -0600
Subject: Re: [PATCH 6.1 000/128] 6.1.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240702170226.231899085@linuxfoundation.org>
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <5279532e-fddb-cb67-271c-f91ebb752ba5@w6rz.net>
Date: Wed, 3 Jul 2024 14:19:34 -0700
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
X-Exim-ID: 1sP7O7-003dBL-2n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:46978
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBME1a0mpWyZ+ooslctKCydQ9+eqcWKMDg491XRVGalS55CULUNLlQhTpeYHGk0PTVyPLIHOMupAsiSy1TM4r8RyIvT2YUDQqKSQWZX/ypIQZ4R+uNU+
 kSbQBqqCXm2zKsnYJoD5eKSN/nIs+8Z3z9Yz+3dkIfe18jiTY7b2eEVZkJK5kzICrX1XJ6oh8Y6+kg==

On 7/2/24 10:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.97 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.97-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


