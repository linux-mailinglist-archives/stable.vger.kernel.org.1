Return-Path: <stable+bounces-192348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BFC3067B
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1844418994AE
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA792D46BB;
	Tue,  4 Nov 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g8RrpGjx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KK/oC2S3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g8RrpGjx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KK/oC2S3"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077027E04C
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250508; cv=none; b=fb08VHZ64uzBfUBILgzzufzb5Ssv3BCVZ2JN5g3tKgh/46ViK5ifxgv7CyyGRTcBcoAvXklFlNoyOwWQseWWXHkEq5nIw+896bMOf0aJBWpEkmHY3plVqKqGheFzyRDgIzzBPbKqrAeGABbsW7VdXi4RqmVmFqWQEqKpgXQaDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250508; c=relaxed/simple;
	bh=Vp8s1sFUhZEtTmOe3NnIXBtWE7EhfmGKuCuGH0ddg5U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVUtUOxPifxSEYcaV+hJ5mZu/I7EG3iTFXyBUJN4lPbDglyBmbQU3ZWzXT4Id3gr/tXzQoQUb2xJ12NSGqfgRo3OOUg+Q+V3CVI8NMsYm+vkuDUL6b/PkqP7/qLttDEJLr9nqVMya6O/QIz2KW2eLlYu1hNYhRmDpHZdHZ+1XLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g8RrpGjx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KK/oC2S3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g8RrpGjx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KK/oC2S3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BED391F385;
	Tue,  4 Nov 2025 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762250503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvML9ahiMNR24WsBOuMm7W2eYvpxZcIULBQYbrFHl1I=;
	b=g8RrpGjxsyYPqGI5s8P0WTepWACzYbr7YdwbUHI1rwwNXJQAAFvzLpfUpzju5lHIDBYRbg
	CvzLnJ12Mn1LzQCEoKQlzrHvicwZ/+6iEV6wLYWRScOPu751zLiAscFFgMXG4QmYG2PLn/
	dW7p+mdjKAb5DjnKhdFsEEwsaksZBx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762250503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvML9ahiMNR24WsBOuMm7W2eYvpxZcIULBQYbrFHl1I=;
	b=KK/oC2S3am5LZLEqgIsNa02QrA7XYCsH3DEo2CMl9ueIAKo6+FeHPc2nrPBDUPSPmnp/uN
	PH24WTdTW6yybXDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762250503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvML9ahiMNR24WsBOuMm7W2eYvpxZcIULBQYbrFHl1I=;
	b=g8RrpGjxsyYPqGI5s8P0WTepWACzYbr7YdwbUHI1rwwNXJQAAFvzLpfUpzju5lHIDBYRbg
	CvzLnJ12Mn1LzQCEoKQlzrHvicwZ/+6iEV6wLYWRScOPu751zLiAscFFgMXG4QmYG2PLn/
	dW7p+mdjKAb5DjnKhdFsEEwsaksZBx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762250503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvML9ahiMNR24WsBOuMm7W2eYvpxZcIULBQYbrFHl1I=;
	b=KK/oC2S3am5LZLEqgIsNa02QrA7XYCsH3DEo2CMl9ueIAKo6+FeHPc2nrPBDUPSPmnp/uN
	PH24WTdTW6yybXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E55B136D1;
	Tue,  4 Nov 2025 10:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xD2mHQfPCWmtOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Nov 2025 10:01:43 +0000
Date: Tue, 04 Nov 2025 11:01:43 +0100
Message-ID: <874irai0ag.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: moonafterrain@outlook.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH v2] ALSA: wavefront: use scnprintf for longname construction
In-Reply-To: <SYBPR01MB7881987D79C62D8122B655FEAFC6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881987D79C62D8122B655FEAFC6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Sun, 02 Nov 2025 16:32:39 +0100,
moonafterrain@outlook.com wrote:
> 
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> Replace sprintf() calls with scnprintf() and a new scnprintf_append()
> helper function when constructing card->longname. This improves code
> readability and provides bounds checking for the 80-byte buffer.
> 
> While the current parameter ranges don't cause overflow in practice,
> using safer string functions follows kernel best practices and makes
> the code more maintainable.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> Changes in v2:
> - Replace sprintf() calls with scnprintf() and a new scnprintf_append()
> - Link to v1: https://lore.kernel.org/all/ME2PR01MB3156CEC4F31F253C9B540FB7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com/

Well, my suggestion was that we can apply such conversions once if a
*generic* helper becomes available; that is, propose
scnprintf_append() to be put in include/linux/string.h or whatever (I
guess better in *.c instead of inline), and once if it's accepted, we
can convert the relevant places (there are many, not only
wavefront.c).

BTW:

> +__printf(3, 4) static int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
> +{
> +	va_list args;
> +	size_t len = strlen(buf);
> +
> +	if (len >= size)
> +		return len;
> +	va_start(args, fmt);
> +	len = vscnprintf(buf + len, size - len, fmt, args);
> +	va_end(args);
> +	return len;

The above should be
	len += vscnprintf(buf + len, size - len, fmt, args);
so that it returns the full size of the string.
If it were in user-space, I'd check a negative error code, but the
Linux kernel implementation doesn't return a negative error code, so
far.
I see it's a copy from a code snipped I suggested which already
contained the error :)

Also, it might be safer to use strnlen() instead of strlen() for
avoiding a potential out-of-bound access.


thanks,

Takashi

