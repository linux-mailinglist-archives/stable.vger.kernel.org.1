Return-Path: <stable+bounces-240636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE5pFs5Q62nkKwAAu9opvQ
	(envelope-from <stable+bounces-240636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:15:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA845D923
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 891CB301739B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320223A782B;
	Fri, 24 Apr 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D3jfUd/t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="84FQ/nvP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gDdi5fNF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L/+SVR0p"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FB392835
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029276; cv=none; b=lKkLYmEkGGtB+vpujyIZ8s0s4RDnfjaej7/0LW2O70k9yQQWTqq+nRahkAvHnDzFsIAtRW/BB2xYWtdFMv47xUfxcPwvX0h8/njFY8noM689E/ekW+oYR1yLEB0U5UpY2tv0TTAZlgKpDhHQUZ8/CmCnRBG4KvdXxAj73mbTACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029276; c=relaxed/simple;
	bh=ZKT1sepTKpW1nMj55n6arlBlwYJl1MbxTNrlOijCGKI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuKjCN+hx4wbpTkaToNd7FDErzHY/4le0BjYKj+wWJD1Wk+wZAgUe8OSh1ZRr3/EGg9cfMmf0eUJOXxJxFvs2dlF4KrnFYN/A+nzwcNhbzyu2HkaG+1J33GMrrm3vBDVnkNCpd7RTFAWTG0ppBT84DkdL/EUrNKasakWZDt5xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D3jfUd/t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=84FQ/nvP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gDdi5fNF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L/+SVR0p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01C835BCC1;
	Fri, 24 Apr 2026 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777029272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3WuoMBtZgKp11lsvEXRtxuakMMlf6c4sL4ohllFrsg=;
	b=D3jfUd/tg78rLjzZCObeKbSJYwIqSSGQgMIQVMPpV+fyIm0U3LSLsVGtuwOHHmhcH+q/pk
	SPo5y4rX6jklW29abfRqWglO7GU17ZztVq83tZkjfVJIeWZVqNu9m3uqELlWrPmtmreinW
	3IjPV5c78GThIqGmJndZtCpE1FpL5rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777029272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3WuoMBtZgKp11lsvEXRtxuakMMlf6c4sL4ohllFrsg=;
	b=84FQ/nvPmiqyhaQYlmsDWXG7d16QwjS5HlaHKZqbDSiO0VCiODKUweJjGj1YGJaV/9U0fd
	2yO4OpMbjW0rJqBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777029268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3WuoMBtZgKp11lsvEXRtxuakMMlf6c4sL4ohllFrsg=;
	b=gDdi5fNFFJZoHktnZD4bO5qbfx/rrpU1ECDu+JFCw6jCGuzwedaqeb8NHD7mTZu0x6T0uH
	UpnlJuUvc4u+pbyHjqd5EYZzQ0bJiUY10kmu3rRRgr6WX3vcG1GFnwwCUKRHEfbFmsKHrm
	ZNoOMXY9a85up/NjzrmoRMq2nLpWBfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777029268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3WuoMBtZgKp11lsvEXRtxuakMMlf6c4sL4ohllFrsg=;
	b=L/+SVR0pi2db4992cdcFdITOmEWIwF/2++G2wRF3gJSVjx0PSR+RKDN6nj8gEool5vuUe3
	BfRpwpDhDI8gErBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF1EA593A4;
	Fri, 24 Apr 2026 11:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6uZKLZNQ62kGLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 24 Apr 2026 11:14:27 +0000
Date: Fri, 24 Apr 2026 13:14:27 +0200
Message-ID: <87se8k1ugc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: aloop: Fix peer runtime UAF during format-change stop
In-Reply-To: <20260423-alsa-aloop-peer-stop-uaf-v1-1-25d8a9745f6c@gmail.com>
References: <20260423-alsa-aloop-peer-stop-uaf-v1-1-25d8a9745f6c@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 1AAA845D923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-240636-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,8fa95c41eafbc9d2ff6f];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Thu, 23 Apr 2026 05:22:22 +0200,
Cássio Gabriel wrote:
> 
> loopback_check_format() may stop the capture side when playback starts
> with parameters that no longer match a running capture stream. Commit
> 826af7fa62e3 ("ALSA: aloop: Fix racy access at PCM trigger") moved
> the peer lookup under cable->lock, but the actual snd_pcm_stop() still
> runs after dropping that lock.
> 
> A concurrent close can clear the capture entry from cable->streams[] and
> detach or free its runtime while the playback trigger path still holds a
> stale peer substream pointer.
> 
> Keep a per-cable count of in-flight peer stops before dropping
> cable->lock, make free_cable() wait for those stops before detaching the
> runtime, and take the peer stream lock around snd_pcm_stop(). This
> preserves the existing behavior while making the peer runtime lifetime
> explicit.
> 
> Reported-by: syzbot+8fa95c41eafbc9d2ff6f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8fa95c41eafbc9d2ff6f
> Fixes: 597603d615d2 ("ALSA: introduce the snd-aloop module for the PCM loopback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
>  sound/drivers/aloop.c | 56 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
> index aa0d2fcb1a18..a997ee262740 100644
> --- a/sound/drivers/aloop.c
> +++ b/sound/drivers/aloop.c
> @@ -99,6 +99,9 @@ struct loopback_ops {
>  struct loopback_cable {
>  	spinlock_t lock;
>  	struct loopback_pcm *streams[2];
> +	/* in-flight peer stops running outside cable->lock */
> +	atomic_t stop_count;
> +	wait_queue_head_t stop_wait;
>  	struct snd_pcm_hardware hw;
>  	/* flags */
>  	unsigned int valid;
> @@ -337,10 +340,10 @@ static bool is_access_interleaved(snd_pcm_access_t access)
>  static int loopback_check_format(struct loopback_cable *cable, int stream)
>  {
>  	struct loopback_pcm *dpcm_play, *dpcm_capt;
> +	struct loopback_pcm *stop_dpcm = NULL;
>  	struct snd_pcm_runtime *runtime, *cruntime;
>  	struct loopback_setup *setup;
>  	struct snd_card *card;
> -	bool stop_capture = false;
>  	int check;
>  
>  	scoped_guard(spinlock_irqsave, &cable->lock) {
> @@ -366,8 +369,11 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
>  				return 0;
>  			if (stream == SNDRV_PCM_STREAM_CAPTURE)
>  				return -EIO;
> -			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING)
> -				stop_capture = true;
> +			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING) {
> +				/* close must not free the peer runtime below */
> +				atomic_inc(&cable->stop_count);
> +				stop_dpcm = dpcm_capt;
> +			}
>  		}
>  
>  		setup = get_setup(dpcm_play);
> @@ -396,8 +402,18 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
>  		}
>  	}
>  
> -	if (stop_capture)
> -		snd_pcm_stop(dpcm_capt->substream, SNDRV_PCM_STATE_DRAINING);
> +	if (stop_dpcm) {
> +		struct snd_pcm_substream *stop_substream = stop_dpcm->substream;
> +		unsigned long flags;
> +
> +		snd_pcm_stream_lock_irqsave_nested(stop_substream, flags);
> +		if (stop_substream->runtime && snd_pcm_running(stop_substream))
> +			snd_pcm_stop(stop_substream, SNDRV_PCM_STATE_DRAINING);
> +		snd_pcm_stream_unlock_irqrestore(stop_substream, flags);
> +
> +		if (atomic_dec_and_test(&cable->stop_count))
> +			wake_up(&cable->stop_wait);
> +	}

Do we need to complicate this handling?  IOW, can it be simply be like
below?

	if (stop_capture) {
		snd_pcm_stop(dpcm_capt->substream, SNDRV_PCM_STATE_DRAINING);
		if (atomic_dec_and_test(&cable->stop_count))
			wake_up(&cable->stop_wait);
	}


thanks,

Takashi

