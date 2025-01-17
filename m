Return-Path: <stable+bounces-109324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8AA14864
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 04:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715DB3A9903
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 03:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7631E1A23;
	Fri, 17 Jan 2025 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq1QTYAx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E797FBA2;
	Fri, 17 Jan 2025 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737083077; cv=none; b=Y6OK8bGkKVR6XcjwDjPDBa3ns4y0qLxmqbN2mnET50VM+kVZMjfqQq49+I7fjuStI8WF/xTAk2RrZowKR6zevE2hKBnJ8gCA1TtWiJZ03Ydi2LN5IRxjtd2XZ/UY0qpsftPz3XoUsaXGVToC9xn5zrHDorjoNPZTRxAmhp7ZvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737083077; c=relaxed/simple;
	bh=vXaRoEvIufkep6qee5G9p7mdoMqruPke+FCAa520amQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKx07tYOo5wupiT5ipdH35VGJ2vw7Bg9M+Qu/yx8fz5w1JGjQZ2jBRR8+/UnreOItOmO3hqX06IW9ZJ2AOC5zn8zb1GBU7RjK9wq/nf2jZ26zs2Nd/8fAtUsy+0Rzhy0aitg36F6hDzzMGsuyvKHQCnMXplhMPKll3RdZoMaDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq1QTYAx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737083076; x=1768619076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vXaRoEvIufkep6qee5G9p7mdoMqruPke+FCAa520amQ=;
  b=Oq1QTYAxn+AFgXkPD3/yC0Ual0MH02pEsDWyZNM8k4cVh0EUM1cw4S8d
   P0ATRuzlHyekhj2Px1Vz4HwXLw5ytQA6yK2eF3V2NNUF7yVKE14VoECyu
   R0LzmhCGqKaAihWrjixyQtVEqMrOqL2eb6DFT55wJ8eYY6joEm2weU4EH
   l6R5mxFQgbZx6Z0wytYkV2vWQ0k4zy2SGmoWKn/mbbwCUURp1Kl6EbLIH
   1HwN28oXONotGhgYAL9X0SgJ0PCGXavUB8K0r9ErlucIPm1qz5et2KCMm
   ABW4JZajAPpK4zy7F01XbvDHnHZ75NO9rOc0svhCnTq0dVwW7SFh/Gtw9
   A==;
X-CSE-ConnectionGUID: WrprVeiLQ3eRSO9ydyoFuQ==
X-CSE-MsgGUID: 99j6pqJwRiu0HcGUnjzQnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="25099633"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="25099633"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 19:04:35 -0800
X-CSE-ConnectionGUID: wtSqSo+ERKWtyW/XBlGRiQ==
X-CSE-MsgGUID: ZVLJ4GkQSG6JeQeNceEwqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="110681858"
Received: from jwang112-mobl2.ccr.corp.intel.com (HELO [10.238.128.245]) ([10.238.128.245])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 19:04:32 -0800
Message-ID: <289e420d-a465-41c9-82ee-68ffbbfba0de@linux.intel.com>
Date: Fri, 17 Jan 2025 11:04:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: "H. Peter Anvin" <hpa@zytor.com>, Ethan Zhao <etzhao@outlook.com>,
 Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
 <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com>
 <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/1/17 9:21, H. Peter Anvin 写道:
> On 1/16/25 16:37, Ethan Zhao wrote:
>>>
>>> hpa suggested to introduce "switch_likely" for this kind of 
>>> optimization
>>> on a switch statement, which is also easier to read.  I measured it 
>>> with
>>> a user space focus test, it does improve performance a lot. But 
>>> obviously there are still a lot of work to do.
>>
>> Find a way to instruct compiler to pick the right hot branch 
>> meanwhile make folks
>> reading happy... yup, a lot of work.
>>
>
> It's not that complicated, believe it or not.
>
> /*
>  * switch(v) biased for speed in the case v == l
>  *
>  * Note: gcc is quite sensitive to the exact form of this
>  * expression.
>  */
> #define switch_likely(v,l) \
>     switch((__typeof__(v))__builtin_expect((v),(l)))
>
I know we could play such trick for one branch, never think of there are 
2-3 branches
are expected among 7 branches. :) , --- external interrupts, syscall, 
page fault.

Thanks,
Ethan
>     -hpa
>
-- 
"firm, enduring, strong, and long-lived"


