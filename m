Return-Path: <stable+bounces-47735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C28D5257
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 21:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C6B230B9
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0697914F127;
	Thu, 30 May 2024 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gLJ6hgi/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NVF6t27i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gLJ6hgi/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NVF6t27i"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555214F10E
	for <stable@vger.kernel.org>; Thu, 30 May 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097425; cv=none; b=VU0ilC9tGOWm2oIQRPZbf38kZWELaxe0WMZwIJFPzNSu4k4t6SewfsZ5RWaZaoooKsZfWGr0gg+e5H8hxQRcoYsmkTF6OZJQmGp6EIjHad4L+9L5nUM1MEK4OPXx/ZMd6Q+YBXWHL5y31AZtPlftOvbtrOrWe3n/n54/gGRhhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097425; c=relaxed/simple;
	bh=CvEeMLD+F1nYWjzrfHtPoh+GCEPDGDWjTymr9Vbk6z0=;
	h=Date:Message-ID:From:To:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAOemKLtta925G84D/zemz/8Ux+S5qOtbbA/OZ9VkWNcyNOMUTcSCBS0NnHj5yMXXjn7PgPB4VNzjOM764MgNG8fR/iGnowXvkt21Zmb3gNzqiwenw3U/AyMMcyj2ZKSLDaQUsGYIwxO2ZGLdgNoVPpioxg9MXmK0PioBCeT0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gLJ6hgi/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NVF6t27i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gLJ6hgi/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NVF6t27i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1611E1F450
	for <stable@vger.kernel.org>; Thu, 30 May 2024 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717097420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eIKb7E9gI2DXExLP5PQ4yhTN3dwcSgYJY6ZO1XncNCk=;
	b=gLJ6hgi/+P+EP3sSFGTlCgzT7IrxmfdmUryWosVYxUSpnn5KtRfkO3ztz6a9yYU7giT5yD
	tHJY+evkK4biljC1nqqx6YtWf9Yc6aM5SQbE8QE/NM1jUYKP0Z2MYsZZgL2cf5XOOaY0ON
	eRMzWw3oeYTe0/488BCNttikFhvt/p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717097420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eIKb7E9gI2DXExLP5PQ4yhTN3dwcSgYJY6ZO1XncNCk=;
	b=NVF6t27iw+xQ/QH+u7hUlBcgSAKWpB5jxK4dKoihyVBDz69ZkeckP00lZYrn33zU38oNU6
	iwp1/9/8QFdG96CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="gLJ6hgi/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NVF6t27i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717097420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eIKb7E9gI2DXExLP5PQ4yhTN3dwcSgYJY6ZO1XncNCk=;
	b=gLJ6hgi/+P+EP3sSFGTlCgzT7IrxmfdmUryWosVYxUSpnn5KtRfkO3ztz6a9yYU7giT5yD
	tHJY+evkK4biljC1nqqx6YtWf9Yc6aM5SQbE8QE/NM1jUYKP0Z2MYsZZgL2cf5XOOaY0ON
	eRMzWw3oeYTe0/488BCNttikFhvt/p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717097420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eIKb7E9gI2DXExLP5PQ4yhTN3dwcSgYJY6ZO1XncNCk=;
	b=NVF6t27iw+xQ/QH+u7hUlBcgSAKWpB5jxK4dKoihyVBDz69ZkeckP00lZYrn33zU38oNU6
	iwp1/9/8QFdG96CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3DFE13A42
	for <stable@vger.kernel.org>; Thu, 30 May 2024 19:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w97DOcvTWGZ5PAAAD6G6ig
	(envelope-from <tiwai@suse.de>)
	for <stable@vger.kernel.org>; Thu, 30 May 2024 19:30:19 +0000
Date: Thu, 30 May 2024 21:30:41 +0200
Message-ID: <87zfs714im.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: stable@vger.kernel.org
Subject: Re: Patch "ALSA: timer: Set lower bound of start tick time" has been added to the 6.8-stable tree
In-Reply-To: <20240530190237.17492-1-sashal@kernel.org>
References: <20240530190237.17492-1-sashal@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[stable@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1611E1F450
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Thu, 30 May 2024 21:02:36 +0200,
Sasha Levin wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     ALSA: timer: Set lower bound of start tick time
> 
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      alsa-timer-set-lower-bound-of-start-tick-time.patch
> and it can be found in the queue-6.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this one for 6.8 and older (you posted for 6.6 too).
As already explained in another mail, this commit needs a prerequisite
use of guard().

An alternative patch has been already submitted.  Take it instead:
  https://lore.kernel.org/all/20240527062431.18709-1-tiwai@suse.de/


thanks,

Takashi


> 
> 
> 
> commit d717dbdb94145bee1e9cf9eca387d973564203c4
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Tue May 14 20:27:36 2024 +0200
> 
>     ALSA: timer: Set lower bound of start tick time
>     
>     [ Upstream commit 4a63bd179fa8d3fcc44a0d9d71d941ddd62f0c4e ]
>     
>     Currently ALSA timer doesn't have the lower limit of the start tick
>     time, and it allows a very small size, e.g. 1 tick with 1ns resolution
>     for hrtimer.  Such a situation may lead to an unexpected RCU stall,
>     where  the callback repeatedly queuing the expire update, as reported
>     by fuzzer.
>     
>     This patch introduces a sanity check of the timer start tick time, so
>     that the system returns an error when a too small start size is set.
>     As of this patch, the lower limit is hard-coded to 100us, which is
>     small enough but can still work somehow.
>     
>     Reported-by: syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com
>     Closes: https://lore.kernel.org/r/000000000000fa00a1061740ab6d@google.com
>     Cc: <stable@vger.kernel.org>
>     Link: https://lore.kernel.org/r/20240514182745.4015-1-tiwai@suse.de
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/sound/core/timer.c b/sound/core/timer.c
> index e6e551d4a29e0..42c4c2b029526 100644
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -553,6 +553,14 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
>  		goto unlock;
>  	}
>  
> +	/* check the actual time for the start tick;
> +	 * bail out as error if it's way too low (< 100us)
> +	 */
> +	if (start) {
> +		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000)
> +			return -EINVAL;
> +	}
> +
>  	if (start)
>  		timeri->ticks = timeri->cticks = ticks;
>  	else if (!timeri->cticks)

