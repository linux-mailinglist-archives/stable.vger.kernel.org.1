Return-Path: <stable+bounces-192485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B02FC34838
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 09:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20EA24E9558
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DFD2D640A;
	Wed,  5 Nov 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Im6GYJFp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="39kiMXuo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Im6GYJFp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="39kiMXuo"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1F2C325F
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332068; cv=none; b=GgCwx5G8mZR67U/U9K0lgCwBSubjNbLJI1m5TDqSvtpgjfdWiB6NeKVy1DNYpwGJOKoR78acjnC04H2gkRcNGSKPnyV5m4V6ECNdYjKWJrmfEtCwkhvV6hKztNeUZOcBV/8tHHmtubf10C0GMBzuRv1glbEEr+b5dq2U+IpHlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332068; c=relaxed/simple;
	bh=p2IE8S5iu4o1eFXTxW5Ox2xSl7vHnJRt8M6JCIv+LKQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLZvA1Hp3WhOeYy/74zhaXqmgJkKCQXeuUBthqj1kdtUQuYCQETh1rY02rui6JzEmg/8sgy3QtMviJ0mezlpEvo160TRKUCmk6vonlwviu2KlgaqTrdrSfyYEG8MVNQC/E75VgH0cryQtCZUNetDhHn29cwm5CtbdO7SvwGu64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Im6GYJFp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=39kiMXuo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Im6GYJFp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=39kiMXuo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2859221157;
	Wed,  5 Nov 2025 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762332065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSMYe//EOTaLznd/zZzMEH7S+N9AWhw/FeUS4JtYOjk=;
	b=Im6GYJFpEjVy3aqg9Yy+ZYQTt6MhUfSr2oNkIczxDasVmCXUJ8u8fRN+K32jUQeKIDLU/a
	adasQF9ELp4MwRS8NfHfVkY/+t+jNBsmazMeWPJoPXp+OlivmotpUy33FfoBNTosKsc8vt
	UzQuTPDW/e6zzxnPHuz5lxjzx44OidI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762332065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSMYe//EOTaLznd/zZzMEH7S+N9AWhw/FeUS4JtYOjk=;
	b=39kiMXuojVbZHzl+l0O1pOzhSjUcMY7v02uLiUY6ESmjQo5TtT9J2zbmq5jwk1+vv23bQb
	9UyF7TOEokNBpsDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762332065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSMYe//EOTaLznd/zZzMEH7S+N9AWhw/FeUS4JtYOjk=;
	b=Im6GYJFpEjVy3aqg9Yy+ZYQTt6MhUfSr2oNkIczxDasVmCXUJ8u8fRN+K32jUQeKIDLU/a
	adasQF9ELp4MwRS8NfHfVkY/+t+jNBsmazMeWPJoPXp+OlivmotpUy33FfoBNTosKsc8vt
	UzQuTPDW/e6zzxnPHuz5lxjzx44OidI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762332065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSMYe//EOTaLznd/zZzMEH7S+N9AWhw/FeUS4JtYOjk=;
	b=39kiMXuojVbZHzl+l0O1pOzhSjUcMY7v02uLiUY6ESmjQo5TtT9J2zbmq5jwk1+vv23bQb
	9UyF7TOEokNBpsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9A7713699;
	Wed,  5 Nov 2025 08:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t9/GN6ANC2koawAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Nov 2025 08:41:04 +0000
Date: Wed, 05 Nov 2025 09:41:04 +0100
Message-ID: <87qzuchnxb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: moonafterrain@outlook.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] ALSA: wavefront: Fix use-after-free in MIDI operations
In-Reply-To: <SYBPR01MB78812BAD18C71593392C2C31AFC4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB78812BAD18C71593392C2C31AFC4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Level: 

On Tue, 04 Nov 2025 15:11:55 +0100,
moonafterrain@outlook.com wrote:
> 
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> Clear substream pointers in close functions to prevent use-after-free
> when timer callbacks or interrupt handlers access them after close.

There can be no actual access done because MPU401_MODE_INPUT_TRIGGER
is guaranteed to be off before closing the stream.  That is, the
variable stream is assigned to an old pointer, but it's not accessed.
So, this is not really a use-after-free bug, per se.

Other than that, the fix itself looks good.  Please resubmit after
rephrasing the patch description.


thanks,

Takashi


> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  sound/isa/wavefront/wavefront_midi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
> index 1250ecba659a..69d87c4cafae 100644
> --- a/sound/isa/wavefront/wavefront_midi.c
> +++ b/sound/isa/wavefront/wavefront_midi.c
> @@ -278,6 +278,7 @@ static int snd_wavefront_midi_input_close(struct snd_rawmidi_substream *substrea
>  	        return -EIO;
>  
>  	guard(spinlock_irqsave)(&midi->open);
> +	midi->substream_input[mpu] = NULL;
>  	midi->mode[mpu] &= ~MPU401_MODE_INPUT;
>  
>  	return 0;
> @@ -300,6 +301,7 @@ static int snd_wavefront_midi_output_close(struct snd_rawmidi_substream *substre
>  	        return -EIO;
>  
>  	guard(spinlock_irqsave)(&midi->open);
> +	midi->substream_output[mpu] = NULL;
>  	midi->mode[mpu] &= ~MPU401_MODE_OUTPUT;
>  	return 0;
>  }
> -- 
> 2.51.1.dirty
> 

