Return-Path: <stable+bounces-161412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA4AFE4CA
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE72C546167
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3F2882C8;
	Wed,  9 Jul 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="WrH7QZl3"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A852882A7
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055126; cv=none; b=Up7IKE+gTHeF8P74gUZh9PxfqsU/oEs56Yro9j5cbR3fDng4Cd/ziPzJ3oYA77m2JFmXByniyJz2JLjVAMny3XMT4mGitEFUp3wsytCWv9FRrPtR9yOTNUy5SfkMmLH0DcwoYWHRJB5iWMYzdwnoVxBEShLXvXIXI9TCDNJa19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055126; c=relaxed/simple;
	bh=8nWTb81n0h18DwoRgCOwtdmkDH8pEICyg/BCNT06z0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa5Ypek/4hfzECQ7xHfPwxPRNwB1MdfGg1f3XOwaT5AnET6EjBBWYHc8uFLSv9MAkqVfYNmeJMXK+f7qhmT6/c52Pu7ar2yghXim7CM5rpEDgqjGW8REyO8YjGC8s2rZBqIcw2eyKbQn6laKm78XukZbk8bYu/nJn3FKJ+4kkm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=WrH7QZl3; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id ZBzFubTDmMETlZRZbuhNiV; Wed, 09 Jul 2025 09:58:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ZRZauYkMTNVlHZRZautOli; Wed, 09 Jul 2025 09:58:42 +0000
X-Authority-Analysis: v=2.4 cv=FOPQxPos c=1 sm=1 tr=0 ts=686e3d52
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I+dNN6fbWA0KEUvI2+owr1v2I2NCE+eWihtrSeVVg3k=; b=WrH7QZl3uUJ6FowIY2Lw7UjMTM
	llDdSBIsQ2ZgzTq8k70IMmgPynC6f6Q9nrD87ApFMQ8Z1w8bbq3N/L/pyV9hiayyv79VOaqs1fzph
	HTv1YZt/bw6vXys0wKCo8lh4/ECIz48azKpRq4qntiEWsnROKB6EVmyTgVY54sxqfQfcMKhN/LMVj
	Mam6QiULl2OJN0bEJ0g6Ng/4+VEBYIzmc6no5UJGlid2BpkdASkKwfCiKh+Yz6EZZ6O8slwkfzxm5
	sB3oItnvZscwg6oGMNpk6IkZMvRXFhow+GaUJ+UbZqCtHW0bXl6/Ntd071JeyXj5UuyllxMTrhKez
	6dQigySQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:60910 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uZRZX-00000003RYj-2sON;
	Wed, 09 Jul 2025 03:58:39 -0600
Message-ID: <fe87e12e-7e5e-497c-bfa3-c727e7f3a18f@w6rz.net>
Date: Wed, 9 Jul 2025 02:58:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/81] 6.1.144-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708180901.558453595@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250708180901.558453595@linuxfoundation.org>
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
X-Exim-ID: 1uZRZX-00000003RYj-2sON
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:60910
X-Source-Auth: re@w6rz.net
X-Email-Count: 76
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGo/caQ3Y8YXVy8AiwL2joEw/MtG6dbmRaCP0tkvNRp+KkCC+VogD5sHWe7VsuPuOzMH+107yLDBv6B08P2MbWi8XUry4+l1CoP/E6l2X0aCOq3eOvW8
 8GFXFiBLxhMM4ASUUcGVNcfW/Vk5f8hFoLwpS9ai1iKhijOQ6TG7Z7r/xIXJCNufAQqXaLfWgeicKQ==

On 7/8/25 11:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.144 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:08:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.144-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


