Return-Path: <stable+bounces-32300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C663488BD4F
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E19B3014B6
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B0E4CDE7;
	Tue, 26 Mar 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="QBoQ1YtO"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF040BE6
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444188; cv=none; b=d9gxB9LC10QF+/R4qFw49ZI8qPUdcABtUtxEUm+yWKv6jpy9R2tPmdMJByCrUWumfoll0YpgDAC9CSFYU48xD/jfIphgFdhdRzRwGWIlOoPtmrfVt9EztVIdFLzp/sETf7WWLXD7yoLVl2yqFDrW3TOzGIy2CmjUveBSjXE47wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444188; c=relaxed/simple;
	bh=zviBgsBXNOR3k3tbOgbAK3NsRdOqlOYIwLz/8y8f7oU=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=SsDKqG9WtXuPb87md+UB7vnFEo6/PM32ynFhACSlCjsRR+55gYXopMdapAJysMbbW+KEjcyBIzutdXPy8zBcNwfWc8aMJ519HbhjK9Sa1lBIJBv35cNc2Ci53ZoNP+6/ayvWG7aJyVRv5hykYP6KK1rQPPNiuxXG7iEKgOTTAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=QBoQ1YtO; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id ocS0rJ3SlPM1hp2oOrdePl; Tue, 26 Mar 2024 09:09:40 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id p2oNrMq9g9zHMp2oNrSug2; Tue, 26 Mar 2024 09:09:39 +0000
X-Authority-Analysis: v=2.4 cv=fo4XZ04f c=1 sm=1 tr=0 ts=660290d3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n4tS1j0m7NWiNX502zvW0bV89P3lIF8twqlrpzeCQUQ=; b=QBoQ1YtOyjpXsB8VEq/m+cnNUw
	Jgiz1DaWo9MKMQ524rGgyF74xevTVe8dTUeqf4ySQAJofa0FMtsFhvHNjbaVZwt22E98b4y7fslA4
	zXVHxj12oDHTcMFFyyk4sRA4ntYGJIeMI6M0tX/E8spTSXfiJzIk3+CIlNK99Xhe8kZaL4xcKXwXF
	R2yei3AB4cpIPnQqCDl4CiZuppuwICp+S0Sx5FzZqJdvBxpY5jGuhLwRjn0FE6f00ke6TYf4pE3A3
	pEeMNVgNvSRvtMGaK9FKBVTPoGvU45dHKcIa3Jb/s1ydZMmT6hmDfTBk6bzEryACDOlnb2yEjMdLS
	VcPq96XA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:53500 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rp2oM-001TUg-2C;
	Tue, 26 Mar 2024 03:09:38 -0600
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240325115939.1766258-1-sashal@kernel.org>
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <5480469c-7e5a-440c-8595-f13a5869da7a@w6rz.net>
Date: Tue, 26 Mar 2024 02:09:36 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rp2oM-001TUg-2C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:53500
X-Source-Auth: re@w6rz.net
X-Email-Count: 36
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPg30F64zxxYq0vRWTh7cpgv8T5bi6ni83vTJuTrGG6m7YRHTSRXEM3clITdJkRbeb875F5+KyB+kiLCUWOVuivJN+lxTT4kUPo31j+k0N+sObVsts4I
 JoPCEkG+KVBoJHnzmpOO0qE0Zg4OT0643zj89THLK64kzSwvSEht40nDDczwsS4GXKUareIw5N6lRg==

On 3/25/24 4:59 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.82
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


