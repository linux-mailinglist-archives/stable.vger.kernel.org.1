Return-Path: <stable+bounces-192483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C9C3477B
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 09:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59849467045
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 08:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A012C21CB;
	Wed,  5 Nov 2025 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l7VgSVQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rokhlFLS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l7VgSVQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rokhlFLS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6773299954
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331295; cv=none; b=hWC+l9y/uGd7WgucnAl0jcsiEaAzlhtumWEbE2PFMpoI0HFbxdskimLZ3LDs4OBrF6GzrZnaS1EDPunu43sWv5sJu8qkPKt+dP5+vJBXlGguul0zAnTN1bDfiaITZBDITYK1n5L+e6aKqW7IfmBmUKB8a0ugc8opas9MW1PLTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331295; c=relaxed/simple;
	bh=faCQStMkOzA8zWUIOPOfGFoLZt44wjXUp3R37OxqcaY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgErh5pTypwjpALrGEBd7t4afrsQaYCwVRSdx5UVe6mShOSYjv58n48Pi2Ho8b1Zmasx8Z6Fw3xOv0a1kOXPPU4ZOtQsMeGBLIPzj3vwq74i/hh1s0bBJolK232jmak9dXqwsRJQTLnVGxTiR225fBGNAPoUpbF8gx3S5dH5Tms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l7VgSVQF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rokhlFLS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l7VgSVQF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rokhlFLS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B63EB1F397;
	Wed,  5 Nov 2025 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762331290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7oii3fj4FPa14vqGcQpAC6z5WVWuDxUvBuwGwCnSlQ=;
	b=l7VgSVQFDqnP1rPIaIGLYRMyVwWBSZWwVz5C6HMn/6SNE9iapwJ6kOHxIFp3NpXbdRzX+8
	5C67LTcZ9hS9VyCxb5ru66cB29e3UwDv0QVOYcSSjxRCaJYKPuj9ZX2IQZ+uSgNRQBkZOo
	cge7SQVmbSvVplMzT3UpYyZtbc4erNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762331290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7oii3fj4FPa14vqGcQpAC6z5WVWuDxUvBuwGwCnSlQ=;
	b=rokhlFLS8bg2rtGYEUHhXlglGC6XBMImPssofgomA0UShs4zeIQRjKxNUzGZJXVgHLwPCx
	fN0vXP5l3RUZ47Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l7VgSVQF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rokhlFLS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762331290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7oii3fj4FPa14vqGcQpAC6z5WVWuDxUvBuwGwCnSlQ=;
	b=l7VgSVQFDqnP1rPIaIGLYRMyVwWBSZWwVz5C6HMn/6SNE9iapwJ6kOHxIFp3NpXbdRzX+8
	5C67LTcZ9hS9VyCxb5ru66cB29e3UwDv0QVOYcSSjxRCaJYKPuj9ZX2IQZ+uSgNRQBkZOo
	cge7SQVmbSvVplMzT3UpYyZtbc4erNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762331290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7oii3fj4FPa14vqGcQpAC6z5WVWuDxUvBuwGwCnSlQ=;
	b=rokhlFLS8bg2rtGYEUHhXlglGC6XBMImPssofgomA0UShs4zeIQRjKxNUzGZJXVgHLwPCx
	fN0vXP5l3RUZ47Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BBE213699;
	Wed,  5 Nov 2025 08:28:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4639GJoKC2kMXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Nov 2025 08:28:10 +0000
Date: Wed, 05 Nov 2025 09:28:10 +0100
Message-ID: <87tsz8hoit.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: 222 Summ <moonafterrain@outlook.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yuhao Jiang
	<danisjiang@gmail.com>
