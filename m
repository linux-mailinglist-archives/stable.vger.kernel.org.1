Return-Path: <stable+bounces-225270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD1ACdzas2mzbgAAu9opvQ
	(envelope-from <stable+bounces-225270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 10:37:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D12809BF
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31058301344A
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522CD37CD5D;
	Fri, 13 Mar 2026 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="z9LUrJeE"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F22375ADE
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394648; cv=none; b=j65AeeUFBIs7v/7q6TCSfUXyrM89xcIdeiT+FLarTwG/4DLn6k6q3z1/hXp9qo7nn+XTZfyU1hwvvJx2zNBjyx1CYDAtL0ajl7VBbG6vuUMNpCbQUOZRNLVxYrBjHrAkGt0yAzUziJ4Jxe/vW0wjizCvMgnYAh89BcziSeU8m2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394648; c=relaxed/simple;
	bh=8XVdrRwFFMeC9dFJaqM8oPsrui61kco+m1XcAVtxLXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyDPcF+oNgk2VsHl/hYJZW5T4SDg6EHq1bB1iXdY+c/CtdSFoKHgYXy3r0Tx6fR+6rm0xwwA/wRl8gVOJNIlf15DVYPPSuq6ACjXBpW9bInkb0jwJzN/JKL6I6LDFr8Mb4FUYZmaV7M9RPxsuiADf0dL/aLb7Sz/I1qv2Vf7yGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=z9LUrJeE; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 0vZ5wFnZ9VCBN0yxMwD6y4; Fri, 13 Mar 2026 09:37:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 0yxLwVT8nN3K10yxLw5oCK; Fri, 13 Mar 2026 09:37:19 +0000
X-Authority-Analysis: v=2.4 cv=UdRRSLSN c=1 sm=1 tr=0 ts=69b3dacf
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7vwVE5O1G3EA:10
 a=EGTM6zHwoJqTM8vi98cA:9 a=QEXdDO2ut3YA:10 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JC5kbKYzzY9hREHoxnstOrWsoE8p9+xtS+3usyPFrGg=; b=z9LUrJeEHd/Nz1y/fzNOhBcTCl
	v+qpghkfpxBZ98zeKEuASYZmI/SvJXa7FWeJlLxIFhJahEgYEHM6MOBK4wVvRswtlwh+g15FH/Vg+
	w9W3gXOZcaTjFEnUTuBYmnZEp3eyIq7nbytLpsM0ce/EuRysahj/sa4xgvUaFk0LKzaUDcBQYWhRh
	8zGfa7g05hEJd2cFpxNQ1xiekyXLqObYBwi6U3+WrF4rt1izALZJDVDWFXIKzc3v9Ohc+eHCK8Tao
	B6FiuUFpRRUL/SbxYm6eknO3I+pCBjJcFGU/8LAU+pu79GBGuaLNUEHjnHK+/ro2P8ecMPk2VkQH0
	UaQVlMZw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:56878 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1w0yxK-00000000Rcz-2Kpo;
	Fri, 13 Mar 2026 03:37:18 -0600
Message-ID: <88e4edea-f204-4f06-b898-2995237fc823@w6rz.net>
Date: Fri, 13 Mar 2026 02:37:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: freeze during boot regression Re: [PATCH 6.12 000/265]
 6.12.77-rc1 review
To: "Barry K. Nathan" <barryn@pobox.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260312201018.128816016@linuxfoundation.org>
 <b4f58774-18d4-4a32-9c85-603f9e2c98fc@pobox.com>
 <ee851013-fec8-47f8-9863-392f17e54474@pobox.com>
 <2a313336-ccfc-42b7-a14d-c116733ef64a@w6rz.net>
 <1c54210a-e197-4eb9-88b5-2ed2589c7230@pobox.com>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <1c54210a-e197-4eb9-88b5-2ed2589c7230@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1w0yxK-00000000Rcz-2Kpo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:56878
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNulRSrXcUUiFmh/LoF7JFxYzQcrABpLNU4YlYYN/JEuNssxjoVYtuPRzcpKwLl0mX4hZAPSb6SGSXthyCzpUS2KSituLAF6YVcR66YXEoJHKZb6yCdx
 TDYT2HMKVKc/oG+iY+/OeHw/z7WHSoB0H3IqXWSo0W2tuKcIwlbKfAWFKoBkzJRZ+8S0FDQJJ8J95A==
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225270-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[w6rz.net:-];
	NEURAL_HAM(-0.00)[-0.896];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C07D12809BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 01:05, Barry K. Nathan wrote:
> On 3/12/26 23:10, Ron Economos wrote:
>> Probably those sched/fair patches.
>
> Yes, after bisecting it turned out to be
> sched-fair-fix-eevdf-entity-placement-bug-causing-sc.patch
>
> Taking 6.12.77-rc1 and reverting both of the sched-fair patches
> results in a working kernel that boots consistently (which I am
> using now to send this email). 

Confirmed on RISC-V. Reverting "sched/fair: Fix lag clamp" commit b547745a2c78fd1cc1fdc6a0d1b05c884c05cec2 and "sched/fair: Fix 
EEVDF entity placement bug causing scheduling lag" commit f9891a33ba67ce40e5a17023d2f3a5e2b7d72ffd resolves the issue.


