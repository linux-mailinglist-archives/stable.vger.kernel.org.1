Return-Path: <stable+bounces-191446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78010C14759
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0128D623EAC
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A12330C37D;
	Tue, 28 Oct 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oHisylFD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sd5JUpjC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oHisylFD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sd5JUpjC"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C430BB91
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652143; cv=none; b=dSSs4Mdaxnu0hkNqJVfV8vG70GVYAXg5llkfSEnrjM96hQraNiTKZCZcYcZ4keeAe/cuMDicyRmo4ufO5RJOIA9Sl+BGQ0o42qwbVS4rGIJXV2Y5scBX1D4k2hZgMrZffwkp4+G1O3lldTR/BYWLoPoz6V/oncivcLaer+XuO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652143; c=relaxed/simple;
	bh=tFmkWJ5YQmGjz9zg7tYmzrM2CMk1xirapYw+td7U+08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv5+vM3d19P3dFDMaLH5QeonuwxvAFznYurlZlhT2pjtBP571qz/3fFEnobCQA9TWUk3wMzENB2fqq8MQMnbcsLHrBPfaZ5rST4iLfkRojw+rXObjr9BlW13Fg/bp872AgMD8mA9t51Ob7lZjYOw8mXBMOaqqq58jSW7ytA6Bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oHisylFD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sd5JUpjC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oHisylFD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sd5JUpjC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 291FC21A49;
	Tue, 28 Oct 2025 11:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761652138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEDsYxFkkJHUjGWGL4EddzX8EcwO4m2OW9aFt7wKD4w=;
	b=oHisylFDAuZV7QpEp9sT3pOu7poBnog3qCyORDuUTdG+ynWHjNS7PQ0KlqQlu4iHxsRiX4
	D4lqUwf0IeeFjI54ZAQV9KAsXpD3fiDajoSApMpqDKQe9F8+6/reXn4Or9d4qkMyjBv3kC
	sFOFa+WANwi38fkkkCP3r1igwdg+qUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761652138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEDsYxFkkJHUjGWGL4EddzX8EcwO4m2OW9aFt7wKD4w=;
	b=sd5JUpjCNPXFTvsLJDmZNd9p5AGpi7UtozPA5+iU1ir/e/GNibMP4ynI7wbKF7Wl39SJP2
	VA+fmGcg/MJ8dvBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761652138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEDsYxFkkJHUjGWGL4EddzX8EcwO4m2OW9aFt7wKD4w=;
	b=oHisylFDAuZV7QpEp9sT3pOu7poBnog3qCyORDuUTdG+ynWHjNS7PQ0KlqQlu4iHxsRiX4
	D4lqUwf0IeeFjI54ZAQV9KAsXpD3fiDajoSApMpqDKQe9F8+6/reXn4Or9d4qkMyjBv3kC
	sFOFa+WANwi38fkkkCP3r1igwdg+qUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761652138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEDsYxFkkJHUjGWGL4EddzX8EcwO4m2OW9aFt7wKD4w=;
	b=sd5JUpjCNPXFTvsLJDmZNd9p5AGpi7UtozPA5+iU1ir/e/GNibMP4ynI7wbKF7Wl39SJP2
	VA+fmGcg/MJ8dvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B57313A7D;
	Tue, 28 Oct 2025 11:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wJN7FqmtAGlAegAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 28 Oct 2025 11:48:57 +0000
Date: Tue, 28 Oct 2025 11:48:51 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Dev Jain <dev.jain@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Barry Song <baohua@kernel.org>, 
	"open list:MEMORY MAPPING" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/mremap: Honour writable bit in mremap pte batching
Message-ID: <jmxnalmkkc5ztfhokqtzqihsdji2gprnv5z4tzruxi6iqgfkni@aerronulpyem>
References: <20251028063952.90313-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028063952.90313-1-dev.jain@arm.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,arm.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue, Oct 28, 2025 at 12:09:52PM +0530, Dev Jain wrote:
> Currently mremap folio pte batch ignores the writable bit during figuring
> out a set of similar ptes mapping the same folio. Suppose that the first
> pte of the batch is writable while the others are not - set_ptes will
> end up setting the writable bit on the other ptes, which is a violation
> of mremap semantics. Therefore, use FPB_RESPECT_WRITE to check the writable
> bit while determining the pte batch.
>

Hmm, it seems to be like we're doing the wrong thing by default here?
I must admit I haven't followed the contpte work as much as I would've
liked, but it doesn't make much sense to me why FPB_RESPECT_WRITE would
be an option you have to explicitly pass, and where folio_pte_batch (the
"simple" interface) doesn't Just Do The Right Thing for naive callers.

Auditing all callers:
 - khugepaged clears a variable number of ptes
 - memory.c clears a variable number of ptes
 - mempolicy.c grabs folios for migrations
 - mlock.c steps over nr_ptes - 1 ptes, speeding up traversal
 - mremap is borked since we're remapping nr_ptes ptes
 - rmap.c TTU unmaps nr_ptes ptes for a given folio

 so while the vast majority of callers don't seem to care, it would make
 sense that folio_pte_batch() works conservatively by default, and
 folio_pte_batch_flags() would allow for further batching (or maybe
 we would add a separate folio_pte_batch_clear() or
 folio_pte_batch_greedy() or whatnot).

> Cc: stable@vger.kernel.org #6.17
> Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
> Reported-by: David Hildenbrand <david@redhat.com>
> Debugged-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

But the solution itself looks okay to me. so, fwiw:

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

