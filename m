Return-Path: <stable+bounces-230520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJUMDxCHxWlc+wQAu9opvQ
	(envelope-from <stable+bounces-230520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:20:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B733ADED
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2762630387AD
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F224B2609E3;
	Thu, 26 Mar 2026 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="heYFtTcT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0dGJKJTj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="heYFtTcT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0dGJKJTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A8346E47
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552571; cv=none; b=HATnN0mII/4fXcQSumYCqevhHduwa0qsMniLucqW/lc4tSgsoQfxx9iFAF4Tz7DDhUbkrp7H1Al3Qk6ge1bZUmo/0d0/UB9SvAJMeX9oErLF8DjMmk4r5Oe1q+1BgEiwJ4YTrLWXTeDrRLzYqqt9DzN/HLC1XidFDyfMnbymbdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552571; c=relaxed/simple;
	bh=w3b8Do7LkXaoGE+vNpLVrtq4hJmsIuhA09aK95ZtroI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0GSWK7pEiVXDW2cEtI4FQ+HEGniVVBQfPUvvWHxS4kDe5JATTlfjwpHLu+iCBkVe3sBnUFxlhUMWCiFhJ8vv7gG3QC3lsMPSFpNyyfA48bvXVsvkXhZbwLGHXjrQKVIBGANJMTnD8OhV7KcVelcXvxvLOsqzzx7TT9gkLVTdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=heYFtTcT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0dGJKJTj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=heYFtTcT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0dGJKJTj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA56A4D2E0;
	Thu, 26 Mar 2026 19:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774552568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0NbDm8sagJWivXfmEO6jIG8gF17/iZfDl2XnEm6e1I=;
	b=heYFtTcT6JppGXGa3o5gocTipUKt8/yAvzZ63BnHcvLNPZ+G50GPIdrndDeCfev63J2seZ
	EUwHZ9Tyz3SL0ME2XwEaU1cUHhjrEWNNOjAeNrop+6s3B8XYSLZMcJ3z1fRL6RqMO4za4s
	82zZCw+Yq+2Hq97xbteAuhMHxjsN8y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774552568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0NbDm8sagJWivXfmEO6jIG8gF17/iZfDl2XnEm6e1I=;
	b=0dGJKJTjS6j9TAbaFDxJIlSYwxPIgxZ8Zis7ILt8c7OJOv9zsWnmYpQ4/ffU/Fmsicw1Xo
	Kl7tOFOE8PAjn4BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774552568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0NbDm8sagJWivXfmEO6jIG8gF17/iZfDl2XnEm6e1I=;
	b=heYFtTcT6JppGXGa3o5gocTipUKt8/yAvzZ63BnHcvLNPZ+G50GPIdrndDeCfev63J2seZ
	EUwHZ9Tyz3SL0ME2XwEaU1cUHhjrEWNNOjAeNrop+6s3B8XYSLZMcJ3z1fRL6RqMO4za4s
	82zZCw+Yq+2Hq97xbteAuhMHxjsN8y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774552568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0NbDm8sagJWivXfmEO6jIG8gF17/iZfDl2XnEm6e1I=;
	b=0dGJKJTjS6j9TAbaFDxJIlSYwxPIgxZ8Zis7ILt8c7OJOv9zsWnmYpQ4/ffU/Fmsicw1Xo
	Kl7tOFOE8PAjn4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A14874A0A3;
	Thu, 26 Mar 2026 19:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id erZ6I/eFxWl1UwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 26 Mar 2026 19:16:07 +0000
Date: Thu, 26 Mar 2026 19:16:05 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com, 
	david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: use invalidate_lock to fix hole-punch race
Message-ID: <bnukmnuxxuhdfeasjz33miemgr7w35c4aa6pqdmgupx7oxmeeb@gozgc3yxhcdd>
References: <20260326162611.693539-1-gourry@gourry.net>
 <jm5rmcwiauy2fn6fvj6cjowiu2dudjndhhlcd2tm275ibmos5i@dwxwchbs24ko>
 <acV83cdc9ZfNk8Xh@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acV83cdc9ZfNk8Xh@gourry-fedora-PF4VCD3F>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230520-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A83B733ADED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:37:17PM -0500, Gregory Price wrote:
> On Thu, Mar 26, 2026 at 05:07:42PM +0000, Pedro Falcato wrote:
> > > Two races allow PTEs to be re-installed for a folio that fallocate
> > > is about to remove from page cache:
> > 
> > Hmm, I don't see how your patch fixes anything.
> > 
> 
> after looking at your comments below i realized race 2 actually requires
> the fork as well, which means they're both essentially variations of the
> same race, so hopefully i can simplify the change log.

Well, then I don't see how changing shmem_fault() & map_mages() fixes fork.

> 
> > >   fallocate              fault-around           fork
> > >   --------               ------------           ----
> > >   set i_private
> > >   unmap_mapping_range()
> > >   # zaps PTEs
> > >                        filemap_map_pages()
> > >                         # re-maps folio!
> > >                                               dup_mmap()
> > >                                               # child VMA
> > >                                               # in tree
> > >   shmem_undo_range()
> > >     lock folio
> > >     unmap_mapping_folio()
>                   ^^^ i_mmap_lock_read held, iterates VMAs
> > 	spin_lock(ptl);
>                   ^^^ child VMA's PTL
> > >     # child VMA:
> > >     #   no PTE, skip
> > 	spin_unlock(ptl);
>                     ^^^ child VMA done, iterator moves on
> 		        it will not re-visit the child.
> 
> > >                                             copy_page_range()
> >                                                spin_lock(dst_ptl);
>                                                    ^ Child PTL
> > 					       spin_lock(src_ptl);
>                                                    ^ Parent PTL
> > 						/* does not copy PTE. either
> > 						 * we find a zapped PTE, or unmap_mapping_folio()
> > 						 * finds two mappings instead of one. */
> 
> At this point, unmap_mapping_folio only processed the child VMA
> (no PTE, skip). The parent PTE *has not* been zapped.
> 
> copy_page_range() acquires src_ptl (parent) and reads a present PTE,
> and boom copies it to child.

Sure, but can child - parent happen when traversing the i_mmap tree? I don't
think so? (in mm/mmap.c)
	/* insert tmp into the share list, just after mpnt */
	vma_interval_tree_insert_after(tmp, mpnt,
			&mapping->i_mmap);

The function itself is somewhat straightforward - find the leftmost node at the
right of 'prev' (our parent) and link ourselves. So an in-order traversal should
always go parent - child. Unless there's some awful tree rotation that can
happen and screw us in the meanwhile.

> 
> When it reaches the parent VMA next, it zaps the parent PTE,
> but the child PTE (just installed) survives.  
> 
> > > 
> > > Fix both races with invalidate_lock.
> > > 
> > 
> > I don't see what you're seeing? Note that both map_pages and fault()
> > take the folio lock (map_pages does a trylock) to exclude against truncate
> > as well.
> > 
> 
> The folio lock serializes map_pages/fault against truncate - but the
> race isn't between those two. It's between truncate's unmap walk and
> fork's copy_page_range - and copy_page_range doesn't take folio lock.

If we observe everything parent - child, there is no way this is broken - if
fork observes the parent pte set, zap will have to observe parent *and* child,
since they hold the corresponding pte locks, and traversal is done in order.
If fork observes the parent pte as none, zap will have already traversed the
parent, and as such there will be no additional mapping of the folio.

If this is broken, then every filesystem out there using filemap_fault() and
filemap_fault_around() has to be broken, and I hope that's not true :p

_If_ there is indeed breakage here regarding tree rotations, I would suggest:

diff --git a/mm/mmap.c b/mm/mmap.c
index 5754d1c36462..7b4e39063d67 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1833,12 +1833,12 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
                        vma_interval_tree_insert_after(tmp, mpnt,
                                        &mapping->i_mmap);
                        flush_dcache_mmap_unlock(mapping);
-                       i_mmap_unlock_write(mapping);
                }
 
                if (!(tmp->vm_flags & VM_WIPEONFORK))
                        retval = copy_page_range(tmp, mpnt);
-
+               if (file)
+                       i_mmap_unlock_write(mapping);
                if (retval) {
                        mpnt = vma_next(&vmi);
                        goto loop_out;


which should protect against concurrent rmap.

-- 
Pedro

