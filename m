Return-Path: <stable+bounces-109329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF1CA148F4
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 05:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D79A1885FCE
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 04:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6BE1F667A;
	Fri, 17 Jan 2025 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gpbMoS6u"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080471F63C6;
	Fri, 17 Jan 2025 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737089024; cv=none; b=tZYMnFDxbL0SqrusRr54pWXfSMb4d7xo6ItIJmSYD1a94Os0WUWsRUhQteGH42OnRjHnosr8eq52V4FkbRu9MdPwfFYF5a1VKZORfWhJxFEBzmQjB0Ues3XLV4+TYCEAEfMZYErT91GCfP39EtxlpPxQ8Qp0GqoNP6VaVjAADzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737089024; c=relaxed/simple;
	bh=d0mM1HuSiW9XJ+ojUyGmpLMrQsvlvKr/+y9EjuoH8qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4qplpEDl8AO2raZvtxdCRMHwnFvaZKslZydVUbq5LbvwRwG1xXgb61VTmjTNBQZ1EK4ekgKWDsXGzQo5QVW+bEKQNhv2TmkIftnJg4M/LMcXd5a/2T2/p7KEFt8wa4pkKVS7ZTRBNm/5+ZJgAtvMVIC8oen1QhBS3FT7MnHdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gpbMoS6u; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50H4h6xd3998984
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 16 Jan 2025 20:43:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50H4h6xd3998984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1737088987;
	bh=WHqMX5gsbuuDm7SS/PqvaBtQq+qr7vZ44nolVT25OXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gpbMoS6uz+lYck9qHAYBVVCave+ChSrTRgBDuIlS4ZyYsFxBFhBIBMcg6uwYQ06sk
	 U85qHZvHnlOcSxl0CSIx38xC0VbGknCm8moedHPF9iIvp4xi0nutLYpxnikCaM6W3I
	 Rey4ATq4Xd7jhF+LEGs8MDDv5W5tElkncc0bT/+E3KjCP3fYHgIOnOAtcRRdQj9bqa
	 CyPg8J5xpYHaPIGbeeItaV5gmlM/GIamH+yIGMIi+Q0mRMlNq4q2lfgYwaHrEl7A8n
	 HaFH+mby54jSIldZCdGv1I4iekmRMpUZaPZQDz9gtFA431lxyNjkS2SU6FBgyBvmgI
	 eOYogrYb3kG/Q==
Message-ID: <4d485294-959b-42a6-a847-513e8e3d0070@zytor.com>
Date: Thu, 16 Jan 2025 20:43:05 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Ethan Zhao <haifeng.zhao@linux.intel.com>,
        "H. Peter Anvin"
 <hpa@zytor.com>, Ethan Zhao <etzhao@outlook.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        andrew.cooper3@citrix.com, mingo@redhat.com, bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <417271c4-0297-41da-a39b-5d5b28dd73f9@zytor.com>
 <TYZPR03MB8801E2BF68A08887A238A32CD11A2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <05b13e99-c7e5-4db7-90bd-a89a91f4e327@zytor.com>
 <TYZPR03MB88013A5D71079FF9E6776E49D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
 <d90975a0-6b01-4a2e-92c2-2af2326e1299@zytor.com>
 <56b92130-7082-422c-952c-9834ebdb7268@linux.intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <56b92130-7082-422c-952c-9834ebdb7268@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/16/2025 8:19 PM, Ethan Zhao wrote:
