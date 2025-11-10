Return-Path: <stable+bounces-192924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A048C45D01
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 11:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 430BD4F02A7
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D4302CB3;
	Mon, 10 Nov 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="01ClbPZE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Dx3gwgS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfJRo7UP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7oGurzhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE22367CF
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768827; cv=none; b=aHS6YcPd+6+JeWcb/mrp+6bJlcfVk1Y8QfIOjPgb8R0tdLeCSx6IQnqaoBRSjgULyS+btSYCHWI1RBpIrpLkJViYXeIUjnhNTkXbrSM+MWfPJHIVOmRwHINQUxSZzVCKGBciesIFbeQfd2+N8RdoP3bSbJd0MhYC5gZUusjWmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768827; c=relaxed/simple;
	bh=0pLiqC7zX6y5XToxFf10Jb0sl2165D68lFufLFCmghU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c5lAWjt6PTwoaH7VAVbz7qFbaj9FZkcP/5TJXu3cHvU6HHvdCiqeSMPGUPqJQa5QId+cx8lVpj1c+fh6LStgRbhX/sDOE0IH3URQTKWWwUKBS9wCYvaw9gUrS5NTp0NjvImRGu7Q7pIEvXPbdoJ4PGXzL0Mo2ADpNuhYCH9JXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=01ClbPZE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Dx3gwgS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfJRo7UP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7oGurzhB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D917F21FD3;
	Mon, 10 Nov 2025 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w/BxzBnNXdonPq9Y2zaHgBKsc6ngF/ZxixFOXiRQSKo=;
	b=01ClbPZEEaxy3wZZLi+/XxDAzr9ERLYxEqIPHHG1P1IfNbwDw8pTZEdwre7d07UuooCVZW
	lglKjLBhNrBp44IfF9288dpUM82muFDyz4yxsuOBnB6p5+uYF6PSFZ+EvfUyeHBhM3R3HN
	BrV8s8vQhRWIiK2o4fLY6Hsm070qHDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w/BxzBnNXdonPq9Y2zaHgBKsc6ngF/ZxixFOXiRQSKo=;
	b=3Dx3gwgSnNNnNO7xj1B5hovmWrE11K8uvmJVtIzoYzmuzzrfmq1fW0AFdLrBpMSUSJhS2D
	4FC99zHgSlhtTKCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w/BxzBnNXdonPq9Y2zaHgBKsc6ngF/ZxixFOXiRQSKo=;
	b=yfJRo7UPgLDczWsyOb5u2S5P5rbSYNqPxCoZmCsfouyx9opWZ3/Fe7rZ5ZjkhGp0eiAsOr
	tItWPqIXvnLA272hctKvBrB2HmKoOvpz3EMutfzAXzAnA7CRcdOTxlpBZsB2HTYeKDjGm2
	hjkNXXNjXR8cq1NlbCc5XYJwNjporFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w/BxzBnNXdonPq9Y2zaHgBKsc6ngF/ZxixFOXiRQSKo=;
	b=7oGurzhBOwCAEPvpUb4Vxelu4c21TIi6sz+7BWCz8wiSYjgfnkf8JhKEeFgbqbItX1OKtL
	S9Jjze6YpUxxLhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A818D1432C;
	Mon, 10 Nov 2025 10:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5q0KLa3EWmBCAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Nov 2025 10:00:22 +0000
Message-ID: <461d3a9e-f3e2-4c2f-ac9b-2b842ce115fd@suse.cz>
Date: Mon, 10 Nov 2025 11:00:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/ksm: fix flag-dropping behavior in ksm_madvise
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Jakub Acs <acsjakub@amazon.de>, linux-mm@kvack.org,
 Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, xu.xin16@zte.com.cn,
 chengming.zhou@linux.dev, peterx@redhat.com, axelrasmussen@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251001090353.57523-1-acsjakub@amazon.de>
 <20251001090353.57523-2-acsjakub@amazon.de>
 <13c7242e-3a40-469b-9e99-8a65a21449bb@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <13c7242e-3a40-469b-9e99-8a65a21449bb@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,imap1.dmz-prg2.suse.org:helo,zte.com.cn:email,amazon.de:email,linux-foundation.org:email,suse.cz:mid,kvack.org:email,linux.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/6/25 11:39, Vlastimil Babka wrote:
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

Clarification: flags with bits >31 did not exist at the time of f8af4da3b4c1
as they were only introduced later with 63c17fb8e5a4 ("mm/core,
x86/mm/pkeys: Store protection bits in high VMA flags") (v4.6) so that would
have been the most precise Fixes: commit. Sorry, Hugh :)

But that doesn't affect the stable backports efforts where the oldest LTS is
5.4 anyway.

> Commit 7677f7fd8be76 is just one that notices it, right? But there are other
> flags in >32 bit area, including pkeys etc. Sounds rather dangerous if they
> can be cleared using a madvise.
> 
> So we can't amend the Fixes: now but maybe could advise stable to backport
> for even older versions than based on 7677f7fd8be76 ?
> 
>> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Xu Xin <xu.xin16@zte.com.cn>
>> Cc: Chengming Zhou <chengming.zhou@linux.dev>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Axel Rasmussen <axelrasmussen@google.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: stable@vger.kernel.org
>> ---
>>  include/linux/mm.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1ae97a0b8ec7..c6794d0e24eb 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -296,7 +296,7 @@ extern unsigned int kobjsize(const void *objp);
>>  #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
>>  #define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
>>  #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
>> -#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
>> +#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
>>  
>>  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
>>  #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
> 


