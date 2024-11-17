Return-Path: <stable+bounces-93672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69DA9D0334
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 12:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BF4B22B5E
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB7613A27D;
	Sun, 17 Nov 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XcJ1OlCH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tfSUTeGC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ioDXYgf8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P8d4JMXB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61A11CAF;
	Sun, 17 Nov 2024 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731841933; cv=none; b=e0OhI2J10cUwGsfUgjDDDudi72yblY7/OVB6YWuGgE6+FoMtp+/L47gNwvpyIKoE5OUo5U8+Dw4rnylMHXMQtTQ7zPyeO0O/rDLSmzj25oUY+Nv59XLjlDgdJc27/srK/rDiCg+Tq1Nzhskc1+jw43Tv05F+Sj2jDzooIBEIe+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731841933; c=relaxed/simple;
	bh=+jlcTYYLyKw82qj7N9YEdPgK+/+T+2RY3jwKtCP/Kag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkFnvrxs2ahkNnSNNvgT7iYpW8nz/pTiyLH36FZv2S8hXqPG9Qbs4ZpbXUX+IMwDHdzmFsI44yY3FYWxI+3fDFD9hhHIeEW0HM6RcstRB7gXsRHSnPBW+oL3OqFbGL7EeBlJ6jjmK+qMnA0FImezUw/eT1kNZwycG/biNT7JzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XcJ1OlCH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tfSUTeGC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ioDXYgf8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P8d4JMXB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E69DD210F0;
	Sun, 17 Nov 2024 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731841926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f4EbAMMmlSBa1NQyk5g/groONUzdOMuy70Z3hW9jfEM=;
	b=XcJ1OlCHyooUm6AUj64baKeAPQJrzcZVuv9f3Y5oVFmVVkQaHg0ViQbdgvdsDQ2qH97LWd
	0rP1ys1KH4fIczjaRb2E0y8STQDmbYdi6rertwJwN2P2ZAUyZphGLQsL6L4cf3euIn1smf
	R2NrE/1ph0al4HGePf1nM9HWA1J4VKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731841926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f4EbAMMmlSBa1NQyk5g/groONUzdOMuy70Z3hW9jfEM=;
	b=tfSUTeGCxF/6ho+PuPdgImo2GSQ5EXkTJghVmGzowrwp4sE3ppG6jabMe0K/4fyAHCZ81b
	6ELwje4VMjwk8ACA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731841925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f4EbAMMmlSBa1NQyk5g/groONUzdOMuy70Z3hW9jfEM=;
	b=ioDXYgf86GYvYn989DaAZcrOvyskhCS0ai/q2hfP8wKx6BCNkaFLpgT9K7f6a8qxdXb7Bl
	tN3cFiswnJ8/7WsBLkehVFk20CwUY5FZTj3P5yT8z2A9GjymWSy8NcHle2aBlsZytXcOP1
	G9cVGE+n+vRiYA8VZ0fmptbAErIyokA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731841925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f4EbAMMmlSBa1NQyk5g/groONUzdOMuy70Z3hW9jfEM=;
	b=P8d4JMXBTEBYNi8HhnG6Cgzd5Mw6mDYdYtwTW2bpahRr5u6an4ZnL15JWLsQngx4yEFMkw
	pLH/TkYg2XPR2tCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC0FA136D9;
	Sun, 17 Nov 2024 11:12:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ufM3LYXPOWdKUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 17 Nov 2024 11:12:05 +0000
Message-ID: <f0502143-3b37-44aa-a3fa-d468e64b3245@suse.cz>
Date: Sun, 17 Nov 2024 12:12:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Respect mmap hint address when aligning for THP
Content-Language: en-US
To: Yang Shi <shy828301@gmail.com>, Kalesh Singh <kaleshsingh@google.com>
Cc: kernel-team@android.com, android-mm@google.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Yang Shi <yang@os.amperecomputing.com>, Rik van Riel <riel@surriel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Minchan Kim <minchan@kernel.org>, Hans Boehm <hboehm@google.com>,
 Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241115215256.578125-1-kaleshsingh@google.com>
 <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAHbLzkrVoK-y4zc10+=0hDGZLi8+i73wSHciTUOWGDBsEcD0xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.980];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/15/24 23:15, Yang Shi wrote:
