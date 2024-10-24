Return-Path: <stable+bounces-88096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DC9AEB61
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A302285BCE
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2891F7086;
	Thu, 24 Oct 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uOjFM8tJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDZKpPro";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vPFGlPfp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f2H3tJou"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03111BD504;
	Thu, 24 Oct 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785886; cv=none; b=DS7lu2w+nqa8IsQ5mDpRgLL7HxNTHyU4ObratjQatZjKNxjJJiQo0yCbhPRNmaYpjL5C1yiNvj5K7ETf+geocvUf9KM/3srIjePeO/+audrmX++2xy1i+KjAAlwDbQhIcGlZdwWe9roL+c32aQqlbdDBvbfsI4QSzr9GEWZmXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785886; c=relaxed/simple;
	bh=wcsY82VQpWJj9t5azimryQC4DuEwr1nLtNdgmYDd3+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUxu6Eq4RSmfVv+dUVXvjcXbxT14ciXW2KDRgfR5GiD3hiwMApyeneHVgTqjOKW7Do39FTvNTME8jALxVeBQ8plJrKr9+VIEVdO1MTkFzjTirnKGYYdJZ6qljkcaQ/Zrs9rd2plo2m49ljwuEl8VDZpKu4K3zz3k9dagyszESPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uOjFM8tJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDZKpPro; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vPFGlPfp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f2H3tJou; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C57D61F79F;
	Thu, 24 Oct 2024 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729785882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C4n+uG16nQASRu4wvt8vLL1Dm7UBTVuUlvxeOUEYA+E=;
	b=uOjFM8tJd6ccW2vrisRX1KZ8VcjhLNwA/V4vMA0F7xGyMrQmehdRQL3SEzxvDStVioJ2yA
	LPfZIHoWttcY7seJe1qGzfXZgbXBi7mgZGMwJGpIHa7P3OPq5rT2w6GJHszHql0q4co/6Y
	H/X/qH9yN4j4asK3tDX96c4K2eFGuZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729785882;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C4n+uG16nQASRu4wvt8vLL1Dm7UBTVuUlvxeOUEYA+E=;
	b=rDZKpProCLkf8OCxvJUuRqEiPRyY2fs1dt9UJQ7FyzhYrkFh3NfdAL2cBIVmBs/GGS/bGG
	fmf+ZYdewqFj/OBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729785881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C4n+uG16nQASRu4wvt8vLL1Dm7UBTVuUlvxeOUEYA+E=;
	b=vPFGlPfpGJlleUqwRfRV582izz80PeosRTG0dr4ATi/ICREGZSjGljmyVSuOZQMOaEhKix
	cZ/GrcqZdtxmfbxH56+c0l7hxRqtVwcHymblUR+gb0qRZ1KREhDfoPX6MSj7AVpeqoE68S
	W5t2LCW7x/pAY3u1XupGCvqlznRAH0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729785881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C4n+uG16nQASRu4wvt8vLL1Dm7UBTVuUlvxeOUEYA+E=;
	b=f2H3tJourdEb5Plg6NMWobaEZ4pqJdpqb0t3m6C3QR9zFVagWQaz9oIjBgdjD9Hk51mtNT
	G4UbBH5ClPli88DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A37F9136F5;
	Thu, 24 Oct 2024 16:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k8aQJxlwGmdRTwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 24 Oct 2024 16:04:41 +0000
Message-ID: <5f7a49e8-0416-4648-a704-a7a67e8cd894@suse.cz>
Date: Thu, 24 Oct 2024 18:04:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12] mm, mmap: limit THP aligment of anonymous
 mappings to PMD-aligned sizes
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>,
 Michael Matz <matz@suse.de>, Gabriel Krisman Bertazi <gabriel@krisman.be>,
 Matthias Bodenbinder <matthias@bodenbinder.de>, stable@vger.kernel.org,
 Rik van Riel <riel@surriel.com>, Yang Shi <yang@os.amperecomputing.com>,
 Matthew Wilcox <willy@infradead.org>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
 <20241024151228.101841-2-vbabka@suse.cz>
 <2b89811b-5957-4fad-8979-86744678d296@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <2b89811b-5957-4fad-8979-86744678d296@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:url]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/24/24 17:47, Lorenzo Stoakes wrote:
