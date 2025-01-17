Return-Path: <stable+bounces-109330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6CAA1491E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 06:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFD21883AAD
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 05:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFF1F560E;
	Fri, 17 Jan 2025 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxFcD0UQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9B8C11;
	Fri, 17 Jan 2025 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737091090; cv=none; b=VLyG5/s7ywiI+kN32rh8HXDZUlBiFSSZS6JgAzWxm+vAWwfYTgKW9x9Fgw1UKxE6PyBdIZjFVBQN0p03Eu7JSX4P3SayZg6zGvSuHabbv+d6NBQNDa6hQQZ6y0fI9NY/Iv7QpBQjQHhjBz2eiVZq9jl6H24Qial8QbFHR4dRG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737091090; c=relaxed/simple;
	bh=BTeRvv3Vr19AnLchBid5kcPBPh9Xd8ij7DUG2XYKyvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3bBLP3wAfm/fUhZJ2jfAnICgo1F0VuCnTjpgIuF0QEnssovP5HdOHZmtPoIjLKY0asjVOTv/SwhrP2XCYkwhUpnBQ32uyjoMJfuYvs0q82p3ar0we3cTLxkAiuAz5oaFkudInG1vZP5piWv3ALTAi8tnIgTy1Lk+JUx6at9M1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxFcD0UQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737091090; x=1768627090;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BTeRvv3Vr19AnLchBid5kcPBPh9Xd8ij7DUG2XYKyvI=;
  b=AxFcD0UQ4FtiCvgWkj56yGLTaKngKwNRtPLpjBdQeP0B210VN7uEJLKt
   EuFKQkLI9+WZ1GSRcY9O3T2fTE/8YX0La8B5tWHFGDftLM/oO4ItfJh6w
   +QWtm++jLMLqxVYG0wYSWs5MZmokcuhOZW+kHSa5t2nXrnaBUOQaNIXXp
   Iehlj1cT+BRLLBD+CqgqK7coOla4O53eIfkgbW6/JzBMIbNCn/FCajJY5
   uBXNYcml9bH/O/bxJzugd1ug9KGv/OzBr4oWz1LITVNl4EiBl2abMeIQ3
   tXrQBl0LL0uqYTar+RcS0xdeFbX/pVwf+Mj/EyTaKE1StlYPZDGt6Kdzb
   Q==;
X-CSE-ConnectionGUID: HleKTQs/Tgmdo350lyClFA==
X-CSE-MsgGUID: 4Mfr8ghLR1qiGmw7EinHWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37205749"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="37205749"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 21:18:07 -0800
X-CSE-ConnectionGUID: ga1oZfpUTEme9ECt2VaL3w==
X-CSE-MsgGUID: 3TzD/DKcQVKCqooN+DVo/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="110701778"
Received: from jwang112-mobl2.ccr.corp.intel.com (HELO [10.238.128.245]) ([10.238.128.245])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 21:18:03 -0800
Message-ID: <33b89995-b638-4a6b-a75f-8278562237c4@linux.intel.com>
Date: Fri, 17 Jan 2025 13:18:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>,
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
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
Autocrypt: addr=haifeng.zhao@linux.intel.com; keydata=
 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
 8TCx1OJHpvWFmL4Deq8=