> On Fri, Nov 15, 2024 at 1:52 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>>
>> Commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>> boundaries") updated __get_unmapped_area() to align the start address
>> for the VMA to a PMD boundary if CONFIG_TRANSPARENT_HUGEPAGE=y.
>>
>> It does this by effectively looking up a region that is of size,
>> request_size + PMD_SIZE, and aligning up the start to a PMD boundary.
>>
>> Commit 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment
>> on 32 bit") opted out of this for 32bit due to regressions in mmap base
>> randomization.
>>
>> Commit d4148aeab412 ("mm, mmap: limit THP alignment of anonymous
>> mappings to PMD-aligned sizes") restricted this to only mmap sizes that
>> are multiples of the PMD_SIZE due to reported regressions in some
>> performance benchmarks -- which seemed mostly due to the reduced spatial
>> locality of related mappings due to the forced PMD-alignment.
>>
>> Another unintended side effect has emerged: When a user specifies an mmap
>> hint address, the THP alignment logic modifies the behavior, potentially
>> ignoring the hint even if a sufficiently large gap exists at the requested
>> hint location.
>>
>> Example Scenario:
>>
>> Consider the following simplified virtual address (VA) space:
>>
>>     ...
>>
>>     0x200000-0x400000 --- VMA A
>>     0x400000-0x600000 --- Hole
>>     0x600000-0x800000 --- VMA B
>>
>>     ...
>>
>> A call to mmap() with hint=0x400000 and len=0x200000 behaves differently:
>>
>>   - Before THP alignment: The requested region (size 0x200000) fits into
>>     the gap at 0x400000, so the hint is respected.
>>
>>   - After alignment: The logic searches for a region of size
>>     0x400000 (len + PMD_SIZE) starting at 0x400000.
>>     This search fails due to the mapping at 0x600000 (VMA B), and the hint
>>     is ignored, falling back to arch_get_unmapped_area[_topdown]().

Hmm looks like the search is not done in the optimal way regardless of
whether or not it ignores a hint - it should be able to find the hole, no?

>> In general the hint is effectively ignored, if there is any
>> existing mapping in the below range:
>>
>>      [mmap_hint + mmap_size, mmap_hint + mmap_size + PMD_SIZE)
>>
>> This changes the semantics of mmap hint; from ""Respect the hint if a
>> sufficiently large gap exists at the requested location" to "Respect the
>> hint only if an additional PMD-sized gap exists beyond the requested size".
>>
>> This has performance implications for allocators that allocate their heap
>> using mmap but try to keep it "as contiguous as possible" by using the
>> end of the exisiting heap as the address hint. With the new behavior
>> it's more likely to get a much less contiguous heap, adding extra
>> fragmentation and performance overhead.
>>
>> To restore the expected behavior; don't use thp_get_unmapped_area_vmflags()
>> when the user provided a hint address.

Agreed, the hint should take precendence.

> Thanks for fixing it. I agree we should respect the hint address. But
> this patch actually just fixed anonymous mapping and the file mappings
> which don't support thp_get_unmapped_area(). So I think you should
> move the hint check to __thp_get_unmapped_area().
> 
> And Vlastimil's fix d4148aeab412 ("mm, mmap: limit THP alignment of
> anonymous mappings to PMD-aligned sizes") should be moved to there too
> IMHO.

This was brought up, but I didn't want to do it as part of the stable fix as
that would change even situations that Rik's change didn't.
If the mmap hint change is another stable hotfix, I wouldn't conflate it
either. But we can try it for further development. But careful about just
moving the code as-is, the file-based mappings are different than anonymous
memory and I believe file offsets matter:

https://lore.kernel.org/all/9d7c73f6-1e1a-458b-93c6-3b44959022e0@suse.cz/

https://lore.kernel.org/all/5f7a49e8-0416-4648-a704-a7a67e8cd894@suse.cz/

>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Yang Shi <yang@os.amperecomputing.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Hans Boehm <hboehm@google.com>
>> Cc: Lokesh Gidra <lokeshgidra@google.com>
>> Cc: <stable@vger.kernel.org>
>> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
>> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

>> ---
>>  mm/mmap.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 79d541f1502b..2f01f1a8e304 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -901,6 +901,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>>         if (get_area) {
>>                 addr = get_area(file, addr, len, pgoff, flags);
>>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
>> +                  && !addr /* no hint */
>>                    && IS_ALIGNED(len, PMD_SIZE)) {
>>                 /* Ensures that larger anonymous mappings are THP aligned. */
>>                 addr = thp_get_unmapped_area_vmflags(file, addr, len,
>>
>> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
>> --
>> 2.47.0.338.g60cca15819-goog
>>


