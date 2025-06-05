Return-Path: <stable+bounces-151527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9EACEF3A
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 14:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAE33ACC6C
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADC319BBA;
	Thu,  5 Jun 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tGtr2Dy3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IeK+w307";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F6TWfQsw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zXpyJk0M"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8D1853
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749126648; cv=none; b=M6ct7IBM+FZ3Vcw7R0gdxCJamjYE6j+QwgDIK/qEWZwAsJbB+WgbnaqYNbn5khjH8456DNpXNsJC3LqnPnjM0btdRmAt/tqObqyWPlaaFl/SQ9PF8vaB0Kmc17WkFkCskK76yIs/R7YVtKeGahKoYPW4u0ZS7pslQNPvYLLvZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749126648; c=relaxed/simple;
	bh=ZLq2zUXzWtbF7mIp3pVsit6RncSI4+1+z+OBT70Zp8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fja/e1aKU/D0Y2TVLCmvQtufC8v1nTUtjxXR3CciCqg2j3TzBeqdERo7FaK+X22jwjIyw9SEN1fUb45iBvkj1cqlfM6vazkZxZ/N+9Fd/crigG9JOWNzgPeICqUvfNm4pFAIAsfX7Sce5ERA5odzcA5EGsVcdc0L4I0y+J/karM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tGtr2Dy3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IeK+w307; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F6TWfQsw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zXpyJk0M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCCDC5C1F6;
	Thu,  5 Jun 2025 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749126644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAgu98E1bIifkTUOiXNpdPWPnGDf9XZuLBI7jjfvBBg=;
	b=tGtr2Dy3C/GpKweEEI9DHbgUKTTNhfhiqJgbj75tlgEAJNn6W8ySsORuvzeXfHiXOgABAo
	o4KE9hX4Rn5z3PMa+bUbwTClWS3FGsFL1YIIzAkJjfnXrJ9Hkyow7SutdUu1QTkzJNQ6o4
	gjRISWBYD/pZtAN0JTuZ0XITB+ucByc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749126644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAgu98E1bIifkTUOiXNpdPWPnGDf9XZuLBI7jjfvBBg=;
	b=IeK+w3075fMh+8B7J58UiOjp9Isy7/MAqGRTPgI/g85DaIUIDVUuGlGVtVqhq0VTEXezMT
	kD0kezbdSQmtukBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749126643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAgu98E1bIifkTUOiXNpdPWPnGDf9XZuLBI7jjfvBBg=;
	b=F6TWfQswfJZexme0kiCnKgKFSCP0akK6Yov5eQ6pZ/WiDPCn2Ttp5ByY9d2jCUf25tZyGt
	YSJE5QCp4ydpnNz8dyPrNN1YKbnP68QPIe545zIpJ+R9jhRGvgD0wmabvYrNIPS3VtkVAh
	DwG68iN5V4k6qdh6x2IaF4ibtacV2oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749126643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAgu98E1bIifkTUOiXNpdPWPnGDf9XZuLBI7jjfvBBg=;
	b=zXpyJk0Mlc3IihdBf2SNSsA8wthXdxSB6O3sKt5WQ3o6r/J3GKTWQVwMKcJCi847iqFOWQ
	xVMQUhfjznO6vlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 132EA137FE;
	Thu,  5 Jun 2025 12:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wxpmAfONQWgbHgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 05 Jun 2025 12:30:43 +0000
Date: Thu, 5 Jun 2025 13:30:37 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory
 snapshot
Message-ID: <tvlqhsldouhdocdf3zsgepv4klq4646yuafsls67n6bwntsnb4@ucsrfbweeumv>
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
 <ba208d76-7992-4c70-be8f-49082001f194@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba208d76-7992-4c70-be8f-49082001f194@suse.cz>
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -7.80

On Thu, Jun 05, 2025 at 09:33:24AM +0200, Vlastimil Babka wrote:
> On 6/3/25 20:21, Jann Horn wrote:
> > When fork() encounters possibly-pinned pages, those pages are immediately
> > copied instead of just marking PTEs to make CoW happen later. If the parent
> > is multithreaded, this can cause the child to see memory contents that are
> > inconsistent in multiple ways:
> > 
> > 1. We are copying the contents of a page with a memcpy() while userspace
> >    may be writing to it. This can cause the resulting data in the child to
> >    be inconsistent.
> > 2. After we've copied this page, future writes to other pages may
> >    continue to be visible to the child while future writes to this page are
> >    no longer visible to the child.
> > 
> > This means the child could theoretically see incoherent states where
> > allocator freelists point to objects that are actually in use or stuff like
> > that. A mitigating factor is that, unless userspace already has a deadlock
> > bug, userspace can pretty much only observe such issues when fancy lockless
> > data structures are used (because if another thread was in the middle of
> > mutating data during fork() and the post-fork child tried to take the mutex
> > protecting that data, it might wait forever).
> > 
> > On top of that, this issue is only observable when pages are either
> > DMA-pinned or appear false-positive-DMA-pinned due to a page having >=1024
> > references and the parent process having used DMA-pinning at least once
> > before.
> 
> Seems the changelog seems to be missing the part describing what it's doing
> to fix the issue? Some details are not immediately obvious (the writing
> threads become blocked in page fault) as the conversation has shown.
> 
> > Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> 
> Given how the fix seems to be localized to the already rare slowpath and
> doesn't require us to pessimize every trivial fork(), it seems reasonable to
> me even if don't have a concrete example of a sane code in the wild that's
> broken by the current behavior, so:
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