In-Reply-To: <4d485294-959b-42a6-a847-513e8e3d0070@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/1/17 12:43, Xin Li 写道:
> On 1/16/2025 8:19 PM, Ethan Zhao wrote:
>>
>> 在 2025/1/17 9:21, H. Peter Anvin 写道:
>>> On 1/16/25 16:37, Ethan Zhao wrote:
>>>>>
>>>>> hpa suggested to introduce "switch_likely" for this kind of 
>>>>> optimization
>>>>> on a switch statement, which is also easier to read.  I measured 
>>>>> it with
>>>>> a user space focus test, it does improve performance a lot. But 
>>>>> obviously there are still a lot of work to do.
>>>>
>>>> Find a way to instruct compiler to pick the right hot branch 
>>>> meanwhile make folks
>>>> reading happy... yup, a lot of work.
>>>>
>>>
>>> It's not that complicated, believe it or not.
>>>
>>> /*
>>>  * switch(v) biased for speed in the case v == l
>>>  *
>>>  * Note: gcc is quite sensitive to the exact form of this
>>>  * expression.
>>>  */
>>> #define switch_likely(v,l) \
>>>     switch((__typeof__(v))__builtin_expect((v),(l)))
>>
>> I tried this macro as following, but got something really *weird* 
>> from gcc.
>>
>> +#define switch_likely(v,l) \
>> +        switch((__typeof__(v))__builtin_expect((v),(l)))
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
>> +       switch_likely ((etype == EVENT_TYPE_EXTINT || etype == 
>> EVENT_TYPE_OTHER), etype) {
>
> Just swap the 2 arguments, and it should be:
> +    switch_likely (etype, EVENT_TYPE_OTHER) {
>
>
after swapped the parameters as following:
+#define switch_likely(v,l) \
+ switch((__typeof__(v))__builtin_expect((v),(l)))
+
  __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
  {
         unsigned long error_code = regs->orig_ax;
+       unsigned short etype = regs->fred_ss.type & 0xf;

         /* Invalidate orig_ax so that syscall_get_nr() works correctly */
         regs->orig_ax = -1;

-       switch (regs->fred_ss.type) {
+       switch_likely (etype, (EVENT_TYPE_EXTINT == etype || 
EVENT_TYPE_OTHER == etype)) {
         case EVENT_TYPE_EXTINT:
                 return fred_extint(regs);
         case EVENT_TYPE_NMI:
@@ -256,11 +260,12 @@ __visible noinstr void fred_entry_from_user(struct 
pt_regs *regs)
  __visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
  {
         unsigned long error_code = regs->orig_ax;
+       unsigned short etype = regs->fred_ss.type & 0xf;

         /* Invalidate orig_ax so that syscall_get_nr() works correctly */
         regs->orig_ax = -1;

-       switch (regs->fred_ss.type) {
+       switch_likely (etype, EVENT_TYPE_EXTINT == etype) {
         case EVENT_TYPE_EXTINT:
                 return fred_extint(regs);

         case EVENT_TYPE_NMI:


Good news -- the gcc works normal, generated right asm code,
Bad news -- it fails back to binary search method to do matching, 
ignored our hints.


$objdump -d vmlinux.o | awk '/<fred_entry_from_kernel>:/{c=65} c&&c--'
00000000000016b0 <fred_entry_from_kernel>:
     16b0:       0f b6 87 a6 00 00 00 movzbl 0xa6(%rdi),%eax
     16b7:       48 8b 77 78 mov    0x78(%rdi),%rsi
     16bb:       55 push   %rbp
     16bc:       48 c7 47 78 ff ff ff movq   $0xffffffffffffffff,0x78(%rdi)
     16c3:       ff
     16c4:       83 e0 0f and    $0xf,%eax
     16c7:       48 89 e5 mov    %rsp,%rbp
     16ca:       3c 03 cmp    $0x3,%al
     16cc:       74 3c je     170a <fred_entry_from_kernel+0x5a>
     16ce:       76 13 jbe    16e3 <fred_entry_from_kernel+0x33>
     16d0:       3c 05 cmp    $0x5,%al
     16d2:       74 41 je     1715 <fred_entry_from_kernel+0x65>
     16d4:       3c 06 cmp    $0x6,%al
     16d6:       75 27 jne    16ff <fred_entry_from_kernel+0x4f>
     16d8:       e8 73 fe ff ff callq  1550 <fred_swexc>
     16dd:       5d pop    %rbp
     16de:       e9 00 00 00 00 jmpq   16e3 <fred_entry_from_kernel+0x33>
     16e3:       84 c0 test   %al,%al
     16e5:       74 42 je     1729 <fred_entry_from_kernel+0x79>
     16e7:       3c 02 cmp    $0x2,%al
     16e9:       75 14 jne    16ff <fred_entry_from_kernel+0x4f>
     16eb:       80 bf a4 00 00 00 02 cmpb   $0x2,0xa4(%rdi)
     16f2:       75 0b jne    16ff <fred_entry_from_kernel+0x4f>
     16f4:       e8 00 00 00 00 callq  16f9 <fred_entry_from_kernel+0x49>
     16f9:       5d pop    %rbp
     16fa:       e9 00 00 00 00 jmpq   16ff <fred_entry_from_kernel+0x4f>
     16ff:       e8 1c fc ff ff callq  1320 <fred_bad_type>
     1704:       5d pop    %rbp
     1705:       e9 00 00 00 00 jmpq   170a <fred_entry_from_kernel+0x5a>
     170a:       e8 21 fd ff ff callq  1430 <fred_hwexc>
     170f:       5d pop    %rbp
     1710:       e9 00 00 00 00 jmpq   1715 <fred_entry_from_kernel+0x65>
     1715:       80 bf a4 00 00 00 01 cmpb   $0x1,0xa4(%rdi)
     171c:       75 e1 jne    16ff <fred_entry_from_kernel+0x4f>
     171e:       e8 00 00 00 00 callq  1723 <fred_entry_from_kernel+0x73>
     1723:       5d pop    %rbp
     1724:       e9 00 00 00 00 jmpq   1729 <fred_entry_from_kernel+0x79>
     1729:       e8 12 fb ff ff callq  1240 <fred_extint>
     172e:       5d pop    %rbp
     172f:       e9 00 00 00 00 jmpq   1734 <fred_entry_from_kernel+0x84>
     1734:       66 66 2e 0f 1f 84 00 data16 nopw %cs:0x0(%rax,%rax,1)
     173b:       00 00 00 00
     173f:       90                      nop

$ objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
00000000000015a0 <fred_entry_from_user>:
     15a0:       0f b6 87 a6 00 00 00 movzbl 0xa6(%rdi),%eax
     15a7:       48 8b 77 78 mov    0x78(%rdi),%rsi
     15ab:       55 push   %rbp
     15ac:       48 c7 47 78 ff ff ff movq   $0xffffffffffffffff,0x78(%rdi)
     15b3:       ff
     15b4:       83 e0 0f and    $0xf,%eax
     15b7:       48 89 e5 mov    %rsp,%rbp
     15ba:       3c 04 cmp    $0x4,%al
     15bc:       74 78 je     1636 <fred_entry_from_user+0x96>
     15be:       77 15 ja     15d5 <fred_entry_from_user+0x35>
     15c0:       3c 02 cmp    $0x2,%al
     15c2:       74 53 je     1617 <fred_entry_from_user+0x77>
     15c4:       77 65 ja     162b <fred_entry_from_user+0x8b>
     15c6:       84 c0 test   %al,%al
     15c8:       75 42 jne    160c <fred_entry_from_user+0x6c>
     15ca:       e8 71 fc ff ff callq  1240 <fred_extint>
     15cf:       5d pop    %rbp
     15d0:       e9 00 00 00 00 jmpq   15d5 <fred_entry_from_user+0x35>
     15d5:       3c 06 cmp    $0x6,%al
     15d7:       74 7c je     1655 <fred_entry_from_user+0xb5>
     15d9:       72 66 jb     1641 <fred_entry_from_user+0xa1>
     15db:       3c 07 cmp    $0x7,%al
     15dd:       75 2d jne    160c <fred_entry_from_user+0x6c>
     15df:       8b 87 a4 00 00 00 mov    0xa4(%rdi),%eax
     15e5:       25 ff 00 00 02 and    $0x20000ff,%eax
     15ea:       3d 01 00 00 02 cmp    $0x2000001,%eax
     15ef:       75 6f jne    1660 <fred_entry_from_user+0xc0>
     15f1:       48 8b 77 50 mov    0x50(%rdi),%rsi
     15f5:       48 c7 47 50 da ff ff movq   $0xffffffffffffffda,0x50(%rdi)
     15fc:       ff
     15fd:       48 89 77 78 mov    %rsi,0x78(%rdi)
     1601:       e8 00 00 00 00 callq  1606 <fred_entry_from_user+0x66>
     1606:       5d pop    %rbp
     1607:       e9 00 00 00 00 jmpq   160c <fred_entry_from_user+0x6c>
     160c:       e8 0f fd ff ff callq  1320 <fred_bad_type>
     1611:       5d pop    %rbp
     1612:       e9 00 00 00 00 jmpq   1617 <fred_entry_from_user+0x77>
     1617:       80 bf a4 00 00 00 02 cmpb   $0x2,0xa4(%rdi)
     161e:       75 ec jne    160c <fred_entry_from_user+0x6c>
     1620:       e8 00 00 00 00 callq  1625 <fred_entry_from_user+0x85>
     1625:       5d pop    %rbp
     1626:       e9 00 00 00 00 jmpq   162b <fred_entry_from_user+0x8b>
     162b:       e8 00 fe ff ff callq  1430 <fred_hwexc>
     1630:       5d pop    %rbp
     1631:       e9 00 00 00 00 jmpq   1636 <fred_entry_from_user+0x96>
     1636:       e8 85 fc ff ff callq  12c0 <fred_intx>
     163b:       5d pop    %rbp
     163c:       e9 00 00 00 00 jmpq   1641 <fred_entry_from_user+0xa1>
     1641:       80 bf a4 00 00 00 01 cmpb   $0x1,0xa4(%rdi)
     1648:       75 c2 jne    160c <fred_entry_from_user+0x6c>
     164a:       e8 00 00 00 00 callq  164f <fred_entry_from_user+0xaf>
     164f:       5d pop    %rbp
     1650:       e9 00 00 00 00 jmpq   1655 <fred_entry_from_user+0xb5>
     1655:       e8 f6 fe ff ff callq  1550 <fred_swexc>
     165a:       5d pop    %rbp
     165b:       e9 00 00 00 00 jmpq   1660 <fred_entry_from_user+0xc0>
     1660:       83 f8 02 cmp    $0x2,%eax
     1663:       75 24 jne    1689 <fred_entry_from_user+0xe9>
     1665:       80 3d 00 00 00 00 00 cmpb   $0x0,0x0(%rip)        # 
166c <fred_entry_from_user+0xcc>
     166c:       74 1b je     1689 <fred_entry_from_user+0xe9>
     166e:       48 8b 47 50 mov    0x50(%rdi),%rax
     1672:       48 c7 47 50 da ff ff movq   $0xffffffffffffffda,0x50(%rdi)
     1679:       ff
     167a:       48 89 47 78 mov    %rax,0x78(%rdi)

In short, seems that __builtin_expect not work with switch(), at least for
  gcc version 8.5.0 20210514(RHEL).

Thanks，
Ethan



> Probably also check __builtin_expect on 
> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html.
>
>>          case EVENT_TYPE_EXTINT:
>>                  return fred_extint(regs);
>>          case EVENT_TYPE_NMI:
>> @@ -256,11 +260,12 @@ __visible noinstr void 
>> fred_entry_from_user(struct pt_regs *regs)
>>   __visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
>>   {
>>          unsigned long error_code = regs->orig_ax;
>> +       unsigned short etype = regs->fred_ss.type & 0xf;
>>
>>          /* Invalidate orig_ax so that syscall_get_nr() works 
>> correctly */
>>          regs->orig_ax = -1;
>>
>> -       switch (regs->fred_ss.type) {
>> +       switch_likely (etype == EVENT_TYPE_EXTINT, etype) {
>>          case EVENT_TYPE_EXTINT:
>>                  return fred_extint(regs);
>>          case EVENT_TYPE_NMI:
>>
>> Got the asm code as following:
>>
>>   objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
>> 00000000000015a0 <fred_entry_from_user>:
>>      15a0:       0f b6 87 a6 00 00 00 movzbl 0xa6(%rdi),%eax
>>      15a7:       48 8b 77 78 mov    0x78(%rdi),%rsi
>>      15ab:       55 push   %rbp
>>      15ac:       48 c7 47 78 ff ff ff movq 
>> $0xffffffffffffffff,0x78(%rdi)
>>      15b3:       ff
>>      15b4:       48 89 e5 mov    %rsp,%rbp
>>      15b7:       66 83 e0 0f and    $0xf,%ax
>>      15bb:       74 11 je     15ce <fred_entry_from_user+0x2e>
>>      15bd:       66 83 f8 07 cmp    $0x7,%ax
>>      15c1:       74 0b je     15ce <fred_entry_from_user+0x2e>
>>      15c3:       e8 78 fc ff ff callq  1240 <fred_extint>
>>      15c8:       5d pop    %rbp
>>      15c9:       e9 00 00 00 00 jmpq   15ce <fred_entry_from_user+0x2e>
>>      15ce:       e8 4d fd ff ff callq  1320 <fred_bad_type>
>>      15d3:       5d pop    %rbp
>>      15d4:       e9 00 00 00 00 jmpq   15d9 <fred_entry_from_user+0x39>
>>      15d9:       0f 1f 80 00 00 00 00 nopl   0x0(%rax)
>>
>> 00000000000015e0 <__pfx_fred_entry_from_kernel>:
>>      15e0:       90                      nop
>>      15e1:       90                      nop
>>
>> 00000000000015f0 <fred_entry_from_kernel>:
>>      15f0:       55 push   %rbp
>>      15f1:       48 8b 77 78 mov    0x78(%rdi),%rsi
>>      15f5:       48 c7 47 78 ff ff ff movq 
>> $0xffffffffffffffff,0x78(%rdi)
>>      15fc:       ff
>>      15fd:       48 89 e5 mov    %rsp,%rbp
>>      1600:       f6 87 a6 00 00 00 0f testb  $0xf,0xa6(%rdi)
>>      1607:       75 0b jne    1614 <fred_entry_from_kernel+0x24>
>>      1609:       e8 12 fd ff ff callq  1320 <fred_bad_type>
>>      160e:       5d pop    %rbp
>>      160f:       e9 00 00 00 00 jmpq   1614 
>> <fred_entry_from_kernel+0x24>
>>      1614:       e8 27 fc ff ff callq  1240 <fred_extint>
>>      1619:       5d pop    %rbp
>>      161a:       e9 00 00 00 00 jmpq   161f 
>> <fred_entry_from_kernel+0x2f>
>>      161f:       90                      nop
>>
>> 0000000000001620 <__pfx___fred_entry_from_kvm>:
>>      1620:       90                      nop
>>      1621:       90                      nop
>>
>>
>> Even the fred_entry_from_kernel() asm code doesn't look right.
>> *gcc version 8.5.0 20210514 (Red Hat 8.5.0-10) (GCC)*
>> **
>> *Did I screw up something ?*
>> **
>> *Thanks,*
>> *Ethan*
>>>
>>>     -hpa
>>>
>>
>
>
-- 
"firm, enduring, strong, and long-lived"


