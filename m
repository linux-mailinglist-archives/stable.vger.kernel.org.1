Return-Path: <stable+bounces-119460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A0A437C6
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 09:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA810174F06
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99125E469;
	Tue, 25 Feb 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iMSj3EYj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TRxa2sAX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEJYeUeY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2GWcGaxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A201C8607
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472612; cv=none; b=r9r4wEhRslQK9ws+ddbnZ5EKJgzMylkerNv/9GxHWAs0d5GVhmAJqas1/9Y1Rjg+zbG2IpPXkOtBb9DVgeArzxV+g8uyU6EEruEwf69bUFoO4vjcjRt3XVwI8+sUVyhRiP8IanJQQ2GycbZsJZaOH3ENdN0Kks1pdWS01ocRb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472612; c=relaxed/simple;
	bh=dYiNWNzutWIunK0YREZeye8mMXG++RLpRz2knUfjkfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHGgIHcB+cH1nT6mYYjCJN/kmUiYRtSMHNFaEpxAUqC3cGbDnmxC6oh/lxCU8leZehwCYv8CHOJ8lGy1wh5G5yMDe6eCTdnl8npVJHXRsdulPFdN4+rAPGKk9c0VkGqE9llfp1QOBWEWIDCX/JH0ZKG+oqOqGQ2KB/nuBNrfgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iMSj3EYj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TRxa2sAX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEJYeUeY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2GWcGaxb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E4572118E;
	Tue, 25 Feb 2025 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740472608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixIW4L2KK1/x1LlQODZCwvIbEcdT4VoLWaThdcRLEE8=;
	b=iMSj3EYjCoNJ4Z740vMgD27ZXFtu3F3CLVZ3oDILVbMlw0tqBuyEub8EIZkyJoPcuaMSQ9
	G3jhPBfdRxBTGbC20LgbOZ9u51YQKPTAb23mcV/JMQ+KUQ13ZpYxnu/wwU8mCM7oh/EB1+
	9/aFr/JtHPWoIBmQ0mXyMnO6Q1YWMt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740472608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixIW4L2KK1/x1LlQODZCwvIbEcdT4VoLWaThdcRLEE8=;
	b=TRxa2sAXnPlD/UqrVIzRVclpxMU9HcFoA1CacAu9ubJK6QHEW5VpPrkxL2IbzRQuDLBuJx
	PSNljU0qjUBar6AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lEJYeUeY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2GWcGaxb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740472607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixIW4L2KK1/x1LlQODZCwvIbEcdT4VoLWaThdcRLEE8=;
	b=lEJYeUeYu/5Ys8uFO5wUOLJGv1Rv9tujKpdmgBhdYZTXGkN0NDf0Mj+ZcBQ1KkU7/whuJz
	3GlsRoHvKAJ18y3q3FOUDVilf+RTLuTme8ZLSYsm9BNGHP0n/5wW+Ig0uRN4IPqmcgH+E/
	jIvpC9x9STl8fkDqE8rA3U18Vk39tsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740472607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixIW4L2KK1/x1LlQODZCwvIbEcdT4VoLWaThdcRLEE8=;
	b=2GWcGaxbapQTPy3/Te8CBxci5u/POnS2l69/xxK+ZEHnFiPzrSZYs0JYSoAu0ksLesZV+n
	2Ewt3Q9+NjNBC0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 770CA13A61;
	Tue, 25 Feb 2025 08:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xlNQGh6BvWemAwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 25 Feb 2025 08:36:46 +0000
Date: Tue, 25 Feb 2025 09:36:44 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com, byungchul@sk.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, stable@vger.kernel.org,
	linux-mm@kvack.org, max.byungchul.park@sk.com,
	max.byungchul.park@gmail.com
Subject: Re: [PATCH] x86/vmemmap: Synchronize with global pgds if populating
 init_mm's pgd
Message-ID: <Z72BHNv18NNq1e2F@localhost.localdomain>
References: <20250220064105.808339-1-gwan-gyeong.mun@intel.com>
 <d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com>
X-Rspamd-Queue-Id: 3E4572118E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,sk.com,linux.intel.com,kernel.org,infradead.org,linux-foundation.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,localhost.localdomain:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Thu, Feb 20, 2025 at 10:02:54AM -0800, Dave Hansen wrote:
> On 2/19/25 22:41, Gwan-gyeong Mun wrote:
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index 01ea7c6df303..7935859bcc21 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1498,6 +1498,54 @@ static long __meminitdata addr_start, addr_end;
> >  static void __meminitdata *p_start, *p_end;
> >  static int __meminitdata node_start;
> >  
> > +static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
> > +{
> > +	void *p = vmemmap_alloc_block(size, node);
> > +
> > +	if (!p)
> > +		return NULL;
> > +	memset(p, 0, size);
> > +
> > +	return p;
> > +}
> 
> This is a pure copy and paste of the generic function. I assume this is
> because the mm/sparse-vmemmap.c is static. But this kind of copying is
> really unfortunate.

Agreed.

> ...
> > +pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
> > +{
> > +	pgd_t *pgd = pgd_offset_k(addr);
> > +
> > +	if (pgd_none(*pgd)) {
> > +		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
> > +
> > +		if (!p)
> > +			return NULL;
> > +
> > +		pgd_populate(&init_mm, pgd, p);
> > +		sync_global_pgds(addr, addr);
> > +	}
> > +
> > +	return pgd;
> > +}
> 
> I'd _really_ like to find another way to do this. We really don't want
> to add copy-and-paste versions of generic functions that we now need to
> maintain on the x86 side.
> 
> The _best_ way is probably to create some p*d_populate_kernel() helpers:
> 
> void pgd_populate_kernel(unsigned long addr, pgd_t *pgd, p4d_t *p4d)
> {
> 	pgd_populate(&init_mm, pgd, p4d);
> 	arch_sync_global_pgds(addr, addr+something);
> }
> 
> and move over most of the callers of:
> 
> 	p*d_populate(&init_mm, ...);

I think this makes more sense, yes.
So for those that do not need the sync, arch_sync_* would be just a
noop, so we could avoid all these code duplication.


-- 
Oscar Salvador
SUSE Labs