> 
> 在 2025/1/17 9:21, H. Peter Anvin 写道:
>> On 1/16/25 16:37, Ethan Zhao wrote:
>>>>
>>>> hpa suggested to introduce "switch_likely" for this kind of 
>>>> optimization
>>>> on a switch statement, which is also easier to read.  I measured it 
>>>> with
>>>> a user space focus test, it does improve performance a lot. But 
>>>> obviously there are still a lot of work to do.
>>>
>>> Find a way to instruct compiler to pick the right hot branch 
>>> meanwhile make folks
>>> reading happy... yup, a lot of work.
>>>
>>
>> It's not that complicated, believe it or not.
>>
>> /*
>>  * switch(v) biased for speed in the case v == l
>>  *
>>  * Note: gcc is quite sensitive to the exact form of this
>>  * expression.
>>  */
>> #define switch_likely(v,l) \
>>     switch((__typeof__(v))__builtin_expect((v),(l)))
> 
> I tried this macro as following, but got something really *weird* from gcc.
> 
> +#define switch_likely(v,l) \
> +        switch((__typeof__(v))__builtin_expect((v),(l)))
> +
>   __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
>   {
>          unsigned long error_code = regs->orig_ax;
> +       unsigned short etype = regs->fred_ss.type & 0xf;
> 
>          /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>          regs->orig_ax = -1;
> 
> -       switch (regs->fred_ss.type) {
> +       switch_likely ((etype == EVENT_TYPE_EXTINT || etype == 
> EVENT_TYPE_OTHER), etype) {

Just swap the 2 arguments, and it should be:
+	switch_likely (etype, EVENT_TYPE_OTHER) {


Probably also check __builtin_expect on 
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html.

>          case EVENT_TYPE_EXTINT:
>                  return fred_extint(regs);
>          case EVENT_TYPE_NMI:
> @@ -256,11 +260,12 @@ __visible noinstr void fred_entry_from_user(struct 
> pt_regs *regs)
>   __visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
>   {
>          unsigned long error_code = regs->orig_ax;
> +       unsigned short etype = regs->fred_ss.type & 0xf;
> 
>          /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>          regs->orig_ax = -1;
> 
> -       switch (regs->fred_ss.type) {
> +       switch_likely (etype == EVENT_TYPE_EXTINT, etype) {
>          case EVENT_TYPE_EXTINT:
>                  return fred_extint(regs);
>          case EVENT_TYPE_NMI:
> 
> Got the asm code as following:
> 
>   objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
> 00000000000015a0 <fred_entry_from_user>:
>      15a0:       0f b6 87 a6 00 00 00 movzbl 0xa6(%rdi),%eax
>      15a7:       48 8b 77 78 mov    0x78(%rdi),%rsi
>      15ab:       55 push   %rbp
>      15ac:       48 c7 47 78 ff ff ff movq   $0xffffffffffffffff,0x78(%rdi)
>      15b3:       ff
>      15b4:       48 89 e5 mov    %rsp,%rbp
>      15b7:       66 83 e0 0f and    $0xf,%ax
>      15bb:       74 11 je     15ce <fred_entry_from_user+0x2e>
>      15bd:       66 83 f8 07 cmp    $0x7,%ax
>      15c1:       74 0b je     15ce <fred_entry_from_user+0x2e>
>      15c3:       e8 78 fc ff ff callq  1240 <fred_extint>
>      15c8:       5d pop    %rbp
>      15c9:       e9 00 00 00 00 jmpq   15ce <fred_entry_from_user+0x2e>
>      15ce:       e8 4d fd ff ff callq  1320 <fred_bad_type>
>      15d3:       5d pop    %rbp
>      15d4:       e9 00 00 00 00 jmpq   15d9 <fred_entry_from_user+0x39>
>      15d9:       0f 1f 80 00 00 00 00 nopl   0x0(%rax)
> 
> 00000000000015e0 <__pfx_fred_entry_from_kernel>:
>      15e0:       90                      nop
>      15e1:       90                      nop
> 
> 00000000000015f0 <fred_entry_from_kernel>:
>      15f0:       55 push   %rbp
>      15f1:       48 8b 77 78 mov    0x78(%rdi),%rsi
>      15f5:       48 c7 47 78 ff ff ff movq   $0xffffffffffffffff,0x78(%rdi)
>      15fc:       ff
>      15fd:       48 89 e5 mov    %rsp,%rbp
>      1600:       f6 87 a6 00 00 00 0f testb  $0xf,0xa6(%rdi)
>      1607:       75 0b jne    1614 <fred_entry_from_kernel+0x24>
>      1609:       e8 12 fd ff ff callq  1320 <fred_bad_type>
>      160e:       5d pop    %rbp
>      160f:       e9 00 00 00 00 jmpq   1614 <fred_entry_from_kernel+0x24>
>      1614:       e8 27 fc ff ff callq  1240 <fred_extint>
>      1619:       5d pop    %rbp
>      161a:       e9 00 00 00 00 jmpq   161f <fred_entry_from_kernel+0x2f>
>      161f:       90                      nop
> 
> 0000000000001620 <__pfx___fred_entry_from_kvm>:
>      1620:       90                      nop
>      1621:       90                      nop
> 
> 
> Even the fred_entry_from_kernel() asm code doesn't look right.
> *gcc version 8.5.0 20210514 (Red Hat 8.5.0-10) (GCC)*
> **
> *Did I screw up something ?*
> **
> *Thanks,*
> *Ethan*
>>
>>     -hpa
>>
> 


