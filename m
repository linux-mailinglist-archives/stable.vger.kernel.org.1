Return-Path: <stable+bounces-215548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ODnGoMvimm3IAAAu9opvQ
	(envelope-from <stable+bounces-215548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:03:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1433113E88
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 20:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323F2301DAE4
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 19:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC42E764D;
	Mon,  9 Feb 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h9jdi9c+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3SKWIJ4Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h9jdi9c+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3SKWIJ4Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D120DE3
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663807; cv=none; b=kZqw2YvBxtYOBy0OLzgaEmAnWLSdlVi/VPSGh3CKvremF+vTgXBKk6wGJD5OJVLyqy8ElOhdpxGwv9pgBs7Dv2lxuhoJMYiCM0WPbodR/iiyeFLm/W+aaJ5/QgfqlPSEn0TtuLj/o1wbdQRKfO3uITocSxCMSJIQSFCXNUwrq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663807; c=relaxed/simple;
	bh=vLCHA4q+mtXgp2R8zAUFho6W6WgcjrPUoa/T/70Dh+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5MZQIMk6rxLRGXsXv6470TI5lnbkkZ4VTzmCbjkmwyPDY39Zq1FZK98w5hLtme4XILiKlTZAJ6TQbbTqVCSV/92SlhQQanxwZqxwTuXrnhgn8+vsZXHxjNoTBgU36BDboUI7laVdGDGwf64a9wgj2Of1ScosAD+B/wj4wFe0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h9jdi9c+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3SKWIJ4Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h9jdi9c+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3SKWIJ4Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 816B15BD12;
	Mon,  9 Feb 2026 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770663805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xK0puEGN5CRYnbu6E9/dBnWPkeOm/WK3mwAREKitcdo=;
	b=h9jdi9c+N23fVWpR2APyCg8uR4N79LD+wcL0d7+NdCFiX3ICTje5Xw8gyryV480/Gq9K3q
	hdnN5pweaMNE6VVpmIDGgkbyTt37wFkBKa8CvpcVRi+cJLv60yyK0R7I+aOTaoMXV0eGm3
	GbsswrYuQKRP5vQPQJXPPuLXFKsO00s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770663805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xK0puEGN5CRYnbu6E9/dBnWPkeOm/WK3mwAREKitcdo=;
	b=3SKWIJ4Z5F9/GuR+cSy15++RNxymOjCE2RS7j6zd4Kemmc4Fap+fB1RJPyOdPFfJP4NPbU
	UytmpD8dKVy2zdBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h9jdi9c+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3SKWIJ4Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770663805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xK0puEGN5CRYnbu6E9/dBnWPkeOm/WK3mwAREKitcdo=;
	b=h9jdi9c+N23fVWpR2APyCg8uR4N79LD+wcL0d7+NdCFiX3ICTje5Xw8gyryV480/Gq9K3q
	hdnN5pweaMNE6VVpmIDGgkbyTt37wFkBKa8CvpcVRi+cJLv60yyK0R7I+aOTaoMXV0eGm3
	GbsswrYuQKRP5vQPQJXPPuLXFKsO00s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770663805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xK0puEGN5CRYnbu6E9/dBnWPkeOm/WK3mwAREKitcdo=;
	b=3SKWIJ4Z5F9/GuR+cSy15++RNxymOjCE2RS7j6zd4Kemmc4Fap+fB1RJPyOdPFfJP4NPbU
	UytmpD8dKVy2zdBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 501C13EA63;
	Mon,  9 Feb 2026 19:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aQo6E30vimnRUQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Feb 2026 19:03:25 +0000
Message-ID: <a972a203-d4c5-4161-b9e6-42fbf733d75a@suse.cz>
Date: Mon, 9 Feb 2026 20:03:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/slab: skip get_from_any_partial() if !allow_spin
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
 linux-mm <linux-mm@kvack.org>, stable <stable@vger.kernel.org>
References: <20260206171348.35886-1-harry.yoo@oracle.com>
 <20260206171348.35886-2-harry.yoo@oracle.com>
 <2ce1eac3-98fd-448f-8a73-01bb3cb5a7d5@suse.cz>
 <CAADnVQ+1RBXBWNQtshEfFNZEp0tDZOFKf_vedyjgdz=wqWdG8A@mail.gmail.com>
 <aYlR_KW8xj4LJaYt@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aYlR_KW8xj4LJaYt@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215548-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1433113E88
X-Rspamd-Action: no action

On 2/9/26 04:18, Harry Yoo wrote:
> On Fri, Feb 06, 2026 at 11:19:01AM -0800, Alexei Starovoitov wrote:
>> On Fri, Feb 6, 2026 at 10:10 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> >
>> > On 2/6/26 18:13, Harry Yoo wrote:
>> > > Lockdep complains when get_from_any_partial() is called in an NMI
>> > > context, because current->mems_allowed_seq is seqcount_spinlock_t and
>> > > not NMI-safe:
>> > >
>> > >   ================================
>> > >   WARNING: inconsistent lock state
>> > >   6.19.0-rc5-kfree-rcu+ #315 Tainted: G                 N
>> > >   --------------------------------
>> > >   inconsistent {INITIAL USE} -> {IN-NMI} usage.
>> > >   kunit_try_catch/9989 [HC1[1]:SC0[0]:HE0:SE1] takes:
>> > >   ffff889085799820 (&____s->seqcount#3){.-.-}-{0:0}, at: ___slab_alloc+0x58f/0xc00
>> > >   {INITIAL USE} state was registered at:
>> > >     lock_acquire+0x185/0x320
>> > >     kernel_init_freeable+0x391/0x1150
>> > >     kernel_init+0x1f/0x220
>> > >     ret_from_fork+0x736/0x8f0
>> > >     ret_from_fork_asm+0x1a/0x30
>> > >   irq event stamp: 56
>> > >   hardirqs last  enabled at (55): [<ffffffff850a68d7>] _raw_spin_unlock_irq+0x27/0x70
>> > >   hardirqs last disabled at (56): [<ffffffff850858ca>] __schedule+0x2a8a/0x6630
>> > >   softirqs last  enabled at (0): [<ffffffff81536711>] copy_process+0x1dc1/0x6a10
>> > >   softirqs last disabled at (0): [<0000000000000000>] 0x0
>> > >
>> > >   other info that might help us debug this:
>> > >    Possible unsafe locking scenario:
>> > >
>> > >          CPU0
>> > >          ----
>> > >     lock(&____s->seqcount#3);
>> > >     <Interrupt>
>> > >       lock(&____s->seqcount#3);
>> > >
>> > >    *** DEADLOCK ***
>> > >
>> > > According to Documentation/locking/seqlock.rst, seqcount_t is not
>> > > NMI-safe and seqcount_latch_t should be used when read path can interrupt
>> > > the write-side critical section. In this case, return NULL and fall back
>> > > to slab allocation if !allow_spin.
>> > >
>> > > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
>> > > ---
>> > >  mm/slub.c | 8 ++++++++
>> > >  1 file changed, 8 insertions(+)
>> > >
>> > > diff --git a/mm/slub.c b/mm/slub.c
>> > > index 102fb47ae013..d46464654c15 100644
>> > > --- a/mm/slub.c
>> > > +++ b/mm/slub.c
>> > > @@ -3789,6 +3789,14 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
>> > >       enum zone_type highest_zoneidx = gfp_zone(pc->flags);
>> > >       unsigned int cpuset_mems_cookie;
>> > >
>> > > +     /*
>> > > +      * read_mems_allow_begin() accesses current->mems_allowed_seq,
>> > > +      * a seqcount_spinlock_t that is not NMI-safe. Skip allocation
>> > > +      * when GFP flags indicate spinning is not allowed.
>> > > +      */
>> > > +     if (!gfpflags_allow_spinning(pc->flags))
>> > > +             return NULL;
>> >
>> > I think it would be less restrictive to just continue,
> 
> Ack.
> 
>> > but skip the
>> > read_mems_allowed_retry() part in the do-while loop, so just make it one
>> > iteration for !allow_spin.
> 
> Makes sense.
> 
>> > If lockdep doesn't like even the
>> > read_mems_allowed_begin() (not clear to me), skip it too?
> 
> Yes, lockdep doesn't like read_mems_allowed_begin(), and thus
> we should skip both.
> 
>> 
>> +1
>> Just unconditional return NULL seems too restrictive.
> 
> Ack.
> 
> I'll do something like this:

Looks good!

> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 102fb47ae013..cc686ab929fe 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3788,6 +3788,7 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
>  	struct zone *zone;
>  	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
>  	unsigned int cpuset_mems_cookie;
> +	bool allow_spin = gfpflags_allow_spinning(pc->flags);
> 
>  	/*
>  	 * The defrag ratio allows a configuration of the tradeoffs between
> @@ -3812,7 +3813,15 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
>  		return NULL;
> 
>  	do {
> -		cpuset_mems_cookie = read_mems_allowed_begin();
> +		/*
> +		 * read_mems_allow_begin() accesses current->mems_allowed_seq,
> +		 * a seqcount_spinlock_t that is not NMI-safe. Do not access
> +		 * current->mems_allowed_seq and avoid retry when GFP flags
> +		 * indicate spinning is not allowed.
> +		 */
> +		if (allow_spin)
> +			cpuset_mems_cookie = read_mems_allowed_begin();
> +
>  		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
>  		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
>  			struct kmem_cache_node *n;
> @@ -3836,7 +3845,7 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
>  				}
>  			}
>  		}
> -	} while (read_mems_allowed_retry(cpuset_mems_cookie));
> +	} while (allow_spin && read_mems_allowed_retry(cpuset_mems_cookie));
>  #endif	/* CONFIG_NUMA */
>  	return NULL;
>  }
> 
> 