> On Thu, Oct 24, 2024 at 05:12:29PM +0200, Vlastimil Babka wrote:
>> Since commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
>> boundaries") a mmap() of anonymous memory without a specific address
>> hint and of at least PMD_SIZE will be aligned to PMD so that it can
>> benefit from a THP backing page.
>>
>> However this change has been shown to regress some workloads
>> significantly. [1] reports regressions in various spec benchmarks, with
>> up to 600% slowdown of the cactusBSSN benchmark on some platforms. The
> 
> Ugh god.
> 
>> benchmark seems to create many mappings of 4632kB, which would have
>> merged to a large THP-backed area before commit efa7df3e3bb5 and now
>> they are fragmented to multiple areas each aligned to PMD boundary with
>> gaps between. The regression then seems to be caused mainly due to the
>> benchmark's memory access pattern suffering from TLB or cache aliasing
>> due to the aligned boundaries of the individual areas.
> 
> Any more details on precisely why?

The experiments performed in [1] didn't seem conclusive enough for me to say
that with enough confidence :) Generally speaking if there are multiple
addresses with the same virtual or physical offset accesssed rapidly, they
can alias in the TLB or processor caches due to limited associativity and
cause thrashing. Aligning the mappings to same 2MB boundary can cause such
aliasing.

>>
>> Another known regression bisected to commit efa7df3e3bb5 is darktable
>> [2] [3] and early testing suggests this patch fixes the regression there
>> as well.
> 
> Good!
> 
>>
>> To fix the regression but still try to benefit from THP-friendly
>> anonymous mapping alignment, add a condition that the size of the
>> mapping must be a multiple of PMD size instead of at least PMD size. In
>> case of many odd-sized mapping like the cactusBSSN creates, those will
>> stop being aligned and with gaps between, and instead naturally merge
>> again.
>>
> 
> Seems like the original logic just padded the length by PMD size and checks
> for overflow, assuming that [pgoff << PAGE_SHIFT, pgoff << PAGE_SHIFT +
> len) contains at least one PMD-sized block.
> 
> Which I guess results in potentially getting mis-sized empty spaces that
> now can't be PMD-merged at the bits that 'overhang' the PMD-sized/aligned
> bit?
> 
> Which is yeah, not great and would explain this (correct me if my
> understanding is wrong).
> 
>> Reported-by: Michael Matz <matz@suse.de>
>> Debugged-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
>> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229012 [1]
>> Reported-by: Matthias Bodenbinder <matthias@bodenbinder.de>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219366 [2]
>> Closes: https://lore.kernel.org/all/2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info/ [3]
>> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
>> Cc: <stable@vger.kernel.org>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Yang Shi <yang@os.amperecomputing.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/mmap.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 9c0fb43064b5..a5297cfb1dfc 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -900,7 +900,8 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>>
>>  	if (get_area) {
>>  		addr = get_area(file, addr, len, pgoff, flags);
>> -	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
>> +		   && IS_ALIGNED(len, PMD_SIZE)) {
> 
> So doing this feels right but...
> 
> Hm this seems like it belongs in __thp_get_unmapped_area() which does a bunch of
> checks up front returning 0 if they fail, which then results in it peforming the
> normal get unmapped area logic.
> 
> That also has a bunch of (offset) alignment checks as well overflow checks
> so it would seem the natural place to also check length?

Petr suggested the same, but changing  __thp_get_unmapped_area() affects FS
THP's and the proposed check seemed wrong to me:

https://lore.kernel.org/all/9d7c73f6-1e1a-458b-93c6-3b44959022e0@suse.cz/

While it could be fixed, I'm still not sure if we want to restrict FS THPs
the same as anonymous THPs. AFAIU even small mappings of a range from a file
should be aligned properly to make it possible for a large range from the
same file (that includes the smaller range) mapped elsewhere to be THP
backed? I mean we can investigate it further, but for the regression fix to
backported to stable kernels it seemed more safe to address only the case
that was changed by commit efa7df3e3bb5 specifically, i.e. anonymous mappings.

>>  		/* Ensures that larger anonymous mappings are THP aligned. */
>>  		addr = thp_get_unmapped_area_vmflags(file, addr, len,
>>  						     pgoff, flags, vm_flags);
>> --
>> 2.47.0
>>


