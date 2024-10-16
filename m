Return-Path: <stable+bounces-86448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407BE9A053F
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC886B255EF
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AC9204F9D;
	Wed, 16 Oct 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ItfSHzFB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ors147bg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ItfSHzFB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ors147bg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0921F76D2;
	Wed, 16 Oct 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070437; cv=none; b=imDaVpQpEXdPCwvwBqJI+noG9b98HHQS93SxSwCYwOe6cx13FzB0lQZjG+GCN2qopi6J8a5o259K1pSUel5/6RYyjCH1UfK2n8udnckNqQrhHN6M52P6wrypQVew0NucRbyPEKSTpIce9uowcVNAkF6x1jyYoZRfezX7UuB5Kd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070437; c=relaxed/simple;
	bh=DLHheLDaRR6+KcGD2A30ZcDjvKbLR7m5Bt+gppFTC5I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiRpWnLiy2dMPZBz5u3bLAK+phpuQJHF2EI3P4TpV8aFwCp7JjWTvynfiVu3adGqZifdbycHakjA+O7pvQwKVIPQvbdov90WJINr29Iip4IJHpYqr3JIa5CwXuLmTZ+8AmDt5V5+9ET9UnkkbTCKqlj0+5xYKV3VyyFV9tZyxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ItfSHzFB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ors147bg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ItfSHzFB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ors147bg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3488F1FBF0;
	Wed, 16 Oct 2024 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729070434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvhLUoXtiT4wtzJvaHxpfK3ExOTawW+kyThvNf02t1Y=;
	b=ItfSHzFB3cL9fMVeibD798GljRMeAlMVFswRxSiPS9pcY9qI3tuqJ04qcqAf9mB8p4jijM
	vXdkspFJHyoqyBQt+cbFRT+fSYNpuyRzw+jCDc2xx1rx6zYSgamHgHZJVdQlLqtbIu8LEH
	t9I/t9MtEjdxBd010ts8BUEAUSExMGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729070434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvhLUoXtiT4wtzJvaHxpfK3ExOTawW+kyThvNf02t1Y=;
	b=ors147bgk2fUWL3RCDQ6/ZuiKcxA7UsaMhtD8l4x05CZ7aoVsC3I7wCPu1b1flTibnOyZN
	btSIvhKlUrDlCnBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729070434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvhLUoXtiT4wtzJvaHxpfK3ExOTawW+kyThvNf02t1Y=;
	b=ItfSHzFB3cL9fMVeibD798GljRMeAlMVFswRxSiPS9pcY9qI3tuqJ04qcqAf9mB8p4jijM
	vXdkspFJHyoqyBQt+cbFRT+fSYNpuyRzw+jCDc2xx1rx6zYSgamHgHZJVdQlLqtbIu8LEH
	t9I/t9MtEjdxBd010ts8BUEAUSExMGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729070434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvhLUoXtiT4wtzJvaHxpfK3ExOTawW+kyThvNf02t1Y=;
	b=ors147bgk2fUWL3RCDQ6/ZuiKcxA7UsaMhtD8l4x05CZ7aoVsC3I7wCPu1b1flTibnOyZN
	btSIvhKlUrDlCnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A7611376C;
	Wed, 16 Oct 2024 09:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B+LdBWKFD2faNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 16 Oct 2024 09:20:34 +0000
Date: Wed, 16 Oct 2024 11:21:24 +0200
Message-ID: <87bjzktncb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dean Matthew Menezes <dean.menezes@utexas.edu>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux Sound
 System <linux-sound@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
	<2024101613-giggling-ceremony-aae7@gregkh>
	<433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 16 Oct 2024 07:56:09 +0200,
Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> On 16.10.24 07:42, Greg KH wrote:
> > On Tue, Oct 15, 2024 at 07:47:22PM -0500, Dean Matthew Menezes wrote:
> >> I am not getting sound on the speakers on my Thinkpad X1 Carbon Gen 12
> >> with kernel 6.11.2  The sound is working in kernel 6.8
> > 
> > Can you use 'git bisect' to track down the offending change?
> 
> Yeah, that would help a lot.
> 
> But FWIW, I CCed the audio maintainers and the sound mailing list, with
> a bit of luck they might have an idea.
> 
> You might also want to publish your dmesg files from the latest working
> and the first broken kernel, that gives people a chance to spot obvious
> problems. Ohh, and runing alsa-info.sh and publishing the output could
> help, too.

Yes, alsa-info.sh outputs are really needed for debugging, especially
because Lenovo has (literally) hundreds of different models.

Please run the script with --no-upload option and attach the outputs
from both working and non-working cases.


thanks,

Takashi

