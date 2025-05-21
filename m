Return-Path: <stable+bounces-145907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B8ABFAC1
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537711BC6014
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090722257E;
	Wed, 21 May 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B2evFl1G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c3szFugv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BuQv6eh9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gBH+2m9h"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F7213E74
	for <stable@vger.kernel.org>; Wed, 21 May 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842825; cv=none; b=s7S+U0XqIwxmrllujIh8X8Z/KSeIF3/rf4vZfd+mSCovcz5Ty4vfkyBi21w2gliQHGKQX2PEcMOxLFhjBBvTyfyipeE8uJBTBegtuXUQTHsbB5MiPbdCNBxtMVKyzvXrJtsAl5UOOB6ZrCRfVAW96zA8x3ChjZ6+y5J3nGfOMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842825; c=relaxed/simple;
	bh=pqWjaAWILbv3c6nvYzijStZPUipPsAKp7i+AMZEi+RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF+G1XiLhZiGz+0otsMQRREqynsQKKi06wwLZUz22HEeT/RLQtof1UsP4xexMQbMe3G5UhT2vwyauHlfGNnF1BC869xFvVfBp8k/zsiCMFt/DvPgesZ4VMkMX4j9YhlWqgypqBbkrMBwq9SFwvBPpgYKgp+MCTgBk1dSEEN/yE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B2evFl1G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c3szFugv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BuQv6eh9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gBH+2m9h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8D4D338B0;
	Wed, 21 May 2025 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747842821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwWfw1tFLg+rteBWXiVctmBLqNA9fuGap1VPFoVp1ws=;
	b=B2evFl1GngYRie7RWcyHlY1VjozvQMrJqfOMt/EMXSTxzTOs2N8IR7xXZIjiyyQkEu5qgf
	Gsbpn39dCtwTPYlsYc6haMivHFFcphW3WYmnfiVy9Rxb1PhmJz3evfqzUGbRsWfeNknvxZ
	835oSQ4NpjbDz60jb+FvBmdBBYUz3Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747842821;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwWfw1tFLg+rteBWXiVctmBLqNA9fuGap1VPFoVp1ws=;
	b=c3szFugvkeRTjq4WbqHyoijpV/+4HER9piQr8tIF2SuXAeK9/FnJG7PEnTtT0Ov+pQ+G76
	AJRsV3O/bHJSCFBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BuQv6eh9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gBH+2m9h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747842820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwWfw1tFLg+rteBWXiVctmBLqNA9fuGap1VPFoVp1ws=;
	b=BuQv6eh9AgRdPV40Lf7xCr4RnXAVqqRjRk30RZR5a1efE8ygDTfi5ZgZewdut1/fCbOJkO
	RNzMG+97iH1stf5qwn4v9hu2HxWUlT+b+qA8pu5ZeIdH0suuGDrw62/2WniF4EjyhshSxN
	fwTTHrmhdsQ8QFMcrllECEj2bfcMcjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747842820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwWfw1tFLg+rteBWXiVctmBLqNA9fuGap1VPFoVp1ws=;
	b=gBH+2m9hPxqOxTGtZrn3mnzBAJC3Dzg68WIdod4SQEdFykOWQkwbtM2UCZAMyw17UTmBsd
	r4QKAZRpEofr9gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B519B13888;
	Wed, 21 May 2025 15:53:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sq9lKwT3LWjwKwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 21 May 2025 15:53:40 +0000
Date: Wed, 21 May 2025 17:53:39 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Hugh Dickins <hughd@google.com>
Cc: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	kernel-dev@igalia.com, stable@vger.kernel.org,
	Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aC33A65HFJOSO1_R@localhost.localdomain>
References: <20250521115727.2202284-1-gavinguo@igalia.com>
 <30681817-6820-6b43-1f39-065c5f1b3596@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30681817-6820-6b43-1f39-065c5f1b3596@google.com>
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: E8D4D338B0
X-Spam-Score: -1.51
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Wed, May 21, 2025 at 08:10:46AM -0700, Hugh Dickins wrote:
> Unless you have a very strong argument why this folio is invisible to
> the rest of the world, including speculative accessors like compaction
> (and the name "pagecache_folio" suggests very much the reverse): the
> pattern of unlocking a lock when you see it locked is like (or worse
> than) having no locking at all - it is potentially unlocking someone
> else's lock.

hugetlb_fault() locks 'pagecache_folio' and unlocks it after returning
from hugetlb_wp().
This patch introduces the possibility that hugetlb_wp() can also unlock it for
the reasons explained.
So, when hugetlb_wp() returns back to hugetlb_fault(), we

1) either still hold the lock (because hugetlb_fault() took it)
2) or we do not anymore because hugetlb_wp() unlocked it for us.

So it is not that we are unlocking anything blindly, because if the lock
is still 'taken' (folio_test_locked() returned true) it is because we,
hugetlb_fault() took it and we are still holding it.



-- 
Oscar Salvador
SUSE Labs

