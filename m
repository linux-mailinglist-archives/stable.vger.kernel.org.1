Return-Path: <stable+bounces-191517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE2FC15F5A
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1583A3A60AF
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182B8343218;
	Tue, 28 Oct 2025 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KzppxNT8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ec1Wl7uf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="grn9GMr4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vppjhsK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F5340DBB
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670004; cv=none; b=BQYNXS7ktD15rpDI3YkHMWdpmSuQQUGWHf5+ZssIJQqB41d/l1aL1Ll72kJTHRlGbPPUAm8xjEtkl0GAHjLjyYfWheQ9M9/3G7eiwJ6b2jgWqDQpCYzi0RPqFnNsxb+Dz93GzhTwgKmOa0fJE7WGDd4znGdhjHFSp7xUZnRU2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670004; c=relaxed/simple;
	bh=p0buOOP4+PhXerrHCnNjXdrU+sJnFopkOp/94saSrlU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUkzjifDLNReYTdd8hC2MLAlt0UF5w+mM2/8fkdaextwJwAlXDbOsEA7+siB9jGwVsoQvoMBDljOZ5f+jwW1S3e4L2d8ODiSfRJt4QNp3S9OaXmfgMxxWDqUgE5LTGfhk/FrnXxpt96UWBtAJa6/NunuDwv8IqCJJqeAn/Lc6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KzppxNT8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ec1Wl7uf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=grn9GMr4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vppjhsK0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1C6A1F460;
	Tue, 28 Oct 2025 16:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761670001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tURTOTmAX96NrUuKLC7yzYM8Gc4Vkf8BrHIXVI2ctSI=;
	b=KzppxNT8GvSjVSjWmLfN1eObhaNw4C1yjNkwSgr2UZkEk1X8ttZaM8bofWj2EPodifnvZo
	9CmULugVuZAicdFHPEfabBzwq9fu7k+QbFAMqnthErK3sBIPS54NiqekCLqEtrvjloaSAN
	EMWzxmV4NVw/ELhT80VAuk4ljfaVBXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761670001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tURTOTmAX96NrUuKLC7yzYM8Gc4Vkf8BrHIXVI2ctSI=;
	b=ec1Wl7ufERjeeGS074TAkXqhLNIpC2bBbnfd6tfOAJPfHhiUcidGN2Gp3xSgygdtWGnzgT
	loQ0TKRxKyrWqECQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761670000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tURTOTmAX96NrUuKLC7yzYM8Gc4Vkf8BrHIXVI2ctSI=;
	b=grn9GMr44vxVVfb7zD3HpnH9SGgAvHAOVHYOqVX+N1vOT0NeISSXQIffwTdVboRmdw1wFn
	ry7ydooE9GBWSh/Wz6Yar9u18iSKufHwo3pL3l0L4oJMQlkBmfcpYF1phMGas+Is4XyaWt
	72upRk6Xzer9aoinoXTzOGzI+m17+oU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761670000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tURTOTmAX96NrUuKLC7yzYM8Gc4Vkf8BrHIXVI2ctSI=;
	b=vppjhsK0uS6oHmFTKeXc5hOZjTzFXFjRXc60dRjbeBuP/fmJwW55CQvf9RdABwSOXY0npK
	UolmMzBBWC4MlOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB24D13A8E;
	Tue, 28 Oct 2025 16:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c61qLHDzAGlHKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 28 Oct 2025 16:46:40 +0000
