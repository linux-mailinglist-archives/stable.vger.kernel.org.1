Return-Path: <stable+bounces-181808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D6BA5A8C
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 10:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70DA07A80D5
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B22D47EB;
	Sat, 27 Sep 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="El7ns55z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bOacy+82";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="El7ns55z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bOacy+82"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10B1991B6
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758960102; cv=none; b=N1ZlOaOyXaS4H94NwEuA71zuUGvAbQptzdFpEvDx8HMRQjpQFBAd7Sur9HKKaXGCcx+WoneudZc2jhksxU0+XnYgniHQXgKrd1fMFM+KgvWKDAtcQ6tzq6glqV7zzk4syiwGche18RMDxQLHFj+j9IcF8JsSM03BnZ9usaLDFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758960102; c=relaxed/simple;
	bh=k+kz3Nc+eDlceMTimw5EzQubZir6VkJWZHkOlNeBgH0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jo5RC9GLlBKH7D603nS7+XN2XxMVXQECqbPe9PT3nynzhJnmMOnNoPW39INPqWgieuy/8DkkGuXI50TOBgwDhU9summsaMFSJrvheudpxCw3/q/VkUSbNcEc5I9ZNQx4CDyvujdxEOhXhWF4Qqn+D3krBO7oULqJKvjoYbVdbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=El7ns55z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bOacy+82; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=El7ns55z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bOacy+82; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44A5E68038;
	Sat, 27 Sep 2025 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758960098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xc47Zb/Ba3WS3bvGHkFpKH7YsU0ppNHclLeiVIV0PXk=;
	b=El7ns55zbkgNLolo7MBIQtAL1dSEYv+WHbhtFt4Dw3zn6EZ0G+xavjELJrYXHnhYwmF5BZ
	jriXuN0ZMULzlYuNrYKz9CzMRmC4FZljjYXZuY0CiT2e5Xu4czqSGNTaJh52wE1VMNVVLu
	ud48xwssA5GZgFKuspWl4muhFzhQIqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758960098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xc47Zb/Ba3WS3bvGHkFpKH7YsU0ppNHclLeiVIV0PXk=;
	b=bOacy+82XyLKWXlqiJxFxtWcR/s/mY7ao7UBB3dNlTTnSUQQW2e+Xlq6wpjMCbWaQabxuD
	M0+v6N8ga4HChfBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=El7ns55z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bOacy+82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758960098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xc47Zb/Ba3WS3bvGHkFpKH7YsU0ppNHclLeiVIV0PXk=;
	b=El7ns55zbkgNLolo7MBIQtAL1dSEYv+WHbhtFt4Dw3zn6EZ0G+xavjELJrYXHnhYwmF5BZ
	jriXuN0ZMULzlYuNrYKz9CzMRmC4FZljjYXZuY0CiT2e5Xu4czqSGNTaJh52wE1VMNVVLu
	ud48xwssA5GZgFKuspWl4muhFzhQIqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758960098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xc47Zb/Ba3WS3bvGHkFpKH7YsU0ppNHclLeiVIV0PXk=;
	b=bOacy+82XyLKWXlqiJxFxtWcR/s/mY7ao7UBB3dNlTTnSUQQW2e+Xlq6wpjMCbWaQabxuD
	M0+v6N8ga4HChfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01F4113782;
	Sat, 27 Sep 2025 08:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sq6AOuGZ12hRMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 08:01:37 +0000
Date: Sat, 27 Sep 2025 10:01:37 +0200
Message-ID: <87bjmwb9y6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jeongjun Park <aha310510@gmail.com>
Cc: clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
In-Reply-To: <20250927044106.849247-1-aha310510@gmail.com>
References: <20250927044106.849247-1-aha310510@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 44A5E68038
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Sat, 27 Sep 2025 06:41:06 +0200,
Jeongjun Park wrote:
> 
> The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
> removal") patched a UAF issue caused by the error timer.
> 
> However, because the error timer kill added in this patch occurs after the
> endpoint delete, a race condition to UAF still occurs, albeit rarely.
> 
> Therefore, to prevent this, the error timer must be killed before freeing
> the heap memory.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

I suppose it's a fix for the recent syzbot reports?
  https://lore.kernel.org/68d17f44.050a0220.13cd81.05b7.GAE@google.com
  https://lore.kernel.org/68d38327.a70a0220.1b52b.02be.GAE@google.com

I had the very same fix in mind, as posted in
  https://lore.kernel.org/87plbhn16a.wl-tiwai@suse.de
so I'll happily apply if that's the case (and it was verified to
work).  I'm just back from vacation and trying to catch up things.


thanks,

Takashi

> ---
>  sound/usb/midi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index acb3bf92857c..8d15f1caa92b 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -1522,6 +1522,8 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
>  {
>  	int i;
>  
> +	timer_shutdown_sync(&umidi->error_timer);
> +
>  	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
>  		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
>  		if (ep->out)
> @@ -1530,7 +1532,6 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
>  			snd_usbmidi_in_endpoint_delete(ep->in);
>  	}
>  	mutex_destroy(&umidi->mutex);
> -	timer_shutdown_sync(&umidi->error_timer);
>  	kfree(umidi);
>  }
>  
> --

