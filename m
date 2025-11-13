Return-Path: <stable+bounces-194686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B33C5752B
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 13:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95DC74E279E
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0234D395;
	Thu, 13 Nov 2025 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TrGvUOCX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWByH5oU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TrGvUOCX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWByH5oU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3933DEC0
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035459; cv=none; b=jDljerYpvUUhZEWkZANXzVKI/liVN9EMUNWBHCs68nTLq9SfT60Zo/clBm8OqFAyJmHQcaQbkEBLz/SwTGLLV1wLatN0xUFvb5NRgNFLasYS10iqVtZBWEgdWNz5lLfMSO+oL9O+9nmprVWNYt08Vh3PoZ/Rrmk9NsM5gAcU4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035459; c=relaxed/simple;
	bh=EwACQkUUaj7OMJsgnLEuauJXcZfosM/TDDQbqvUOeTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjY5SfnD+VqJtbcvQSwrT7npm6OOq9ecB/TOVB8whW9q7pociC00NhexP8TmrsWj6WiEMcMaXVqzf8h3DAO+v5/e++9pGH4RmdcoQ93h2L2FmKgEnOh55mv28abICs8P57Y1V1Xd/4nj94g0/DuKHUvU9xdq4c6zDo4YzUPRoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TrGvUOCX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWByH5oU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TrGvUOCX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWByH5oU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90FE31F395;
	Thu, 13 Nov 2025 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763035455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4cIyQEDcX8IYtapSz3cwYnB1AEHvylAazd0oOZJHbE=;
	b=TrGvUOCXOs7QH+PYeNPFvHAjxdbuXMoqiFrtYnA6FVga97LTv59g87y10uPCpInRkt9xMG
	di4+EuW30F3iYLY1TcmH1EFqbwBtwoXgmMCYMWyVpn2bMeu2QyHBE39GEi4eb+Fera4LSR
	L1/ule3HpZ3pRHHv0kwPbp+5ftsWwdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763035455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4cIyQEDcX8IYtapSz3cwYnB1AEHvylAazd0oOZJHbE=;
	b=cWByH5oUpIspG+wv+pyu95wcBOxFKb/gmooUgkcMDoujQfkBdYmM8CaeO32N2xtZb5Ll32
	5rvGvm1VxafLUlAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763035455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4cIyQEDcX8IYtapSz3cwYnB1AEHvylAazd0oOZJHbE=;
	b=TrGvUOCXOs7QH+PYeNPFvHAjxdbuXMoqiFrtYnA6FVga97LTv59g87y10uPCpInRkt9xMG
	di4+EuW30F3iYLY1TcmH1EFqbwBtwoXgmMCYMWyVpn2bMeu2QyHBE39GEi4eb+Fera4LSR
	L1/ule3HpZ3pRHHv0kwPbp+5ftsWwdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763035455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4cIyQEDcX8IYtapSz3cwYnB1AEHvylAazd0oOZJHbE=;
	b=cWByH5oUpIspG+wv+pyu95wcBOxFKb/gmooUgkcMDoujQfkBdYmM8CaeO32N2xtZb5Ll32
	5rvGvm1VxafLUlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB4533EA61;
	Thu, 13 Nov 2025 12:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BAugLj7JFWnzEQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 13 Nov 2025 12:04:14 +0000
Date: Thu, 13 Nov 2025 13:04:07 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org, david@redhat.com, muchun.song@linux.dev,
	kraxel@redhat.com, airlied@redhat.com, jgg@ziepe.ca,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	vivek.kasireddy@intel.com,
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/memfd: fix information leak in hugetlb folios
Message-ID: <aRXJN2WHvfAwoAFE@localhost.localdomain>
References: <20251112145034.2320452-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112145034.2320452-1-kartikey406@gmail.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[f64019ba229e3a5c411b];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Wed, Nov 12, 2025 at 08:20:34PM +0530, Deepanshu Kartikey wrote:
> When allocating hugetlb folios for memfd, three initialization steps
> are missing:
> 
> 1. Folios are not zeroed, leading to kernel memory disclosure to userspace
> 2. Folios are not marked uptodate before adding to page cache
> 3. hugetlb_fault_mutex is not taken before hugetlb_add_to_page_cache()
> 
> The memfd allocation path bypasses the normal page fault handler
> (hugetlb_no_page) which would handle all of these initialization steps.
> This is problematic especially for udmabuf use cases where folios are
> pinned and directly accessed by userspace via DMA.
> 
> Fix by matching the initialization pattern used in hugetlb_no_page():
> - Zero the folio using folio_zero_user() which is optimized for huge pages
> - Mark it uptodate with folio_mark_uptodate()
> - Take hugetlb_fault_mutex before adding to page cache to prevent races
> 
> The folio_zero_user() change also fixes a potential security issue where
> uninitialized kernel memory could be disclosed to userspace through
> read() or mmap() operations on the memfd.
> 
> Reported-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/20251112031631.2315651-1-kartikey406@gmail.com/ [v1]
> Closes: https://syzkaller.appspot.com/bug?extid=f64019ba229e3a5c411b
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Cc: stable@vger.kernel.org
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Tested-by: syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

As David mentioned, we can drop the comment wrt. __folio_mark_uptodate.
As for the addr_hint in folio_zero_user, I do not think it makes a
difference in here.
AFAIK, it serves the purpose that subpages belong to the addr_hint will
be zeroed the latest to keep them in cache, but here it does not really
apply, so '0' should just work?

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

