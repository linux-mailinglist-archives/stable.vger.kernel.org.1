Return-Path: <stable+bounces-109223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D852CA13506
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 09:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A18218892EC
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E219C569;
	Thu, 16 Jan 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="HvuB/aB9"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6819C566
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737015074; cv=none; b=ACCS4aZ1/x/VEcRL97lAm7bAhhp7mNOtAzc9qJSdGjraI/ZD6qr4ZI+rSt+4fKfdrv85iyFhxsBcUcSkSzOynqCvFMet+erDt1EctYs9f5WZYNsCnpn2C+PfeQFoc9p1TzmYSmS+euB3t/4Wgfd1YxBCwifcvUbajh5pRna3OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737015074; c=relaxed/simple;
	bh=x5jUqpgDbHiCKEIPM7jW9aA/0PMqI/PV2VeAncxZz54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XN/7KPwRaVDzymwBt0wq7i0lzNDMLKQ9v6QeabFxbw1nzqtDgwcQDo5opSGkvAnWVxR2dq+KTZ2r6WpW2sbPy70wP223FCbQMdhuXsJ8MNJ4lkmhWz70GaNiS5lu8L7Cu2J4MJnCSOigeiRPiQ+1/3SLAtGvHUkbjMYPkkrdkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=HvuB/aB9; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id YIvQtX3x7dz4NYKy7t48ab; Thu, 16 Jan 2025 08:11:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id YKy6tLj1H5bbpYKy6tkeDh; Thu, 16 Jan 2025 08:11:11 +0000
X-Authority-Analysis: v=2.4 cv=JYa6r1KV c=1 sm=1 tr=0 ts=6788bf1f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=etuS0e9UrcASmx6ziUalUsm5WEuZ+YSwzKmxqMa+n5Y=; b=HvuB/aB92yrDwPsLYiJbB/5XAS
	CF5tsTL/5tcDjREu03GA/ZmqKQi4y8m6zXxK36XAOp5q1uzRg4nBJAE4GRH2ic/HAR9siH+QkfPMg
	VA+BSrLJeGpaAQbsId4/nHWFwVCUQ3sQUi2LGGgV7wMPKX4uLDKSOGvOgtPq+M+nccW3cJbao0MRx
	2ir8ec3+hicYaIqAu9TxqLlbx89/Oj3++40vnSBsnEJOPdVp3WGUy0Pw6m2DhCVFDC/hSlGVxfxib
	GcB3pOnSTKwXRpSNw15+VGWlP0i5bvUQM+zjhRWOgWu3D1OVpuPKcWAgK4MZ8EEuajGZYvZNtvgxM
	URZRRijg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:51264 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tYKy5-003dP8-1e;
	Thu, 16 Jan 2025 01:11:09 -0700
Message-ID: <ac8529e1-3f64-4629-9bdf-c1e2503f2f7d@w6rz.net>
Date: Thu, 16 Jan 2025 00:11:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/129] 6.6.72-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103554.357917208@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
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
X-Exim-ID: 1tYKy5-003dP8-1e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:51264
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAK8TqQfnqnbeyLM5odWC9ya44femX7AbdX9lDA/kUo6yLVAr20IoGlLzIxYfF/4jUOZQmDhcebWFM1EI+Cw3vzS2UVhPMf+I8oe/tPizH7tuHZoCZB/
 pZJQi4WTXyyPzBm97pPlGHtRHYa/oRsnOD7gQKA/u7Gtv1pbrteQs/ZpXwiurXoTb0TQvfLQ/ISJgw==

On 1/15/25 02:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.72 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.72-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


