Return-Path: <stable+bounces-110146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD0A1906C
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD253AE748
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84848211A11;
	Wed, 22 Jan 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Ox3xBahS"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B8211A02
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544310; cv=none; b=SOMT9+d3UnIRl0vPFQSffmFiFN/S1I0Yl10NFHJ8EYs1TXnMD0vpJquYcCS9FqWnle3DGAMLDhFgEMzUcWj+/siiDK49nlEj+ZPZTVegsBNbMzJuopRDWDih52WBwux/8pfTI6VTZ8r7zIsIIEtU3TRVB7Wu3uwRol0KcG4/GvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544310; c=relaxed/simple;
	bh=OOoMM6ogp3WvYHbeHr0N0ppNAmLwrloVGDbXHFJyWsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeiuB3VgD9DPs6NorM9NSrUEouROJgL7YziGzpK2Ubr68DelVidZSALHZTrLW9WYtbAuipWBGCeVTiesvDSgrCC89t28IEkoMArLoN6xFoOOVTLHmDkeCiN8h7sVMtNCTtegTpUkgd5y8vHIxI1TYenPWP1eIroEw8IDahPsSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Ox3xBahS; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id aJTotttjFAfjwaYeAtGjbv; Wed, 22 Jan 2025 11:11:46 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id aYe9tk7drG3qKaYeAtSTht; Wed, 22 Jan 2025 11:11:46 +0000
X-Authority-Analysis: v=2.4 cv=PN4J++qC c=1 sm=1 tr=0 ts=6790d272
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=ag1SF4gXAAAA:8
 a=5w5GKDrklCRB6mbyaZYA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mwdjw+pPnWKxKBlaA04VTYFOaMsNHgNXqAmkF4+QZrk=; b=Ox3xBahSwjIpeAUckOv8TeN5BN
	9U/Aksn35MJDDBXEqOK7OAzjbF2hGV3vY7wVCwZiq6/QhyTG542uecdzegbLexRMfq4LkUx122jLv
	oPwRhVsC+lIObHeEDCqxiRsOhE1SxZsDSbP3F18GriuM9utwmbfvyiunWPQTAzLpKwXnKpWSqXeY0
	OIcfq/RpQ40bK5yNk7rXRI9ou7miPNmKTFJmkxSrkO+YywUtXzNwEGj296B938eNe6lVETyEhpVe5
	zMhvq3mFiS3NeWBzCTVroxolWvGk/c4rj93dW86Tbwc5tfgH/aajH88liomvzzGGjI/qp/u7zuigc
	wOD3XlWQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:56226 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1taYe8-000VLw-1S;
	Wed, 22 Jan 2025 04:11:44 -0700
Message-ID: <faa9e4ef-05f5-4db1-8c36-e901e156caea@w6rz.net>
Date: Wed, 22 Jan 2025 03:11:40 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/122] 6.12.11-rc1 review
To: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck
 <linux@roeck-us.net>, shuah <shuah@kernel.org>, patches@kernelci.org,
 lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
 Jon Hunter <jonathanh@nvidia.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>, srw@sladewatkins.net,
 rwarsow@gmx.de, Conor Dooley <conor@kernel.org>, hargar@microsoft.com,
 Mark Brown <broonie@kernel.org>, Anders Roxell <anders.roxell@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20250121174532.991109301@linuxfoundation.org>
 <CA+G9fYtv3NNpxuipt8Dxa_=0DhieWWc07kDgCDBM+o0gKRi4Dw@mail.gmail.com>
 <cc947edf-bece-498c-bcb0-5bc403141257@app.fastmail.com>
 <20250122105949.GK7145@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250122105949.GK7145@noisy.programming.kicks-ass.net>
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
X-Exim-ID: 1taYe8-000VLw-1S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:56226
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJx4Rn3hVVUaip4GK9w9b1vyGSk+jM2fUH0n4VheXLKRGqQnmuXOPDPocrGJ0n1FBDDXKGLXKaUumCK/xzTpsj2rof3oIeaiU5hxy5etg+4Tlp7pNmbR
 S8DxV8mdzNpNNRX5BPQ/Hdz8fWqhY4HDGqiWkXH1X6Ftw16VJqPh32VJJb7AxxMm8Mom1YCIC4Hxjw==

On 1/22/25 02:59, Peter Zijlstra wrote:
> On Wed, Jan 22, 2025 at 11:56:13AM +0100, Arnd Bergmann wrote:
>> On Wed, Jan 22, 2025, at 11:04, Naresh Kamboju wrote:
>>> On Tue, 21 Jan 2025 at 23:28, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>> 0000000000000000
>>> <4>[  160.712071] Call trace:
>>> <4>[ 160.712597] place_entity (kernel/sched/fair.c:5250 (discriminator 1))
>>> <4>[ 160.713221] reweight_entity (kernel/sched/fair.c:3813)
>>> <4>[ 160.713802] update_cfs_group (kernel/sched/fair.c:3975 (discriminator 1))
>>> <4>[ 160.714277] dequeue_entities (kernel/sched/fair.c:7091)
>>> <4>[ 160.714903] dequeue_task_fair (kernel/sched/fair.c:7144 (discriminator 1))
>>> <4>[ 160.716502] move_queued_task.isra.0 (kernel/sched/core.c:2437
>>> (discriminator 1))
>> I don't see anything that immediately sticks out as causing this,
>> but I do see five scheduler patches backported in stable-rc
>> on top of v6.12.8, these are the original commits:
>>
>> 66951e4860d3 ("sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE")
> This one reworks reweight_entity(), but I've been running with that on
> top of 13-rc6 for a week or so and not seen this.

The offending commit is 6d71a9c6160479899ee744d2c6d6602a191deb1f 
"sched/fair: Fix EEVDF entity placement bug causing scheduling lag"

It works fine on 6.13, at least on RISC-V (which is the only arch I test).

It's already been reverted and 6.12.11-rc2 has been pushed out.