Subject: Re: [PATCH v2] ALSA: wavefront: use scnprintf for longname construction
In-Reply-To: <SYBPR01MB7881D2110FD5E269FF682327AFC5A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881987D79C62D8122B655FEAFC6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<874irai0ag.wl-tiwai@suse.de>
	<SYBPR01MB7881D2110FD5E269FF682327AFC5A@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B63EB1F397
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,suse.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Wed, 05 Nov 2025 05:28:27 +0100,
222 Summ wrote:
> 
> Hi Takashi,
> 
> Thank you for your detailed feedback on the v2 patch. I've prepared a v3
> patch series that incorporates your suggestions.
> 
> Based on your comments, I've made the following changes:
> 
> 1. Split the patch into two parts:
>    - Patch 1/2: Adds `scnprintf_append()` to `lib/vsprintf.c`
>    - Patch 2/2: Converts `wavefront.c` to use it
> 2. Fixed the return value you pointed out
> 3. Used strnlen() instead of strlen() for safety
> 
> I plan to submit this as a two-patch series. However, before I send it, I'd like to confirm a few things:
> 
> 1. Is this approach (adding the helper to lib/vsprintf.c) what you had in
>    mind? Or would you prefer a different location?

IMO lib/vsprintf.c should be fine.

> 2. Would you recommend sending both patches together, or waiting until
> patch 1/2 is reviewed and accepted before submitting patch 2/2?

You can try patching not only wavefront.c but covering a few others in
the series at first for showing that it really makes sense to be a
generic helper function.  And, submitting the whole might be better to
understand what's the use and effect, too.

Note that there can be suggestions for other forms, e.g. there have
been some progresses for the continuous string processing, IIRC.
So this is merely one example to achieve the goal.

The merit of this way would be its simplicity, though: you can replace
the code with a single function call without keeping anything else,
and the handling logic is quite straightforward.

> The implementation of scnprintf_append() is shown below:
> +int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
> +{
> +	va_list args;
> +	size_t len;
> +
> +	len = strnlen(buf, size);
> +	if (len >= size)
> +		return len;
> +	va_start(args, fmt);
> +	len += vscnprintf(buf + len, size - len, fmt, args);
> +	va_end(args);
> +	return len;
> +}

This should be with EXPORT_SYMBOL_GPL() (or EXPORT_SYMBOL() is any
user is non-GPL).


thanks,

Takashi

> 
> Thanks again for your guidance.
> 
> Best regards,
> Junrui
> 
> ________________________________________
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, November 4, 2025 18:01
> To: moonafterrain@outlook.com <moonafterrain@outlook.com>
> Cc: Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; linux-sound@vger.kernel.org <linux-sound@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.org>; Yuhao Jiang <danisjiang@gmail.com>
> Subject: Re: [PATCH v2] ALSA: wavefront: use scnprintf for longname construction
>  
> On Sun, 02 Nov 2025 16:32:39 +0100,
> moonafterrain@outlook.com wrote:
> >
> > From: Junrui Luo <moonafterrain@outlook.com>
> >
> > Replace sprintf() calls with scnprintf() and a new scnprintf_append()
> > helper function when constructing card->longname. This improves code
> > readability and provides bounds checking for the 80-byte buffer.
> >
> > While the current parameter ranges don't cause overflow in practice,
> > using safer string functions follows kernel best practices and makes
> > the code more maintainable.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> > ---
> > Changes in v2:
> > - Replace sprintf() calls with scnprintf() and a new scnprintf_append()
> > - Link to v1: https://lore.kernel.org/all/ME2PR01MB3156CEC4F31F253C9B540FB7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com/
> 
> Well, my suggestion was that we can apply such conversions once if a
> *generic* helper becomes available; that is, propose
> scnprintf_append() to be put in include/linux/string.h or whatever (I
> guess better in *.c instead of inline), and once if it's accepted, we
> can convert the relevant places (there are many, not only
> wavefront.c).
> 
> BTW:
> 
> > +__printf(3, 4) static int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
> > +{
> > +     va_list args;
> > +     size_t len = strlen(buf);
> > +
> > +     if (len >= size)
> > +             return len;
> > +     va_start(args, fmt);
> > +     len = vscnprintf(buf + len, size - len, fmt, args);
> > +     va_end(args);
> > +     return len;
> 
> The above should be
>         len += vscnprintf(buf + len, size - len, fmt, args);
> so that it returns the full size of the string.
> If it were in user-space, I'd check a negative error code, but the
> Linux kernel implementation doesn't return a negative error code, so
> far.
> I see it's a copy from a code snipped I suggested which already
> contained the error :)
> 
> Also, it might be safer to use strnlen() instead of strlen() for
> avoiding a potential out-of-bound access.
> 
> 
> thanks,
> 
> Takashi

