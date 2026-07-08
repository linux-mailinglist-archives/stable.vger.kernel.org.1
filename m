Return-Path: <stable+bounces-272700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k6pjDvN6TmpzNgIAu9opvQ
	(envelope-from <stable+bounces-272700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:29:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B352728B73
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:29:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EaOYvba+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YMvQUPMc;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EaOYvba+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YMvQUPMc;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272700-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272700-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 124E23004DF5
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDE43079D;
	Wed,  8 Jul 2026 16:29:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2140927B
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:29:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528176; cv=none; b=YhXYwvdayFIHLpeFukMb/yqv/gYwTHLtU5XxiU+dTIfnFnZNazT0t7zf3Erbg5pd1rgQpe95uWM6RORKovV8csRpRRW1d4D6FQHWIHFAISnsqHb1FEYV16rcIpDz9V3Gl80mbGsSa5Ir/sfI81LbWvOQksOm5lAJuOdnNeo4nL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528176; c=relaxed/simple;
	bh=3lSdyCLeUGu19piqkuUHLgWw74UGkM3eShfZ48QoXxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ5I/vISHGuqS9dYR2fyNbKQnI78V3+zBlj9+WIO1W+wZOBQidJMIXqaLhlVJBEvdlIqPZQ7kuMv2tuQ6tXlUohVDbUiVCVEtI+7fnSPT4mmAmStDbRyNDRR5UqwYyVbFsg5LXhIizI2RWKuQYXCGiSoA2zIKVF/9YNJnSvHAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EaOYvba+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YMvQUPMc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EaOYvba+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YMvQUPMc; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9207C75E8A;
	Wed,  8 Jul 2026 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783528173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/5vL0gtxnVlH2N135h4PQDZCX0YmGfUctk3tp3zRJI=;
	b=EaOYvba+ARiTsxtWUrYDBPR91BTRtXJsdTCLw0wNxhImLHwujj3dJv3h6cCGHlzp977dwE
	dIFixPE0pstyi4E9xED3cWLPtkgkfPJlBRlLF7KoOoeIks09dRwL71VB5xwNHvOu19Ks7M
	f6YOoObWR6FseQ6/IWOt8xy1k9VtSCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783528173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/5vL0gtxnVlH2N135h4PQDZCX0YmGfUctk3tp3zRJI=;
	b=YMvQUPMc+wnAmpwZbJQ/e5jUHFTTPHF8iv6B8qO+/rMFuQCGHrdiC6JQ6JXIlbiMj+vuvf
	ZWYh9doHo6nNVsDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783528173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/5vL0gtxnVlH2N135h4PQDZCX0YmGfUctk3tp3zRJI=;
	b=EaOYvba+ARiTsxtWUrYDBPR91BTRtXJsdTCLw0wNxhImLHwujj3dJv3h6cCGHlzp977dwE
	dIFixPE0pstyi4E9xED3cWLPtkgkfPJlBRlLF7KoOoeIks09dRwL71VB5xwNHvOu19Ks7M
	f6YOoObWR6FseQ6/IWOt8xy1k9VtSCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783528173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/5vL0gtxnVlH2N135h4PQDZCX0YmGfUctk3tp3zRJI=;
	b=YMvQUPMc+wnAmpwZbJQ/e5jUHFTTPHF8iv6B8qO+/rMFuQCGHrdiC6JQ6JXIlbiMj+vuvf
	ZWYh9doHo6nNVsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B315779AE;
	Wed,  8 Jul 2026 16:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r222Hux6TmpHdwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 08 Jul 2026 16:29:32 +0000
Date: Wed, 8 Jul 2026 17:29:30 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>, 
	Gregg Leventhal <gleventhal@janestreet.com>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios
 when collapsing
Message-ID: <ak56uatKoDR-TAIn@pedro-suse.lan>
References: <20260708151357.353173-1-pfalcato@suse.de>
 <ak5tKPfX99kdkhIG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak5tKPfX99kdkhIG@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272700-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:willy@infradead.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:song@kernel.org,m:ehagberg@janestreet.com,m:ziy@nvidia.com,m:gleventhal@janestreet.com,m:lance.yang@linux.dev,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B352728B73

On Wed, Jul 08, 2026 at 04:30:48PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 08, 2026 at 04:13:57PM +0100, Pedro Falcato wrote:
> > [There is no upstream commit, as this code was removed by upstream
> >  commit 044925f9b565 ("mm: fs: remove filemap_nr_thps*() functions and their users")]
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Eric Hagberg <ehagberg@janestreet.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
> > Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
> > Tested-by: Zi Yan <ziy@nvidia.com>
> > Tested-by: Lance Yang <lance.yang@linux.dev>
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!

-- 
Pedro

