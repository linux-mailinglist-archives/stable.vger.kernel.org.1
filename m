Return-Path: <stable+bounces-76191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A9979CA5
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 10:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B81C2272A
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF5B13AA5F;
	Mon, 16 Sep 2024 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rWsYQ8IT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="so3gjMzd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rWsYQ8IT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="so3gjMzd"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9723A9
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474810; cv=none; b=rPWmJnTJv/3uhS3DiZRTmPUIVCQCL00c+1/PhYMl63/Z7Yscr5l2ospV7cWGADTPL3qEPs5vKfLBkrVyp0XusCeZ2E588lDuAvVeVyqKVfcf5o6H3bSBTMcqR+4+i4ERbgVXWdeojXs1viMv1gusGG/rO4rhI+iJ0I4RQAm0Xi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474810; c=relaxed/simple;
	bh=Ni2pG/WvUicMTqpy+qdCtXY4btVXgylLkg0hAkAuPl0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkOyI3YEkm+tN2iAf9bYySLT5lpUe51llBaL/+nzlGDY24RyMlVb7TRGykJvfBhNhckhZhRS+pCLsQvjoGlU2Pre4GC8RwX+jFnvhFKLAK+kSaqS0Bcl9TFdyPWx5oOMmjC1Bfgv0b/CZ0MYg79IBxVGxvZ240+TJIG97qHCgiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rWsYQ8IT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=so3gjMzd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rWsYQ8IT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=so3gjMzd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E2931F86C;
	Mon, 16 Sep 2024 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726474806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2HjPfaQ84uk+pnk1W7uFFM3O3gnvZ9vk9gfvXx3Lx8=;
	b=rWsYQ8ITEWKN6otNWEJ6WkWkEyD5CtnzXNkayU2UCG4TNGNFuzrJYE4jKw36AxeqVpPhss
	fGo0fctBhEGfjGtOZqIAjlY0J5yHWBdJXus1xHe7FtxO3P5QSgdp8NnWYZSN8zstCHcrxt
	3DkpKOpbFFpzxvg2+Ft16iRfrKv+W9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726474806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2HjPfaQ84uk+pnk1W7uFFM3O3gnvZ9vk9gfvXx3Lx8=;
	b=so3gjMzdU27Mo4+HNiMJTu1b7mMA0mivLEbbi5laFAPmsJiFabkk3Kj7vK7TNZByZntL2u
	bATva5gO5duuzmAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rWsYQ8IT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=so3gjMzd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726474806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2HjPfaQ84uk+pnk1W7uFFM3O3gnvZ9vk9gfvXx3Lx8=;
	b=rWsYQ8ITEWKN6otNWEJ6WkWkEyD5CtnzXNkayU2UCG4TNGNFuzrJYE4jKw36AxeqVpPhss
	fGo0fctBhEGfjGtOZqIAjlY0J5yHWBdJXus1xHe7FtxO3P5QSgdp8NnWYZSN8zstCHcrxt
	3DkpKOpbFFpzxvg2+Ft16iRfrKv+W9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726474806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2HjPfaQ84uk+pnk1W7uFFM3O3gnvZ9vk9gfvXx3Lx8=;
	b=so3gjMzdU27Mo4+HNiMJTu1b7mMA0mivLEbbi5laFAPmsJiFabkk3Kj7vK7TNZByZntL2u
	bATva5gO5duuzmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C945D139CE;
	Mon, 16 Sep 2024 08:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NsCILzXq52ZlPQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Sep 2024 08:20:05 +0000
Date: Mon, 16 Sep 2024 10:20:55 +0200
Message-ID: <87jzfcxb4o.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Ariadne Conill <ariadne@ariadne.space>,
	xen-devel@lists.xenproject.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
In-Reply-To: <ZufgI6gw1kA8v4OD@infradead.org>
References: <20240906184209.25423-1-ariadne@ariadne.space>
	<877cbnewib.wl-tiwai@suse.de>
	<9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
	<ZuK6xcmAE4sngFqk@infradead.org>
	<874j6g9ifp.wl-tiwai@suse.de>
	<ZufdOjFCdqQQX7tz@infradead.org>
	<87wmjc8398.wl-tiwai@suse.de>
	<ZufgI6gw1kA8v4OD@infradead.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 1E2931F86C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Mon, 16 Sep 2024 09:37:07 +0200,
Christoph Hellwig wrote:
> 
> On Mon, Sep 16, 2024 at 09:30:11AM +0200, Takashi Iwai wrote:
> > On Mon, 16 Sep 2024 09:24:42 +0200,
> > Christoph Hellwig wrote:
> > > 
> > > On Mon, Sep 16, 2024 at 09:16:58AM +0200, Takashi Iwai wrote:
> > > > Yes, all those are really ugly hacks and have been already removed for
> > > > 6.12.  Let's hope everything works as expected with it.
> > > 
> > > The code currently in linux-next will not work as explained in my
> > > previous mail, because it tries to side step the DMA API and abuses
> > > get_dma_ops in an unsupported way.
> > 
> > Those should have been removed since the last week.
> > Could you check the today's linux-next tree?
> 
> Ok, looks like the Thursday updates fix the dma_get_ops abuse.
> 
> They introduce new bugs at least for architectures with virtuall
> indexed caches by combining vmap and dma mappings without
> mainintaining the cache coherency using the proper helpers.

Yes, but it should be OK, as those functions are applied only for
x86.  Others should use noncontig DMA instead, if any.

> What confuses my about this is the need to set the DMAable memory
> to write combinable.  How does that improve things over the default
> writeback cached memory on x86?  We could trivially add support for
> WC mappings for cache coherent DMA, but someone needs to explain
> how that actually makes sense first.

It's required for a few sound hardware including some HD-audio
controllers like old AMD graphics chips, at least.  Most of other
hardware work in PCI snooping with the default wb pages but those
chips lead to either stuttering or silence.  It seems that Windows
uses wc or uc pages, hence they aren't designed to work in other way.


thanks,

Takashi

