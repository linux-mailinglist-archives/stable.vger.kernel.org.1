Return-Path: <stable+bounces-75626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77713973606
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042431F22497
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE718CBE6;
	Tue, 10 Sep 2024 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TdqiNgZ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+U/3fD1t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IfqFcZCL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gAnalbD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE914D280
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966980; cv=none; b=YEPVzNquWQqpaEDHrIEb64u2fwxacAJjvnriT6zowAE0qp0IE6qOYNvxNnBmJ0bMPE/h/NXRn+gEIEg/IeNpzAL33gOPaFnYPmmnIFa3XfuiOjXHFnHRh8GoeD+s1kchIYuJ1inRA6FA19lw48G6zGU/muy1849sIQGT7+WwE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966980; c=relaxed/simple;
	bh=UQ6tx0C8V1AzErgCb79nfD55bcyzkNG7asM8BFx/REo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiKrvDDqJj9EOrLTsnW0w2gjyxWTDTs22ZwfNT681iO/g7nmuQVHs8ZuBGZyDayUbkISeqf42eEvG9W4UnLTzdh42CCWO5QAaYqH4Xqo9YSfTDGHNWDX8Cm3Z65ufw+eD3ACWdiYxqEXE/1Famyx5so55adN8XFzqKWW0wwDOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TdqiNgZ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+U/3fD1t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IfqFcZCL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gAnalbD1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF9C921A08;
	Tue, 10 Sep 2024 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725966976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSWXduxUIFCZw/mkRONMzdnLrFbA8fCzPQXxmT6OpsU=;
	b=TdqiNgZ86ajx2uMv0jf8pmfq/to+dJxDzOmj+DL16/W1FwcAPyPUn55EelS1YNw+WcA1VO
	5QJ9mUbW1Jab5/SDgJZbMP9Tg9HuPmeB0pN5t5uO5/UYZZ551OKMUbSfQ3IS/euDB8b/xD
	9RdyBvNwygk7h3jpKKKR/u/q0uUinxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725966976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSWXduxUIFCZw/mkRONMzdnLrFbA8fCzPQXxmT6OpsU=;
	b=+U/3fD1tt5keolWAGCrbos4u+0brW+rPrcMLVfzsJ+b9R/4FDyNQYAaAlbqZVQmJgkgAtW
	nykhKUuf5QmGzPDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IfqFcZCL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gAnalbD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725966975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSWXduxUIFCZw/mkRONMzdnLrFbA8fCzPQXxmT6OpsU=;
	b=IfqFcZCLNpTBDSXEI3ZGpkC6oziaeXai4r3R4UUZwuhw6PTI4m1qzRhakGhdUSIvKjwKUz
	dItR3o5WSM/MKZ4BvAD0neKvALqP27CEafIkoCG9Tj/Q+LnMAvY6DnPhLMwpEexSTZkHMH
	k2YZuhdErGL91J80ViH967OIguBkjrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725966975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aSWXduxUIFCZw/mkRONMzdnLrFbA8fCzPQXxmT6OpsU=;
	b=gAnalbD1MuJX8DTO2OIeYEZjw+xb37EeiBcx7KXWPF8YHCVeCjhvXfE+JfzoQ/HP109LJD
	/RjeiIq8JnPVRCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1E4D13A3A;
	Tue, 10 Sep 2024 11:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 292FKn8q4GYVcAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Sep 2024 11:16:15 +0000
Date: Tue, 10 Sep 2024 13:17:03 +0200
Message-ID: <8734m77o7k.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Elliott Mitchell <ehem+xen@m5p.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Ariadne Conill <ariadne@ariadne.space>,
	xen-devel@lists.xenproject.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
In-Reply-To: <Zt9UQJcYT58LtuRV@mattapan.m5p.com>
References: <20240906184209.25423-1-ariadne@ariadne.space>
	<877cbnewib.wl-tiwai@suse.de>
	<9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
	<Zt9UQJcYT58LtuRV@mattapan.m5p.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: CF9C921A08
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[xen];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon, 09 Sep 2024 22:02:08 +0200,
Elliott Mitchell wrote:
> 
> On Sat, Sep 07, 2024 at 11:38:50AM +0100, Andrew Cooper wrote:
> > On 07/09/2024 8:46 am, Takashi Iwai wrote:
> > > On Fri, 06 Sep 2024 20:42:09 +0200,
> > > Ariadne Conill wrote:
> > >> This patch attempted to work around a DMA issue involving Xen, but
> > >> causes subtle kernel memory corruption.
> > >>
> > >> When I brought up this patch in the XenDevel matrix channel, I was
> > >> told that it had been requested by the Qubes OS developers because
> > >> they were trying to fix an issue where the sound stack would fail
> > >> after a few hours of uptime.  They wound up disabling SG buffering
> > >> entirely instead as a workaround.
> > >>
> > >> Accordingly, I propose that we should revert this workaround patch,
> > >> since it causes kernel memory corruption and that the ALSA and Xen
> > >> communities should collaborate on fixing the underlying problem in
> > >> such a way that SG buffering works correctly under Xen.
> > >>
> > >> This reverts commit 53466ebdec614f915c691809b0861acecb941e30.
> > >>
> > >> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> > >> Cc: stable@vger.kernel.org
> > >> Cc: xen-devel@lists.xenproject.org
> > >> Cc: alsa-devel@alsa-project.org
> > >> Cc: Takashi Iwai <tiwai@suse.de>
> > > The relevant code has been largely rewritten for 6.12, so please check
> > > the behavior with sound.git tree for-next branch.  I guess the same
> > > issue should happen as the Xen workaround was kept and applied there,
> > > too, but it has to be checked at first.
> > >
> > > If the issue is persistent with there, the fix for 6.12 code would be
> > > rather much simpler like the blow.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > --- a/sound/core/memalloc.c
> > > +++ b/sound/core/memalloc.c
> > > @@ -793,9 +793,6 @@ static void *snd_dma_sg_alloc(struct snd_dma_buffer *dmab, size_t size)
> > >  	int type = dmab->dev.type;
> > >  	void *p;
> > >  
> > > -	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> > > -		return snd_dma_sg_fallback_alloc(dmab, size);
> > > -
> > >  	/* try the standard DMA API allocation at first */
> > >  	if (type == SNDRV_DMA_TYPE_DEV_WC_SG)
> > >  		dmab->dev.type = SNDRV_DMA_TYPE_DEV_WC;
> > >
> > >
> > 
> > Individual subsystems ought not to know or care about XENPV; it's a
> > layering violation.
> > 
> > If the main APIs don't behave properly, then it probably means we've got
> > a bug at a lower level (e.g. Xen SWIOTLB is a constant source of fun)
> > which is probably affecting other subsystems too.
> 
> This is a big problem.  Debian bug #988477 (https://bugs.debian.org/988477)
> showed up in May 2021.  While some characteristics are quite different,
> the time when it was first reported is similar to the above and it is
> also likely a DMA bug with Xen.

Yes, some incompatible behavior has been seen on Xen wrt DMA buffer
handling, as it seems.  But note that, in the case of above, it was
triggered by the change in the sound driver side, hence we needed a
quick workaround there.  The result was to move back to the old method
for Xen in the end.

As already mentioned in another mail, the whole code was changed for
6.12, and the revert isn't applicable in anyway.

So I'm going to submit another patch to drop this Xen PV-specific
workaround for 6.12.  The new code should work without the workaround
(famous last words).  If the problem happens there, I'd rather leave
it to Xen people ;)


thanks,

Takashi

