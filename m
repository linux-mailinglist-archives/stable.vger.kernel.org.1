Return-Path: <stable+bounces-210496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cImTDpuKcGkEYQAAu9opvQ
	(envelope-from <stable+bounces-210496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 09:13:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D024B534F5
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 09:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4CE448BA31
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71466425CDC;
	Tue, 20 Jan 2026 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lzCi14l+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pNULk4FU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lzCi14l+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pNULk4FU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342B3A1CE2
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909483; cv=none; b=dMjvbbF9/f5YnmrIwG1jaxE3Gsl8eGHraZdE0uexK2BT6o5EGxX/gH0lNtIOri3tKSynChzUv1JRGtlm/DuilayrKs/a3eks8sp/m4dVMrBZw7HSu2nbf1oqEAxwuT5ZKHCT18K4kwmUV1hFgy6dOqrSA8UCOGsvme46yX1V2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909483; c=relaxed/simple;
	bh=ggf85RRn2u2pSDSYrEKt3VaOLiAsoHlL6CzuF7s7sus=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImhvqxNPD2givkIyMQzjfpMSbnwjHbLsMXA/cvswIKx7sDyBx8JSqFjzHngjLjv+48l1HE7eG0dgH8kY9cIJ9FjdEgdMZraCuUn6gFkelgnS4Gp2qqLVJYKCz55xGFEdsgMnbaj2EH9kIKy4ooegrpA+IV23wA7bN75SI/8kqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lzCi14l+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pNULk4FU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lzCi14l+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pNULk4FU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53386337D7;
	Tue, 20 Jan 2026 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768909480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pn7EWLq2tn5kc+cr0gyHMptWRSFsTtsvV3282EXGQnY=;
	b=lzCi14l+XDAyQJj4cP2LZszcN09FvX5rropkn8M0igZWX8NUxz9Sjw7i+hSH2h6bB+rNZz
	t2XqCQBglvggWQ7mrCOrC09cpZAAnRAFkyaQ/K2P75JIbjZQ9Sl0nceLmvT8tVVPJxw6TM
	lR+XpdsCeZDkVSLJRkDEBhsjojQp8Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768909480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pn7EWLq2tn5kc+cr0gyHMptWRSFsTtsvV3282EXGQnY=;
	b=pNULk4FUEnPZ3fbyHfsPbMnKPkf3nA6BDC1PFEi/m46CpDuM7fJL+VpoXsuRVtpCALqlTX
	1cAXhsjC92wrYTCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lzCi14l+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pNULk4FU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768909480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pn7EWLq2tn5kc+cr0gyHMptWRSFsTtsvV3282EXGQnY=;
	b=lzCi14l+XDAyQJj4cP2LZszcN09FvX5rropkn8M0igZWX8NUxz9Sjw7i+hSH2h6bB+rNZz
	t2XqCQBglvggWQ7mrCOrC09cpZAAnRAFkyaQ/K2P75JIbjZQ9Sl0nceLmvT8tVVPJxw6TM
	lR+XpdsCeZDkVSLJRkDEBhsjojQp8Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768909480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pn7EWLq2tn5kc+cr0gyHMptWRSFsTtsvV3282EXGQnY=;
	b=pNULk4FUEnPZ3fbyHfsPbMnKPkf3nA6BDC1PFEi/m46CpDuM7fJL+VpoXsuRVtpCALqlTX
	1cAXhsjC92wrYTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 363213EA63;
	Tue, 20 Jan 2026 11:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9saSDKhqb2l0OQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 20 Jan 2026 11:44:40 +0000
Date: Tue, 20 Jan 2026 12:44:35 +0100
Message-ID: <87cy34tsnw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Berk Cem Goksel <berkcgoksel@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	andreyknvl@gmail.com
Subject: Re: [PATCH] ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()
In-Reply-To: <20260120102855.7300-1-berkcgoksel@gmail.com>
References: <20260120102855.7300-1-berkcgoksel@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210496-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D024B534F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 11:28:55 +0100,
Berk Cem Goksel wrote:
> 
> When snd_usb_create_mixer() fails, snd_usb_mixer_free() frees
> mixer->id_elems but the controls already added to the card still
> reference the freed memory. Later when snd_card_register() runs,
> the OSS mixer layer calls their callbacks and hits a use-after-free read.
> 
> Call trace:
>   get_ctl_value+0x63f/0x820 sound/usb/mixer.c:411
>   get_min_max_with_quirks.isra.0+0x240/0x1f40 sound/usb/mixer.c:1241
>   mixer_ctl_feature_info+0x26b/0x490 sound/usb/mixer.c:1381
>   snd_mixer_oss_build_test+0x174/0x3a0 sound/core/oss/mixer_oss.c:887
>   ...
>   snd_card_register+0x4ed/0x6d0 sound/core/init.c:923
>   usb_audio_probe+0x5ef/0x2a90 sound/usb/card.c:1025
> 
> Fix by calling snd_ctl_remove() for all mixer controls before freeing
> id_elems. We save the next pointer first because snd_ctl_remove()
> frees the current element.
> 
> Fixes: 6639b6c2367f ("[ALSA] usb-audio - add mixer control notifications")
> Cc: stable@vger.kernel.org
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>

Thanks, applied now.


Takashi

