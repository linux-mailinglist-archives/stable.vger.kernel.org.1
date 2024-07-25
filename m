Return-Path: <stable+bounces-61427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C193C2AD
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1CD1F21F36
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D3319AD6F;
	Thu, 25 Jul 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oUd2QNDt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SCp6G7Eq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oUd2QNDt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SCp6G7Eq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AFB199E9B;
	Thu, 25 Jul 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912829; cv=none; b=L0KpUpuP1KKzz3INoLOopP4wQr8o688eUCdWho2F4xWYNVV8GpO9rTT/a20q+A6CwxdZVz96cY1Bd2gzP+Dx8gGJq6NwcPruaVG6lmAbs7NSwS9lflFjf2Jjbar8ayJXdzKs3T2VXzLYbJcWKIpj+Xk7JV/ac6kvKJhdFONWcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912829; c=relaxed/simple;
	bh=27UdjVY2T9kftaELLseaAoaA4TD8YZeRfanOV32l7I0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p59T+cvO7FnqivV+iYza/aND4FBI1HrASy7iCn0Fs//4OAMbHNtHgp/lwMngEUF7rwECkxJe+MlOp9U8GTx+5RBjmsVZD5ZNz55Mp/x5VuJASmd7wvd9y0sT89db8MW5OuhrNd4usis2xlmLWojSxwMDizedvadY2LFK+9jTjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oUd2QNDt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SCp6G7Eq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oUd2QNDt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SCp6G7Eq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FA471FC24;
	Thu, 25 Jul 2024 13:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721912825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7a2eLlH3iIWOinS6JEA7tMaX+0WlcTQWISwluY5v5U=;
	b=oUd2QNDtyhsQ3bE2a/AeXhL7YygsZVTa8e7uZ4oGeucZyLPU93E6qpdGMpnms41r6AHiAI
	L4M7Prp9JhVQuI7ZOcq4vaiRNKQEYbUxQM4d5gt/D52cC0H2QivekzVC4bqDVQgyaUkzAC
	bGuWh1c7DEW4I6O8Yn8goQsp5Y6k31g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721912825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7a2eLlH3iIWOinS6JEA7tMaX+0WlcTQWISwluY5v5U=;
	b=SCp6G7Eq6DJVRxI6M3JoMYXXwQI5pP0r1nwln+zkmD4qugxDH/d6P00SvZq4MXl1lUJEKL
	1dp4w/20ll4/4+Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oUd2QNDt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SCp6G7Eq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721912825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7a2eLlH3iIWOinS6JEA7tMaX+0WlcTQWISwluY5v5U=;
	b=oUd2QNDtyhsQ3bE2a/AeXhL7YygsZVTa8e7uZ4oGeucZyLPU93E6qpdGMpnms41r6AHiAI
	L4M7Prp9JhVQuI7ZOcq4vaiRNKQEYbUxQM4d5gt/D52cC0H2QivekzVC4bqDVQgyaUkzAC
	bGuWh1c7DEW4I6O8Yn8goQsp5Y6k31g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721912825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7a2eLlH3iIWOinS6JEA7tMaX+0WlcTQWISwluY5v5U=;
	b=SCp6G7Eq6DJVRxI6M3JoMYXXwQI5pP0r1nwln+zkmD4qugxDH/d6P00SvZq4MXl1lUJEKL
	1dp4w/20ll4/4+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68FBC13874;
	Thu, 25 Jul 2024 13:07:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zDuHGPlNomaCegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jul 2024 13:07:05 +0000
Date: Thu, 25 Jul 2024 15:07:40 +0200
Message-ID: <87r0bhipr7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "edmund.raile" <edmund.raile@proton.me>
Cc: alsa-devel@alsa-project.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	o-takashi@sakamocchi.jp,
	gustavoars@kernel.org,
	clemens@ladisch.de,
	linux-sound@vger.kernel.org
Subject: Re: [REGRESSION] ALSA: firewire-lib: heavy digital distortion with Fireface 800
In-Reply-To: <rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2>
References: <rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.31 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 9FA471FC24
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.31

On Thu, 25 Jul 2024 00:24:29 +0200,
edmund.raile wrote:
> 
> Bisection revealed that the bitcrushing distortion with RME FireFace 800
> was caused by 1d717123bb1a7555
> ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning").
> 
> Reverting this commit yields restoration of clear audio output.
> I will send in a patch reverting this commit for now, soonTM.
> 
> #regzbot introduced: 1d717123bb1a7555

While it's OK to have a quick revert, it'd be worth to investigate
further what broke there; the change is rather trivial, so it might be
something in the macro expansion or a use of flex array stuff.


thanks,

Takashi

