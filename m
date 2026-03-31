Return-Path: <stable+bounces-231433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LlAOJHby2lHMAYAu9opvQ
	(envelope-from <stable+bounces-231433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:34:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9BD36B091
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C1673017A9A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9B3E1202;
	Tue, 31 Mar 2026 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LJUu95iO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SMIi5VxY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LJUu95iO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SMIi5VxY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC23DDDC5
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967282; cv=none; b=oodqKVvykHqgCtekYqL/sMjQPxvskg2je4ZIStE5txl/1WRTiVcbYMtOAhwSNpvKZ4b1WcOmWN3XwHFKO1ImrxEKPXoKq/0cq60xz9kGZCv1n33v0DJRbBYgSXj3c7Tj2ZZxJrcJAcVNddavx7fVYIkp/nZQv2sbrRm0Q+jbyjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967282; c=relaxed/simple;
	bh=PDKzth9NTSFtxwfqtK3w5HCs2MPn+cP59Rr0qDNleqI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3Eh3gURI68y9jRWmAyueBn5o6sFWvQXq8j/a9/XqGBKd1f5+PDbJAKQKWe0JcRaGGbxd4whsRudSKpXdkbOE8OIog6lhmsVTOvqyMTv5zlYv8vkIHKIzj4jAmC3PQ2xr6ruGWqxwxi1qSinFCrePv4giU0UCofiq2D8AYh6HVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LJUu95iO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SMIi5VxY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LJUu95iO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SMIi5VxY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7ABAD4D27D;
	Tue, 31 Mar 2026 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774967279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	b=LJUu95iOK+E2XRq+yk9t2EWvbAHiuhyYgcdHQ8SKUrK8k/0jqIChVxbA4162VvBErm3cSx
	Z7gMVIciNgXODHAzxlnREGJ9GlP65V7+i9FaKWpG6nsMh7iqhlE7cuOKYXLFE6AgaP8xkz
	7iliEMeS+K9J2QzZNf7jJJOx3Oprlbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774967279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	b=SMIi5VxYppR2hqgelmmhmlr14VloaOgLpuDKNZJJnSEeKi6nDBgberrVHgX9wfVxCKysim
	0ndmqMiMHCKgePCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774967279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	b=LJUu95iOK+E2XRq+yk9t2EWvbAHiuhyYgcdHQ8SKUrK8k/0jqIChVxbA4162VvBErm3cSx
	Z7gMVIciNgXODHAzxlnREGJ9GlP65V7+i9FaKWpG6nsMh7iqhlE7cuOKYXLFE6AgaP8xkz
	7iliEMeS+K9J2QzZNf7jJJOx3Oprlbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774967279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HqKpU3qn80efCu2LyflGJS5zncivPfp3CASz23aZ0M=;
	b=SMIi5VxYppR2hqgelmmhmlr14VloaOgLpuDKNZJJnSEeKi6nDBgberrVHgX9wfVxCKysim
	0ndmqMiMHCKgePCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56E084A0A2;
	Tue, 31 Mar 2026 14:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kZJtFO/Zy2kUGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 31 Mar 2026 14:27:59 +0000
Date: Tue, 31 Mar 2026 16:27:51 +0200
Message-ID: <878qb8rs48.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
In-Reply-To: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
References: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-231433-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF9BD36B091
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 00:27:28 +0200,
Cássio Gabriel wrote:
> 
> The i2sbus PCM code uses pi->active to constrain the sibling stream to
> an already prepared duplex format and rate in i2sbus_pcm_open().
> 
> That state is set from i2sbus_pcm_prepare(), but the current code only
> clears it on close. As a result, the sibling stream can inherit stale
> constraints after the prepared state has been torn down, or after a new
> prepare attempt fails before completing.
> 
> Clear pi->active when hw_params() or hw_free() drops the prepared state,
> clear it before starting a new prepare attempt, and set it again only
> after prepare succeeds.
> 
> Replace the stale FIXME in the duplex constraint comment with
> a description of the current driver behavior: i2sbus still programs a
> single shared transport configuration for both directions, so mixed
> formats are not supported in duplex mode.
> 
> Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
>  sound/aoa/soundbus/i2sbus/pcm.c | 53 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
> index 97c807e67d56..47a89da43cff 100644
> --- a/sound/aoa/soundbus/i2sbus/pcm.c
> +++ b/sound/aoa/soundbus/i2sbus/pcm.c
> @@ -165,17 +165,16 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
>  	 * currently in use (if any). */
>  	hw->rate_min = 5512;
>  	hw->rate_max = 192000;
> -	/* if the other stream is active, then we can only
> -	 * support what it is currently using.
> -	 * FIXME: I lied. This comment is wrong. We can support
> -	 * anything that works with the same serial format, ie.
> -	 * when recording 24 bit sound we can well play 16 bit
> -	 * sound at the same time iff using the same transfer mode.
> +	/* If the other stream is already prepared, keep this stream
> +	 * on the same duplex format and rate.
> +	 *
> +	 * i2sbus_pcm_prepare() still programs one shared transport
> +	 * configuration for both directions, so mixed duplex formats
> +	 * are not supported here.
>  	 */
>  	if (other->active) {
> -		/* FIXME: is this guaranteed by the alsa api? */
>  		hw->formats &= pcm_format_to_bits(i2sdev->format);
> -		/* see above, restrict rates to the one we already have */
> +		/* Restrict rates to the one already in use. */
>  		hw->rate_min = i2sdev->rate;
>  		hw->rate_max = i2sdev->rate;
>  	}
> @@ -283,6 +282,22 @@ void i2sbus_wait_for_stop_both(struct i2sbus_dev *i2sdev)
>  }
>  #endif
>  
> +static void i2sbus_pcm_clear_active(struct i2sbus_dev *i2sdev, int in)
> +{
> +	struct pcm_info *pi;
> +
> +	guard(mutex)(&i2sdev->lock);
> +
> +	get_pcm_info(i2sdev, in, &pi, NULL);
> +	pi->active = 0;
> +}
> +
> +static inline int i2sbus_hw_params(struct snd_pcm_substream *substream, int in)
> +{
> +	i2sbus_pcm_clear_active(snd_pcm_substream_chip(substream), in);
> +	return 0;
> +}
> +
>  static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
>  {
>  	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
> @@ -291,14 +306,25 @@ static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
>  	get_pcm_info(i2sdev, in, &pi, NULL);
>  	if (pi->dbdma_ring.stopping)
>  		i2sbus_wait_for_stop(i2sdev, pi);
> +	i2sbus_pcm_clear_active(i2sdev, in);
>  	return 0;
>  }
>  
> +static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream)
> +{
> +	return i2sbus_hw_params(substream, 0);
> +}
> +
>  static int i2sbus_playback_hw_free(struct snd_pcm_substream *substream)
>  {
>  	return i2sbus_hw_free(substream, 0);
>  }
>  
> +static int i2sbus_record_hw_params(struct snd_pcm_substream *substream)
> +{
> +	return i2sbus_hw_params(substream, 1);
> +}
> +
>  static int i2sbus_record_hw_free(struct snd_pcm_substream *substream)
>  {
>  	return i2sbus_hw_free(substream, 1);
> @@ -335,7 +361,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
>  		return -EINVAL;
>  
>  	runtime = pi->substream->runtime;
> -	pi->active = 1;
> +	pi->active = 0;
>  	if (other->active &&
>  	    ((i2sdev->format != runtime->format)
>  	     || (i2sdev->rate != runtime->rate)))

Do we need to clear the active flag here?  It must have been cleared
by hw_params call.  Or is it the case for errors?


thanks,

Takashi