Date: Tue, 28 Oct 2025 17:46:40 +0100
Message-ID: <87ikfzezyn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: moonafterrain@outlook.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] ALSA: wavefront: fix buffer overflow in longname construction
In-Reply-To: <ME2PR01MB3156CEC4F31F253C9B540FB7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com>
References: <ME2PR01MB3156CEC4F31F253C9B540FB7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 28 Oct 2025 17:26:43 +0100,
moonafterrain@outlook.com wrote:
> 
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> The snd_wavefront_probe() function constructs the card->longname string
> using unsafe sprintf() calls that can overflow the 80-byte buffer when
> module parameters contain large values.
> 
> The vulnerability exists at wavefront.c where multiple sprintf()
> operations append to card->longname without length checking.
> 
> Fix by replacing all sprintf() calls with scnprintf() and proper length
> tracking to ensure writes never exceed sizeof(card->longname).
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  sound/isa/wavefront/wavefront.c | 40 ++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
> index 07c68568091d..74ea3a67620c 100644
> --- a/sound/isa/wavefront/wavefront.c
> +++ b/sound/isa/wavefront/wavefront.c
> @@ -343,6 +343,7 @@ snd_wavefront_probe (struct snd_card *card, int dev)
>  	struct snd_rawmidi *ics2115_external_rmidi = NULL;
>  	struct snd_hwdep *fx_processor;
>  	int hw_dev = 0, midi_dev = 0, err;
> +	size_t len, rem;
>  
>  	/* --------- PCM --------------- */
>  
> @@ -492,26 +493,35 @@ snd_wavefront_probe (struct snd_card *card, int dev)
>  	   length restrictions
>  	*/
>  
> -	sprintf(card->longname, "%s PCM 0x%lx irq %d dma %d",
> -		card->driver,
> -		chip->port,
> -		cs4232_pcm_irq[dev],
> -		dma1[dev]);
> +	len = scnprintf(card->longname, sizeof(card->longname),
> +			"%s PCM 0x%lx irq %d dma %d",
> +			card->driver,
> +			chip->port,
> +			cs4232_pcm_irq[dev],
> +			dma1[dev]);
>  
> -	if (dma2[dev] >= 0 && dma2[dev] < 8)
> -		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
> +	if (dma2[dev] >= 0 && dma2[dev] < 8 && len < sizeof(card->longname)) {
> +		rem = sizeof(card->longname) - len;
> +		len += scnprintf(card->longname + len, rem, "&%d", dma2[dev]);
> +	}
>  
>  	if (cs4232_mpu_port[dev] > 0 && cs4232_mpu_port[dev] != SNDRV_AUTO_PORT) {
> -		sprintf (card->longname + strlen (card->longname), 
> -			 " MPU-401 0x%lx irq %d",
> -			 cs4232_mpu_port[dev],
> -			 cs4232_mpu_irq[dev]);
> +		if (len < sizeof(card->longname)) {
> +			rem = sizeof(card->longname) - len;
> +			len += scnprintf(card->longname + len, rem,
> +					 " MPU-401 0x%lx irq %d",
> +					 cs4232_mpu_port[dev],
> +					 cs4232_mpu_irq[dev]);
> +		}
>  	}
>  
> -	sprintf (card->longname + strlen (card->longname), 
> -		 " SYNTH 0x%lx irq %d",
> -		 ics2115_port[dev],
> -		 ics2115_irq[dev]);
> +	if (len < sizeof(card->longname)) {
> +		rem = sizeof(card->longname) - len;
> +		scnprintf(card->longname + len, rem,
> +			  " SYNTH 0x%lx irq %d",
> +			  ics2115_port[dev],
> +			  ics2115_irq[dev]);
> +	}
>  
>  	return snd_card_register(card);
>  }	

Thanks for the patch.  But the code change is way too complex for the
gain it can have.

There can't be any overflow in the current code as is, because the
buffer size is large enough.  snd_card.longname[] is 80 bytes, hence
even if you count all other fields, it can't overflow, practically
seen.

If the code change were trivial, such a fix would still make sense.
But the proposed patch makes the code just harder to understand and
more error-prone.

If you're still interested in "fixing" such cases, I guess we may
introduce a new helper to append a format string, e.g.

int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
{
	va_list args;
	size_t len = strlen(buf);

	if (len >= size)
		return len;
	va_start(args, fmt);
	len = vscnprintf(buf + len, size - len, fmt, args);
	va_end(args);
	return len;
}

Then the rest change would be really trivial, just to replace the
snprintf(buf + strlen()) with this new function call.  There seem many
other codes doing the similar things, and they can be replaced
gracefully, too.


thanks,

Takashi

