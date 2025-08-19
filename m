Return-Path: <stable+bounces-171760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50034B2BEB8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED48B1891AEF
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61828265296;
	Tue, 19 Aug 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="BUecJvIR"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD471DED40
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598735; cv=none; b=f04Tdf4gNnTsE40xZsSrBiC3JldGwEABFz3zZBL6K6A9lvg8wsQKhFpe94rUKAFG6WZy8s0l1wNWshQVUNUns4ymTFpLqkyMH1XKljcWwL7h2MbrKkO+h9pAS7TMWgvdQ/UQsZREfdze2SvKKxGIVbk0aVrrWSFP5SujrVGp83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598735; c=relaxed/simple;
	bh=Hhb2cQ0JJTQkVEzTWknXVix4/H+OSoRjFJa3rEm/Wt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmXBIjqMF2kbnWK0XVEG5WAJZxqHEGnVEYVC07jiyGJVcUo4OmFQU22+h98JOWnZuIfL7CVeYm184KTyop5tLcOzBkYquzO4+/cHoy+b88leGp89MgDSlyXWd5Os5QbPgou9dXftfcfzeiC6eUP+UqGMJxK2sASht3JCACTGgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=BUecJvIR; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id oHGGuFW10JLhFoJQauuCCC; Tue, 19 Aug 2025 10:18:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id oJQZu08RVWvdBoJQaugexH; Tue, 19 Aug 2025 10:18:52 +0000
X-Authority-Analysis: v=2.4 cv=cZfSrmDM c=1 sm=1 tr=0 ts=68a44f8c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tFgQPAS5XSBd2ITqQ24vKOIlDW+0jUUp8BqPdlM51aY=; b=BUecJvIRZyY/jyQb3M18OaBpkL
	oQOA+WUgUjqWo1WOpq3utBg2qfpqXUXDtpjfbWXg5QNcHuy5E97tGhyN8TTOS5gc2NqZxRw5lVvCi
	cNBNnzuOuDn//xLeFqDvAEKYbgGes8HpBJ+Yg0BHZV7uIclfFRThmHXasLGP/PdP1T0PeLwGCB2g4
	SuXblLw3qM+yWqzdIf5xYrzubxeIBKrL7n+C21WejMFLkFTkseNKJ56OjalAkWtNFkBuuzWJ98SEp
	g9hmGx1f+cBsYIw8cYAgWzizHazfzH/3xnd8D/xaYAe6/UmWvBsyjiThPAGKGH0lnVaUite6++Nav
	R/NIUxog==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59832 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uoJQY-000000025ch-46ag;
	Tue, 19 Aug 2025 04:18:51 -0600
Message-ID: <1dfa969f-3a56-4295-9f4b-47ef24b684e8@w6rz.net>
Date: Tue, 19 Aug 2025 03:18:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/444] 6.12.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250818124448.879659024@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
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
X-Exim-ID: 1uoJQY-000000025ch-46ag
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59832
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDCrPuTtk8Q8ubfkH67NrzcqyTPHwmMhkQo25gXk4Hxl1AX3wtqyb4z5A/MesJQsra3LqTsvLdgZFUwi6AbXnbjyafJ3QCuRKlYCSR9iXC+kLyfc7g06
 8IfqBie1y/GtVx/6uDPznsTjm97R/SjKvR4frEP1wN02zRb6S1/bDb5ZSLo1PLMaIfkQ2x3NFVsJzQ==

On 8/18/25 05:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.43-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


