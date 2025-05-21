Return-Path: <stable+bounces-145933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A47DABFD7F
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 21:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DE71BC60FB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF027CB0D;
	Wed, 21 May 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nlxRa7k0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="68iGYbBh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nlxRa7k0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="68iGYbBh"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9325A321
	for <stable@vger.kernel.org>; Wed, 21 May 2025 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856666; cv=none; b=fNwBKnFCvPjO6VT39lokNUXVYRiZBUSy4X1jImqNf40OiO3KnB6XQ6ZkvkK9fRKiGRiTqTuYDotRivWiqVN5qja+8rjX7bA2OTzwSPyi4NdbROa7SZ35YnszR6SA5WrXsfBc6kg6a0waESlEfWx8W1UyAiJE7L7bywbcWaa7W7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856666; c=relaxed/simple;
	bh=bpJbsMuWTrnO8zYhG/yRzb0a8X7S8LKO8Io3Q+P/At0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzgeCjtDFY12cb/84am6v25LeTAXmBBNFoYO9DwdqMdSUI5/bbERdZeOAxhGuo/mPHTDYJyYl7lrMY0Rdriu5u/MsXxPfvw4LJZXz1lhCiOYtuPVpumt/BdrP7fy0KN6kgZLazgqOSlAXCfbNxoSWHBt7MyP6ndkVYHwIvTD0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nlxRa7k0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=68iGYbBh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nlxRa7k0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=68iGYbBh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FDAC338F6;
	Wed, 21 May 2025 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747856663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TrMZ/8HB7EhYJqBEvRvkIrJcHzaSX/uXuZlZjBJy94=;
	b=nlxRa7k0ivhQJGuJtSnhTZo4pFXKjmNASdK1ZY2XD6QmLwbykV8AIe7VvWuWRn028wGKQr
	ue9xB4HQTDDq++JvT2/uTmHysa/XdRYUT223N4GXrlsiK5/3vRK3er0vo5jSm3DxOb/JVr
	+JwlUGZnJD8bMKTwAuZvFLY8BkX+EEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747856663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TrMZ/8HB7EhYJqBEvRvkIrJcHzaSX/uXuZlZjBJy94=;
	b=68iGYbBhAHvxM+cN74wZmURlmADFTVshScHdThA5OnnJwno1ZjyhnMvOqqf3vDIfXZEBgl
	dlj6XI8xFX8DusDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nlxRa7k0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=68iGYbBh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747856663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TrMZ/8HB7EhYJqBEvRvkIrJcHzaSX/uXuZlZjBJy94=;
	b=nlxRa7k0ivhQJGuJtSnhTZo4pFXKjmNASdK1ZY2XD6QmLwbykV8AIe7VvWuWRn028wGKQr
	ue9xB4HQTDDq++JvT2/uTmHysa/XdRYUT223N4GXrlsiK5/3vRK3er0vo5jSm3DxOb/JVr
	+JwlUGZnJD8bMKTwAuZvFLY8BkX+EEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747856663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2TrMZ/8HB7EhYJqBEvRvkIrJcHzaSX/uXuZlZjBJy94=;
	b=68iGYbBhAHvxM+cN74wZmURlmADFTVshScHdThA5OnnJwno1ZjyhnMvOqqf3vDIfXZEBgl
	dlj6XI8xFX8DusDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E91A913888;
	Wed, 21 May 2025 19:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IyYqOBYtLmi9YgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 21 May 2025 19:44:22 +0000
Date: Wed, 21 May 2025 21:44:21 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Hugh Dickins <hughd@google.com>
Cc: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	akpm@linux-foundation.org, kernel-dev@igalia.com,
	stable@vger.kernel.org, Florent Revest <revest@google.com>,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aC4tFWSclf40KJ_J@localhost.localdomain>
References: <20250521115727.2202284-1-gavinguo@igalia.com>
 <30681817-6820-6b43-1f39-065c5f1b3596@google.com>
 <aC33A65HFJOSO1_R@localhost.localdomain>
 <54bd3d6c-d763-ae09-6ee2-7ef192a97ca9@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54bd3d6c-d763-ae09-6ee2-7ef192a97ca9@google.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 1FDAC338F6
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, May 21, 2025 at 08:58:32AM -0700, Hugh Dickins wrote:
> If we unlocked it, anyone else could have taken it immediately after.

Sorry Hugh, I was being dumb, of course you are right.

Then, maybe v1 was not really a bad idea, but we might need to think of
a better idea overall.

-- 
Oscar Salvador
SUSE Labs

