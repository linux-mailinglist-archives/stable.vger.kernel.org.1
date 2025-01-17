Return-Path: <stable+bounces-109402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C69A15431
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 17:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F121668D9
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A4E19C574;
	Fri, 17 Jan 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cEA4SQLT"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E269443;
	Fri, 17 Jan 2025 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131118; cv=none; b=lcZiK6vWsM/3mjeCKrqFnakbQ/z3j11EdPj59mlVaBElG3rvvWJJdOrhYlIOOuHkxbXK+egOjeTGAf+x+qUW6HaOmMM36O+WEK+PEqvgK2RwymupshOL+3Mus8onz/gsW6jWyFsyY+ppvwCQiW+96THk+gX25VS6C50mFNPeuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131118; c=relaxed/simple;
	bh=I8EpZonizEFVHQxzlw54g7V7LZ0QLS1FMKRkuMi7P54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpHH176b5rY35leHFG+WwBeZ2sFl7Hnor1gW5TONTUNcPIzoh1yDfh/G4xBBQmpqMbNoft06x0/GZ82PfGo1QITx+XYKkrxGDw6KIpsuNN4F7K3BQdExfy2XOvuac3/hX1rZyntfonhqMY68yN9tZ0XiSQQDUik8Cki3CyC4TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cEA4SQLT; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8080:c1f1:e386:c572:17d3:6ddc] ([IPv6:2601:646:8080:c1f1:e386:c572:17d3:6ddc])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50HGOmrR037200
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 17 Jan 2025 08:24:48 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50HGOmrR037200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737131089;
	bh=cYqdHxwjXLBzNcwPlVzG9npiTRsahmwSbuxX8PL3YNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cEA4SQLT7qqu68qTb1s7N19d54GgYTOnb05jFFEz8+IE7pte79qBIPqvAAtnCWzJp
	 3Q+aE6kacfV1NgbFj7eNswpXrjeWDhSVo/fyvWQdfd545KOX6bT+akV+Ata1+iYsDA
	 0kFMyeK1SmXzAqQfK75wrmuX1XXe+1hG7FzygKsK/J3njHq9kupQt1Q59EZms77SwN
	 Tu9HMuJELx7Ks5C002S4DOS4R4jr5z//+LGs+2wG4GEZb1e1GeyeY+NKQtyNu0b6M8
	 83UeS1jplJ57cW0LfxILxk1dTbaxQM7h5rO3np3bDPAejTeFmmgSPKENA+6krCAbJA
	 DJ7pctuSPh6cg==
Message-ID: <c111ecfe-9055-46f3-8bd0-808a4dc039dd@zytor.com>
Date: Fri, 17 Jan 2025 08:24:43 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Xin Li <xin@zytor.com>,
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
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <33b89995-b638-4a6b-a75f-8278562237c4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> 
> In short, seems that __builtin_expect not work with switch(), at least for
>   gcc version 8.5.0 20210514(RHEL).
> 

For forward-facing optimizations, please don't use an ancient version of 
gcc as the benchmark.

	-hpa


