Return-Path: <stable+bounces-147978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AFDAC6D25
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75B11C0073F
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68EE28B7C1;
	Wed, 28 May 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cde8scR/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="refnbGjY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bySGC134";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4zAFPZZL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016121E8323
	for <stable@vger.kernel.org>; Wed, 28 May 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447157; cv=none; b=ZMxKFD7yGTHTA7shUGZ03Ewy1MzmwB5UbxSa+vNey/NmGTcRs6S3hKU1F1Cgwg9AdMBctfu7A1l7zbmK7Ch6hHIPxN4kf+ritnnQETl/eut8nmkoCtBd1bjbarR0izIQuk/QQrL5XlXaoAAMU3LgXOxWS3xgIfW6VT5SFMQVvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447157; c=relaxed/simple;
	bh=j19nRteXPJvYzv7WC5pci+ARTaE0cmwkYfp8eCoLENQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV9jhVUwSN3GsXh8lnzf1skQOqERCnoeiZb6j4xaXVE4cAYbDmGsYVj2MFHQzmFZrYuXinJg0+vq4jc9fwYjaBeC5VugeCbKb/tbuWlykTulJP08/DqFBR/MaTSsePJLneJ+1zzUIJCsp5jPt+nzNTOMc0DQpRSFdhE4Q/udGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cde8scR/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=refnbGjY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bySGC134; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4zAFPZZL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4F821F79C;
	Wed, 28 May 2025 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748447154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90//cSFAovb3np1TlyFoHzplikprSinbUOdqaHViB8o=;
	b=cde8scR/o0imOH1tMYP+EspNV1riDEv+jEb2YncHIjrFwzvbbxUxS3geTgrz30xiWKjnCm
	03OkyE/MpmrC9bIrj9Cz0rZmsizfDCICVcACw5hGRT9QaDQF3QIoOhE/e9Mw85YriyTB85
	BnHygwkDaf07MxXESwcgpHniu7wXCps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748447154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90//cSFAovb3np1TlyFoHzplikprSinbUOdqaHViB8o=;
	b=refnbGjYp6nygWQaU2kMghJpFXkEjfCKcPn4auWX9beB95omPCsB69NHXVPHfBl7DnYvGD
	ECszSfzxoK7J1qCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bySGC134;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4zAFPZZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748447153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90//cSFAovb3np1TlyFoHzplikprSinbUOdqaHViB8o=;
	b=bySGC1341VeoGLtrqpW1sa/fZV3bSUnihA+NwO4B+NY03PQ/D90Z38/MVoJgUvS/LGnAQt
	9HTgOGGmczarDomWlaf7qOgoXn4dvKfZGgU7i4CrFrVkS2sag3uujOtX8R8qb8931SUqrr
	WgAXMcHcBrQFxoEfXUWWfHsVlBvxFo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748447153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90//cSFAovb3np1TlyFoHzplikprSinbUOdqaHViB8o=;
	b=4zAFPZZLIye49Ym7SvHCAr5z85yuCq+lzqo4WQ26ob313OeHfpBRys5whzANewy4kPsW04
	qd7rmKAuFz00fZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11224136E3;
	Wed, 28 May 2025 15:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id znZRAbEvN2h8ZQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 28 May 2025 15:45:53 +0000
Date: Wed, 28 May 2025 17:45:42 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Gavin Guo <gavinguo@igalia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	mike.kravetz@oracle.com, kernel-dev@igalia.com,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aDcvplLNH0nGsLD1@localhost.localdomain>
References: <20250528023326.3499204-1-gavinguo@igalia.com>
 <aDbXEnqnpDnAx4Mw@localhost.localdomain>
 <aDcl2YM5wX-MwzbM@x1.local>
 <629bb87e-c493-4069-866c-20e02c14ddcc@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629bb87e-c493-4069-866c-20e02c14ddcc@redhat.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D4F821F79C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On Wed, May 28, 2025 at 05:09:26PM +0200, David Hildenbrand wrote:
> On 28.05.25 17:03, Peter Xu wrote:
> > So I'm not 100% sure we need the folio lock even for copy; IIUC a refcount
> > would be enough?
> 
> The introducing patches seem to talk about blocking concurrent migration /
> rmap walks.

I thought the main reason was because PageLock protects us against writes,
so when copying (in case of copying the underlying file), we want the
file to be stable throughout the copy?

> Maybe also concurrent fallocate(PUNCH_HOLE) is a problem regarding
> reservations? Not sure ...

fallocate()->hugetlb_vmdelete_list() tries to grab the vma in write-mode,
and hugetlb_wp() grabs the lock in read-mode, so we should be covered?

Also, hugetlbfs_punch_hole()->remove_inode_hugepages() will try to grab the mutex.

The only fishy thing I see is hugetlbfs_zero_partial_page().

But that is for old_page, and as I said, I thought main reason was to
protect us against writes during the copy.

> For 2) I am also not sure if we need need the pagecache folio locked; I
> doubt it ... but this code is not the easiest to follow.
 
I have been staring at that code and thinking about potential scenarios
for a few days now, and I cannot convice myself that we need
pagecache_folio's lock when pagecache_folio != old_folio because as a
matter of fact I cannot think of anything it protects us against.

I plan to rework this in a more sane way, or at least less offusctaed, and then
Galvin can fire his syzkaller to check whether we are good.

-- 
Oscar Salvador
SUSE Labs

