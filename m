Return-Path: <stable+bounces-151446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E3ACE206
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 18:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E26D7AAE37
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE86150997;
	Wed,  4 Jun 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JW3s5E4w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GiDYZjk3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qvVMw7e2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ib421YMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C72339A1
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053776; cv=none; b=WLkhLXvSMBhEtguIHVrya+lyLNARWl25hluhyXkyIfV37/PT6sckayq4yln2RGRBRvnz8SowqZ/NEfU3rqHdU1iPbg9PDMzP02HzuOd9uuupRFBCsKZcwTKIctT0kCFv50r/zf8djj5MkEiNvCA9QuWq19jQk4UEa9sd4CSoxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053776; c=relaxed/simple;
	bh=weHQwns0gJTioruMnZ6e+lbjxPJy1R3/J0uJNHbei/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfSFVsSwbPyxs3F4ds1nQB8V4MO6P+tXxKSW+1kfQPBFYCYHdjKX99yBO5bIBXkm9Yj8Mz8XMhji1408VHYBmUV3cnjZbOeNvkK1l10RXuy26FiGYlK8M6q6bU6aXYxJbLsJl/Z1KsrW7ArXZdfXZXmo9w+S8v0JseDrGbOMu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JW3s5E4w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GiDYZjk3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qvVMw7e2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ib421YMQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEB912033D;
	Wed,  4 Jun 2025 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749053773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmdkHicZ9vMglOkN9sId8WADOZ0AiEKxD+HKkXswifw=;
	b=JW3s5E4w/Lq8bnMW7jFK4SnNpKvFd6SXiT2E5iKZJSsFk75BrW0vJSwSpL+o9geysesFIf
	8saaOt3PhJj/bYi16+BZ2p1pDIfcTU8d1K2D3QaLnzWK5VPGEC1BnBxbqzedDmyKkKumrP
	fdkwgF/NfXZ7iHY5+9MW07K1gZkegVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749053773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmdkHicZ9vMglOkN9sId8WADOZ0AiEKxD+HKkXswifw=;
	b=GiDYZjk3W/3b75T4+UMWn/ckf3lpcrUELe7rDdgSyeE4QJz59fduZu9ndYMV0lTLB5KTTg
	Bmea3lFDHcTYpoDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qvVMw7e2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ib421YMQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749053772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmdkHicZ9vMglOkN9sId8WADOZ0AiEKxD+HKkXswifw=;
	b=qvVMw7e2XoaVcUE2le8pfxYUhFk5XJfc1fLEqRPChbEQ2ko9L3bWU7sSua9U3yYkZChYj8
	FNONXjiWXRwXRKKeKdoHyUTZKRyxn09x4R/J2yhO1uyyB3090bijaEwEhX+tbGjTrOH3Op
	xYOYUD2e1+7+hOltBZXxlfOYTr16prI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749053772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmdkHicZ9vMglOkN9sId8WADOZ0AiEKxD+HKkXswifw=;
	b=Ib421YMQE2vfLRFvp8nrk30gIIOH/ThJCJEgYSbQgQYBc+TNJ5/X5OaqRLUMRx9BRpn374
	J2mCcWDj3aWdxTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D13C13A63;
	Wed,  4 Jun 2025 16:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNQYBExxQGhiIAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 04 Jun 2025 16:16:12 +0000
Date: Wed, 4 Jun 2025 17:16:10 +0100
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
Message-ID: <gm6gm4hmojfhgwjgyzxfzxjlr7yz2gtkspdocsufzxydyfc4ri@n5iynjdpoe33>
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
 <t5uqs6kbzmcl2sjplxa5tqy6luinuysi7lfimbademagop7323@gveunpi3eqyo>
 <CAG48ez29awjpSXnupQGyxCLoLds72QcYtbhmkAyLT2dCqFzA5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez29awjpSXnupQGyxCLoLds72QcYtbhmkAyLT2dCqFzA5Q@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DEB912033D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.61 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.20)[0.733];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -1.61
X-Spam-Level: 

On Wed, Jun 04, 2025 at 05:41:47PM +0200, Jann Horn wrote:
> On Tue, Jun 3, 2025 at 10:32 PM Pedro Falcato <pfalcato@suse.de> wrote:
> > On Tue, Jun 03, 2025 at 08:21:02PM +0200, Jann Horn wrote:
> > > When fork() encounters possibly-pinned pages, those pages are immediately
> > > copied instead of just marking PTEs to make CoW happen later. If the parent
> > > is multithreaded, this can cause the child to see memory contents that are
> > > inconsistent in multiple ways:
> > >
> > > 1. We are copying the contents of a page with a memcpy() while userspace
> > >    may be writing to it. This can cause the resulting data in the child to
> > >    be inconsistent.
> >
> > This is an interesting problem, but we'll get to it later.
> >
> > > 2. After we've copied this page, future writes to other pages may
> > >    continue to be visible to the child while future writes to this page are
> > >    no longer visible to the child.
> > >
> >
> > Yes, and this is not fixable. It's also a problem for the regular write-protect
> > pte path where inevitably only a part of the address space will be write-protected.
> 
> I don't understand what you mean by "inevitably only a part of the
> address space will be write-protected". Are you talking about how
> shared pages are kept shared between parent in child? Or are you
> talking about how there is a point in time at which part of the
> address space is write-protected while another part is not yet
> write-protected? In that case: Yes, that can happen, but that's not a
> problem.
> 
> > This would only be fixable if e.g we suspended every thread on a multi-threaded fork.
> 
> No, I think it is fine to keep threads running in parallel on a
> multi-threaded fork as long as all the writes they do are guaranteed
> to also be observable in the child. Such writes are no different from
> writes performed before fork().
> 
> It would only get problematic if something in the parent first wrote
> to page A, which has already been copied to the child (so the child no
> longer sees the write) and then wrote to page B, which is CoWed (so
> the child would see the write). I prevent this scenario by effectively
> suspending the thread that tries to write to page A until the fork is
> over (by making it block on the mmap lock in the fault handling path).
> 

Ah yes, I see my mistake - we write lock all VMAs as we dup them, so
the problem I described can't happen. Thanks for the explanation :)

-- 
Pedro

