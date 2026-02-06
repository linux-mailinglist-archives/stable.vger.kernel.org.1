Return-Path: <stable+bounces-214693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKdkLO0mhmlSKAQAu9opvQ
	(envelope-from <stable+bounces-214693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:37:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD691012DF
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47EED303FFDF
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FC23A1E64;
	Fri,  6 Feb 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vm8Fg+FJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmdQb3ok";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vm8Fg+FJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmdQb3ok"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904E2E7BD2
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399268; cv=none; b=LyHQnWTOb039FcZZaYu2WcpCszO8T/TLNBAofZ/Bm/5wdNs1F2AD2XYoBzPwqjHGYkr3NYI6w4om3/zC42pUGCFNSmXnBudKVV+L/B8SM7rAGHptmJWUerlF+jEhcJxiCmsKMEFCWz0MmCPS5g6cWfl9Ga35Qm8CFhKfB+9ClYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399268; c=relaxed/simple;
	bh=G73NPbAr9sDgjCCnvpQnKtQeN8KTGo+zEVcIq8mmSQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3B/2ix0wyDoLBloBM5a3nlZfVGvIXS7KLGCiJJbOm5Jvo/CuUuG75yzbI9YFdef5lBqUIkMCIGDFQqZAECKbrzlfcXwQ4RnP+uvio/NEmNBvwORZFkQhlp9NQlcA9CBIkDnQ6SiBIriOj7dBuhR/k0e+s/516ByhzGxMEdPKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vm8Fg+FJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmdQb3ok; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vm8Fg+FJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmdQb3ok; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8095A3E6D6;
	Fri,  6 Feb 2026 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770399266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzcSvBrkCZ6hqwbe0q+3XZbA+hCy0075eIN7Kvu56m8=;
	b=vm8Fg+FJKNVnpxYR2SRg/827ADrVaCtxQKOmYeJ5HvoFA6lwE34i6k+atXJdyqwyQ7Qjae
	Se5qY5K6IHXO51xqPWogOK3lnsEMD1bcYRnMzpwCr6isFmTxCBJnR4C2thvMnkJ5EE3t8p
	2Zm6DMSexOummQQC8etcAhKIvlKVVk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770399266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzcSvBrkCZ6hqwbe0q+3XZbA+hCy0075eIN7Kvu56m8=;
	b=HmdQb3ok7Aoh2RbgwCIdYe+bfofthbR1PwBmvHZiNV/8k17gHAdfoVZff5pnWAEb/ZmT0x
	vN9ok3hcHtVjYMBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770399266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzcSvBrkCZ6hqwbe0q+3XZbA+hCy0075eIN7Kvu56m8=;
	b=vm8Fg+FJKNVnpxYR2SRg/827ADrVaCtxQKOmYeJ5HvoFA6lwE34i6k+atXJdyqwyQ7Qjae
	Se5qY5K6IHXO51xqPWogOK3lnsEMD1bcYRnMzpwCr6isFmTxCBJnR4C2thvMnkJ5EE3t8p
	2Zm6DMSexOummQQC8etcAhKIvlKVVk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770399266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KzcSvBrkCZ6hqwbe0q+3XZbA+hCy0075eIN7Kvu56m8=;
	b=HmdQb3ok7Aoh2RbgwCIdYe+bfofthbR1PwBmvHZiNV/8k17gHAdfoVZff5pnWAEb/ZmT0x
	vN9ok3hcHtVjYMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47A993EA63;
	Fri,  6 Feb 2026 17:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2/slESImhmnNcAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 06 Feb 2026 17:34:26 +0000
Message-ID: <651bd1f9-8971-48da-a0c4-328e235c2eab@suse.cz>
Date: Fri, 6 Feb 2026 18:34:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: skip debug_check_no_{obj,locks}_freed with
 FPI_TRYLOCK
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20260206165802.17280-1-harry.yoo@oracle.com>
 <7B9B9CF3-29A6-4271-8C3C-87FF3EB9FA4D@nvidia.com> <aYYi3DhceyKbta2Y@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aYYi3DhceyKbta2Y@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-214693-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Queue-Id: EDD691012DF
X-Rspamd-Action: no action

On 2/6/26 18:20, Harry Yoo wrote:
> On Fri, Feb 06, 2026 at 12:08:04PM -0500, Zi Yan wrote:
>> On 6 Feb 2026, at 11:58, Harry Yoo wrote:
>> 
>> > When CONFIG_DEBUG_OBJECTS_FREE is enabled,
>> > debug_check_no_{obj,locks}_freed() functions are called.
>> >
>> > Since both of them spin on a lock, they are not safe to be called
>> > if the FPI_TRYLOCK flag is specified. This leads to a lockdep splat:
>> >
>> >   ================================
>> >   WARNING: inconsistent lock state
>> >   6.19.0-rc5-slab-for-next+ #326 Tainted: G                 N
>> >   --------------------------------
>> >   inconsistent {INITIAL USE} -> {IN-NMI} usage.
>> >   kunit_try_catch/9046 [HC2[2]:SC0[0]:HE0:SE1] takes:
>> >   ffffffff84ed6bf8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed+0xe0/0x300
>> >   {INITIAL USE} state was registered at:
>> >     lock_acquire+0xd9/0x2f0
>> >     _raw_spin_lock_irqsave+0x4c/0x80
>> >     __debug_object_init+0x9d/0x1f0
>> >     debug_object_init+0x34/0x50
>> >     __init_work+0x28/0x40
>> >     init_cgroup_housekeeping+0x151/0x210
>> >     init_cgroup_root+0x3d/0x140
>> >     cgroup_init_early+0x30/0x240
>> >     start_kernel+0x3e/0xcd0
>> >     x86_64_start_reservations+0x18/0x30
>> >     x86_64_start_kernel+0xf3/0x140
>> >     common_startup_64+0x13e/0x148
>> >   irq event stamp: 2998
>> >   hardirqs last  enabled at (2997): [<ffffffff8298b77a>] exc_nmi+0x11a/0x240
>> >   hardirqs last disabled at (2998): [<ffffffff8298b991>] sysvec_irq_work+0x11/0x110
>> >   softirqs last  enabled at (1416): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
>> >   softirqs last disabled at (1303): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
>> >
>> >   other info that might help us debug this:
>> >    Possible unsafe locking scenario:
>> >
>> >          CPU0
>> >          ----
>> >     lock(&obj_hash[i].lock);
>> >     <Interrupt>
>> >       lock(&obj_hash[i].lock);
>> >
>> >    *** DEADLOCK ***
>> >
>> > Fix this by adding an fpi_t parameter to free_pages_prepare() and
>> > skipping those checks if FPI_TRYLOCK is set. Since mm/compaction.c
>> > calls free_pages_prepare(), move the fpi_t definition to mm/internal.h.
>> >
>> > Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
>> > Cc: <stable@vger.kernel.org>
>> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
>> > ---
>> >  mm/compaction.c |  2 +-
>> >  mm/internal.h   | 35 ++++++++++++++++++++++++++++++++++-
>> >  mm/page_alloc.c | 42 ++++++------------------------------------
>> >  3 files changed, 41 insertions(+), 38 deletions(-)
>> >
>> > diff --git a/mm/compaction.c b/mm/compaction.c
>> > index 1e8f8eca318c..9ffeb7c6d2b0 100644
>> > --- a/mm/compaction.c
>> > +++ b/mm/compaction.c
>> > @@ -1859,7 +1859,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
>> >  	struct page *page = &dst->page;
>> >
>> >  	if (folio_put_testzero(dst)) {
>> > -		free_pages_prepare(page, order);
>> > +		free_pages_prepare(page, order, FPI_NONE);
>> 
>> Is it OK to add something like free_pages_prepare_fpi_none() for this one
>> to avoid the FPI flag move?
> 
> Yeah, moving FPI flag definition isn't great :)
> 
> I'm totally fine with your suggestion,
> as long as page allocator/compaction folks are fine with it!

Maybe even like this?
free_pages_prepare() which calls __free_pages_prepare(FPI_NONE)


