Return-Path: <stable+bounces-192595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE8C3A50D
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 11:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9382F1881E07
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408D2D94A1;
	Thu,  6 Nov 2025 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGUAu15u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGWAfYfM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGUAu15u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGWAfYfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0626738B
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425573; cv=none; b=gLk91cdY6RwG+xrp63zLYqXVBm8cENWPgvMN3x4U0V6QJW4zQuvkXBPxCsQjHBuyGq/hAeIwKBZJx+K8F5vK8w4a6jJclxNEk9pEPGkKCmtAmGQjKV/56vHPDvmOIx2VDRe+B5oj9zo2FhR6U8HQ9QZ/Q9zs6AOg4eV5DRo/IY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425573; c=relaxed/simple;
	bh=SSW95CX6WlK0R8DRQxilEgtoYYnKrIWcKhxcs8gQqPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJ1nSJJKV1azUA3JWvsvUla6LhcytSwiEPqacaZQCHu1wCJGRBIEv6Llz2hBSFmBhGY5ohceUngDKHxy9AWPfNx8LcJvDjaIVO2h2dO6uWgNxmhzyv6XPNuaWxORtVljLyEv0xZxTvNNWtPfSkbAA6ZYwqSlTZqsEbu1RNttit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGUAu15u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGWAfYfM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGUAu15u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGWAfYfM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A48A211D0;
	Thu,  6 Nov 2025 10:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762425569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUC894EkN1Ri8Isz8oVgyo60pIndnmnfMDWBoq1SCQk=;
	b=fGUAu15uukdcYPvh1QKp+k56esnXoryL6xnIi5ODC6JToaAfcaF9vYJeuYfHn4kXuJI2nv
	UHVoPzZhRgqu8T+IdbjbP3PGxvK+aLqiBQgrkAVnyR8sXrE2T9E6zPeA+zDRdyrmX1WWiv
	ME3qg7zXFhXaN3ImX1c6orASo5qj15E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762425569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUC894EkN1Ri8Isz8oVgyo60pIndnmnfMDWBoq1SCQk=;
	b=yGWAfYfMI92bWPSsIXCYdU4IRWi5rLaW5zOC6GadK9cXmb1ZfnC+wuU2cNBPUDV/39oksx
	BF4ohMLXDOywqvDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fGUAu15u;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yGWAfYfM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762425569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUC894EkN1Ri8Isz8oVgyo60pIndnmnfMDWBoq1SCQk=;
	b=fGUAu15uukdcYPvh1QKp+k56esnXoryL6xnIi5ODC6JToaAfcaF9vYJeuYfHn4kXuJI2nv
	UHVoPzZhRgqu8T+IdbjbP3PGxvK+aLqiBQgrkAVnyR8sXrE2T9E6zPeA+zDRdyrmX1WWiv
	ME3qg7zXFhXaN3ImX1c6orASo5qj15E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762425569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUC894EkN1Ri8Isz8oVgyo60pIndnmnfMDWBoq1SCQk=;
	b=yGWAfYfMI92bWPSsIXCYdU4IRWi5rLaW5zOC6GadK9cXmb1ZfnC+wuU2cNBPUDV/39oksx
	BF4ohMLXDOywqvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B3FF13A31;
	Thu,  6 Nov 2025 10:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WXyXGeF6DGmTXAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Nov 2025 10:39:29 +0000
Message-ID: <13c7242e-3a40-469b-9e99-8a65a21449bb@suse.cz>
Date: Thu, 6 Nov 2025 11:39:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/ksm: fix flag-dropping behavior in ksm_madvise
Content-Language: en-US
To: Jakub Acs <acsjakub@amazon.de>, linux-mm@kvack.org,
 Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, xu.xin16@zte.com.cn,
 chengming.zhou@linux.dev, peterx@redhat.com, axelrasmussen@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251001090353.57523-1-acsjakub@amazon.de>
 <20251001090353.57523-2-acsjakub@amazon.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20251001090353.57523-2-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8A48A211D0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/1/25 11:03, Jakub Acs wrote:
> syzkaller discovered the following crash: (kernel BUG)
> 
> [   44.607039] ------------[ cut here ]------------
> [   44.607422] kernel BUG at mm/userfaultfd.c:2067!
> [   44.608148] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   44.608814] CPU: 1 UID: 0 PID: 2475 Comm: reproducer Not tainted 6.16.0-rc6 #1 PREEMPT(none)
> [   44.609635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   44.610695] RIP: 0010:userfaultfd_release_all+0x3a8/0x460
> 
> <snip other registers, drop unreliable trace>
> 
> [   44.617726] Call Trace:
> [   44.617926]  <TASK>
> [   44.619284]  userfaultfd_release+0xef/0x1b0
> [   44.620976]  __fput+0x3f9/0xb60
> [   44.621240]  fput_close_sync+0x110/0x210
> [   44.622222]  __x64_sys_close+0x8f/0x120
> [   44.622530]  do_syscall_64+0x5b/0x2f0
> [   44.622840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   44.623244] RIP: 0033:0x7f365bb3f227
> 
> Kernel panics because it detects UFFD inconsistency during
> userfaultfd_release_all(). Specifically, a VMA which has a valid pointer
> to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.
> 
> The inconsistency is caused in ksm_madvise(): when user calls madvise()
> with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR
> mode, it accidentally clears all flags stored in the upper 32 bits of
> vma->vm_flags.
> 
> Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int
> and int are 32-bit wide. This setup causes the following mishap during
> the &= ~VM_MERGEABLE assignment.
> 
> VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
> After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
> promoted to unsigned long before the & operation. This promotion fills
> upper 32 bits with leading 0s, as we're doing unsigned conversion (and
> even for a signed conversion, this wouldn't help as the leading bit is
> 0). & operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
> instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
> the upper 32-bits of its value.
> 
> Fix it by changing `VM_MERGEABLE` constant to unsigned long, using the
> BIT() macro.
> 
> Note: other VM_* flags are not affected:
> This only happens to the VM_MERGEABLE flag, as the other VM_* flags are
> all constants of type int and after ~ operation, they end up with
> leading 1 and are thus converted to unsigned long with leading 1s.
> 
> Note 2:
> After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
> no longer a kernel BUG, but a WARNING at the same place:
> 
> [   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067
> 
> but the root-cause (flag-drop) remains the same.
> 
> Fixes: 7677f7fd8be76 ("userfaultfd: add minor fault registration mode")

Late to the party, but it seems to me the correct Fixes: should be
f8af4da3b4c1 ("ksm: the mm interface to ksm")
which introduced the flag and the buggy clearing code, no?

Commit 7677f7fd8be76 is just one that notices it, right? But there are other
flags in >32 bit area, including pkeys etc. Sounds rather dangerous if they
can be cleared using a madvise.

So we can't amend the Fixes: now but maybe could advise stable to backport
for even older versions than based on 7677f7fd8be76 ?

> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xu Xin <xu.xin16@zte.com.cn>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..c6794d0e24eb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -296,7 +296,7 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
>  #define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
>  #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
> -#define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
> +#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
>  
>  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
>  #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */


