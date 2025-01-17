Return-Path: <stable+bounces-109401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC5FA1542D
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34B53A4D93
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3D19D8A9;
	Fri, 17 Jan 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P/2DodBq"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDC19C578;
	Fri, 17 Jan 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131054; cv=none; b=YXzVk1Q/HBNeFya/atMu30ctqXrv9ca27hFtSc+NN7odgdyuotmPwk+H+W1eS4USBiIzg/g/V3ox+rEqZCUzBl+h+HIInG2IaC5y9XxpxBzr61GoMj/93d6LIQJR8nGz++dch3hsFZx2WJbbv6uZkQOHi84tP2Y9PfGBPWostgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131054; c=relaxed/simple;
	bh=tybeA7r93PgFDrpKwJMpovI5WbYdZovVz8taaQoVIvI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pS9uhEFjdvL8WwZH5mTuvEnsu91S63JkXljxQK9E9tcdFQIVVdNT3nY43IN2fjYvGZ1USR+VZ99ByGZvqhEz6kPcH6IUPKITrbJF8HBIUbWUKWMIeAY00sLE1YS/kDu+ptqZLhulMShIHAZhPYHn2BAhTlwPMVejopZQqDsSXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=P/2DodBq; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8080:c1f1:e386:c572:17d3:6ddc] ([IPv6:2601:646:8080:c1f1:e386:c572:17d3:6ddc])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50HGNeUV034966
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 17 Jan 2025 08:23:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50HGNeUV034966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737131022;
	bh=79ilTLzybvTs3bji+6rF5zCXsuvfAB61gXOc6zccAkI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=P/2DodBqn9/VGrVMDj3cwatrsG+XmLw6kGSEpKKkOucuzDbJtDst7A/6M1wYL+G3L
	 2I++gnicLfqB1Cfg0eJzArZ55IheF/HuvVwfwR+X6QYT7HDN9VMoAo1m8rSvYTHA61
	 zCZDUY8395ikjuGV4obcZ05mfa9NfumBKowcsGk3gYl8EaZrVEx8+bh0t0X+26apF7
	 QqGBlSvkG1GA0ryV1BoqhDSeF6N5qGuZYejMucsXqozS8G5dT9z/UM+zKFlSW3Yox9
	 QRohsi1N5v3/n4H42qFDsHA/RNnakRACs+FaMD73jtiMZik3EEQ6QE/7Sa7lr16/OY
	 vPJFbcx0NXT4w==
Message-ID: <9315ac61-f617-4449-ae23-72ad23eb668a@zytor.com>
Date: Fri, 17 Jan 2025 08:23:35 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
        Ethan Zhao <etzhao@outlook.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
 <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com>
 <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com>
 <56b92130-7082-422c-952c-9834ebdb7268@linux.intel.com>
 <4d485294-959b-42a6-a847-513e8e3d0070@zytor.com>
 <33b89995-b638-4a6b-a75f-8278562237c4@linux.intel.com>
 <d96d60b9-fa17-4981-a7e9-1b8bab1a7eed@zytor.com>
 <21a2dc23-a87f-42aa-b5c0-ab828b1c6ad8@zytor.com>
Content-Language: en-US
In-Reply-To: <21a2dc23-a87f-42aa-b5c0-ab828b1c6ad8@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/17/25 08:17, H. Peter Anvin wrote:
>>>
>>> -       switch (regs->fred_ss.type) {
>>> +       switch_likely (etype, (EVENT_TYPE_EXTINT == etype || 
>>> EVENT_TYPE_OTHER == etype)) {
>>
>> This is not what I suggested, the (l) argument should be only one
>> constant; __builtin_expect() doesn't allow 2 different constants.
>>
> 
> The (l) argument is not a boolean expression! It is the *expected value* 
> of (v).
> 

Also, EVENT_TYPE_EXTINT == etype is not Linux style.

More fundamentally, though, I have to question this unless based on 
profiling, because it isn't at all clear that EXTINT is more important 
than FAULT (page faults, to be specific.)

To optimize syscalls, you want to do a one-shot comparison of the entire 
syscall64 signature (event type, 64-bit flag, and vector) as a mask and 
compare. For that you want to make sure the compiler loads the high 32 
bits into a register so that your mask and compare values can be 
immediates. In other words, you don't actually want it to be part of the 
switch at all, and you want *other* EVENT_TYPE_OTHER to fall back to the 
switch with regular (low) priority.

	-hpa


