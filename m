Return-Path: <stable+bounces-92608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C369D9C5755
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156F4B41FFB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BB2141AD;
	Tue, 12 Nov 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EXa/ppdB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SgNV99uu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EXa/ppdB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SgNV99uu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C82123F5;
	Tue, 12 Nov 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408004; cv=none; b=dpv3Q31puLnsJCfn/Wcol1yJeY0dIZ6hNHQbM08207gBWu7LN7ck471tJMUw7QlJI6EkDC/rUExFQ+xf5+jaBtdEH6hsLdKX3ASOGYEW1Sa+ybEW5R8U2SredejS+Xo0W0MRl+0TV+awCFZjNZC0zXOtM9Yim7b9aMMJB81fde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408004; c=relaxed/simple;
	bh=UxFxom0gcxOKeTripJTHAGUcE98YuF4wuprK7Ac6taE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSFBFoiMTtXenhR/nJgvhC10q94RhAkvoELacEay6Z0bG0e91hSyPomfcyYY2hDh9FL2wbS9XgAuyA7fuR9Wgz9JlnwsdOUbh6XP0N7O2AmWoAaZEVDtSweFIAkyeZ7j1OMS7Nx9t9Nhfzo16cB4TLltt73xwiDWHQtFvk80z5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EXa/ppdB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SgNV99uu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EXa/ppdB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SgNV99uu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15FE11F451;
	Tue, 12 Nov 2024 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731408001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dHS1sjrRLhtpQVGwhx+Cmb/G/GWD8EvV6lll1hsF9os=;
	b=EXa/ppdBClb/UMJjF6C0QE+3hJrFMdcdZU0qhuQ5HEvrWOIPEd/7WQfXojVKdZdh6dLLux
	kU2j/4wF4vY5LtZFHk8PQCBKMVHPpY7+PafX63KdZn0NeYBGP/Tb4cILbMmHAeuBO6FaOb
	OYNWUOZrj1vBtpV+zJZdOzcNnN1QZwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731408001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dHS1sjrRLhtpQVGwhx+Cmb/G/GWD8EvV6lll1hsF9os=;
	b=SgNV99uuZCEdtl1slbVq1e6OptyjVJd8Eh4RCXcmXOxSredyHOsEoVnFF4Qtas+TseQOSp
	yiTRNuVpr1wbVVAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731408001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dHS1sjrRLhtpQVGwhx+Cmb/G/GWD8EvV6lll1hsF9os=;
	b=EXa/ppdBClb/UMJjF6C0QE+3hJrFMdcdZU0qhuQ5HEvrWOIPEd/7WQfXojVKdZdh6dLLux
	kU2j/4wF4vY5LtZFHk8PQCBKMVHPpY7+PafX63KdZn0NeYBGP/Tb4cILbMmHAeuBO6FaOb
	OYNWUOZrj1vBtpV+zJZdOzcNnN1QZwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731408001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dHS1sjrRLhtpQVGwhx+Cmb/G/GWD8EvV6lll1hsF9os=;
	b=SgNV99uuZCEdtl1slbVq1e6OptyjVJd8Eh4RCXcmXOxSredyHOsEoVnFF4Qtas+TseQOSp
	yiTRNuVpr1wbVVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0174F13301;
	Tue, 12 Nov 2024 10:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3PMHAIEwM2fJNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 10:40:00 +0000
Message-ID: <751739c3-2d33-4759-b9cf-a02d35391cbb@suse.cz>
Date: Tue, 12 Nov 2024 11:40:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix address wraparound in move_page_tables()
Content-Language: en-US
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241111-fix-mremap-32bit-wrap-v1-1-61d6be73b722@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/11/24 20:34, Jann Horn wrote:
> On 32-bit platforms, it is possible for the expression
> `len + old_addr < old_end` to be false-positive if `len + old_addr` wraps
> around. `old_addr` is the cursor in the old range up to which page table
> entries have been moved; so if the operation succeeded, `old_addr` is the
> *end* of the old region, and adding `len` to it can wrap.
> 
> The overflow causes mremap() to mistakenly believe that PTEs have been
> copied; the consequence is that mremap() bails out, but doesn't move the
> PTEs back before the new VMA is unmapped, causing anonymous pages in the
> region to be lost. So basically if userspace tries to mremap() a
> private-anon region and hits this bug, mremap() will return an error and
> the private-anon region's contents appear to have been zeroed.
> 
> The idea of this check is that `old_end - len` is the original start
> address, and writing the check that way also makes it easier to read; so
> fix the check by rearranging the comparison accordingly.
> 
> (An alternate fix would be to refactor this function by introducing an
> "orig_old_start" variable or such.)
> 
> Cc: stable@vger.kernel.org
> Fixes: af8ca1c14906 ("mm/mremap: optimize the start addresses in move_page_tables()")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> ---
> Tested in a VM with a 32-bit X86 kernel; without the patch:
> 
> ```
> user@horn:~/big_mremap$ cat test.c
> #define _GNU_SOURCE
> #include <stdlib.h>
> #include <stdio.h>
> #include <err.h>
> #include <sys/mman.h>
> 
> #define ADDR1 ((void*)0x60000000)
> #define ADDR2 ((void*)0x10000000)
> #define SIZE          0x50000000uL
> 
> int main(void) {
>   unsigned char *p1 = mmap(ADDR1, SIZE, PROT_READ|PROT_WRITE,
>       MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
>   if (p1 == MAP_FAILED)
>     err(1, "mmap 1");
>   unsigned char *p2 = mmap(ADDR2, SIZE, PROT_NONE,
>       MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
>   if (p2 == MAP_FAILED)
>     err(1, "mmap 2");
>   *p1 = 0x41;
>   printf("first char is 0x%02hhx\n", *p1);
>   unsigned char *p3 = mremap(p1, SIZE, SIZE,
>       MREMAP_MAYMOVE|MREMAP_FIXED, p2);
>   if (p3 == MAP_FAILED) {
>     printf("mremap() failed; first char is 0x%02hhx\n", *p1);
>   } else {
>     printf("mremap() succeeded; first char is 0x%02hhx\n", *p3);
>   }
> }
> user@horn:~/big_mremap$ gcc -static -o test test.c
> user@horn:~/big_mremap$ setarch -R ./test
> first char is 0x41
> mremap() failed; first char is 0x00
> ```
> 
> With the patch:
> 
> ```
> user@horn:~/big_mremap$ setarch -R ./test
> first char is 0x41
> mremap() succeeded; first char is 0x41
> ```
> ---
>  mm/mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index dda09e957a5d4c2546934b796e862e5e0213b311..dee98ff2bbd64439200dddac16c4bd054537c2ed 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -648,7 +648,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	 * Prevent negative return values when {old,new}_addr was realigned
>  	 * but we broke out of the above loop for the first PMD itself.
>  	 */
> -	if (len + old_addr < old_end)
> +	if (old_addr < old_end - len)
>  		return 0;
>  
>  	return len + old_addr - old_end;	/* how much done */
> 
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241111-fix-mremap-32bit-wrap-747105730f20
> 


