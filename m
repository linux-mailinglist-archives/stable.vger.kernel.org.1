Return-Path: <stable+bounces-260529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mtGIAGKeIWpSKAEAu9opvQ
	(envelope-from <stable+bounces-260529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:48:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CAA641917
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:48:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=swf01uPE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7Fu22zoa;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=swf01uPE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7Fu22zoa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260529-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260529-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 505AF30D5933
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE332E6B4;
	Thu,  4 Jun 2026 15:23:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D16293458
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 15:23:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586626; cv=none; b=b6UCOoVIR1FTtbixD3LItIvNRnU3b0i52yVkMMFPHYinEGkzAwxgIUddR18bjkYE2hPXXkAFs9fqQE7FzXPF1wzWJa5k3ux7l1kOIhCgSf6Ee6k8NGEGV+LoSA+Zs3e3DPsKre5CjvDxoEipBmoNSl5B0H80AFQvBSWmB6TFKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586626; c=relaxed/simple;
	bh=z7zgnozPqp2m+PHZytRQdE4wyFtfKrO9YQwTyexCFQM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWnYIIkdz+sXbj/HgD0C6P3R0wgLxIM45+3anwikj0TuFtqKhYd2lmZrey09faahr4EV0Ai/cLtUWovrbco4V5mdYK4JYHGnSc7Myb4kXENj0cMtf3B2DoFhxpRJy7LN2O9h46I4kpshf7G++eMpfe0D9TPDj6PqSP6VpQgRalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=swf01uPE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Fu22zoa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=swf01uPE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Fu22zoa; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 960266B1FD;
	Thu,  4 Jun 2026 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780586623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYRZ+oBNg3lTdL9+i272m7bjHMQY5meB9azcfe+HaK0=;
	b=swf01uPEWcHfRI+nqd6EXHGqyewEVbz4PNsh2m7Z20TtGwS9wrpTDGrImmYhWoBs23KKDp
	Tb8UKeMBlqs4n0jvNvP7agQnjoEAyB1gAqLIEygpvu/v8iT3qZEVFJBUocFlRJBkBDv+7O
	Tmbswsp+YM44zApJRTOSCJbIqO03mh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780586623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYRZ+oBNg3lTdL9+i272m7bjHMQY5meB9azcfe+HaK0=;
	b=7Fu22zoaKz3a1GM7tehu1W9Q7eGN29g+m3xcXGxwxvokNQAJLI/IflWYSPlkEgm0ObVPYx
	nzwhcAEdOwG4/HCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780586623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYRZ+oBNg3lTdL9+i272m7bjHMQY5meB9azcfe+HaK0=;
	b=swf01uPEWcHfRI+nqd6EXHGqyewEVbz4PNsh2m7Z20TtGwS9wrpTDGrImmYhWoBs23KKDp
	Tb8UKeMBlqs4n0jvNvP7agQnjoEAyB1gAqLIEygpvu/v8iT3qZEVFJBUocFlRJBkBDv+7O
	Tmbswsp+YM44zApJRTOSCJbIqO03mh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780586623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYRZ+oBNg3lTdL9+i272m7bjHMQY5meB9azcfe+HaK0=;
	b=7Fu22zoaKz3a1GM7tehu1W9Q7eGN29g+m3xcXGxwxvokNQAJLI/IflWYSPlkEgm0ObVPYx
	nzwhcAEdOwG4/HCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 629B0779A8;
	Thu,  4 Jun 2026 15:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MOQDFn+YIWqTJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Jun 2026 15:23:43 +0000
Date: Thu, 04 Jun 2026 17:23:42 +0200
Message-ID: <87wlweuy69.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Batishchev <ii343hbka@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable micmute LED on HP EliteBook 6 G1a
In-Reply-To: <20260604131518.45993-1-ii343hbka@gmail.com>
References: <20260604131518.45993-1-ii343hbka@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260529-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ii343hbka@gmail.com,m:perex@perex.cz,m:tiwai@suse.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:from_mime,suse.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3CAA641917

On Thu, 04 Jun 2026 15:15:18 +0200,
Denis Batishchev wrote:
> 
> The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
> Without a quirk no fixup is selected and the mic-mute LED stays off.
> It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
> already-supported 14" variant (SSID 103c:8dfb), so add it.
> 
> Note: I don't know how to fix sound-mute LED though.

What does this mean?  Is this patch confirmed to work or not?

> Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
>  sound/hda/codecs/realtek/alc269.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
> index 78a865709..8eebf9159 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -7274,6 +7274,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +	SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>  	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),

The table is sorted in PCI SSID order.  Please try to put the entry at
the right position.


thanks,

Takashi

