Return-Path: <stable+bounces-109328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78976A148D4
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 05:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816F3188BFC2
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 04:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F81F6679;
	Fri, 17 Jan 2025 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fn9ak85k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9748C11;
	Fri, 17 Jan 2025 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737087574; cv=none; b=MI3TQZX6agUA/zaIjVk5IawsP6qBg6f9AS/rsDtjW9VXaB4vGEXkdYcparHmtyl64dgfumbLNtjIPQHxH5K+Bzq6RoO5wiAAD8O5yS9MmRu7RP1+Sbij/mRbAkuEXQMq4IQWd+vKC3veVx0zQfg+6ALa5cCmrS+CjLa0kaleOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737087574; c=relaxed/simple;
	bh=lPHawRl7iFksXt4yqKdS4kz86/yknrYx4pv2NbrMzOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o12xrU84iFDAZOk4II5fpzu8WPl3pXmdcwRTXGFdIvaVvd5MmpXZd5L11iFwnSDigYM3jHZlpC7vWAf2NgwEtvL7Hz/AQhvlUbr/TIgJmhM1FsG0npKzip6wbC9+6De/y2Svc8HQU25OQ6/c5YSkb9UNY1/fsfHdhLXzJoR9Qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fn9ak85k; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737087572; x=1768623572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lPHawRl7iFksXt4yqKdS4kz86/yknrYx4pv2NbrMzOM=;
  b=fn9ak85kxSRyCiLG0y4k2GhJRhF0Z32mI1tIu/0l+6f5Guw0iG92OWH8
   5pq6gyKbLVhXOAnrdrw8T5lbhPsYd8qBKXSwVwej46AjfBqd9JLC/uMSX
   PYsw7mIZV59dHrPo4NknqkbckapYC2gByNOqta8XjW2lzJMM2hMVpl4ry
   N927ekH+VsTCPprHflY6pCP2aiCX+9wa9yeqJydMibsUuY+0VKG63ayaI
   99wfG35+W/yWeB7tHwKx1Ip1Q++QHQqZaXicnzES3RzUaEClfPucnCjjM
   h99sa3Fs13sheNntp09xL1hdeqfHYTvMfE9nZxpiyWX/PXB11qwhpO3U4
   Q==;
X-CSE-ConnectionGUID: CY/zrqtUSz+mxOI87K4FyA==
X-CSE-MsgGUID: 2iT4gnajQf+2imDvaFvqWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48171381"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="48171381"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 20:19:32 -0800
X-CSE-ConnectionGUID: RKCWxbreSxuT/6aKCQR0Tg==
X-CSE-MsgGUID: SCQifGfAR6iFPD8U7R9Z8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106576269"
Received: from jwang112-mobl2.ccr.corp.intel.com (HELO [10.238.128.245]) ([10.238.128.245])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 20:19:29 -0800
Message-ID: <56b92130-7082-422c-952c-9834ebdb7268@linux.intel.com>
Date: Fri, 17 Jan 2025 12:19:26 +0800
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

I tried this macro as following, but got something really *weird* from gcc.

+#define switch_likely(v,l) \
+        switch((__typeof__(v))__builtin_expect((v),(l)))
+
  __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
  {
         unsigned long error_code = regs->orig_ax;
+       unsigned short etype = regs->fred_ss.type & 0xf;

         /* Invalidate orig_ax so that syscall_get_nr() works correctly */
         regs->orig_ax = -1;

-       switch (regs->fred_ss.type) {
+       switch_likely ((etype == EVENT_TYPE_EXTINT || etype == 
EVENT_TYPE_OTHER), etype) {
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
+       switch_likely (etype == EVENT_TYPE_EXTINT, etype) {
         case EVENT_TYPE_EXTINT:
                 return fred_extint(regs);
         case EVENT_TYPE_NMI:

Got the asm code as following:

  objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'
00000000000015a0 <fred_entry_from_user>:
     15a0:       0f b6 87 a6 00 00 00 movzbl 0xa6(%rdi),%eax
     15a7:       48 8b 77 78 mov    0x78(%rdi),%rsi
     15ab:       55 push   %rbp
     15ac:       48 c7 47 78 ff ff ff movq   $0xffffffffffffffff,0x78(%rdi)
     15b3:       ff
     15b4:       48 89 e5 mov    %rsp,%rbp
     15b7:       66 83 e0 0f and    $0xf,%ax
     15bb:       74 11 je     15ce <fred_entry_from_user+0x2e>
     15bd:       66 83 f8 07 cmp    $0x7,%ax
     15c1:       74 0b je     15ce <fred_entry_from_user+0x2e>
     15c3:       e8 78 fc ff ff callq  1240 <fred_extint>
     15c8:       5d pop    %rbp
     15c9:       e9 00 00 00 00 jmpq   15ce <fred_entry_from_user+0x2e>
     15ce:       e8 4d fd ff ff callq  1320 <fred_bad_type>
     15d3:       5d pop    %rbp
     15d4:       e9 00 00 00 00 jmpq   15d9 <fred_entry_from_user+0x39>
     15d9:       0f 1f 80 00 00 00 00 nopl   0x0(%rax)

00000000000015e0 <__pfx_fred_entry_from_kernel>:
     15e0:       90                      nop
     15e1:       90                      nop

00000000000015f0 <fred_entry_from_kernel>:
     15f0:       55 push   %rbp
     15f1:       48 8b 77 78 mov    0x78(%rdi),%rsi
     15f5:       48 c7 47 78 ff ff ff movq   $0xffffffffffffffff,0x78(%rdi)
     15fc:       ff
     15fd:       48 89 e5 mov    %rsp,%rbp
     1600:       f6 87 a6 00 00 00 0f testb  $0xf,0xa6(%rdi)
     1607:       75 0b jne    1614 <fred_entry_from_kernel+0x24>
     1609:       e8 12 fd ff ff callq  1320 <fred_bad_type>
     160e:       5d pop    %rbp
     160f:       e9 00 00 00 00 jmpq   1614 <fred_entry_from_kernel+0x24>
     1614:       e8 27 fc ff ff callq  1240 <fred_extint>
     1619:       5d pop    %rbp
     161a:       e9 00 00 00 00 jmpq   161f <fred_entry_from_kernel+0x2f>
     161f:       90                      nop

0000000000001620 <__pfx___fred_entry_from_kvm>:
     1620:       90                      nop
     1621:       90                      nop


Even the fred_entry_from_kernel() asm code doesn't look right.
*gcc version 8.5.0 20210514 (Red Hat 8.5.0-10) (GCC)*
**
*Did I screw up something ?*
**
*Thanks,*
*Ethan*
>
>     -hpa
>

-- 
"firm, enduring, strong, and long-lived"


