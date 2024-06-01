Return-Path: <stable+bounces-47819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C778D6E9A
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 09:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C027C285F48
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0145171A5;
	Sat,  1 Jun 2024 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="K/76qgSJ"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59C15EA6;
	Sat,  1 Jun 2024 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717225615; cv=none; b=UhW3+YWlkTLi0n1h/cw5tTpnWSKJBoglsF2qJlwg1TZ+UZzCLFZTfOYFGnhpvkuXEDYmXsicfD5QbSK/Ksbsj5qzvyRiXjLEhliD+EA4XHyUxERwJdySC3kST/u0mXcirtMmw2ZynmNGOwmsgtCACc7U3GBWX//oYdLXovWYAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717225615; c=relaxed/simple;
	bh=uTAufFMWS2LmELT62loIWwoupgYR0tVWRf2AqpE0Xhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jf7NyezRLzgIfkIlbwdiN3B67qPowfiUKlMe9mvNm26xqDdaX2UK1pzHVAeiPIy/B3Z6Gns3Grbe9GYOeYXgA88yH4bO7OFoxQskp+SFFiZC1frSil1Gy7bw47cGGSFNx0+Q+YRZZwextF2QWZXE0wZeJAtw8GR1hV/GvohsQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=K/76qgSJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=MlVEIL/1oKU52uTbfUT3WvGbRTEXEM31zuD3P0n3zHY=;
	t=1717225613; x=1717657613; b=K/76qgSJ7MKpl6dc8x9CYlAxw8IwnmxO414vtqcM/DLoHyW
	Uwb5Sqvu967h9f4Dtocs7MZjxemAvMVUUMY4cOqFC12yK5N41TJVuKibl7Tr0bUrNeRVpDtrY2j0m
	5yvu4T3XsdKSXs+znWcLl8VI7CLPCdXIQaz3GyGjodcgwIgg3MNBmYdcpPirhLZVSIw2VmymEwEBT
	RvBfiSLGnWduCY8eeSFyZ+2VGW+dy2+Ey9tmA/Evz9F8zu0X3Z12JOs1UWIBZFe9ZomS4O3x3YiHJ
	lSGI24euD/KBa44eD4DCaSEr8dMgfN+eeW92DS+FkduMLeQc+QTpQXuGYRLX+BRw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sDIpH-0005n7-KE; Sat, 01 Jun 2024 09:06:51 +0200
Message-ID: <1e26effd-a142-44f5-9a72-90a823666d7c@leemhuis.info>
Date: Sat, 1 Jun 2024 09:06:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology
 detection
To: Thomas Gleixner <tglx@linutronix.de>,
 Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com> <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com> <87r0dj8ls4.ffs@tglx>
 <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <bd7ff2f3-bf2c-4431-9848-8eb41e7422c6@googlemail.com> <87ikyu8jp4.ffs@tglx>
 <87frty8j9p.ffs@tglx>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87frty8j9p.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717225613;ad815138;
X-HE-SMSGID: 1sDIpH-0005n7-KE

On 31.05.24 10:42, Thomas Gleixner wrote:
> On Fri, May 31 2024 at 10:33, Thomas Gleixner wrote:

> ---
> Subject: x86/topology/intel: Unlock CPUID before evaluating anything
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 30 May 2024 17:29:18 +0200
> 
> Intel CPUs have a MSR bit to limit CPUID enumeration to leaf two. If this
> bit is set by the BIOS then CPUID evaluation including topology enumeration
> does not work correctly as the evaluation code does not try to analyze any
> leaf greater than two.
> [...]

TWIMC, I noticed a bug report with a "12 × 12th Gen Intel® Core™
i7-1255U" where the reporter also noticed a lot of messages like these:

archlinux kernel: [Firmware Bug]: CPU4: Topology domain 1 shift 7 != 6
archlinux kernel: [Firmware Bug]: CPU4: Topology domain 2 shift 7 != 6
archlinux kernel: [Firmware Bug]: CPU4: Topology domain 3 shift 7 != 6

Asked the reporter to test this patch. For details see:
https://bugzilla.kernel.org/show_bug.cgi?id=218879

Ciao, Thorsten

#regzbot fix: x86/topology/intel: Unlock CPUID before evaluating anything

