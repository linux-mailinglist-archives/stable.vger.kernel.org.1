Return-Path: <stable+bounces-150767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E68ACCE38
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 22:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C869D16AE83
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C6AD23;
	Tue,  3 Jun 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EjcNgWPR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C2K+JcMl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EjcNgWPR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C2K+JcMl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045FBA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982751; cv=none; b=WVFfHLn+ChmJOubCvTqZ4joB1c4X/+zjldchAu3jSW34v32CJUO83RjB9jSt8lU8mq6a49s0gmz90ynGnmrMmfaIhnYLE2e36e1YKTUshytLrqnUfJqOKh3d+7oxa+v8XN12fW8sGyTDfjlZgJP3a8whI/FQzUsO+2A9oFtgRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982751; c=relaxed/simple;
	bh=Yi/PN6WUbY2/ibUf6JUpx4q5fD5lP4t75USMba7UcX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeGzV71he56py9sp5H+m7usmwAbiLeF0s0xCfYU8i7s4Je9T7OsEtFQaguD6h607iXf2t/27pADIIrr4jdj3hFfmjHVifEhVPA5zh/M21VSwwKw2WqGlDTgYIKIBD4wwtOm3Wsj7YXo2DTqjfoJAOW4E84+kAVzp19pAly12qOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EjcNgWPR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C2K+JcMl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EjcNgWPR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C2K+JcMl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CB0921B3A;
	Tue,  3 Jun 2025 20:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748982748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhfHJT53yffbMXSdWcA79R8PFaqMFgQVzTzK7KA/Z88=;
	b=EjcNgWPRBPVEYSTQJ0AiTlg/vdUcH1wjG1EnPEAoQqWDm1CKCQf8L2YHQ50G7NVUsyFMLQ
	RxXdaKFV6mBDs8ZRWUu5pcF37njJSlGMH3ofNIiSWF27ueKtkYG1jAfLDVDeXLEgA4t/iY
	IhPMiek/fhfR5+JwEcRlZfKpdfBxSeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748982748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhfHJT53yffbMXSdWcA79R8PFaqMFgQVzTzK7KA/Z88=;
	b=C2K+JcMlH6Up79Qf5IxU+OC2uCc7A/C6PfVZhMLrJPxyz879N+jBZlV5J583/HDUSEtiAC
	8uxTm8jGPPXGGjDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748982748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhfHJT53yffbMXSdWcA79R8PFaqMFgQVzTzK7KA/Z88=;
	b=EjcNgWPRBPVEYSTQJ0AiTlg/vdUcH1wjG1EnPEAoQqWDm1CKCQf8L2YHQ50G7NVUsyFMLQ
	RxXdaKFV6mBDs8ZRWUu5pcF37njJSlGMH3ofNIiSWF27ueKtkYG1jAfLDVDeXLEgA4t/iY
	IhPMiek/fhfR5+JwEcRlZfKpdfBxSeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748982748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhfHJT53yffbMXSdWcA79R8PFaqMFgQVzTzK7KA/Z88=;
	b=C2K+JcMlH6Up79Qf5IxU+OC2uCc7A/C6PfVZhMLrJPxyz879N+jBZlV5J583/HDUSEtiAC
	8uxTm8jGPPXGGjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5757E13A92;
	Tue,  3 Jun 2025 20:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cPs2EttbP2g8FAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 03 Jun 2025 20:32:27 +0000
Date: Tue, 3 Jun 2025 21:32:25 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory
 snapshot
Message-ID: <t5uqs6kbzmcl2sjplxa5tqy6luinuysi7lfimbademagop7323@gveunpi3eqyo>
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Tue, Jun 03, 2025 at 08:21:02PM +0200, Jann Horn wrote:
> When fork() encounters possibly-pinned pages, those pages are immediately
> copied instead of just marking PTEs to make CoW happen later. If the parent
> is multithreaded, this can cause the child to see memory contents that are
> inconsistent in multiple ways:
> 
> 1. We are copying the contents of a page with a memcpy() while userspace
>    may be writing to it. This can cause the resulting data in the child to
>    be inconsistent.

This is an interesting problem, but we'll get to it later.

> 2. After we've copied this page, future writes to other pages may
>    continue to be visible to the child while future writes to this page are
>    no longer visible to the child.
>

Yes, and this is not fixable. It's also a problem for the regular write-protect
pte path where inevitably only a part of the address space will be write-protected.
This would only be fixable if e.g we suspended every thread on a multi-threaded fork.


> This means the child could theoretically see incoherent states where
> allocator freelists point to objects that are actually in use or stuff like
> that. A mitigating factor is that, unless userspace already has a deadlock
> bug, userspace can pretty much only observe such issues when fancy lockless
> data structures are used (because if another thread was in the middle of
> mutating data during fork() and the post-fork child tried to take the mutex
> protecting that data, it might wait forever).
> 

Ok, so the issue here is that atomics + memcpy (or our kernel variants) will
possibly observe tearing. This is indeed a problem, and POSIX doesn't _really_
tell us anything about this. _However_:

POSIX says:
> Any locks held by any thread in the calling process that have been set to be process-shared
> shall not be held by the child process. For locks held by any thread in the calling process
> that have not been set to be process-shared, any attempt by the child process to perform
> any operation on the lock results in undefined behavior (regardless of whether the calling
> process is single-threaded or multi-threaded).

The interesting bit here is "For locks held by any thread [...] any attempt by
the child [...] results in UB". I don't think it's entirely far-fetched to say
the spirit of the law is that atomics may also be UB (just like a lock[1] that was
held by a separate thread, then unlocked mid-concurrent-fork is in a UB state).

In any way, I think the bottom-line is that fork memory snapshot coherency is
a fallacy. It's really impossible to reach without adding insane constraints
(like the aforementioned thread suspending + resume). It's not even possible
when going through normal write-protect paths that have been conceptually stable since
the BSDs in the 1980s (due to the write-protect-a-page-at-a-time-problem).

Thus, personally I don't think this is worth fixing.

[1] This (at least in theory) covers every lock, so it also encompasses pthread spinlocks

-- 
Pedro

