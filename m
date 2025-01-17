Return-Path: <stable+bounces-109318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E21A1477E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 02:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B6E7A2F09
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345D27466;
	Fri, 17 Jan 2025 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NMq6i7fs"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7731F957;
	Fri, 17 Jan 2025 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076914; cv=none; b=f8sGu1UXyHYMtGmYwd0ti+cDB0DUSpIbvb1M8mSYBs3cGBsCNQJdka7DSqxWSB3ICqwAkk3FRo2EGpAUjupxW0+AxrErLpCw6C32KLoivvN5RwNEaQwM5w35FiIj8ZChwE3DVlhrfjip3yuW/LRFCwUrqtPue4HrpgkZ4Qjo6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076914; c=relaxed/simple;
	bh=7wfOt2FoExF+GKwYDUlX+OzjGgkUeRtIF++6jEWvFzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qp8fcxjkk9olyAh2AK/oGl3wtWAYVefWqwcdGpeNDNbYrNjfUe8MHs7l1Nzw5UAzfi85iY6ADe2T+POzo7+XD2QmfSXstzS96TxUXLKUm2FPAmgCHawok0fvzBXn01f30SvXK9NDI+CZTgE6IYRJKMSaSGAjUHtvSFnIFbPsweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NMq6i7fs; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8080:c1f1:e386:c572:17d3:6ddc] ([IPv6:2601:646:8080:c1f1:e386:c572:17d3:6ddc])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50H1LLAT3940796
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 16 Jan 2025 17:21:21 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50H1LLAT3940796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737076882;
	bh=gjWhULIjjRSz2e8v8Mb0+8MpcEhcCtBb7eD5X5gs8bo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NMq6i7fs9gyq8rkmyc5VNFrgKV0H+jn6dM3nsXoN/9oiE0zt6HBRKancfbSi40gpQ
	 7vwiUHaFlGUgSGesL+bde9FV17u+8aeBg2I5HoVxoT+8pDZr9d1afb+g0MbRnFjHBx
	 t3X9C9Ofq3NTOStYD2DPxtW7KvaNfsUqVD3uFrk4CR/yHw7PetWhgW68tswC2QhF3N
	 XFmoeIOi9JQLi6SvMv3t+OOkPpZ+2srBzaDBFBjI/htQlKHBL+YYzQYa5pRb3fFmQc
	 Nl4Brbf3PG/nc3T6C4YJ1vL3V9CuJmYF/WzZl5Vffpr2fiaWnvFp+AKHi66nha/lM6
	 S8KOKwOVeUrjw==
Message-ID: <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com>
Date: Thu, 16 Jan 2025 17:21:16 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Ethan Zhao <etzhao@outlook.com>, Xin Li <xin@zytor.com>,
        Ethan Zhao <haifeng.zhao@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
 <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com>
 <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/16/25 16:37, Ethan Zhao wrote:
>>
>> hpa suggested to introduce "switch_likely" for this kind of optimization
>> on a switch statement, which is also easier to read.  I measured it with
>> a user space focus test, it does improve performance a lot.  But 
>> obviously there are still a lot of work to do.
> 
> Find a way to instruct compiler to pick the right hot branch meanwhile 
> make folks
> reading happy... yup, a lot of work.
> 

It's not that complicated, believe it or not.

/*
  * switch(v) biased for speed in the case v == l
  *
  * Note: gcc is quite sensitive to the exact form of this
  * expression.
  */
#define switch_likely(v,l) \
	switch((__typeof__(v))__builtin_expect((v),(l)))

	-hpa


