Return-Path: <stable+bounces-195478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EECEC780E0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53FDF35C3DB
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D545D33E369;
	Fri, 21 Nov 2025 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OtvIACLX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDoLwJr6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OtvIACLX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDoLwJr6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CAA33DEE8
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716104; cv=none; b=hKlCbht/nRM/SeTR6Qw4jA3iO1Kz9sf3TQYbBVy0JvYUBOMQW0LHNWwkQmCOPKHAJLERFbCFZUovSdWKhQHz2/Pqw7qAF8WDohgxvYs9DQaFZO651QSKu9KLq8PvwXKKmwJjx52CdtrDeU38t9N/VL7UQ81AfATi0ZgFqxNqaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716104; c=relaxed/simple;
	bh=jpLNNWNHADLggZ3eXZrUj8mMWm8GM5xqwjHe3NiQoEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7fdFVNb39G7hXz9eQBplqGSjD4r4kKWHnS4sWZoXMr9D4XunCQFK8HaAkgv8TpoqhQ2pfS/xa5xiNHrGFw9rkFq7JL3jnYwXL3L13FcyukVeOVtXBGo6w+sBuFxi0PIfcQc6ZH+rU7GPpc+11ZA7GhSm7cpNYE7I2ybC3Yfzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OtvIACLX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDoLwJr6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OtvIACLX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDoLwJr6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47F2E20F11;
	Fri, 21 Nov 2025 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763716100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aui9l7AgpNh+vCcDY9SRw7llzOsh+jqboWLjXhXxfO4=;
	b=OtvIACLXgtdbS8YoKbF6+sVqsKnkEmY7oTxuELuDiFPTIyaNZBWaZ1Qp/ieCd1Ubi9epsp
	jw8pDdzt7N0oQtGqUTGY+LfwfUMgD0n9g9LM4UqBsHffwOv+PQoptPHLGI4bvTxloTI9DK
	rMPoIyyZIToZoxyiIEsNQWF+5aBB6p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763716100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aui9l7AgpNh+vCcDY9SRw7llzOsh+jqboWLjXhXxfO4=;
	b=oDoLwJr6URXKC+fm3LWfjBq+79HSjVrlrtdX3ZtS8ERo7FwOlBnjYssE1qX9ZFTsN/HGU1
	vlXZgQQIDrtfXZDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OtvIACLX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oDoLwJr6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763716100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aui9l7AgpNh+vCcDY9SRw7llzOsh+jqboWLjXhXxfO4=;
	b=OtvIACLXgtdbS8YoKbF6+sVqsKnkEmY7oTxuELuDiFPTIyaNZBWaZ1Qp/ieCd1Ubi9epsp
	jw8pDdzt7N0oQtGqUTGY+LfwfUMgD0n9g9LM4UqBsHffwOv+PQoptPHLGI4bvTxloTI9DK
	rMPoIyyZIToZoxyiIEsNQWF+5aBB6p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763716100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aui9l7AgpNh+vCcDY9SRw7llzOsh+jqboWLjXhXxfO4=;
	b=oDoLwJr6URXKC+fm3LWfjBq+79HSjVrlrtdX3ZtS8ERo7FwOlBnjYssE1qX9ZFTsN/HGU1
	vlXZgQQIDrtfXZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E6D93EA61;
	Fri, 21 Nov 2025 09:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nvLuCgQsIGlkXgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 21 Nov 2025 09:08:20 +0000
Message-ID: <18ae4b82-b18a-4ed8-8b72-4a9697a4dc8f@suse.cz>
Date: Fri, 21 Nov 2025 10:08:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
 stable@vger.kernel.org, syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
 <aRUggwAQJsnQV_07@casper.infradead.org>
 <d9e181fe-e3d8-427a-8323-ea979f5a02ad@paulmck-laptop>
 <f7abdb4c-b7e2-4fe4-9198-f313d0cacacb@lucifer.local>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <f7abdb4c-b7e2-4fe4-9198-f313d0cacacb@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 47F2E20F11
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[131f9eb2b5807573275c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

(sorry for the late reply)

On 11/13/25 12:05, Lorenzo Stoakes wrote:
>> > > I think one source of confusion for me with maple tree operations is - what
>> > > to do if we are in a position where some kind of reset is needed?
>> > >
>> > > So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
>> > > to me that we ought to set to the address.
>> >
>> > I think that's a separate problem.
>> >
>> > > > +++ b/mm/mmap_lock.c
>> > > > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>> > > >  		if (PTR_ERR(vma) == -EAGAIN) {
>> > > >  			count_vm_vma_lock_event(VMA_LOCK_MISS);
>> > > >  			/* The area was replaced with another one */
>> > > > +			mas_set(&mas, address);
>> > >
>> > > I wonder if we could detect that the RCU lock was released (+ reacquired) in
>> > > mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?
>> >
>> > Dropping and reacquiring the RCU read lock should have been a big red
>> > flag.  I didn't have time to review the patches, but if I had, I would
>> > have suggested passing the mas down to the routine that drops the rcu
>> > read lock so it can be invalidated before dropping the readlock.
>>
>> There has been some academic efforts to check for RCU-protected pointers
>> leaking from one RCU read-side critical section to another, but nothing
>> useful has come from this.  :-/
> 
> Ugh a pity. I was hoping we could do (in debug mode only obv) something
> absolutely roughly like:
> 
> On init:
> 
> mas->rcu_critical_section = rcu_get_critical_section_blah();

AFAICT, get_state_synchronize_rcu()?

> ...
> 
> On walk:
> 
> 	VM_WARN_ON(rcu_critical_section_blah() != mas->rcu_critical_section);

And here, poll_state_synchronize_rcu()?

It wouldn't detect directly that we dropped and reacquired the rcu read
lock, but with enough testing, that would at some point translate to a new
grace period between the first and second read lock, and we'd catch it then?

> But sounds like that isn't feasible.
I don't think what Paul says means your suggestion is not feasible. I think
he says there are no known ways to do this checking automagicallt. But your
suggestion is doing it manually for a specific case. I guess it depends on
how many maple tree functions we'd have to change and how ugly it would be.

> I always like the idea of us having debug stuff that helps highlight dumb
> mistakes very quickly, no matter how silly they might be :)
> 
>>
>> But rcu_pointer_handoff() and unrcu_pointer() are intended not only for
>> documentation, but also to suppress the inevitable false positives should
>> anyone figure out how to detect leaking of RCU-protected pointers.
>>
>> 							Thanx, Paul
> 
> Cheers, Lorenzo


