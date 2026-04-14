Return-Path: <stable+bounces-237793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN1sJxse3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:59:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B243F9089
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59207301E3EF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5763876A4;
	Tue, 14 Apr 2026 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ga49fdDU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UXtktOFR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ga49fdDU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UXtktOFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192833F8AD
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164189; cv=none; b=avlKCJrlHF3GaRegSf+XY4d4jCRG5s/dblGJjlTTo/1F/jcle+gsgB5c7ZigKi6cAQHvfvIK73GAhJVBQwicGTsffohFOZmeriX+GkcjMIGMjJuEO06iWfSw18c7gVJcKskmnWdK5vAd7G/sKD0tj/df3Tok/ujSOUkI4vmh3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164189; c=relaxed/simple;
	bh=KendIKKWvarLHNo/vYS33F5BV7aPEbnD0ZUUfJQf20I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlxbeqpkmGWBeh0NY305OpWJ4drUU/hSMM3Gj11dELWjSEPsfp0ReCc+DAFBU66Itg2ct+EuVX9rrc2EYfsq6nLPtIz4iA1ZoH4/hrZ5P2JGg/oLAdzHITCeRUIGXp/SnqJB7hutjdNjYX4bOpzKHLwZERytaUtcaXynML4r854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ga49fdDU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UXtktOFR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ga49fdDU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UXtktOFR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDA105BDBB;
	Tue, 14 Apr 2026 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776164186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I20ubF9NCl37sfitbPld17871wEcT11G9wOtWCycvdg=;
	b=Ga49fdDUofW5gDk22sQi9aHXC9leN9COAJWvbIwE86iWnznA37fQfK1Gh92c+KI3qPCKKx
	KpB5y3SQKFqnpaGXqk9b3TrmvUYa/oLACNVD4XHfOC63iahPt3Y7SrxnzB03L5ZN9+ySnJ
	MpDGWskV2I2gJ1jl//UWkVlmpMRcJIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776164186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I20ubF9NCl37sfitbPld17871wEcT11G9wOtWCycvdg=;
	b=UXtktOFRyH8rYMg7JOj+quuyjp3K4ex91rxJcKvUu14Jc+uAaSBY9kjnaT2DyDBob57er3
	pU906KzQWd6QiOAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ga49fdDU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UXtktOFR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776164186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I20ubF9NCl37sfitbPld17871wEcT11G9wOtWCycvdg=;
	b=Ga49fdDUofW5gDk22sQi9aHXC9leN9COAJWvbIwE86iWnznA37fQfK1Gh92c+KI3qPCKKx
	KpB5y3SQKFqnpaGXqk9b3TrmvUYa/oLACNVD4XHfOC63iahPt3Y7SrxnzB03L5ZN9+ySnJ
	MpDGWskV2I2gJ1jl//UWkVlmpMRcJIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776164186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I20ubF9NCl37sfitbPld17871wEcT11G9wOtWCycvdg=;
	b=UXtktOFRyH8rYMg7JOj+quuyjp3K4ex91rxJcKvUu14Jc+uAaSBY9kjnaT2DyDBob57er3
	pU906KzQWd6QiOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1AD4B3E6;
	Tue, 14 Apr 2026 10:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8iKjKFkd3mn8JgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 14 Apr 2026 10:56:25 +0000
Date: Tue, 14 Apr 2026 12:56:25 +0200
Message-ID: <87eckhstd2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Berk Cem Goksel <berkcgoksel@gmail.com>
Cc: zonque@gmail.com,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreyknvl@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ALSA: caiaq: fix use-after-free and double-free in setup_card()
In-Reply-To: <20260413034941.1131465-2-berkcgoksel@gmail.com>
References: <20260413034941.1131465-1-berkcgoksel@gmail.com>
	<20260413034941.1131465-2-berkcgoksel@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,perex.cz,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-237793-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 03B243F9089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 05:49:40 +0200,
Berk Cem Goksel wrote:
> 
> When snd_card_register() fails in setup_card(), snd_card_free() is
> called on the card, but there is no return statement afterwards.
> Execution falls through to snd_usb_caiaq_control_init(cdev), which
> dereferences members of the just-freed card, resulting in a
> use-after-free.
> 
> setup_card() is void and init_card() still returns 0 on this path,
> so snd_probe() leaves the freed card pointer in the USB interface's
> private data via usb_set_intfdata(). When the device is later
> disconnected, snd_usb_caiaq_disconnect() calls
> snd_card_free_when_closed() on that same pointer, producing a
> double-free and slab corruption.
> 
> Add the missing return so a failed snd_card_register() cleanly
> aborts setup without touching freed memory.
> 
> The issue is reachable by any caiaq-compatible USB device whose
> descriptors cause snd_card_register() to fail. It was reproduced
> with raw-gadget + dummy_hcd on 7.0.0-rc5 (arm64, KASAN).
> 
> Fixes: 8e3cd08ed8e5 ("[ALSA] caiaq - add control API and more input features")
> Cc: stable@vger.kernel.org
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
> ---
> v2:
>  - Correct "Fixes:" tag
> 
>  sound/usb/caiaq/device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
> index 3a71bab8a477..d52f3b9a2bac 100644
> --- a/sound/usb/caiaq/device.c
> +++ b/sound/usb/caiaq/device.c
> @@ -369,6 +369,7 @@ static void setup_card(struct snd_usb_caiaqdev *cdev)
>  	if (ret < 0) {
>  		dev_err(dev, "snd_card_register() returned %d\n", ret);
>  		snd_card_free(cdev->chip.card);
> +		return;
>  	}
>
>  	ret = snd_usb_caiaq_control_init(cdev);

Looking at the code again, this fix doesn't seem sufficing.
And, we have snd_card_free() call in the error case of init_card(),
but setup_card() doesn't give the error back properly.

That said, a proper fix would be to change setup_card() to return the
error, and handle it in init_card().  The place you fixed should
return an error instead of calling snd_card_free() there.

I'm going to cook up a patch.


thanks,

Takashi

