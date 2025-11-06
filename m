Return-Path: <stable+bounces-192598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D6C3A883
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CA2460498
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540EA30E831;
	Thu,  6 Nov 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNIBL3u3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AFB30F805;
	Thu,  6 Nov 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427803; cv=none; b=aPci45kCM/Ojdg97ECSHYk7Q3gkkpB9fwhqZ/ZLMlZuQh6C5ZjLCn/NF6ezm0NMoIdGOomllZiISuL6ZAaG1QtU6EQqSV6bxT13xyESXRnysLIARoJkXkt9pJiXTfDEx+RKDnifRfT2UiIq/yMK9uu0d9oLJ5ebVVc5ewLY9Cb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427803; c=relaxed/simple;
	bh=8cnDbTxQTbM8lcfQEMN460D5ylwQe2K609JbpAnX38A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8D3QuVNhWuvJ8r/RCHs1TQmL3EfGmhshYhGBudVFVYVA5x9XICU2IYeK02Q6JZHcF3qpjJAcYmn3O0g2fWSFRnbkMkuemqsIf6oWKHIGqEn16XqM72rencCq0g+JTl0ZnQ/TPBjD0pekV0zGxcDppxHmDxsG+RLfgzySY3zyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNIBL3u3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B1CC16AAE;
	Thu,  6 Nov 2025 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762427802;
	bh=8cnDbTxQTbM8lcfQEMN460D5ylwQe2K609JbpAnX38A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pNIBL3u3EEjtdJUOBEkKSw9pgKm1DKIuwuAhXAGF61uu+g4vxWTiopAz9au9bPyWZ
	 LlR+oCdBEexup/EKygNsFNvjID3HblLXFXz78unMmeM1MgpW8/aUaThhNIPaKH+nGV
	 pCShx9dzuS3c5sBJSN96D0tIqukdM1KSl0W5hPXxK3mmyTME5zyPkF4hCSm+Oo4Of0
	 UTeOlr1FN6o1H1EHaKrocMZ6B43YU1Wp0RzrsqMmuc5CDNgSkcec6XFODO7gfTvKbY
	 GV6YgI4/vUNODAb8KG3Fxn2iGlUve6/sR4awUWbOesU7y/xNrw/EyuUwBbo+Cj/0Bj
	 SigsL9PrJwEHQ==
Message-ID: <0bc6a1ba-4f4f-4b04-b66c-b5d217faefab@kernel.org>
Date: Thu, 6 Nov 2025 12:16:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/ksm: fix flag-dropping behavior in ksm_madvise
To: Vlastimil Babka <vbabka@suse.cz>, Jakub Acs <acsjakub@amazon.de>,
 linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
 Jann Horn <jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
 peterx@redhat.com, axelrasmussen@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251001090353.57523-1-acsjakub@amazon.de>
 <20251001090353.57523-2-acsjakub@amazon.de>
 <13c7242e-3a40-469b-9e99-8a65a21449bb@suse.cz>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <13c7242e-3a40-469b-9e99-8a65a21449bb@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.11.25 11:39, Vlastimil Babka wrote:
> On 10/1/25 11:03, Jakub Acs wrote:
>> syzkaller discovered the following crash: (kernel BUG)
>>
>> [   44.607039] ------------[ cut here ]------------
>> [   44.607422] kernel BUG at mm/userfaultfd.c:2067!
>> [   44.608148] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
>> [   44.608814] CPU: 1 UID: 0 PID: 2475 Comm: reproducer Not tainted 6.16.0-rc6 #1 PREEMPT(none)
>> [   44.609635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>> [   44.610695] RIP: 0010:userfaultfd_release_all+0x3a8/0x460
>>
>> <snip other registers, drop unreliable trace>
>>
>> [   44.617726] Call Trace:
>> [   44.617926]  <TASK>
>> [   44.619284]  userfaultfd_release+0xef/0x1b0
>> [   44.620976]  __fput+0x3f9/0xb60
>> [   44.621240]  fput_close_sync+0x110/0x210
>> [   44.622222]  __x64_sys_close+0x8f/0x120
>> [   44.622530]  do_syscall_64+0x5b/0x2f0
>> [   44.622840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [   44.623244] RIP: 0033:0x7f365bb3f227
>>
>> Kernel panics because it detects UFFD inconsistency during
>> userfaultfd_release_all(). Specifically, a VMA which has a valid pointer
>> to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.
>>
>> The inconsistency is caused in ksm_madvise(): when user calls madvise()
>> with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR
>> mode, it accidentally clears all flags stored in the upper 32 bits of
>> vma->vm_flags.
>>
>> Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int
>> and int are 32-bit wide. This setup causes the following mishap during
>> the &= ~VM_MERGEABLE assignment.
>>
>> VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
>> After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
>> promoted to unsigned long before the & operation. This promotion fills
>> upper 32 bits with leading 0s, as we're doing unsigned conversion (and
>> even for a signed conversion, this wouldn't help as the leading bit is
>> 0). & operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
>> instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
>> the upper 32-bits of its value.
>>
>> Fix it by changing `VM_MERGEABLE` constant to unsigned long, using the
>> BIT() macro.
>>
>> Note: other VM_* flags are not affected:
>> This only happens to the VM_MERGEABLE flag, as the other VM_* flags are
>> all constants of type int and after ~ operation, they end up with
>> leading 1 and are thus converted to unsigned long with leading 1s.
>>
>> Note 2:
>> After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
>> no longer a kernel BUG, but a WARNING at the same place:
>>
>> [   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067
>>
>> but the root-cause (flag-drop) remains the same.
>>
>> Fixes: 7677f7fd8be76 ("userfaultfd: add minor fault registration mode")
> 
> Late to the party, but it seems to me the correct Fixes: should be
> f8af4da3b4c1 ("ksm: the mm interface to ksm")
> which introduced the flag and the buggy clearing code, no?
> 
> Commit 7677f7fd8be76 is just one that notices it, right? But there are other
> flags in >32 bit area, including pkeys etc. Sounds rather dangerous if they
> can be cleared using a madvise.
> 
> So we can't amend the Fixes: now but maybe could advise stable to backport
> for even older versions than based on 7677f7fd8be76 ?

Yes, I agree.

-- 
Cheers

David

