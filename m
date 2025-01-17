Return-Path: <stable+bounces-109400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E670DA15412
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 17:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8733A1D5C
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA5E19D09C;
	Fri, 17 Jan 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lZbQ85YO"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16719ABB6;
	Fri, 17 Jan 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130720; cv=none; b=aYLnLEK8eEXZfBAMMYoOtbrfU0br/iHbDK7tZc7GuZCbAxnRzFemUM7j7/jRnjwmKPHtYbJeNJzpYS5E1CSbc6nudbFRpR2At+FHfsdQRU75LGv7UfavADBXG/YZuvwEls1IzHALHqZFlg7JV9I+7Og7J4/79qhlALyB5Xtj6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130720; c=relaxed/simple;
	bh=sNB1uFZu2mloisjdFqNHk8gx5JdSczvBHoAr2NbAulY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTUSSRslJNfLTkq86s7OVaphWujTIdTmBQKcNrDAtbTlmF7r74bURmny1M6nOAZGgEe6D4USBZrJWjX0me5/1Df4xAqyADmCES3u4nyTm9ZAd0lZv0C99Noirw7GhYZcYlOUmN8hRn+k9cOfcivJm9svaNNvbRwlBV99POqLJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lZbQ85YO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8080:c1f1:e386:c572:17d3:6ddc] ([IPv6:2601:646:8080:c1f1:e386:c572:17d3:6ddc])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50HGHe8n033816
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 17 Jan 2025 08:17:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50HGHe8n033816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737130662;
	bh=OPSHPuabXC/5Wx6kXSJEUR24EKV1g+IykVWVbIKLyHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lZbQ85YOnalhAQ/mMnubxBiGj2rzjIjzUSmFR9bsSsV9NZC5iHe082wO55Gj295ja
	 lSrj8TOz2ro6hkXJDMDf+62qi0apCfa3UKrZyYHJP06RaX+z2hbFmo8eyIWDDKCiSY
	 ZbDB6cjmG7WBn1/wFhDIJOSZxAg8u9stR3M8rFY5Nz/4xWOelPUbC1E+XL+N7cZ33G
	 icMHeQBRqAhksIvo0GvgFKhC0gSQ9jUmJl6KLc9fvcvuoWKqsxgJ4t5fe7vngHGq3N
	 ZEtjR0EXm/ahCZBVj3Z97W7CrJBaMLtdbkfuTTs/Jv2YGe+W4825JkYEoB+TcMBfaE
	 Q+Ov2Hh+eOyMg==
Message-ID: <21a2dc23-a87f-42aa-b5c0-ab828b1c6ad8@zytor.com>
Date: Fri, 17 Jan 2025 08:17:35 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
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
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <d96d60b9-fa17-4981-a7e9-1b8bab1a7eed@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/16/25 21:54, Xin Li wrote:
> On 1/16/2025 9:18 PM, Ethan Zhao wrote:
>>>
>>> Just swap the 2 arguments, and it should be:
>>> +    switch_likely (etype, EVENT_TYPE_OTHER) {
>>>
>>>
>> after swapped the parameters as following:
>> +#define switch_likely(v,l) \
>> + switch((__typeof__(v))__builtin_expect((v),(l)))
>> +
>>   __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
>>   {
>>          unsigned long error_code = regs->orig_ax;
>> +       unsigned short etype = regs->fred_ss.type & 0xf;
>>
>>          /* Invalidate orig_ax so that syscall_get_nr() works 
>> correctly */
>>          regs->orig_ax = -1;
>>
>> -       switch (regs->fred_ss.type) {
>> +       switch_likely (etype, (EVENT_TYPE_EXTINT == etype || 
>> EVENT_TYPE_OTHER == etype)) {
> 
> This is not what I suggested, the (l) argument should be only one
> constant; __builtin_expect() doesn't allow 2 different constants.
> 

The (l) argument is not a boolean expression! It is the *expected value* 
of (v).

	-hpa


