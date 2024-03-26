Return-Path: <stable+bounces-32298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954F88BD49
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 10:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E14B2E8D22
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557A482E2;
	Tue, 26 Mar 2024 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="3wMkEkrK"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D4548F1
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444040; cv=none; b=hCRCmWZRC/6CwvV1QsoSWvftA4BONcmZoeZV/xeLTRH6zDnyMKDHM+YH5H8cUg02tHGcoIyDt8C/ZmC3cYxPmk6xFJCOf4plXAMtQ5pp6ynxmBMfhcCNd7CBGYnjmXKGAbrBEV9SFE2ybkm7Em7/fTG3WHAmMa/UPRHLlKVbzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444040; c=relaxed/simple;
	bh=7w3SXmhwi6J52SnebvvWOulWLYiZRvSO9Sobxg7ZDEw=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=EGjbQrnZwwaAM3jA88dL9uU+dXP5YDuh7V14eeSd9zcoF5O9bzGcJr7UzXX+V0btG0yw0hZ/OyQDY8Wnuqe9abiZeXDFUwxChhT/UD2dHRx8I5uEZq87BV2KxrjWr2uWIM3iPElfTc1sVw0YrExiZg+LXaomFtY+vlDFkJvm1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=3wMkEkrK; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id omuGrHFf5s4yTp2lzruIYc; Tue, 26 Mar 2024 09:07:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id p2lyrg77Dbhc1p2lyrlSFO; Tue, 26 Mar 2024 09:07:10 +0000
X-Authority-Analysis: v=2.4 cv=Z7bqHmRA c=1 sm=1 tr=0 ts=6602903e
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
	bh=4U38qOGHp9WJFdIRhw0/LL8ZKp8Q6OhQj8gsoSXNlRc=; b=3wMkEkrK2vBc0SAhjwXS260Kyh
	CcYu7DvumsM3UyXlgj2da1YxNfLWIU1bY+vZqhQnJpu1+hUOGVM7sni9IyVimW0Bk/fkUd37pVXHm
	+2m1zsyKOoze2Ur74xNwN/KSnXsqoIQPveusEUtc5G1JNSgiCLf6eeIHGocBFV+HyHC5QK/+0GdUx
	BsaZb44HWtWTxS8Iu3oWqSqwz938+jrz1zq/LiAfpZIGqKzpdpxW5hOrAWLm0/+Y68d+PA/xobdT1
	kIqjupuhoD69L2j4NGP5cAosfn9TCR2gDXUzmvTXyCHRQcynK9r2xux76K8OcppmThTnkuhJel+s4
	+dSbnvaQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:53492 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rp2lx-001RSH-2c;
	Tue, 26 Mar 2024 03:07:09 -0600
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240325115951.1766937-1-sashal@kernel.org>
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <fc7685c8-078f-23af-5e28-607fc52f41d5@w6rz.net>
Date: Tue, 26 Mar 2024 02:07:08 -0700
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
X-Exim-ID: 1rp2lx-001RSH-2c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:53492
X-Source-Auth: re@w6rz.net
X-Email-Count: 25
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCZG9VKto6RK6vkQoEbcLngSaLScgR+pIyfzKc6rArk7gt1T/KzJlB3j50zpuxFaxG8iy+Dd8D5uT8A6M0NxkJARkifKtZd7L87cpKHWiR/jhxZZWW9H
 0EX4wZv6/2ruGLnf664RLz9IiiqIWJUwUZHETIxc5iAjUYtfjCyMz3CAmUS/E05LGgYainRK9Rrodw==

On 3/25/24 4:59 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:59:50 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.22
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


